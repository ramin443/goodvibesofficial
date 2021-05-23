import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goodvibesoffl/models/model.dart';
import 'package:goodvibesoffl/screens/premium/getpremium.dart';
import 'package:goodvibesoffl/services/adsManagerService.dart';
import 'package:goodvibesoffl/services/adsModelService.dart';
import 'package:goodvibesoffl/services/connectivity_service.dart';
import 'package:goodvibesoffl/services/interstitialAdsService.dart';
import 'package:goodvibesoffl/services/navigation_service.dart';
import 'package:goodvibesoffl/services/player_service.dart';
import 'package:goodvibesoffl/services/services.dart';
import 'package:goodvibesoffl/utils/utils.dart';

import '../locator.dart';

_playPlaylistTrack(
    {@required Track currentTrack,
      @required MusicService musicLocator,
      @required ComposerSavedMix composerMix,
      @required BuildContext context}) {
  if (currentTrack?.id != musicLocator.currentTrack.value.id) {
    /// if new track is played which is not equal to current track

    musicLocator.playSinglePlayer(
        isFromPlaylist: true, composerMix: composerMix, context: context);
  } else {
    /// if same track , play or pause the current track
    musicLocator.playOrPausePlayer();
  }
}

handleAdsForFreeUser({
  @required MusicService musicLocator,
  @required BuildContext context,
}) async {
  var _track = musicLocator.currentTrack.value;
  if (_track.trackPaidType == TrackPaidType.Premium) {
    {
      Navigator.push(
          context, CupertinoPageRoute(builder: (_) => GetPremium()));
      return;
    }
  }

  if (locator<AdsManagerService>().showInterstitialAd &&
      locator<AdsModelService>().adsData.showInterstitialAd) {
    final _isLoaded = await InterstitialAdsService().isLoaded;
    if (_isLoaded) {
      await InterstitialAdsService().show();
    } else {
      musicLocator.playSinglePlayer(
          composerMix: _track?.composerMix, context: context);
    }
  } else {
    musicLocator.playSinglePlayer(
        composerMix: _track?.composerMix, context: context);
  }
}

_playSingleTrack(
    {@required Track currentTrack,
      @required bool playingStatus,
      @required MusicService musicLocator,
      @required ComposerSavedMix composerMix,
      @required BuildContext context,
      bool togglePlayback = false}) async {
  bool _isUserPaid = locator<UserService>().user.value.paid;

  if (currentTrack?.id == musicLocator.currentTrack.value.id) {
    /// if same track is playing pause the audio , else play the audio

    if (playingStatus) {
      if (togglePlayback) musicLocator.pauseSinglePlayer();
    } else {
      var _cTrack = musicLocator.currentTrack.value;

      //  musicLocator.play();
      musicLocator.playSinglePlayer(
          composerMix: composerMix,
          context: context,
          togglePlayback: togglePlayback);
    }

    //// if current track is different
  } else {
    if (_isUserPaid) {
      musicLocator.playSinglePlayer(
          composerMix: composerMix,
          context: context,
          togglePlayback: togglePlayback);
    }

    //// if user is free user
    else {
      handleAdsForFreeUser(
        musicLocator: musicLocator,
        context: context,
      );
    }
  }
}

_handleTrackOffline(
    {@required ConnectivityStatus connectionStatus,
      @required bool playerBufferingStatus,
      @required bool playingStatus,
      @required BuildContext context,
      @required MusicService musicLocator,
      @required bool isTrackDownloaded}) async {
  if (connectionStatus == ConnectivityStatus.Offline) {
    if (playingStatus && !playerBufferingStatus) {
      musicLocator.pauseSinglePlayer();
    } else if (playerBufferingStatus) {
      PlayerState _playerState = await musicLocator.getPlayerState();

      if (_playerState == PlayerState.stop ||
          _playerState == PlayerState.pause) {
        showOfflineSnackBar(context: context);
      } else {
        musicLocator.stopPlayer();
      }
    } else {
      showOfflineSnackBar(context: context);
    }
    if (!isTrackDownloaded) return;
  }
}

ConnectivityStatus _getStatusFromResult(ConnectivityResult result) {
  switch (result) {
    case ConnectivityResult.mobile:
      return ConnectivityStatus.Cellular;
    case ConnectivityResult.wifi:
      return ConnectivityStatus.WiFi;
    case ConnectivityResult.none:
      return ConnectivityStatus.Offline;
  }
}

onPressedPlayPauseButton(
    {bool fromPlayList = false, bool togglePlayback = false}) async {
  final context = locator<NavigationService>().navigationKey.currentContext;
  final musicLocator = locator<MusicService>();

  var res = await musicLocator.getTrackStatus();
  bool isTrackDownloaded = res['is_downloaded'];

  ConnectivityStatus connectionStatus =
  _getStatusFromResult(await Connectivity().checkConnectivity());
  bool playerBufferingStatus =
      await musicLocator.currentTrackBufferingStatus?.value?.value ?? false;

  bool playingStatus =
      await musicLocator.currentTrackStatus?.value?.value ?? false;
  Track currentTrack = musicLocator.getCurrentTrack();

  await _handleTrackOffline(
    connectionStatus: connectionStatus,
    context: context,
    musicLocator: musicLocator,
    isTrackDownloaded: isTrackDownloaded,
    playerBufferingStatus: playerBufferingStatus,
    playingStatus: playingStatus,
  );

  /// if track is from playlist
  if (fromPlayList) {
    _playPlaylistTrack(
        currentTrack: currentTrack,
        musicLocator: musicLocator,
        composerMix: currentTrack.composerMix,
        context: context);
  } else {
    /// if is a single track
    _playSingleTrack(
      currentTrack: currentTrack,
      playingStatus: playingStatus,
      composerMix: currentTrack?.composerMix,
      context: context,
      musicLocator: musicLocator,
      togglePlayback: togglePlayback,
    );
  }
}
