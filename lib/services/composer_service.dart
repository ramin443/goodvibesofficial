import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:goodvibesoffl/models/composer_download_task_model.dart';
import 'package:goodvibesoffl/providers/music_providers/composer_provider.dart';
import 'package:goodvibesoffl/services/database_service.dart';
import 'package:goodvibesoffl/services/player_service.dart';
import 'package:goodvibesoffl/utils/common_functiona.dart';
import 'package:goodvibesoffl/utils/image_paths.dart';
import 'package:goodvibesoffl/utils/strings/audio_constants.dart';
import 'package:goodvibesoffl/widgets/common_widgets/common_widgets_methods.dart';
import 'package:goodvibesoffl/widgets/dialog_boxes.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../locator.dart';
import "../models/composer_audio_model.dart";
import 'package:path/path.dart';
import '../widgets/common_widgets/common_widgets_methods.dart';
import 'package:flutter/services.dart' show rootBundle;

class ComposerService {
  FlutterFFmpeg flutterFFmpeg;
  FlutterFFmpegConfig _flutterFFmpegConfig;
  FlutterFFprobe _flutterFFprobe;
  bool ffmpegAvailable;

  ValueNotifier<bool> isOnComposerPage = ValueNotifier(null);

  /// variable to indentify which saved composer mix is being played
  ValueNotifier<int> playingSavedMixId = ValueNotifier(-111);

  /// Currently playing composer mix
  ValueNotifier<ComposerSavedMix> playingComposerMix = ValueNotifier(null);

  /// List to keep track of downlaoding composer items
  List<DownloadTaskModel> downloadingComposerAudios = [];

  List<String> composerDownloadingTaskIds = [];

  AssetsAudioPlayerGroup group;
  // List<PlayingAudio> playingAudios;

  ValueNotifier<bool> playingStatus = ValueNotifier(null);

  /// List used to pass into [playingItemsListStream] stream when new composer item is added or removed,
  /// this list is not directly used in ui, but is passed through stream
  List<int> playingItemsIdsForUpdatingStream = [];

  /// Value notifier of List<int> which contains id's of currenlty palying composer
  /// item's id
  ValueNotifier<List<int>> playingIds = ValueNotifier([]);

  /// This list is used to track a track that is added but has not played yet
  /// [ComposerAudio]'s id is serched into this list and [playingIds] , if not found on bot
  /// item's onclick is not processed
  ValueNotifier<List<int>> addedButNotPlayingList = ValueNotifier([]);

  /// stream that is used to refresh ui of each item in composer grid view
  /// passed [playingItemsIdsForUpdatingStream] when an item is added or removed from mixer
  StreamController<List<int>> playingItemsListStream =
  StreamController<List<int>>.broadcast();

  ///  Stream used to show or hide mini player while scrolling down/up,
  ///  value is added in this stream in scroll controller's listener
  StreamController<bool> miniPlayerHideStream =
  StreamController<bool>.broadcast();

  /// variable for syncing with single player
  ValueNotifier<List<ComposerAudio>> playingComposerAudios = ValueNotifier([]);

  List<ComposerAudio> _playingComposerAudiosListOnly = [];

  /// Path to save composer items after downloading or fetched brfore playing to append to filename
  String _savePath = '';
  String appsDocsDirectoryForThisSession = "";

  /// composer page's build context
  BuildContext _composerBuildContext;

  /// list of audios assets bundled with app
  ValueNotifier<List<String>> assetsComposerAudiosList = ValueNotifier([]);

  /// list of downloaded composer items
  ValueNotifier<List<String>> localComposerAudiosList = ValueNotifier([]);

  /// stream for emitting the last downloaded composer item

  StreamController<int> lastDownloadedItemController =
  StreamController<int>.broadcast();

  StreamController<List<DownloadTaskModel>> downloadingComposerItemsController =
  StreamController<List<DownloadTaskModel>>.broadcast();

  /// function to initialize composer from comopser page
  /// shows composer group's notifications
  initComposer(BuildContext context) async {
    if (_savePath.isEmpty) getSaveDirectoryPath();
    _composerBuildContext = context;
    playingItemsListStream.add([]);

    group = AssetsAudioPlayerGroup(
      showNotification: true,
      notificationStopEnabled: true,
      playInBackground: PlayInBackground.enabled,
      onNotificationOpened: (g, a) {
        //print("notification opened");
      },
      onNotificationPause: (g, a) {
        group.pause();

        var pState;
        if (locator<MusicService>().playingAudio.value != null) {
          pState = locator<MusicService>().playingState?.value.value;
          //print("playing state ::::: $pState");

          if (pState == PlayerState.play) {
            locator<MusicService>().assetsAudioPlayer.pause();
          }
        }
      },
      onNotificationPlay: (g, a) {
        group.play();

        var pState;
        if (locator<MusicService>().playingAudio.value != null) {
          pState = locator<MusicService>().playingState?.value.value;
          //print("playing state ::::: $pState");

          if (pState == PlayerState.pause) {
            locator<MusicService>().assetsAudioPlayer.play();
          }
        }
      },
      onNotificationStop: (g, a) {
        playingIds.value.clear();
        playingItemsListStream.add([]);

        group.stop();
      },
      updateNotification: (g, a) async {
        return PlayerGroupMetas(
          title: "Composer Mixer",
          subTitle: " ${group.playingAudios.length} sounds playing now",
          image: MetasImage.asset(placeholder_image),
        );
      },
    );

    group.isPlaying.listen((event) {
      playingStatus.value = event;
    });

    // listenComposerAudioCompletion();
  }

  /// function to initialize composer group from single player
  /// notification is disabled
  intComposerForSinglePlayer(BuildContext context) async {
    if (_savePath.isEmpty) getSaveDirectoryPath();
    _composerBuildContext = context;
    playingItemsListStream.add([]);

    group = AssetsAudioPlayerGroup(
        showNotification: false,
        notificationStopEnabled: true,
        playInBackground: PlayInBackground.enabled,
        updateNotification: null);

    group.isPlaying.listen((event) {
      playingStatus.value = event;
    });
  }

  Future addAdudiosInGroup(
      {List<ComposerAudio> audios, BuildContext context}) async {
    if (Platform.isAndroid) {
      await addAudiosInGroupAndroid(audios: audios, context: context);
    } else if (Platform.isIOS) {
      await addAudiosInGroupIos(audios: audios, context: context);
    }
  }

  Future addAudiosInGroupAndroid(
      {List<ComposerAudio> audios, BuildContext context}) async {
    audios.forEach((element) {
      addedButNotPlayingList.value.add(element.id);
    });

    await Future.forEach(audios, (ComposerAudio item) async {
      /// when compostions are addd from mix or from single player limit 10
      ///can be crossed , to prevent on adding each item length is checked
      if (playingIds.value.length >= 10) {
        return;
      }

      Metas metas = Metas(
        title: item.audioTitle,
        extra: {
          "id": item.id,
          "url": item.url,
          "downloadUrl": item.downloadUrl,
          "category": item.category,
          "categoryId": item.categoryId,
          "defaultVolume": item.defaultVolume,
          "paid": item.isPaid,
          "image": item.image,
          "fileName": item.fileName
        },
      );

      /// creatae add audio according to its type
      switch (item.audioPathType) {
        case audio_asset:
          var _fileName = item.fileName;
          if (item.fileName.contains(" ")) {
            _fileName = item.fileName.replaceAll(RegExp(' +'), "%20");
          }

          final Audio _audio = Audio("assets/audio/" + _fileName, metas: metas);

          //var res = await group.add(
           //   Playlist(audios: [_audio, _audio], startIndex: 0),
       //       loopMode: LoopMode.single,
         //     volume: item.defaultVolume ?? 0.5);

       //   if (res.containsKey("error")) {
         //   showToastMessage(
       //         message: "An error occured while playing the sound");
     //       addedButNotPlayingList.value.remove(item.id);
   //         return;
 //         }

          break;
        case audio_file:
          bool itemExistsInFileSystem =
          await checkIfComposerFileExists(item.fileName);

          if (itemExistsInFileSystem) {
            final _audio =
            Audio.file(join(_savePath, item.fileName), metas: metas);

 //           var res = await group.add(
   //             Playlist(audios: [_audio, _audio], startIndex: 0),
     //           loopMode: LoopMode.single,
       //         volume: item.defaultVolume ?? 0.5);

     //       if (res.containsKey("error")) {
       //       showSinglePlayerErrorDialog(
         //         error: res["error"], composerAudio: item);
//
  //            addedButNotPlayingList.value.remove(item.id);
    //          return;
      //      }
          } else {
            bool _isOffline = await checkIfOffline();

            if (!_isOffline) {
              addIntoDownloadQ(item);
            }
          }

          break;
        case audio_network:
          bool itemExistsInFileSystem =
          await checkIfComposerFileExists(item.fileName);

          final _audio = Audio.network(item.url, metas: metas, cached: false);

        //  await group
           //   .add(Playlist(audios: [_audio, _audio], startIndex: 0),
         //     loopMode: LoopMode.single, volume: item.defaultVolume ?? 0.5)
            //  .then((res) {
          //  if (res.containsKey("error")) {
        //      showToastMessage(message: "Could not play this sound.");
      //        removeAudioFromGroup(null, id: item.id);
    //        }
  //        });

          break;
      }

      if (group.playingAudios.length == 1 && playingIds.value.length == 0) {
        group.play();
      }

      if (!_playingComposerAudiosListOnly.contains(item)) {
        _playingComposerAudiosListOnly.add(item);
      }

      if (!playingIds.value.contains(item.id)) {
        playingItemsIdsForUpdatingStream.add(item.id);
        playingIds.value.add(item.id);
        miniPlayerHideStream.add(false);
      }
    });

    playingItemsListStream.add(playingItemsIdsForUpdatingStream);
  }

  Future addAudiosInGroupIos(
      {List<ComposerAudio> audios, BuildContext context}) async {
    audios.forEach((element) {
      addedButNotPlayingList.value.add(element.id);
    });

    await Future.forEach(audios, (ComposerAudio item) async {
      /// when compostions are addd from mix or from single player limit 10
      ///can be crossed , to prevent on adding each item length is checked
      if (playingIds.value.length >= 10) {
        return;
      }

      Metas metas = Metas(
        title: item.audioTitle,
        extra: {
          "id": item.id,
          "url": item.url,
          "downloadUrl": item.downloadUrl,
          "category": item.category,
          "categoryId": item.categoryId,
          "defaultVolume": item.defaultVolume,
          "paid": item.isPaid,
          "image": item.image,
          "fileName": item.fileName
        },
      );

      /// creatae add audio according to its type
      switch (item.audioPathType) {
        case audio_asset:
          try {
            var assetName = 'assets/audio/' + item.fileName;

            var rawData = await rootBundle.load(assetName);

            Uint8List dataBuffer = rawData.buffer.asUint8List();

            var convertedPath = await _convertAsset(
              filename: item.fileName,
              dataBuffer: dataBuffer,
              item: item,
              finalExtensionType: "wav",
            );

   //         var res = await group.add(
 //             Playlist(audios: [
           //     Audio.file(convertedPath, metas: metas),
         //       Audio.file(convertedPath, metas: metas),
       //       ]),
     //         loopMode: LoopMode.single,
   //           volume: item.defaultVolume ?? 0.5,
 //           );

           // if (res.containsKey("error")) {
            //  showToastMessage(
          //        message: "An error occured while playing the sound");
        //      removeAudioFromGroup(null, id: item.id);
      //        return;
    //        }
          } catch (e) {}

          break;

        case audio_file:
          bool itemExistsInFileSystem =
          await checkIfComposerFileExists(item.fileName);

          if (itemExistsInFileSystem) {
            var _convertedPath = await _convertFile(
                filename: item.fileName,
                inputFilePath: '''$_savePath/"${item.fileName}"''',
                finalExtensionType: "wav");

            //print("converted path is: $_convertedPath");

            metas.extra['filename'] = _convertedPath;

  //          var res = await group.add(
    //            Playlist(audios: [
      //            Audio.file(_convertedPath, metas: metas),
        //          Audio.file(_convertedPath, metas: metas),
          //      ], startIndex: 0),
            //    loopMode: LoopMode.single,
              //  volume: item.defaultVolume ?? 0.5);

           // if (res.containsKey("error")) {
         //     showToastMessage(
       //           message: "An error occured while playing the sound");
         //     removeAudioFromGroup(null, id: item.id);
      //        return;
    //        }
          }

          break;
        case audio_network:
          try {
         //   var res = await group.add(
          //      Playlist(audios: [
        //          Audio.network(item.url, metas: metas),
      //          ]),
            //    loopMode: LoopMode.single,
          //      volume: item.defaultVolume ?? 0.5);
        //    if (res.containsKey("error")) {
      //        showToastMessage(message: "Could not play this sound.");
    //          removeAudioFromGroup(null, id: item.id);
  //          }
          } catch (e) {}

          break;
      }

      if (group.playingAudios.length == 1 && playingIds.value.length == 0) {
        group.play();
      }

      if (!_playingComposerAudiosListOnly.contains(item)) {
        _playingComposerAudiosListOnly.add(item);
      }

      if (!playingIds.value.contains(item.id)) {
        playingItemsIdsForUpdatingStream.add(item.id);
        playingIds.value.add(item.id);
        miniPlayerHideStream.add(false);
      }
    });

    playingItemsListStream.add(playingItemsIdsForUpdatingStream);
  }

  getSingleAudioFromGroup(int id) {
    var playing = group.playingAudios;

    var singleAudio =
    playing.firstWhere((element) => element.audio.metas.extra["id"] == id);
    return singleAudio.audio;
  }

  removeAudioFromGroup(Audio audio, {int id}) {
    int _id = id ?? audio.metas.extra['id'];

    if (audio != null) {
      group.removeAudio(audio);
    }

    playingItemsIdsForUpdatingStream.remove(_id);

    playingIds.value.remove(_id);

    addedButNotPlayingList.value.remove(id);

    playingItemsListStream.add(playingItemsIdsForUpdatingStream);

    List<ComposerAudio> _tempList = _playingComposerAudiosListOnly;

    var item = _tempList.firstWhere((element) => element.id == _id,
        orElse: () => null);

    if (item != null) {
      _playingComposerAudiosListOnly.remove(item);
    }
  }

  removeEntireGroup() {
    group.stop();
  }

  clearAll() async {
    if (group != null) await group?.stop();

    playingItemsListStream.add([]);
    playingItemsIdsForUpdatingStream.clear();

    playingIds.value.clear();
    playingIds.value = [];

    _playingComposerAudiosListOnly.clear();

    addedButNotPlayingList.value = [];

    if (playingSavedMixId.value != -111) {
      playingSavedMixId.value = -111;
      playingComposerMix.value = null;
    }
  }

  AssetsAudioPlayer getSinglePlayerForAudioInGroup(Audio audio) {
    return group.audiosWithPlayers[audio];
  }

  onPressedSingleItem({ComposerAudio item}) async {
    var length = 0;

    length = group?.playingAudios?.length ?? 0;

    if (downloadingComposerAudios.isNotEmpty) {
      var some = downloadingComposerAudios
          .firstWhere((cItem) => cItem.audioId == item.id, orElse: () => null);

      if (some != null) {
        //print("this item is being downloaded");

        /// composer
        showComposerItemsBeingDownloadedDialog();

        /// showing item being downloaded dialog if download not complete
        showComposerItemsBeingDownloadedDialog();

        return;
      }
    }

    if (group != null) {
      // group is not null
      var allPlayingAudios = group.playingAudios;

      if (allPlayingAudios.isNotEmpty) {
        /// if there are alredy playing audios
        /// check if the audio was alredy playing

        PlayingAudio _audio = allPlayingAudios.firstWhere((audio) {
          return audio.audio.metas.extra["id"] == item.id;
        }, orElse: () {
          return null;
        });

        List<int> _playingIds = playingIds.value;

        if (_audio != null) {
          //// if already playing , remove the audio

          var player = getSinglePlayerForAudioInGroup(_audio.audio);
          player.stop();

          removeAudioFromGroup(_audio.audio, id: item.id);
        } else {
          /// if not already present , add the audio

          if (length < 10) {
            await addAdudiosInGroup(audios: [item]);
          } else {
            showToastMessage(message: "Only 10 sounds can be played at a time");
          }
        }
      } else {
        /// if no audios were there , simply add the audio
        await addAdudiosInGroup(audios: [item]);
      }
    }
  }

  addIntoDownloadQ(ComposerAudio item) async {
    recordCrashlyticsLog(
        "adding composer item ${item.audioTitle} in download queue}");

    var checkingFileExists = await checkIfComposerFileExists(item.fileName);

    if (!checkingFileExists) {
      var taskId = await FlutterDownloader.enqueue(
        url: item.downloadUrl,
        savedDir: _savePath,
        //      notificationtitle: item.audioTitle,
        fileName: item.fileName,
        //    trackID: item.id,
        showNotification: false,
      );

      downloadingComposerAudios.add(DownloadTaskModel(
          audioId: item.id,
          taskId: taskId,
          audioPath: _savePath,
          audioTitle: item.audioTitle,
          fileName: item.fileName));
      downloadingComposerItemsController.add(downloadingComposerAudios);

      composerDownloadingTaskIds.add(taskId);

      //print("download task id iss:::: $taskId");
    }
  }

  getSaveDirectoryPath() async {
    Directory directory = await getApplicationDocumentsDirectory();
    _savePath = directory.path;

    String initialPath =
    Platform.isAndroid ? directory.parent.path : directory.path;

// setting this once so that every time same directory path is not needed to be fetched
    appsDocsDirectoryForThisSession = initialPath;

    var path = join(initialPath, 'files', 'composer_audios');

    bool directoryExists = await Directory(path).exists();

    var savedDir = path;

    if (!directoryExists) {
      var createdPath = await Directory(path).create(recursive: true);
      savedDir = createdPath.path;
    }

//// create directory for converted audios
    var convertedPaths =
    join(initialPath, 'files', 'composer_audios', 'converted');

    if (!Directory(convertedPaths).existsSync()) {
      try {
        await Directory(path).create(recursive: true);
      } catch (e) {
        //print(e);
      }
    }

    _savePath = savedDir;
  }

  handleComposerDownload(DownloadTaskModel taskModel) async {
    Database _db = await DatabaseService().db;

    //print("progress: ${taskModel.taskId}");

    var item = downloadingComposerAudios
        .firstWhere((element) => element.taskId == taskModel.taskId);

    var uptaedTaskModel = item.copyWith(
        progress: taskModel.progress,
        downloadTaskStatus: taskModel.downloadTaskStatus);

    if (taskModel.downloadTaskStatus == DownloadTaskStatus.complete) {
      var item = downloadingComposerAudios
          .firstWhere((element) => element.taskId == taskModel.taskId);

      ///TODO: to update local files wala table also with the same query

      await DatabaseService().insertIntoDownloadedCFilesTable(
        DownloadTaskModel(
          audioId: item.audioId,
          taskId: item.taskId,
          audioPath: join(_savePath, item.audioTitle),
          audioTitle: item.audioTitle,
          fileName: item.fileName,
        ),
        _db,
      );

      /// /before update

      try {
        var beforeUpdate = await _db.rawQuery(
            '''SELECT *  FROM "${DatabaseService.composer_audio_files}" 
          WHERE id=${item.audioId}''');
      } catch (e) {
        //print(e);
      }

      try {
        var updateRes = await _db
            .rawQuery(''' UPDATE "${DatabaseService.composer_audio_files}"
           SET audioPathType="$audio_file"
           WHERE id=${item.audioId} ''');
      } catch (e) {
        //print(e);
      }

      try {
        var afterUpdate = await _db.rawQuery(
            '''SELECT *  FROM "${DatabaseService.composer_audio_files}" 
          WHERE id=${item.audioId}''');
        //print("updated: ");
        //log.i(afterUpdate);
      } catch (e) {
        //print(e);
      }

      localComposerAudiosList.value.add(item.fileName);

      downloadingComposerAudios.remove(item);

      downloadingComposerItemsController.add(downloadingComposerAudios);

      composerDownloadingTaskIds.remove(taskModel.taskId);

      /// adding in stream to update the list
      lastDownloadedItemController.add(item.audioId);
    }

    var res =
    await DatabaseService().getAllDownloadedComposerFileNamesList(_db);
  }

  Future<bool> checkIfComposerFileExists(filename) async {
    Directory directory = await getApplicationDocumentsDirectory();

    String initialPath =
    Platform.isAndroid ? directory.parent.path : directory.path;
    var tempPath = join(initialPath, 'files', 'composer_audios');
    Directory dir = Directory(tempPath);
    String path = join(
      dir.path,
      filename,
    );

    // File file = File(downloadedLocation);
    File file = File(path);
    bool doFileExists = await file.exists();

    return doFileExists;
  }

  loadAudioAssetsFileNames(BuildContext context) async {
    recordCrashlyticsLog("Gettting assets filenames");
    var assetData =
    await DefaultAssetBundle.of(context).loadString("AssetManifest.json");

    Map<String, dynamic> fileNames = json.decode(assetData);

    var audioAssetsList =
    fileNames.keys.where((key) => key.contains("assets/audio/")).toList();

    //log.e(audioAssetsList);
    assetsComposerAudiosList.value = audioAssetsList;

    var some = assetsComposerAudiosList.value;

    //print(some);

    var item = some[0];

    DefaultAssetBundle.of(context).load(item);
  }

  getAndSetDownloadedComposerFileNamesList() async {
    recordCrashlyticsLog("Gettting downloaded comopser items  filenames");
    var list =
    await locator<ComposerProvider>().getDownloadedComposerFileNamesList();

    localComposerAudiosList.value = list;
    var some = localComposerAudiosList.value;

    //print(some);
  }

  Future<String> _convertAsset(
      {String filename,
        Uint8List dataBuffer,
        String finalExtensionType,
        ComposerAudio item}) async {
    if (dataBuffer != null) {
      flutterFFmpeg = FlutterFFmpeg();

      // var tempDir = await getExternalStorageDirectory();

      var initialPath = appsDocsDirectoryForThisSession;

      var tempDir = join(initialPath, 'files', 'composer_audios', 'converted');

      var directory = Directory(tempDir);
      if (!directory.existsSync()) directory.createSync(recursive: true);

      File inputfile = File('''$tempDir/$filename''');

      bool _inputFileExist = inputfile.existsSync();

      var fileNameWithoutExtension = filename.split(".ogg").first.trim();

      var convertedOutputFile =
      File('''$tempDir/$fileNameWithoutExtension.$finalExtensionType''');

      bool _doesOutputFileExists = convertedOutputFile.existsSync();
      if (_doesOutputFileExists) {
        Database _db = await DatabaseService().db;
        try {
          var updateRes = await _db
              .rawQuery(''' UPDATE "${DatabaseService.composer_audio_files}"
           SET audioPathType="$audio_file",
          fileName="$fileNameWithoutExtension.$finalExtensionType"
           WHERE id=${item.id} ''');
        } catch (e) {}

        DatabaseService().insertIntoDownloadedCFilesTable(
          DownloadTaskModel(
            audioId: item.id,
            taskId: "adfgawgegevceec",
            audioPath: convertedOutputFile.path,
            audioTitle: item.audioTitle,
            fileName: "$fileNameWithoutExtension.$finalExtensionType",
          ),
          _db,
        );

        return convertedOutputFile.path;
      }

      try {
        File("$tempDir/$filename").writeAsBytesSync(dataBuffer);
//
        // inputfile.writeAsBytesSync(dataBuffer);
      } catch (e) {
        //print(e);
      }

      var inputFilePath = inputfile.path;

      var outputFilePath =
      '''$tempDir/$fileNameWithoutExtension.$finalExtensionType''';

      /// converting using ffmpeg
      var res = await flutterFFmpeg.execute(
        // " -loglevel error -y -i $inputFilePath -c:a copy $outputFilePath"
          "-y -i $inputFilePath  $outputFilePath");

      //print(res);

      if (res == 0) {
        inputfile.delete();
      }
      return outputFilePath;
    }
  }

  Future<String> _convertFile({
    String filename,
    Uint8List dataBuffer,
    String inputFilePath,
    String finalExtensionType,
  }) async {
    var initialPath = appsDocsDirectoryForThisSession;

    var tempDir = join(initialPath, 'files', 'composer_audios');
    var fileNameWithoutExtension = filename.split(".ogg").first.trim();

    var outputFilePath =
    '''$tempDir/$fileNameWithoutExtension.$finalExtensionType''';

    var outputFileExists = File(outputFilePath).existsSync();
    if (outputFileExists) return outputFilePath;

    /// converting using ffmpeg
    flutterFFmpeg = FlutterFFmpeg();

    var res =
    await flutterFFmpeg.execute("-y -i $inputFilePath  $outputFilePath"
      // "-y -i $inputFilePath -c:a copy $outputFilePath"
    );

    return outputFilePath;
  }

  Future<bool> isFFmpegAvailable() async {
    if (_flutterFFmpegConfig == null) {
      _flutterFFmpegConfig = FlutterFFmpegConfig();
      String version = await _flutterFFmpegConfig.getFFmpegVersion();
      String platform = await _flutterFFmpegConfig.getPlatform();
      ffmpegAvailable = (version != null && platform != null);
    }

    return ffmpegAvailable;
  }

  List<ComposerAudio> get playingComposerAudiosListOnly =>
      _playingComposerAudiosListOnly;
}
