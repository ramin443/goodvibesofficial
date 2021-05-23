import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goodvibesoffl/models/music_model.dart';
import 'package:goodvibesoffl/services/player_service.dart';
import 'package:goodvibesoffl/utils/theme/style.dart';
import 'package:goodvibesoffl/utils/utils.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import '../../../locator.dart';

class CircularSlider extends StatelessWidget {
  final musicLocator = locator<MusicService>();
  CircularSlider({Key key, this.duration, this.innerChild, this.size})
      : super(key: key);

  var duration;
  final Widget innerChild;
  final size;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Stream<RealtimePlayingInfos>>(
        valueListenable: musicLocator.realtimePlayingInfo,
        builder: (context, currentTrackStream, _) {
          return StreamBuilder<RealtimePlayingInfos>(
              stream: currentTrackStream,
              initialData: null,
              builder: (context, currentTrackInfo) {
                Track _track = musicLocator.getCurrentTrack();
                return SleekCircularSlider(
                  min: -0.0010,
                  initialValue: getMinDuration(
                      currentTrackInfo.data?.currentPosition,
                      _track,
                      currentTrackInfo.data?.current?.audio),
                  max: getMaxDuration(currentTrackInfo.data?.current?.audio),
                  onChangeStart: (value) {},
                  onChangeEnd: (value) {
                    if (_track?.id != musicLocator.currentTrack.value.id) {
                      var _totalDuration = getSecondsFromDurationString(
                          musicLocator.currentTrack.value.duration);

                      var _seekDuration = value * _totalDuration / 360;

                      var __track = musicLocator.currentTrack.value;
                      var _duration = getDurationFromDouble(_seekDuration);
                      var _newTrack =
                      __track.copyWith(lastPlayedDuration: _duration);
                      musicLocator.currentTrack.value = null;
                      musicLocator.currentTrack.value = _newTrack;

                      var aTrack = musicLocator.currentTrack.value;

                      print(aTrack.lastPlayedDuration);
                    }

                    if (_track?.id == musicLocator.currentTrack.value.id) {
                      musicLocator.seekMusic(value);
                    }
                  },
                  onChange: (value) {},
                  innerWidget: (value) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: innerChild,
                    );
                  },
                  appearance: CircularSliderAppearance(
                    size: size == double.nan ? 250 : size,
                    startAngle: 90,
                    angleRange: 360.0,
                    animationEnabled: false,
                    customWidths: CustomSliderWidths(
                        handlerSize: 10.0,
                        trackWidth: 8,
                        shadowWidth: 10,
                        progressBarWidth: 10),
                    customColors: CustomSliderColors(
                      dotColor: whiteColor,
                      trackColor: Color(0xff392F75),
                      progressBarColors: [
                        Color(0xffFD729E2),
                        Color(0xff1C91FB),
                      ],
                      gradientStartAngle: 90.0,
                      gradientEndAngle: 270.0,
                    ),
                  ),
                );
              });
        });
  }

  double getMinDuration(
      Duration duration, Track track, PlayingAudio playingAudio) {
    if (track == null || playingAudio == null)
      return 0;
    else if (track.id == musicLocator.currentTrack.value.id) {
      if (duration == null)
        return 0;
      else if (playingAudio.duration == null)
        return 0;
      else if (playingAudio.duration.inSeconds < duration.inSeconds)
        return playingAudio.duration.inSeconds.toDouble();
      return duration == null ? 0 : duration.inSeconds.toDouble();
    } else
      return 0;
  }

  double getMaxDuration(PlayingAudio track) {
    if (track == null || track.audio == null)
      return 360;
    else if (track.audio?.metas?.extra["track"].id ==
        musicLocator.currentTrack.value.id) {
      return track.duration == null ? 360 : track.duration.inSeconds.toDouble();
    } else
      return 360;
  }
}
