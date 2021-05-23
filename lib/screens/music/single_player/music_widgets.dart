import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:goodvibesoffl/bloc/downloadpage/downloadpage_bloc.dart';
import 'package:goodvibesoffl/models/composer_audio_model.dart';
import 'package:goodvibesoffl/models/models.dart';
import 'package:goodvibesoffl/models/music_model.dart';
import 'package:goodvibesoffl/models/player_status_enum.dart';
import 'package:goodvibesoffl/screens/premium/getpremium.dart';
import 'package:goodvibesoffl/services/adsManagerService.dart';
import 'package:goodvibesoffl/services/adsModelService.dart';
import 'package:goodvibesoffl/services/appConfig.dart';
import 'package:goodvibesoffl/services/connectivity_service.dart';
import 'package:goodvibesoffl/services/interstitialAdsService.dart';
import 'package:goodvibesoffl/services/navigation_service.dart';
import 'package:goodvibesoffl/services/player_service.dart';
import 'package:goodvibesoffl/utils/image_paths.dart';
import '../../../services/services.dart';
import 'package:goodvibesoffl/utils/common_functiona.dart';
import '../../../utils/utils.dart';

import 'package:goodvibesoffl/utils/strings/string_constants.dart';
import 'package:goodvibesoffl/utils/theme/style.dart';
import 'package:goodvibesoffl/utils/theme/text_style.dart';
import 'package:goodvibesoffl/widgets/common_widgets/streamBuilder.dart';
import 'package:goodvibesoffl/widgets/common_widgets/valueListenableBuilder.dart';
import 'package:goodvibesoffl/widgets/music_page_favorite_icon.dart';
import 'package:goodvibesoffl/widgets/music_timer_dialog.dart';
import 'package:provider/provider.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:responsive_flutter/scaling_query.dart';
import '../../../locator.dart';

class FavoriteButton extends StatelessWidget {
  final musicLocator;
  FavoriteButton({this.musicLocator});
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
        valueListenable: musicLocator.isFav,
        builder: (context, fav, _) {
          return MusicPlayerPageFavIcon();
        });
  }
}

class PlayOrPauseButton extends StatefulWidget {
  final MusicService musicLocator;
  final bool fromPlayList;
  final ComposerSavedMix composerMix;

  final bool isTrackDownloaded;
  PlayOrPauseButton(
      {this.musicLocator,
        @required this.fromPlayList,
        this.isTrackDownloaded,
        this.composerMix});

  @override
  _PlayOrPauseButtonState createState() => _PlayOrPauseButtonState();
}

class _PlayOrPauseButtonState extends State<PlayOrPauseButton> {
  bool _isUserPaid = locator<UserService>().user.value.paid;
  final interstitialAdsService = InterstitialAdsService();
  Timer timer;
  @override
  void initState() {
    super.initState();
    interstitialAdsService.getInterstitialAds.listener = (event) {
      if (event == MobileAdEvent.closed) {
        widget.musicLocator.playSinglePlayer(
            composerMix: widget.composerMix, context: context);
        interstitialAdsService.reload();
      }
    };
  }

  _playPlaylistTrack(Track currentTrack) {
    if (currentTrack?.id != widget.musicLocator.currentTrack.value.id) {
      /// if new track is played which is not equal to current track

      widget.musicLocator.playSinglePlayer(
          isFromPlaylist: true,
          composerMix: widget.composerMix,
          context: context);
    } else {
      /// if same track , play or pause the current track
      widget.musicLocator.playOrPausePlayer();
    }
  }

  _handleAdsForFreeUser() async {
    var _track = widget.musicLocator.currentTrack.value;
    if (_track.trackPaidType == TrackPaidType.Premium) {
      locator<NavigationService>()
          .navigationKey
          .currentState
          .push(CupertinoPageRoute(builder: (_) => GetPremium()));
      return;
    }

    if (locator<AdsManagerService>().showInterstitialAd &&
        locator<AdsModelService>().adsData.showInterstitialAd) {
      final _isLoaded = await interstitialAdsService.isLoaded;
      if (_isLoaded) {
        if (widget.musicLocator.assetsAudioPlayer?.isPlaying?.value) {
          widget.musicLocator.stopPlayer();
        }

        await interstitialAdsService.show();
      } else {
        widget.musicLocator.playSinglePlayer(
            composerMix: widget.composerMix, context: context);
      }
    } else {
      widget.musicLocator
          .playSinglePlayer(composerMix: widget.composerMix, context: context);
    }
  }

  _playSingleTrack({Track currentTrack, bool playingStatus}) async {
    if (currentTrack?.id == widget.musicLocator.currentTrack.value.id) {
      /// if same track is playing pause the audio , else play the audio

      if (playingStatus) {
        widget.musicLocator.pauseSinglePlayer();
      } else {
        var _cTrack = widget.musicLocator.currentTrack.value;

        // widget.musicLocator.play();
        widget.musicLocator.playSinglePlayer(
            composerMix: widget.composerMix, context: context);
      }

      //// if current track is different
    } else {
      if (_isUserPaid) {
        widget.musicLocator.playSinglePlayer(
            composerMix: widget.composerMix, context: context);
      }

      //// if user is free user
      else {
        _handleAdsForFreeUser();
      }
    }
  }

  _handleTrackOffline(
      {ConnectivityStatus connectionStatus,
        bool playerBufferingStatus,
        bool playingStatus}) async {
    if (connectionStatus == ConnectivityStatus.Offline) {
      if (playingStatus && !playerBufferingStatus) {
        widget.musicLocator.pauseSinglePlayer();
      } else if (playerBufferingStatus) {
        PlayerState _playerState = await widget.musicLocator.getPlayerState();
        if (_playerState == PlayerState.stop ||
            _playerState == PlayerState.pause) {
          showOfflineSnackBar(context: context);
        } else {
          widget.musicLocator.stopPlayer();
        }
      } else {
        showOfflineSnackBar(context: context);
      }
      if (!widget.isTrackDownloaded) return;
    }
  }

  _onPressedPlayPauseButton(
      {@required ConnectivityStatus connectionStatus,
        @required Track currentTrack,
        @required bool playingStatus}) async {
    await _handleTrackOffline(connectionStatus: connectionStatus);

    /// if track is from playlist
    if (widget.fromPlayList) {
      _playPlaylistTrack(currentTrack);
    } else {
      /// if is a single track
      _playSingleTrack(
          currentTrack: currentTrack, playingStatus: playingStatus);
    }
  }

  @override
  Widget build(BuildContext context) {
    final sizeManager = ResponsiveFlutter.of(context);
    Color whiteColor=Colors.white;
    final buttonSize =
    AppConfig.isTablet ? sizeManager.wp(9) : sizeManager.wp(14.6);
    return ValueListenableBuilder2<Stream<bool>, Stream<bool>>(
        widget.musicLocator.currentTrackStatus,
        widget.musicLocator.currentTrackBufferingStatus,
        builder: (context, playingStatusStream, playerBufferingStream, _) {
          return StreamBuilder3<ConnectivityStatus, bool, bool>(
              ConnectivityService().connectionStatusController.stream,
              playingStatusStream,
              playerBufferingStream,
              firstInitialValue: Provider.of<ConnectivityStatus>(context),
              thirdInitialValue: false,
              secondInitialValue: false, builder: (context, connectionStatus,
              playingStatus, playerBufferingStatus) {
            Track currentTrack = widget.musicLocator.getCurrentTrack();
            return InkWell(
              onTap: () async {
                await _onPressedPlayPauseButton(
                  connectionStatus: connectionStatus,
                  currentTrack: currentTrack,
                  playingStatus: playingStatus ?? false,
                );
              },
              splashColor: whiteColor.withOpacity(0.2),
              enableFeedback: true,
              customBorder: CircleBorder(),
              child: Container(
                height: buttonSize,
                width: buttonSize,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    getPlayPauseIcon(playingStatus),

                    /// loading indicator
                    getBufferingIcon(
                      playerBufferingStatus,
                      sizeManager,
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }

  Widget getPlayPauseIcon(bool status) {

    Track track = widget.musicLocator.getCurrentTrack();
    if (track?.id == widget.musicLocator.currentTrack.value.id) {
      return status
          ? SvgPicture.asset(pause_icon)
          : SvgPicture.asset(play_icon);
    } else
      return SvgPicture.asset(play_icon);
  }

  Widget getBufferingIcon(bool status, ScalingQuery sizeManager) {
    Color whiteColor=Colors.white;
    Track track = widget.musicLocator.getCurrentTrack();
    if (track?.id == widget.musicLocator.currentTrack.value.id) {
      return status
          ? SpinKitCircle(
        size: sizeManager.wp(12.16),
        color: whiteColor.withOpacity(0.7),
      )
          : Container();
    } else
      return Container();
  }
}

//// download button

class DownloadButton extends StatelessWidget {
  final bool isPaidUser;
  DownloadButton({this.isPaidUser});

  final musicLocator = locator<MusicService>();

  Widget getDownloadingButton(
      {Function cancelDownload, ScalingQuery sizeManager}) {
    Color whiteColor=Colors.white;
    return ValueListenableBuilder<int>(
      valueListenable: musicLocator.downloadPercantage,
      builder: (context, percantage, _) {
        /// cross circular indicator with download percentage
        return InkWell(
          customBorder: CircleBorder(),
          onTap: cancelDownload,
          child: Container(
            padding: EdgeInsets.only(left: 8),
            child: Container(
              height: (AppConfig.isTablet
                  ? sizeManager.wp(8)
                  : sizeManager.wp(12.16)),
              width: (AppConfig.isTablet
                  ? sizeManager.wp(8)
                  : sizeManager.wp(12.16)),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xff493A79),
              ),
              child: Center(
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                          semanticsLabel: 'Downloading..',
                          semanticsValue: '$percantage',
                          value: percantage / 100.0,
                          valueColor: AlwaysStoppedAnimation(
                            Color(0xff42A5F5),
                          ),
                          strokeWidth: 2,
                          backgroundColor: whiteColor),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2),
                      child: Center(
                        child: Icon(
                          Icons.clear,
                          color: whiteColor,
                          size: AppConfig.isTablet
                              ? sizeManager.wp(3.0)
                              : sizeManager.wp(4.86),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final sizeManager = ResponsiveFlutter.of(context);
    return StreamBuilder(
        stream: ConnectivityService().connectionStatusController.stream,
        initialData: Provider.of<ConnectivityStatus>(context),
        builder: (context, connectionStatus) {
          return ValueListenableBuilder3<int, bool, bool>(
            musicLocator.trackId,
            musicLocator.isDownloaded,
            musicLocator.isDownloading,
            builder: (context, currentTrackID, isDownloaded, isDownloading, _) {
              final downloadingTrackID = musicLocator.downloadingTrackId;
              if (isDownloaded && currentTrackID != downloadingTrackID) {
                //When track is already downloaded
                return InkWell(
                  customBorder: CircleBorder(),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: IconWithCircularBackground(
                      icon: Icons.cloud,
                      iconColor: Color(0xff3D72DE),
                    ),
                  ),
                  onTap: () {
                    if (connectionStatus.data == ConnectivityStatus.Offline) {
                      showOfflineSnackBar(context: context);
                      return;
                    }
                    showDialogBox(
                      dialogType: delete_download,
                      context: context,
                      proceedAction: (value) {
                        musicLocator.isDownloaded.value = false;
                        isDownloaded = false;
                        musicLocator.deleteDown(
                          trackId: musicLocator.currentTrack.value.id,
                        );
                        BlocProvider.of<DownloadpageBloc>(context).add(
                          DownloadPageDeleteTrack(
                            track: musicLocator.currentTrack.value,
                          ),
                        );
                      },
                    );
                  },
                );
              } else {
                //When Track is Downloading
                if (isDownloading) {
                  //Same Downloading Track
                  if (currentTrackID == downloadingTrackID) {
                    return getDownloadingButton(
                      sizeManager: sizeManager,
                      cancelDownload: () {
                        showDialogBox(
                            dialogType: cancel_download,
                            context: context,
                            proceedAction: (value) async {
                              musicLocator.downloadPercantage.value = 0;
                              isDownloaded = false;
                              BlocProvider.of<DownloadpageBloc>(context).add(
                                DownloadPageDeleteTrack(
                                    track: musicLocator.downloadingTrack),
                              );
                              await musicLocator.stopDown();
                              Fluttertoast.showToast(
                                  msg: 'Download cancled!',
                                  backgroundColor: Colors.deepPurple,
                                  textColor: Colors.white70);
                            });
                      },
                    );
                  } else {
                    //Different Track
                    return Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: IconWithCircularBackground(
                        icon: Icons.cloud_queue,
                      ),
                    );
                  }
                } else {
                  //When No Track is Downloading
                  return InkWell(
                    customBorder: CircleBorder(),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: IconWithCircularBackground(
                        icon: FeatherIcons.download,
                      ),
                    ),
                    onTap: () {
                      if (connectionStatus.data == ConnectivityStatus.Offline) {
                        showOfflineSnackBar(context: context);
                        return;
                      }
                      if (isPaidUser) {
                        //Download Track Function
                        Fluttertoast.showToast(
                            msg: ' Download Started...',
                            backgroundColor: Colors.deepPurple,
                            textColor: Colors.white70);
                        musicLocator.implementDownload(
                            context: context,
                            downloadSuccess: (value) {
                              musicLocator.isDownloaded.value = value;
                              isDownloaded = value;
                            });
                      } else {
                        //Show Cannot Download
                        showDialogBox(
                            dialogType: cannot_download, context: context);
                      }
                    },
                  );
                }
              }
            },
          );
        });
  }
}

class TimerDurationUnderButton extends StatelessWidget {
  final musicLocator = locator<MusicService>();
  @override
  Widget build(BuildContext context) {
    return musicLocator.remainingTimerDuration.value == Duration(seconds: 0)
        ? Container(height: 0, width: 0)
        : ValueListenableBuilder(
      valueListenable: musicLocator.remainingTimerDuration,
      builder: (context, time, _) {
        if (time > Duration(seconds: 0)) {
          return Text(
              '${time.toString().split('.').first.padLeft(8, "0")}',
              style: whiteText14);
        } else {
          return Container();
        }
      },
    );
  }
}

class DownloadPercentUnderButton extends StatelessWidget {
  final musicLocator = locator<MusicService>();
  @override
  Widget build(BuildContext context) {
    final sizeManager = ResponsiveFlutter.of(context);
    //// another download in progress notifier

    return ValueListenableBuilder(
      valueListenable: musicLocator.isDownloading,
      builder: (context, isDownloading, child) {
        return isDownloading == true
            ? ValueListenableBuilder<int>(
            valueListenable: musicLocator.downloadPercantage,
            builder: (context, percantage, _) {
              return Container(
                padding: EdgeInsets.only(bottom: sizeManager.hp(1)),
                child: musicLocator.trackId.value ==
                    musicLocator.downloadingTrackId
                    ? Padding(
                  padding: EdgeInsets.all(sizeManager.wp(2.3)),
                  child: Text(
                    '$percantage % Downloading',
                    style: TextStyle(
                      color: Color(0xff82B1FF),
                      fontSize: sizeManager.fontSize(1.66),
                    ),
                  ),
                )
                    : !musicLocator.isDownloaded.value
                    ? Text(
                  'Wait Download\n in progress...',
                  textAlign: TextAlign.center,
                  style: whiteText14.copyWith(
                    fontSize: sizeManager.fontSize(1.66),
                  ),
                )
                    : Text(
                  "",
                  style: whiteText14.copyWith(
                    fontSize: sizeManager.fontSize(1.66),
                  ),
                ),
              );
            })
            : showEmptyText(sizeManager);
      },
    );
  }

  Widget showEmptyText(ScalingQuery sizeManager) {
    return Container(
      padding: EdgeInsets.only(bottom: sizeManager.hp(1)),
      width: 0,
      child: Padding(
        padding: EdgeInsets.all(sizeManager.wp(2.3)),
        child: Text(
          '',
          style: TextStyle(
            color: Color(0xff82B1FF),
            fontSize: sizeManager.fontSize(1.66),
          ),
        ),
      ),
    );
  }
}

//// timer button
class TimerButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final musicLocator = locator<MusicService>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        InkWell(
          onTap: () async {
            showDialog(
                barrierDismissible: true,
                context: context,
                builder: (_) {
                  if (musicLocator.isFirstClickTimer.value) {
                    return TimerDialogBox();
                  } else {
                    return TimerActiveDialog();
                  }
                });
          },
          customBorder: CircleBorder(),
          enableFeedback: true,
          child: ValueListenableBuilder<Duration>(
              valueListenable: musicLocator.remainingTimerDuration,
              builder: (context, duration, _) {
                return IconWithCircularBackground(
                    icon: duration != Duration.zero
                        ? Icons.alarm
                        : Icons.timer);
              }),
        ),

        // SizedBox(height: 5),
        // TimerDurationUnderButton(),
      ],
    );
  }
}

class MusicDuration extends StatelessWidget {
  final musicLocator = locator<MusicService>();

  @override
  Widget build(BuildContext context) {
    final _textStyle = Theme.of(context)
        .textTheme
        .button
        .copyWith(fontWeight: FontWeight.bold);
    return ValueListenableBuilder<Stream<RealtimePlayingInfos>>(
        valueListenable: musicLocator.realtimePlayingInfo,
        builder: (context, currentTrackStream, _) {
          return StreamBuilder<RealtimePlayingInfos>(
              stream: currentTrackStream,
              initialData: null,
              builder: (context, currentTrackInfo) {
                Track _track = musicLocator.getCurrentTrack();
                if (_track?.id != musicLocator.currentTrack.value.id) {
                  return Text(
                      musicLocator.currentTrack.value.duration
                          .toString()
                          .split('.')[0],
                      style: _textStyle);
                } else if (currentTrackInfo.data?.current?.audio == null ||
                    currentTrackInfo.data?.currentPosition == null)
                  return Text(
                      musicLocator.currentTrack.value.duration
                          .toString()
                          .split('.')[0],
                      style: _textStyle);
                Duration remainingTime = Duration(
                    seconds: currentTrackInfo.data.duration.inSeconds -
                        currentTrackInfo.data.currentPosition.inSeconds);
                if (remainingTime.isNegative) remainingTime = Duration.zero;
                return Text(remainingTime.toString().split('.')[0],
                    style: _textStyle);
              });
        });
    // return ValueListenableBuilder2<Stream<PlayingAudio>, ValueStream<Duration>>(
    //   musicLocator.playingAudio,
    //   musicLocator.currentTrackPosition,
    //   builder: (context, playingAudioStream, trackPositionStream, _) {
    //     return StreamBuilder2<PlayingAudio, Duration>(
    //       playingAudioStream,
    //       trackPositionStream,
    //       firstInitialValue: null,
    //       secondInitialValue: Duration.zero,
    //       builder: (context, playingAudio, trackPosition) {
    //     Track _track = musicLocator.getCurrentTrack();
    //     if (_track?.id != musicLocator.currentTrack.value.id) {
    //       return Text(
    //           musicLocator.currentTrack.value.duration
    //               .toString()
    //               .split('.')[0],
    //           style: _textStyle);
    //     } else if (playingAudio == null || trackPosition == null)
    //       return Text(
    //           musicLocator.currentTrack.value.duration
    //               .toString()
    //               .split('.')[0],
    //           style: _textStyle);
    //     Duration remainingTime = Duration(
    //         seconds:
    //             playingAudio.duration.inSeconds - trackPosition.inSeconds);
    //     if (remainingTime.isNegative) remainingTime = Duration.zero;
    //     return Text(remainingTime.toString().split('.')[0],
    //         style: _textStyle);
    //   },
    // );
    //   },
    // );
  }
}

class RadiantGradientMask extends StatelessWidget {
  RadiantGradientMask({this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xff314991),
          Color(0xff883B98),
        ],
        tileMode: TileMode.mirror,
        transform: GradientRotation(0.3),
      ).createShader(bounds),
      child: child,
    );
  }
}

class IconWithCircularBackground extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final iconSize;
  final containerDimension;
  final Color backgroundColor;
  final IconButton iconButton;

  IconWithCircularBackground({
    this.icon,
    this.iconColor,
    this.iconSize,
    this.containerDimension,
    this.backgroundColor,
    this.iconButton,
  });
  @override
  Widget build(BuildContext context) {
    Color whiteColor=Colors.white;
    final sizeManager = ResponsiveFlutter.of(context);
    return Container(
      height: containerDimension ??
          (AppConfig.isTablet ? sizeManager.wp(8) : sizeManager.wp(12.16)),
      width: containerDimension ??
          (AppConfig.isTablet ? sizeManager.wp(8) : sizeManager.wp(12.16)),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor ?? whiteColor.withOpacity(0.2),
      ),
      child: iconButton ??
          Icon(icon,
              size: iconSize ??
                  (AppConfig.isTablet
                      ? sizeManager.wp(4)
                      : sizeManager.wp(7.29)),
              color: iconColor ?? whiteColor.withOpacity(0.7)),
    );
  }
}

class RewindOrForwardIcon extends StatelessWidget {
  final bool isRewind;
  final isVisible;
  RewindOrForwardIcon({this.isRewind, this.isVisible});
  @override
  Widget build(BuildContext context) {
    final sizeManager = ResponsiveFlutter.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SvgPicture.asset(
          isRewind ? fast_backward_icon : fast_forward_icon,
          height: AppConfig.isTablet ? sizeManager.wp(4) : sizeManager.wp(6),
        ),
        SizedBox(height: sizeManager.hp(1.3)),
        Visibility(
          visible: isVisible,
          child: Text(
            '15s',
            style: TextStyle(color: Colors.redAccent),
          ),
          maintainAnimation: true,
          maintainSize: true,
          maintainState: true,
        ),
      ],
    );
  }
}

class MusicLoadingScreen extends StatelessWidget {
  final PlayerStatus status;
  MusicLoadingScreen({this.status});

  final _locator = locator<MusicService>();

  @override
  Widget build(BuildContext context) {
    Color whiteColor=Colors.white;
    return (_locator.songIndex == _locator.currentPlayerIndex &&
        status == PlayerStatus.isLoading)
        ? SpinKitCircle(
      size: 28,
      color: whiteColor.withOpacity(0.7),
    )
        : Container();
  }
}
