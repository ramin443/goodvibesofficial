import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
//import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:goodvibesoffl/bloc/downloadpage/downloadpage_bloc.dart';
import 'package:goodvibesoffl/models/composer_audio_model.dart';
import 'package:goodvibesoffl/models/music_model.dart';
import 'package:goodvibesoffl/models/player_status_enum.dart';
import 'package:goodvibesoffl/models/playlist_model.dart';
//import 'package:goodvibesofficial/pages/home/composer/saved_composer_mixes.dart';
import 'package:goodvibesoffl/providers/favorites_provider.dart';
import 'package:goodvibesoffl/providers/music_providers/music_repository.dart';
import 'package:goodvibesoffl/providers/rituals_provider.dart';
import 'package:goodvibesoffl/screens/home/composer/saved_composer_mixes.dart';
import 'package:goodvibesoffl/services/adsManagerService.dart';
import 'package:goodvibesoffl/services/api_service.dart';
import 'package:goodvibesoffl/services/services.dart';
import 'package:goodvibesoffl/services/user_service.dart';
import 'package:goodvibesoffl/utils/common_functiona.dart';
import 'package:goodvibesoffl/widgets/common_widgets/common_widgets_methods.dart';
import 'package:goodvibesoffl/widgets/dialog_boxes.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';
import '../locator.dart';
import 'package:goodvibesoffl/services/database_service.dart';
import 'package:goodvibesoffl/services/shared_pref_service.dart';
import 'package:path/path.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:goodvibesoffl/services/composer_service.dart';

class MusicService {
  final _apiLocator = ApiService();

  List<Track> playlistTracks = List();

  bool userPaid = false;
  bool isRepeatTrack = false;

  ValueNotifier<int> trackId = ValueNotifier(-1);
  int songIndex;
  int downloadingTrackId = -2;
  int downloadTrackIndex = 9999;
  int currentPlayerIndex = 9999;
  int downloadId = -1;

  String downloadTaskId = "";
  bool _isPlaylist = false;
  bool _isTimerStarted = false;
  int _playlistPlayingIndex = -1;

  String filePath = '';
  String localFileUrl = '';

  var databasePath;

  Timer timer;
  Timer saveTrackPositionTimer;
  Timer updateRitualTrackPositionApiTimer;
  AssetsAudioPlayer assetsAudioPlayer;
  double pos = 0.0;

  ValueNotifier<PlayList> currentPlaylist = ValueNotifier(null);

  ValueNotifier<int> downloadPercantage = ValueNotifier(0);
  ValueNotifier<bool> isDownloading = ValueNotifier(false);
  ValueNotifier<bool> isDownloaded = ValueNotifier(false);

  ValueNotifier<bool> isFav = ValueNotifier(true);

  ValueNotifier<Duration> current = ValueNotifier(Duration(seconds: 0));
  ValueNotifier<Duration> max = ValueNotifier(Duration(seconds: 0));
  ValueNotifier<Duration> remainingTimerDuration =
  ValueNotifier(Duration(seconds: 0));
  ValueNotifier<PlayerStatus> playerStatus =
  ValueNotifier(PlayerStatus.isStopped);
  ValueNotifier<bool> isFirstClickTimer = ValueNotifier(true);
  ValueNotifier<int> currentPlaylistID = ValueNotifier(-1);

  ValueNotifier<bool> isSingleTrackWithComposerMixPlaying =
  ValueNotifier(false);

  StreamController<int> playbackDurationController =
  StreamController<int>.broadcast();

  Track repeatTrack;

  /// [currentTrack] gives the track that is just pressed,with navigation action , clicking next or previous button, from downloads, favourites and history
  ValueNotifier<Track> currentTrack = ValueNotifier(null);

  /// [downloadingTrack] is used to track the info the trakc being downloaded
  Track downloadingTrack;
  final cancelTokens = <String, CancelToken>{};

  //New Implementation

  ValueNotifier<Stream<PlayingAudio>> playingAudio = ValueNotifier(null);
  ValueNotifier<Stream<Playing>> finishedTracked = ValueNotifier(null);
  ValueNotifier<Playlist> playlist = ValueNotifier(Playlist());
  ValueNotifier<ValueStream<bool>> currentTrackStatus = ValueNotifier(null);
  ValueNotifier<ValueStream<Duration>> currentTrackPosition =
  ValueNotifier(null);
  ValueNotifier<ValueStream<bool>> currentTrackBufferingStatus =
  ValueNotifier(null);
  ValueNotifier<Stream<RealtimePlayingInfos>> realtimePlayingInfo =
  ValueNotifier(null);

  ValueNotifier<ValueStream<PlayerState>> playingState = ValueNotifier(null);

  final composerService = ComposerService();
  //--------------------------------------
  getTrackStatus() async {
    bool isFavouritePulled =
        await SharedPrefService().getIsFavouritePulled() ?? false;

    if (!isFavouritePulled) {
      await Future.wait<dynamic>(
        [
         FavoritesProvider().getFavsFromApi(),
          SharedPrefService().setIsFavouritePulled(true)
        ],
      );
    }

    await Future.wait<bool>(
      [checkIfDownloaded(), isFavTrack()],
    ).then((results) async {
      isDownloaded.value = results[0];
      isFav.value = results[1];
    });

    if (isDownloaded.value) {
      await getMusicFileLocalUrl();
    }

    return {"is_downloaded": isDownloaded.value};
  }

  Future<bool> checkIfDownloaded() async {
    bool result = await checkIfMusicFileExists(currentTrack?.value?.filename);
    isDownloaded.value = result;
    return result;
  }

  int getMusicDownloadPercentage(int d, int t) {
    return (d * 100 ~/ t);
  }

  setDownloadingFalse() {
    downloadPercantage.value = 0;
    isDownloading.value = false;
  }

  getDownloadInformation({int trackId}) async {
    Map response = await _apiLocator.getDownloadInformation(trackId: trackId);

    if (response.containsKey('data')) {
      downloadId = response['data']["id"];
    } else {
      setDownloadingFalse();
      showToastMessage(
        message: 'Network Error!',
      );
      return;
    }
  }

  /// download related methods
  implementDownload(
      {ValueChanged<bool> downloadSuccess,
        @required BuildContext context}) async {
    Track track = currentTrack.value;
    isDownloading.value = true;
    downloadingTrackId = trackId.value;

    downloadingTrack = track;

    /// getting download information
    await getDownloadInformation(trackId: track.id);

    var filename = trimDownloadFilename(track.filename);

    Directory directory = await getApplicationDocumentsDirectory();

    String initialPath =
    Platform.isAndroid ? directory.parent.path : directory.path;

    var path = join(initialPath, 'files', 'sounds');

    bool directoryExists = await Directory(path).exists();

    var savedDir = path;

    if (!directoryExists) {
      var createdPath = await Directory(path).create(recursive: true);
      savedDir = createdPath.path;
    }
    //print("file path is::: $initialPath  and file name is : $filename");

    isDownloading.value = true;
    downloadingTrack = track;
    downloadingTrackId = track.id;

    DatabaseService().addDownloadedItemIntoDownloadList(
        track: downloadingTrack,
        downloadPath: join(
          savedDir,
          track.filename,
        ),
        downloadId: downloadId ?? 1);
    BlocProvider.of<DownloadpageBloc>(context).add(
      DownloadPageAddTrack(
        track: downloadingTrack.copyWith(downloadId: downloadId),
      ),
    );
//     // setting its id to downloding track id
    downloadingTrackId = currentTrack.value.id;
    recordCrashlyticsLog("Start downloading ${track.title}");
    final taskId = await FlutterDownloader.enqueue(
      url: track.trackDownloadUrl,
      savedDir: savedDir,
      fileName: track.filename,
      //     notificationtitle: track.title,
      showNotification: true,
      //     trackID: track.id,
      openFileFromNotification: true,
    );

    downloadTaskId = taskId;
  }

  cancelFlutterDownloaderDownload() async {
    recordCrashlyticsLog("cancelled download");
    downloadPercantage.value = 0;

    await FlutterDownloader.cancel(taskId: downloadTaskId);
    downloadingTrackId = -2;
    // downloadingTrack = null;
  }

  Future stopDown() async {
    cancelFlutterDownloaderDownload();
    await DatabaseService().deleteDownloadItem(
        trackId: downloadingTrackId ?? currentTrack.value.id);
    setDownloadingFalse();
    notifyServerDownloadCancellation();
  }

  notifyServerDownloadCancellation() async {
    await _apiLocator.cancelDownloadNotifyServer(
      trackId: currentTrack.value.id,
      downloadId: downloadId,
    );
  }

  notifyServerDownloadComplete() async {
    isDownloading.value = false;
    await _apiLocator.downloadFinished(
      downloadId: downloadId,
      trackId: currentTrack.value.id,
    );
  }

  Future deleteDown({int trackId, int trackDownloadId}) async {
    Track tempTrack = await DatabaseService().getSingleDownload(trackId);
    trackDownloadId = tempTrack.downloadId;

    await _apiLocator.deleteDownload(
        trackId: trackId, downloadId: trackDownloadId);

    await DatabaseService()
        .deleteDownloadItem(trackId: trackId ?? currentTrack.value.id);
  }

  void seekMusic(d) {
    assetsAudioPlayer.seek(Duration(seconds: (d as double).floor()));
  }

//// favoutites methods
  Future<bool> isFavTrack() async {
    bool _isFav =
    await DatabaseService().checkFavourite(currentTrack?.value?.id);
    isFav.value = _isFav;
    return _isFav;
  }

  Future implementFavourite(track) async {
    try {
      Map res = await _apiLocator.addOnFavorite(track.id);

      if (res != null && res.containsKey("data")) {
        showToastMessage(message: "Added into your favorites list!");
      } else {
        showToastMessage(message: "Could not add into your favorites list");
      }

      await DatabaseService().addIntoFavourite(track);
      isFav.value = true;
    } catch (e) {
      showToastMessage(message: "Could not add into your favorites list");
    }
  }

  deletFav(track) async {
    try {
      var res = await _apiLocator.removeFromFavorite(track.id);
      if (res != null && res.containsKey("data")) {
        showToastMessage(message: "Removed from your favorites list");
      } else {
        showToastMessage(message: "Could not remove from favorites list");
      }
      await DatabaseService().deleteFromFavourite(track.id);
      isFav.value = false;
    } catch (e) {
      showToastMessage(message: "Could not remove from favorites list");
    }
  }

  /// history methods
  addIntoHistory({Track track}) async {
    await DatabaseService().addTrackInHistory(track: track);
    MusicProvider().trackPlay.add(track);
  }

  void startTimer() {
    _isTimerStarted = true;
    timer = Timer.periodic(Duration(seconds: 1), (t) {
      if (remainingTimerDuration.value < Duration(seconds: 1)) {
        timer.cancel();
        assetsAudioPlayer?.pause();
        pauseComposer();
        isFirstClickTimer.value = true;
        _isTimerStarted = false;
        return;
      }
      remainingTimerDuration.value =
          remainingTimerDuration.value - Duration(seconds: 1);
      isFirstClickTimer.value = false;
    });
  }

  pauseComposer() {
    final composer = ComposerService();
    if (composer.group != null || composer.playingIds.value.isNotEmpty) {
      composer.group.stop();
      composer.playingIds.value = [];
      composer.playingItemsListStream.add([]);
    }
  }

  void stopTimer() async {
    timer?.cancel();
    final currentPlayerState = await getPlayerState();
    if (currentPlayerState == PlayerState.play) {
      assetsAudioPlayer?.pause();
    }

    remainingTimerDuration.value = Duration(seconds: 0);
    _isTimerStarted = false;
    isFirstClickTimer.value = true;
  }

  addDownloadInforIntoDatabase({Track track, int downloadId}) async {
    /// after download success add item into db
    try {
      await DatabaseService().addDownloadedItemIntoDownloadList(
          downloadId: downloadId, downloadPath: filePath, track: track);
    } catch (e, s) {
      showToastMessage(message: 'Could not save file on your phone.');
 //     FirebaseCrashlytics.instance.recordError(e, s,
   //       reason: "Error occured in database while saving downloads");
     // FirebaseCrashlytics.instance
       //   .setUserIdentifier(locator<UserService>().user.value.email ?? '');
    }
  }

  getMusicFileLocalUrl() async {
    List<Map<String, dynamic>> some =
    await DatabaseService().getMusicFileLocalUrl(currentTrack.value.id);
    if (some.isEmpty) {
      isDownloaded.value = false;
      return;
    }
    Map map = some[0];
    localFileUrl = map['url'];
  }

  // new Implementation

  _onTrackFinished() {
    assetsAudioPlayer.playlistAudioFinished.listen((event) async {
      currentTrack.value = getCurrentTrack();

      if (currentTrack.value.saveTrackDuration) {
        _closeSavePositionTimer();
        var state = await getPlayerState();

        await DatabaseService()
            .updateRitualTrackCompletionStatus(currentTrack.value);
      }

      trackId.value = getCurrentTrack()?.id;
      if (currentTrack != null) await getTrackStatus();
    });
  }

  _onTrackReadyToPlay() {
    assetsAudioPlayer.onReadyToPlay.listen((event) async {
      if (event != null) {
        addIntoHistory(track: getCurrentTrack());

        if (currentTrack.value.saveTrackDuration) {
          DatabaseService().insertIntoRitualsTable(track: currentTrack.value);

          if (currentPlaylist != null) {
            DatabaseService()
                .insertIntoPlaylistTable(playlist: currentPlaylist.value);
          }
        }

        if (assetsAudioPlayer?.readingPlaylist?.audios?.length == 1)
          AdsManagerService().addTrackCount();
        _apiLocator.playTrack(trackId: getCurrentTrack().id);
      }
    });
  }

  _setupDiffernetPlayerNotiferValues() {
    playingAudio.value = assetsAudioPlayer.onReadyToPlay;
    finishedTracked.value = assetsAudioPlayer.playlistAudioFinished;
    playlist.value = assetsAudioPlayer.playlist;

    currentTrackStatus.value = assetsAudioPlayer.isPlaying;
    currentTrackPosition.value = assetsAudioPlayer.currentPosition;
    currentTrackBufferingStatus.value = assetsAudioPlayer.isBuffering;

    realtimePlayingInfo.value = assetsAudioPlayer.realtimePlayingInfos;
    playingState.value = assetsAudioPlayer.playerState;
  }

  _addErrorHandlerInPlayer() {
    assetsAudioPlayer.onErrorDo = (_handler) {
      showToastMessage(message: "An error occured while playing this track.");
  //    _handler.player.setBufferingOff();
      _handler.player.stop();
    };
  }

  initPlayer({BuildContext context}) async {
    assetsAudioPlayer = AssetsAudioPlayer();
    _addErrorHandlerInPlayer();
    _setupDiffernetPlayerNotiferValues();
    _onTrackReadyToPlay();
    _onTrackFinished();
  }

  Track getCurrentTrack() {
    if (assetsAudioPlayer != null) {
      if (assetsAudioPlayer.readingPlaylist == null)
        return null;
      else
        return (assetsAudioPlayer.readingPlaylist.current.metas.extra["track"]
        as Track);
    }
    return null;
  }

  _startSavePositionTimer(Track track) {
    if (saveTrackPositionTimer != null) saveTrackPositionTimer.cancel();

    if (track.saveTrackDuration) {
      bool _isBuffering = assetsAudioPlayer.isBuffering.value;
      saveTrackPositionTimer =
          Timer.periodic(Duration(seconds: 5), (timer) async {
            // print(' 5 seconds timer at : ${DateTime.now()}');
            // print("3 sevonds timer on track: ${track.title}");
            var _stats = track.playableStat;

            if (assetsAudioPlayer.currentPosition.value.toString() !=
                "0:00:00.000000") {
              if (_isBuffering == false) {
                var _trackDurationInSeconds = getSecondsFromDurationString(
                    assetsAudioPlayer.currentPosition.value.toString());

                DatabaseService()
                    .updateRitualTrackDuration(_trackDurationInSeconds, track);
              }
              // print('current track id : ${track.id}');

              playbackDurationController.add(track.id);
            }
          });

      updateRitualTrackPositionApiTimer =
          Timer.periodic(Duration(seconds: 30), (timer) async {
            // print(' 10 timer at : ${DateTime.now()}');
            // print("10 sevonds timer on track: ${currentTrack.value.title}");

            var _stats = track.playableStat;

            var _trackDurationInSeconds = getSecondsFromDurationString(
                assetsAudioPlayer.currentPosition.value.toString());

            if (_isBuffering == false) {
              if (track.playableStat.status != CompletionStatus.Complete)
                RitualsProvider().updateRitualPlayedDuration(
                  playableStatId: _stats.id,
                  trackPlayedDuration: _trackDurationInSeconds,
                );
            }
          });
    }
  }

  _closeSavePositionTimer() {
    if (saveTrackPositionTimer != null) saveTrackPositionTimer.cancel();
    if (updateRitualTrackPositionApiTimer != null) {
      updateRitualTrackPositionApiTimer.cancel();
    }
  }

  playSinglePlayer(
      {bool isFromPlaylist = false,
        ComposerSavedMix composerMix,
        BuildContext context,
        bool togglePlayback = true}) async {
    var pState = assetsAudioPlayer?.playerState?.value;
    final composerService = ComposerService();

    composerMix = currentTrack.value.composerMix;

    await _handleComposerFromSinglePlayer(pState: pState);

    if (!isFromPlaylist) {
      currentPlaylistID.value = -1;
    }

    if (playingAudio.value == null) {
      initPlayer();
      _openAssetsAudioPlayer(isFromPlaylist);
      _startSavePositionTimer(currentTrack.value);
    } else {
      ///if an audio is playing already
      var _track = playlist.value.audios.first.metas.extra["track"] as Track;
      if (currentTrack.value.id == _track.id) {
        /// currently playing/paused audioo is same as CurrentTrack
        try {
          var _track = getCurrentTrack();

          if (togglePlayback) {
            await assetsAudioPlayer?.play();

            _startSavePositionTimer(_track);
          }
        } on PlatformException catch (e) {
          stopPlayer();
          _closeSavePositionTimer();
        }
      } else {
        /// diffrent track
        _openAssetsAudioPlayer(isFromPlaylist);
        _startSavePositionTimer(currentTrack.value);
      }
    }

    if (composerMix != null && pState == PlayerState.pause) {
      if (composerService.playingIds.value.isNotEmpty)
        await composerService.group.play();
    }
  }

  playComposerOnly(SavedComposerMixes composerMix, PlayerState pState) async {
    if (composerMix != null && pState == PlayerState.pause) {
      if (composerService.playingIds.value.isNotEmpty)
        await composerService.group.play();
    }
  }

  play() {
    assetsAudioPlayer?.play();
  }

  _handleComposerFromSinglePlayer(
      {@required pState,
        ComposerSavedMix composerMix,
        BuildContext context}) async {
    /// if hass composer mix, stop and remove all currently playing composer
    /// getting the current player state (paused or playing or stop)
    if (playingAudio.value != null) {
      pState = assetsAudioPlayer.playerState?.value;
    } else {
      pState = PlayerState.stop;
    }

    if (pState != PlayerState.pause) {
      if (composerMix != null && composerMix.audios.isNotEmpty) {
        if (composerService.playingIds.value.isNotEmpty) {
          composerService.clearAll();
        }

        await composerService.getSaveDirectoryPath();

        composerService.intComposerForSinglePlayer(context);
        composerService.addAdudiosInGroup(audios: composerMix.audios);
        isSingleTrackWithComposerMixPlaying.value = true;
      }
    }

    /// list of composer audios that were playing beforeg
    final List<ComposerAudio> _composerAudios = [
      ...composerService.playingComposerAudiosListOnly
    ];

    /// if single player with composer audios was playing before
    /// and now composer mix in current track object is null
    /// then stop the composer i.e clearAll function is called
    if (isSingleTrackWithComposerMixPlaying.value && composerMix == null) {
      composerService.clearAll();
    } else if (_composerAudios.isNotEmpty &&
        composerMix == null &&
        isSingleTrackWithComposerMixPlaying.value != true) {
      /// if the current playing track is not single player with composer audio
      ///  clear all currently playing composer and intialize composer group
      /// for singl player

      final List<ComposerAudio> tempList = _composerAudios;

      composerService.clearAll();
      // composerService.playingComposerAudiosListOnly.clear();
      composerService.intComposerForSinglePlayer(context);

      await composerService.addAdudiosInGroup(audios: tempList);
      if (assetsAudioPlayer != null)
        assetsAudioPlayer?.isBuffering.listen((status) {
          if (status) {
            bool _isAlredyPlaying = composerService.group?.isPlaying?.value;

            if (!_isAlredyPlaying) composerService.group.play();
          }
        });

      isSingleTrackWithComposerMixPlaying.value = false;
    }
  }

  _openAssetsAudioPlayer(bool isFromPlaylist) async {
    playlist.value = await _getSingleTrackPlayList();
    try {
      await assetsAudioPlayer
          ?.open(
        playlist.value,
        showNotification: true,
        autoStart: true,
        playInBackground: PlayInBackground.enabled,
        loopMode: isFromPlaylist ? LoopMode.none : LoopMode.single,
        notificationSettings: NotificationSettings(
          customStopAction: (_) {
            _closeSavePositionTimer();
            playingAudio.value = null;
            assetsAudioPlayer?.stop();

            if (ComposerService().playingIds.value.isNotEmpty) {
              ComposerService().clearAll();
            }
          },
          customPlayPauseAction: (value) {
            playOrPausePlayer();
          },
          customPrevAction: seekRewindSinglePlayer,
          customNextAction: seekForwardSinglePlayer,
        ),
      )
          .catchError((error) {
        showSinglePlayerErrorDialog(
            currentTrack: currentTrack.value, error: error.toString());
        stopPlayer();
        _closeSavePositionTimer();
      });

      if (currentTrack.value.lastPlayedDuration != null &&
          currentTrack.value.lastPlayedDuration != Duration.zero) {
        await assetsAudioPlayer.seek(currentTrack.value.lastPlayedDuration);
      }
      if (currentTrack.value.saveTrackDuration) {
        await assetsAudioPlayer.seek(currentTrack.value.lastPlayedDuration);
      }
    } on PlatformException catch (e) {
      stopPlayer();
      _closeSavePositionTimer();
    }
  }

  seekForwardSinglePlayer(_) {
    assetsAudioPlayer.realtimePlayingInfos.first.then((audio) async {
      if ((audio.duration.inSeconds - audio.currentPosition.inSeconds) > 15) {
        try {
          await assetsAudioPlayer?.seekBy(Duration(seconds: 15));
        } on PlatformException catch (e) {
          //print("error on player is::: $e");
          stopPlayer();
          _closeSavePositionTimer();
        }
      }
    });
  }

  seekRewindSinglePlayer(_) {
    assetsAudioPlayer.realtimePlayingInfos.first.then((audio) async {
      if (audio.currentPosition.inSeconds > 15) {
        try {
          assetsAudioPlayer?.seekBy(-Duration(seconds: 15));
        } on PlatformException catch (e) {
          stopPlayer();
          _closeSavePositionTimer();
          //print("error on player is::: $e");
        }
      }
    });
  }

  pauseSinglePlayer() {
    assetsAudioPlayer?.pause();
    _closeSavePositionTimer();
    final composerService = ComposerService();

    bool _isPlaying = composerService.group != null
        ? composerService.group?.isPlaying?.value ?? false
        : false;

    if (composerService.playingIds != null && _isPlaying) {
      composerService.group.pause();
    }
    var pState = assetsAudioPlayer.playerState?.value.toString();
  }

  playOrPausePlayer() async {
    final composerService = ComposerService();

    try {
      if (assetsAudioPlayer.isPlaying.value) {
        _closeSavePositionTimer();
        await assetsAudioPlayer.pause();
      } else {
        var _track = getCurrentTrack();
        _startSavePositionTimer(_track);
        await assetsAudioPlayer.play();
      }

      if (composerService.playingIds != null && composerService.group != null) {
        if (composerService.group.isPlaying.value) {
          await composerService.group.pause();
        }
      } else if (composerService.group != null &&
          composerService.playingIds != null &&
          composerService.group.isPlaying.value == false) {
        await composerService.group.play();
      }
    } on PlatformException catch (e) {
      //print("error on player is::: $e");
      stopPlayer();
      _closeSavePositionTimer();
    }
  }

  /// ****Deprecated: this function is no longer used for playing tracks in playlist
  /// if used change/modify [_getMultipleTrackPlaylist] function also
  playFromPlaylistPlayer(
      {int startIndex = 0, @required BuildContext context}) async {
    if (playingAudio.value == null) initPlayer(context: context);
    playlist.value = await _getMultipleTrackPlaylist(startIndex: startIndex);
    try {
      await assetsAudioPlayer
          ?.open(
        playlist.value,
        showNotification: true,
        autoStart: true,
        playInBackground: PlayInBackground.enabled,
        notificationSettings: NotificationSettings(
          customStopAction: (_) {
            _closeSavePositionTimer();
            playingAudio.value = null;
            currentPlaylistID.value = -1;
            assetsAudioPlayer.stop();
          },
          customPrevAction: seekRewindSinglePlayer,
          customNextAction: seekForwardSinglePlayer,
        ),
      )
          .catchError((error) {
        stopPlayer();
        _closeSavePositionTimer();
      });
    } on PlatformException catch (e) {
      //print("error on player is::: $e");
      stopPlayer();
      _closeSavePositionTimer();
    }
  }

  Future<Playlist> _getSingleTrackPlayList() async {
    String url = "";

    var _currentlyDownloadingTrackId = downloadingTrackId;

    if (_currentlyDownloadingTrackId == currentTrack.value.id) {
      url = "";
    }

    if (isDownloaded.value) {
      var fileOnlyName = currentTrack.value.filename;
      var docsDirectoryPath = await getApplicationDocumentsDirectory();

      if (Platform.isIOS) {
        var temp =
        join(docsDirectoryPath.path, "files", "sounds", fileOnlyName);
        url = temp;
      } else {
        /// andoroid

        var temp = join(
            docsDirectoryPath.parent.path, "files", "sounds", fileOnlyName);
        url = temp;
      }
    } else {
      /// if not downloaded
      url = "";
    }

    return Playlist(
      audios: [
        url.isEmpty
            ? Audio.network(
          currentTrack.value.url,
          metas: Metas(
            title: currentTrack.value.title,
            image: MetasImage.network(currentTrack.value.image),
            artist: currentTrack.value.gname ?? "",
            extra: {"track": currentTrack.value},
            id: currentTrack.value.id.toString(),
          ),
        )
            : Audio.file(
          url,
          metas: Metas(
              title: currentTrack.value.title,
              image: MetasImage.network(currentTrack.value.image),
              artist: currentTrack.value.gname ?? "",
              extra: {"track": currentTrack.value},
              id: currentTrack.value.id.toString()),
        )
      ],
      startIndex: 0,
    );
  }

  Future<Playlist> _getMultipleTrackPlaylist({int startIndex = 0}) async {
    List<Audio> item = [];
    final paidStatus = UserService().user.value.paid;
    for (int i = 0; i < playlistTracks.length; i++) {
      if (!paidStatus && playlistTracks[i].paid) continue;

      String url =
          (await _checkAndGetDownloadedFileUrl(playlistTracks[i])) ?? "";

      if (url.isEmpty)
        item.add(
          Audio.network(
            playlistTracks[i].url,
            metas: Metas(
              title: playlistTracks[i].title,
              image: MetasImage.network(playlistTracks[i].image),
              artist: playlistTracks[i].gname ?? "",
              extra: {"track": playlistTracks[i]},
              id: playlistTracks[i].id.toString(),
            ),
          ),
        );
      else
        item.add(
          Audio.file(
            url,
            metas: Metas(
              title: playlistTracks[i].title,
              image: MetasImage.network(playlistTracks[i].image),
              artist: playlistTracks[i].gname ?? "",
              extra: {"track": playlistTracks[i]},
              id: playlistTracks[i].id.toString(),
            ),
          ),
        );
    }
    return Playlist(
      audios: item,
      startIndex: startIndex,
    );
  }

  Future<String> _checkAndGetDownloadedFileUrl(Track track) async {
    var res = await DatabaseService().getMusicFileLocalUrl(track.id)
    as List<Map<String, dynamic>>;

    var url = "";

    var fileOnlyName = trimDownloadFilename(track.filename);
    var docsDirectoryPath = await getApplicationDocumentsDirectory();
    if (Platform.isIOS) {
      var temp = join(docsDirectoryPath.path, "files", "sounds", fileOnlyName);
      url = temp;
    } else {
      /// andoroid
      var temp =
      join(docsDirectoryPath.parent.path, "files", "sounds", fileOnlyName);
      url = temp;
    }

    var esists = File(url).existsSync();
    if (esists) return url;

    return null;
  }

  updateplaylist({List<Track> myPlaylistTracks}) {
    final paidStatus = UserService().user.value.paid;
    playlistTracks = myPlaylistTracks;
    if (assetsAudioPlayer != null) {
      int playlistLength = assetsAudioPlayer.playlist.audios.length;
      if (playlistLength <= 1) return;
      if (playlistLength < myPlaylistTracks.length) {
        Track fTrack =
        getTrackFromAudio(assetsAudioPlayer.playlist.audios.first);
        Track lTrack = getTrackFromAudio(
            assetsAudioPlayer.playlist.audios[playlistLength - 1]);
        if (fTrack.id == myPlaylistTracks.first.id &&
            lTrack.id == myPlaylistTracks[playlistLength - 1].id) {
          final temp = myPlaylistTracks.sublist(playlistLength)
            ..removeWhere((element) => element.paid);
          if (temp.isEmpty) return;
          assetsAudioPlayer.playlist.addAll(
            getAudioListFromTrack(
              temp,
            ),
          );
        }
      }
    }
  }

  List<Audio> getAudioListFromTrack(List<Track> item) {
    return item
        .map(
          (e) => Audio.network(
        e.url,
        metas: Metas(
          title: e.title,
          image: MetasImage.network(e.image),
          artist: e.gname ?? "",
          extra: {"track": e},
          id: e.id.toString(),
        ),
      ),
    )
        .toList();
  }

  Track getTrackFromAudio(Audio audio) {
    if (audio != null) {
      return audio.metas.extra["track"];
    }
    return null;
  }

  Future<void> stopPlayer() async {
    _closeSavePositionTimer();
 //   assetsAudioPlayer?.setBufferingOff();
    await assetsAudioPlayer?.stop();
    playingAudio.value = null;
    assetsAudioPlayer = null;
  }

  Future<PlayerState> getPlayerState() async {
    return await assetsAudioPlayer?.playerState?.first;
  }
}
