import 'package:flutter/material.dart';
import 'package:goodvibesoffl/locator.dart';
import 'package:goodvibesoffl/models/music_model.dart';
import 'package:goodvibesoffl/services/player_service.dart';
import 'adsModelService.dart';

class RewardedTrack {
  Track track;
  DateTime _dateTime;

  RewardedTrack({
    @required this.track,
  }) : _dateTime = DateTime.now();

  bool get isExpired {
    if (_dateTime == null)
      return false;
    else {
      if (DateTime.now().difference(_dateTime).inSeconds < 300) return false;
      return true;
    }
  }
}

class AdsManagerService {
  int _numberofTrackPlayed = 0;
  bool _isRewardAdsShown = false;
  bool _isInterstialAdsShown = false;
  final playerService = locator<MusicService>();
  List<RewardedTrack> _rewaredTracks = [];

  void addTrackCount() {
    if (_isInterstialAdsShown) {
      _numberofTrackPlayed = 0;
      _isInterstialAdsShown = false;
    } else
      _numberofTrackPlayed++;
  }

  bool get showInterstitialAd {
    var adAfterTracksCount =
        locator<AdsModelService>().adsData.singlePlayerAdCcount;

    /// every track has to show ads before, even the first track
    /// if adAfterTracksCount is 1 , then first track gets ommited,
    /// therefore ,if 1 comes from remote config, value is set to 0
    adAfterTracksCount = adAfterTracksCount == 1 ? 0 : adAfterTracksCount;

    print("ad value from remote config is:$adAfterTracksCount ");

    if (_isRewardAdsShown) {
      rewardAdsShown = false;
      return false;
    }

    ///  if (_numberofTrackPlayed == 0) return false;
    if (!_isRewardAdsShown && _numberofTrackPlayed >= adAfterTracksCount) {
      /// if interstetial ads is to be shown after every track i.e [adAfterTracksCount] =1  from remote config
      /// never set true to `_isINterstitialAdsShown`.
      if (adAfterTracksCount == 1 || adAfterTracksCount == 0) {
        _isInterstialAdsShown = false;
      } else {
        _isInterstialAdsShown = true;
      }

      return true;
    }
    return false;
  }

  set rewardAdsShown(bool val) {
    _isRewardAdsShown = val;
  }

  addRewardedTrack(Track track) {
    int index = _rewaredTracks.indexWhere((e) => e.track.id == track.id);
    if (index >= 0) {
      _rewaredTracks[index] = RewardedTrack(track: track);
    } else {
      _rewaredTracks.add(RewardedTrack(track: track));
    }
  }

  bool showAdsToCurrentTrack(Track track) {
    Track currentTrack = playerService.getCurrentTrack();
    if (currentTrack?.id == track.id &&
        playerService.playingAudio.value != null)
      return false;
    else {
      int index = _rewaredTracks.indexWhere((e) => e.track?.id == track.id);
      if (index >= 0) {
        return _rewaredTracks[index].isExpired;
      } else
        return true;
    }
  }
}
