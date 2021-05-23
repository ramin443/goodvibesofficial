import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';

import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:goodvibesoffl/models/composer_download_task_model.dart';
import 'package:goodvibesoffl/models/models.dart';
import 'package:goodvibesoffl/models/music_model.dart';
import 'package:goodvibesoffl/models/playable_model.dart';
import 'package:goodvibesoffl/models/playlist_model.dart';
import 'package:goodvibesoffl/services/api_service.dart';
import 'package:goodvibesoffl/services/player_service.dart';
import 'package:goodvibesoffl/utils/strings/string_constants.dart';
//import 'package:goodvibes/utils/strings/string_constants.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import '../locator.dart';
import 'package:goodvibesoffl/services/services.dart';

//   static const undefined = const DownloadTaskStatus(0);
//   static const enqueued = const DownloadTaskStatus(1);
//   static const running = const DownloadTaskStatus(2);
//   static const complete = const DownloadTaskStatus(3);
//   static const failed = const DownloadTaskStatus(4);
//   static const canceled = const DownloadTaskStatus(5);
//   static const paused = const DownloadTaskStatus(6);
// }

class RitualsProvider {
  static RitualsProvider _instance = RitualsProvider._();

  final ApiService _apiService = ApiService();

  factory RitualsProvider() {
    return _instance;
  }
  RitualsProvider._();

  static int _playlistCount = 1;
  static int _totalDownloadPer = 0;
  static get totaldownloadPercentage => _totalDownloadPer / _playlistCount;

  List<Playable> _ritualsTracks = [];
  List<PlayList> _ritualsPlaylists = [];
  List<Playable> _moreRituals = [];
  List<PlayList> _startedRituals = [];

  List<PlayList> _favouriteRituals = [];

  String ritualsTrackError = "";
  String ritualsPlaylistsError = "";
  String moreRitualsError = "";

  bool _hasRitualsTracksError = false;
  bool _hasRitualsPlaylistsError = false;
  bool _hasMoreRitualsError = false;

  /// download related
  List<DownloadTaskModel> playlistDownloadAudios = [];
  List<String> playlistDownloadingTaskIds = [];

  ValueListenable<List<int>> downloadingTracksIds = ValueNotifier([]);
  ValueNotifier<List<int>> downloadCompletedIds = ValueNotifier([]);

  ValueNotifier<List<DownloadTaskModel>> dowloadingPlaylistItems =
  ValueNotifier([]);
  StreamController<List<DownloadTaskModel>> downloadingItemsStream =
  StreamController.broadcast();

  ValueNotifier<double> totalProgress = ValueNotifier(0);
  MusicService _playerService = MusicService();
  int downloadId = -1;

  Map<int, List<int>> progressTrackMap = {};

  downloadPlaylist({@required int playlistId, List<Track> tracks}) async {
    totalProgress.value = 0.0;
    if (tracks.isNotEmpty) _playlistCount = tracks.length;
    _totalDownloadPer = 0;

    var dir = await getApplicationDocumentsDirectory();
    String initialPath = Platform.isAndroid ? dir.parent.path : dir.path;
    var path = join(initialPath, 'files', 'sounds');

    bool directoryExists = await Directory(path).exists();

    var savedDir = path;

    Map res = await _apiService.getDownloadInformation(playlistId: playlistId);

    if (res != null && res.containsKey('data')) {
      Logger log = Logger();
      log.e(res);
      downloadId = res['data']['id'] ?? -1;
    }
    if (!directoryExists) {
      var createdPath = await Directory(path).create(recursive: true);
      savedDir = createdPath.path;
    }

    tracks.forEach((track) async {
      var taskId = await FlutterDownloader.enqueue(
        url: track.trackDownloadUrl,
        savedDir: savedDir,
        showNotification: true,
        fileName: track.filename,
        openFileFromNotification: true,
        //    notificationtitle: track.title,
        //   trackID: track.id
      );

      downloadingTracksIds.value.add(track.id);
      playlistDownloadingTaskIds.add(taskId);

      playlistDownloadAudios.add(DownloadTaskModel(
          taskId: taskId,
          audioId: track.id,
          audioPath: path,
          audioTitle: track.title,
          isDownloading: true,
          fileName: track.filename));

      dowloadingPlaylistItems.value = playlistDownloadAudios;

      await DatabaseService().addDownloadedItemIntoDownloadList(
          track: track,
          downloadId: downloadId,
          downloadPath: join(path, track.filename));

      progressTrackMap[track.id] = [0];
    });
  }

  cancelDownload() {
    FlutterDownloader.cancelAll();
    dowloadingPlaylistItems.value = [];
    playlistDownloadAudios = [];
    _apiService.cancelDownloadNotifyServer(downloadId: downloadId);
  }

  handleDownloadStatus(
      {var taskId, DownloadTaskStatus status, int progress}) async {
    var _downloadItem = dowloadingPlaylistItems.value
        .firstWhere((element) => element.taskId == taskId, orElse: () => null);
    //print("download task status : $status");
    //print("progress: $progress");

    if (_downloadItem != null) {
      if (status == DownloadTaskStatus.enqueued) {
        _downloadItem.isDownloading = true;
      } else if (status == DownloadTaskStatus.canceled) {
        /// download canceled
        dowloadingPlaylistItems.value.remove(_downloadItem);

        _playerService.setDownloadingFalse();
      } else if (status == DownloadTaskStatus.failed) {
        dowloadingPlaylistItems.value.remove(_downloadItem);
        _playerService.setDownloadingFalse();
      } else if (status == DownloadTaskStatus.running) {
        ///
        _downloadItem.progress = progress;

        progressTrackMap[_downloadItem.audioId].add(progress);

        var _tProgress = 0.0;
        progressTrackMap.forEach((key, value) {
          _tProgress += value.last;
        });

        totalProgress.value = _tProgress / _playlistCount;

        //print("playables count:  $_playlistCount");
        //print("toal downlad progress: $_tProgress");

        //print("total progress value after calculate: ${totalProgress.value}");

        downloadingItemsStream.add(dowloadingPlaylistItems.value);

        // _downloadItem.progress = progress;
      } else if (status == DownloadTaskStatus.complete) {
        _downloadItem.progress = progress;
        _downloadItem.isDownloading = false;
        _playerService.setDownloadingFalse();

        downloadCompletedIds.value.add(_downloadItem.audioId);

        DatabaseService().setDownloadComplete(trackID: _downloadItem.audioId);

        if (playlistDownloadingTaskIds.length == 1) {
          playlistDownloadingTaskIds = [];
          dowloadingPlaylistItems.value = [];
          _apiService.downloadFinished(downloadId: downloadId);
        } else {
          playlistDownloadingTaskIds.remove(_downloadItem.taskId);
          dowloadingPlaylistItems.value.remove(_downloadItem);
        }
      }
    }
  }

  deleteDownloadedRituals(int downloadId) {
    _apiService.deleteDownload();
  }

  onFavoriteButtonPressed(PlayList playlist) {
    var _item = _favouriteRituals
        .firstWhere((element) => element.id == playlist.id, orElse: () => null);

    if (_item != null) {
      removeRitualsFromFavorite(playlist);
    } else {
      addRitualsIntoFavorite(playlist);
    }

    return _favouriteRituals;
  }

  getFavouriteTituals() async {
    Map res = await _apiService.getFavouriteRituals();

    if (res == null) {
    } else if (res.containsKey('error')) {
    } else if (res.containsKey('data')) {
      var data = res['data'] as List;

      _favouriteRituals = data.map((item) => PlayList.fromJson(item)).toList();
    }
  }

  _checkIfritualPlaylistIdFav(playlistId) async {}

  addRitualsIntoFavorite(PlayList playlist) {
    _favouriteRituals.add(playlist);

    _apiService.addRitualPlaylistInFavorite(playlist.id);
  }

  removeRitualsFromFavorite(PlayList playList) {
    _favouriteRituals.remove(playList);
    _apiService.removeRitualPlaylistFromFavorite(playList.id);
  }

  getRitualsTracks(
      {@required int ritualId, bool isRefreshRequest = false}) async {
    _hasRitualsTracksError = false;
    Map res = await _apiService.getRitualsTracks(ritualId,
        isRefreshRequest: isRefreshRequest);
    if (res == null) {
    } else if (res.containsKey("error")) {
      ritualsTrackError = error_error;
      _hasRitualsTracksError = true;
      ritualsTrackError = res['error'];
    } else if (res.containsKey("data")) {
      //print(res['data']);
      var data = res['data'];

      _ritualsTracks =
          data['playables'].map<Playable>((e) => Playable.fromJson(e)).toList();
    }
  }

  getRitualsPlaylists({bool isRefreshRequest = false}) async {
    Map<String, dynamic> res = await _apiService.getRitualsPlaylitsts(
        isRefreshRequest: isRefreshRequest);

    if (res == null) {
      _hasRitualsPlaylistsError = true;
      ritualsPlaylistsError = error_error;
    } else if (res.containsKey("error")) {
      _hasRitualsPlaylistsError = true;
      ritualsPlaylistsError = res['error'];
    } else if (res.containsKey("data")) {
      var list = res['data'] as List;
      _ritualsPlaylists =
          list.map<PlayList>((item) => PlayList.fromJson(item)).toList();
      //print(_ritualsPlaylists.length);
    }
  }

  getMoreRituals({bool isRefreshRequest = false}) async {
    _hasMoreRitualsError = false;

    Map res =
    await _apiService.getMoreRituals(isRefreshRequest: isRefreshRequest);

    if (res == null) {
      _hasMoreRitualsError = true;
      moreRitualsError = error_error;
    } else if (res.containsKey("error")) {
      _hasMoreRitualsError = true;
      moreRitualsError = res['error'];
    } else if (res.containsKey("data")) {
      var data = res['data'] as List;

      _moreRituals =
          data.map<Playable>((item) => Playable.fromJson(item)).toList();
    }
  }

  getStartedRituals() async {
    var res = await DatabaseService().getPlayedRitualPlaylists();

    if (res.isNotEmpty) {
      _startedRituals =
          res.map<PlayList>((e) => PlayList.fromRitualDb(e)).toList();
    }
  }

  updateRitualPlayedDuration(
      {@required int playableStatId, @required var trackPlayedDuration}) async {
    Map res = await _apiService.updateRitualTracksDuration(
        playableStatId, trackPlayedDuration);
  }

  List<Playable> get ritualsTracks => _ritualsTracks;
  List<PlayList> get ritualsPlaylists => _ritualsPlaylists;
  List<Playable> get moreRituals => _moreRituals;
  List<PlayList> get startedRituals => _startedRituals;
  List<PlayList> get favouriteRituals => _favouriteRituals;

  bool get hasError => _hasRitualsTracksError;
  bool get hasRitualsPlaylistError => _hasRitualsPlaylistsError;
  bool get hasMoreRitualsError => _hasMoreRitualsError;
}
