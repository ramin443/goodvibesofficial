import 'dart:collection';
import 'dart:io';
//import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:goodvibesoffl/locator.dart';
import 'package:goodvibesoffl/models/download_playable.dart';
import 'package:goodvibesoffl/models/music_model.dart';
import 'package:goodvibesoffl/models/playlist_model.dart';
import 'package:goodvibesoffl/services/api_service.dart';
import 'package:goodvibesoffl/services/appConfig.dart';
import 'package:goodvibesoffl/services/database_service.dart';
import 'package:goodvibesoffl/services/player_service.dart';
import 'package:goodvibesoffl/services/services.dart';
import 'package:goodvibesoffl/utils/common_functiona.dart';
import 'package:goodvibesoffl/models/playlist_model.dart';
// import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DownloadRepository {
  List<Track> _downloadedTracks = [];
  List<String> _filterCategory = [];
  bool _hasDownloadError = false;
  String _downloadError = "";
  bool _isLoadedFirstTime = true;
  bool _isLoadedFromInternet = false;
  bool _isLoadedFromDB = false;
  bool _isDownloadedFilesDeleted = false;
  List<PlayList> _playlists = [];
  List<PlayList> get playlists => _playlists;

  static final DownloadRepository _downloadsRespository =
  DownloadRepository._internal();

  factory DownloadRepository() {
    return _downloadsRespository;
  }

  DownloadRepository._internal();

  void _resetDownloadErrorMessage() {
    _hasDownloadError = false;
    _downloadError = "";
  }

  createListOfFilters() {
    List<String> _filterList = ['All'];
    _downloadedTracks.forEach((track) {
      bool contains = _filterList.contains((track.cname));
      if (!contains) {
        if (track.cname.trim().isNotEmpty) _filterList.add(track.cname);
      }
    });
    _filterCategory = _filterList;
    _filterList.insert(1, 'Courses');
  }

  Future<void> fetehDataFromDB() async {
    List<Map<String, dynamic>> downloadData =
    await DatabaseService().getDownloads();
    // Logger log = Logger();
    // log.i(downloadData);

    final tracks = downloadData
        .map<Track>((data) => Track.fromDb(data))
        .cast<Track>()
        .toList();

    tracks.forEach((element) {
      var trackIndex =
      _downloadedTracks.indexWhere((item) => item.id == element.id);
      if (trackIndex > -1) {
        if (_downloadedTracks[trackIndex].downloadId == -1 ||
            _downloadedTracks[trackIndex].downloadId == null) {
          _downloadedTracks[trackIndex] = element;
        }
      }
      if (trackIndex == -1) {
        _downloadedTracks.add(element);
      }
    });
    //print("before check share dpref");

    //// deleting free user's downlaods

    try {
      await _checkSharedPrefAndCallDownloadDelete(tracks: tracks);
    } catch (e) {
      //print(e);
    }

    createListOfFilters();
  }

  Future<bool> fetchDataFromServer() async {
    _resetDownloadErrorMessage();
    Map<String, dynamic> downloadData =
    await locator<ApiService>().getDownloads();
    if (downloadData.containsKey('data')) {
      List<Track> temp = [];
      final downloadedItem = downloadData['data'] as List<dynamic>;

      _playlists.clear();
      downloadedItem.forEach((element) {
        DownloadPlayable playable = DownloadPlayable.fromJson(element);

        if (playable.track != null) {
          temp.add(playable.track);
        } else if (playable.playList != null) {
          _playlists.add(playable.playList);
        }
      });

      if (locator<MusicService>().isDownloading.value) {
        temp = temp.reversed.toList();
      }

      /// deleting downloads for user after therir subscription ends
      ///
      try {
        await _checkSharedPrefAndCallDownloadDelete(tracks: temp);
      } catch (e) {
        //print(e);
      }
      final latestData = comapareAndGetUpdatedTrack(_downloadedTracks, temp);

      if (_downloadedTracks.length != latestData.length) {
        _downloadedTracks = latestData;
        await _addDownloadsFromApiInDatabase();
        createListOfFilters();
        return true;
      }
      return false;

      //////
    } else {
      _hasDownloadError = true;
      if (downloadData != null && downloadData.containsKey('error')) {
        _downloadError = downloadData['error'];
      } else {
        _downloadError = "some error occured";
      }
      return false;
    }
  }

  List<Track> comapareAndGetUpdatedTrack(
      List<Track> oldDownloadedTracks, List<Track> newDownloadedTracks) {
    final temp = [...oldDownloadedTracks];
    newDownloadedTracks.forEach((_track) {
      if (temp.indexWhere((oldTrack) => oldTrack.id == _track.id) == -1) {
        temp.add(_track);
      }
    });
    return temp;
  }

  bool addTrackToRepository(Track track) {
    final trackIndex =
    _downloadedTracks.indexWhere((item) => item.id == track.id);
    if (trackIndex == -1) {
      _downloadedTracks.insert(0, track);
      createListOfFilters();
      return true;
    } else if (trackIndex > -1) {
      if (trackIndex == -1) {
        _downloadedTracks[trackIndex] = track;
        createListOfFilters();
        return true;
      }
    }
    return false;
  }

  bool deleteTrackToRepository(Track track) {
    if (_downloadedTracks.indexWhere((item) => item.id == track.id) != -1) {
      _downloadedTracks.removeWhere((item) => item.id == track.id);
      createListOfFilters();
      return true;
    }
    return false;
  }

  deletePlaylist(PlayList playlist) {
    var _item = _playlists.firstWhere((element) => element.id == playlist.id,
        orElse: () => null);

    if (_item != null) {
      _playlists.remove(_item);
    }
  }

  _addDownloadsFromApiInDatabase() async {
    // var path = await getDatabasesPath();
    Directory directory = await getApplicationDocumentsDirectory();
    String initialPath =
    Platform.isAndroid ? directory.parent.path : directory.path;
    var tempPath = join(initialPath, 'files', 'sounds');
    Directory dir = Directory(tempPath);

    await Future.forEach(_downloadedTracks, (Track track) async {
      bool exists =
      await DatabaseService().checkIfDownloadExistInTable(track.id);

      if (exists) {
        /// do nothing or update

      } else {
        DatabaseService().addDownloadedItemIntoDownloadList(
          track: track,
          downloadId: track.downloadId,
          downloadPath: join(
            dir.path,
            track.filename,
          ),
        );
      }
    });
  }

  deleteDownloadedFiles() async {
    var dir = await getApplicationDocumentsDirectory();

    String initialPath = Platform.isAndroid ? dir.parent.path : dir.path;

    var path = join(initialPath, 'files', 'sounds');

    var newDir = Directory(path);

    if (newDir.existsSync()) {
      try {
        recordCrashlyticsLog("Deleting downlaods on logout");
        await newDir.delete(recursive: true);
      } catch (e, s) {
     //   await Crashlytics.instance.recordError(e.toString(), s);
      }

      await DatabaseService().clearDownloadsTable();
    }
  }

  _checkSharedPrefAndCallDownloadDelete({@required List<Track> tracks}) async {
    if (locator<UserService>().user.value.paid) {
      bool _isDeleted =
          await SharedPrefService().getFreeUsersDloadDeleted() ?? false;
      if (!_isDeleted) {
        //print("shard pref not deleted date");
        tracks.forEach((element) async {
          await _deleteFreeUsersDownloadedFiles(
              filename: element.filename,
              downloadedDate: element.dateTime,
              trackId: element.id);
        });

        SharedPrefService().setFreeUsersDloadDeleted(true);
      }
    }
  }

  _deleteFreeUsersDownloadedFiles(
      {String filename, String downloadedDate, int trackId}) async {
    if (filename == null || filename == "") {
      //print("file name nll");
      return;
    }
    downloadedDate = downloadedDate.trim();
    recordCrashlyticsLog("download date of track is $downloadedDate");
    var _dDate =
    downloadedDate == null || downloadedDate == "" || downloadedDate == " "
        ? DateTime.now()
        : DateTime.parse(downloadedDate);

    //print("getting date");
    var _current = DateTime.now();
    final diff = _current.difference(_dDate).inMinutes;

    if (diff < AppConfig.freeUserDownloadsDeleteAfter) {
      recordCrashlyticsLog(
          "download date differnce was less than 30, i.e.$diff");
      return;
    }

    Directory directory = await getApplicationDocumentsDirectory();
    String initialPath =
    Platform.isAndroid ? directory.parent.path : directory.path;
    var tempPath = join(initialPath, 'files', 'sounds');

    try {
      recordCrashlyticsLog("Trying to delete free user's downloads");
      final _filePath = join(tempPath, filename);
      File _file = File(_filePath);
      //print(_filePath);
      if (_file.existsSync()) {
        //print('deleteing');
        _file.deleteSync();

        try {
          await DatabaseService().deleteDownloadItem(trackId: trackId);
        } catch (e) {
          // something happens here
        }
      }
    } catch (e, s) {
      //print(e);
   //   await Crashlytics.instance.recordError(e.toString(), s);
    }
  }

  List<Track> get downloadedTracks => [..._downloadedTracks];
  bool get hasDownloadError => _hasDownloadError;
  String get downloadError => _downloadError;
  bool get isLoadedFirstTime => _isLoadedFirstTime;
  bool get isLoadedFromDB => _isLoadedFromDB;
  bool get isLoadedFromInternet => _isLoadedFromInternet;
  bool get isEmpty => _downloadedTracks.isEmpty;
  bool get isNotEmpty => _downloadedTracks.isNotEmpty;
  List<String> get filterCategory => _filterCategory;
}
