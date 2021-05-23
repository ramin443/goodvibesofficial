import 'dart:async';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:goodvibesoffl/services/adsModelService.dart';
import 'package:goodvibesoffl/services/appConfig.dart';
import 'package:goodvibesoffl/services/composer_service.dart';
import 'package:goodvibesoffl/services/dynamic_link_service.dart';
import 'package:goodvibesoffl/services/player_service.dart';
import 'package:share/share.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:goodvibesoffl/bloc/musicPlayer/musicplayer_bloc.dart';
import 'package:goodvibesoffl/models/music_model.dart';
import 'package:goodvibesoffl/models/player_status_enum.dart';
import 'package:goodvibesoffl/screens/home/composer/composer_control.dart';
import 'package:goodvibesoffl/screens/music/single_player/circular_music_slider.dart';
import 'package:goodvibesoffl/screens/music/single_player/music_widgets.dart';
import 'package:goodvibesoffl/services/services.dart';
import 'package:goodvibesoffl/utils/theme/style.dart';
import 'package:goodvibesoffl/widgets/common_widgets/common_widgets_methods.dart';
import 'package:goodvibesoffl/widgets/common_widgets/custom_rounded_button.dart';
import 'package:goodvibesoffl/widgets/common_widgets/pages_wrapper_with_background.dart';
import 'package:goodvibesoffl/widgets/scrolling_text.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../locator.dart';

class SingplePlayerRedesign extends StatefulWidget {
  final bool fromPlaylist;

  SingplePlayerRedesign({@required this.fromPlaylist});
  @override
  _SingplePlayerRedesignState createState() => _SingplePlayerRedesignState();
}

class _SingplePlayerRedesignState extends State<SingplePlayerRedesign> {
  bool isPaidUser = false;

  bool showBackward15 = false;
  bool showForward15 = false;

  final musicLocator = locator<MusicService>();

  /// for duration
  double duration = 0.0;

  var width;
  var height;
  var sliderSize = AppConfig.isTablet ? 200.0 : 250.0;
  bool isTrackDownloaded = false;
  @override
  void initState() {
    super.initState();

    checkStatus();
    if (!musicLocator.isDownloading.value) {
      musicLocator.downloadPercantage.value = 0;
    }

    isPaidUser = locator<UserService>().user.value.paid;
  }

  checkStatus() async {
    var res = await musicLocator.getTrackStatus();
    isTrackDownloaded = res['is_downloaded'];

    if (mounted) setState(() {});
  }

  double setSliderSize(var width, var height) {
    if (width < 650) {
      return ResponsiveFlutter.of(context).wp(70);
    } else if (width > 650 && height < 1050) {
      return 500;
    } else if (width > 650) return 550;
  }

  musicPlayerLoadingStatusIndicator({PlayerStatus status}) {
    return (musicLocator.songIndex == musicLocator.currentPlayerIndex &&
        status == PlayerStatus.isLoading)
        ? SpinKitCircle(
      size: 50,
      color: whiteColor.withOpacity(0.7),
    )
        : Container();
  }

  Widget buildPlayerInnerChild() {
    final sizeManager = ResponsiveFlutter.of(context);
    return ValueListenableBuilder<Track>(
        valueListenable: musicLocator.currentTrack,
        builder: (context, _track, _) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: sizeManager.hp(3.41)),
                child: GestureDetector(
                    child: RewindOrForwardIcon(
                      isRewind: true,
                      isVisible: showBackward15,
                    ),
                    onTap: () async {
                      if (musicLocator.getCurrentTrack()?.id == _track?.id) {
                        musicLocator.seekRewindSinglePlayer("");
                        if (mounted) setState(() => showBackward15 = true);
                        Timer(Duration(seconds: 5), () {
                          if (mounted) setState(() => showBackward15 = false);
                        });
                      }
                    }),
              ),

              PlayOrPauseButton(
                musicLocator: musicLocator,
                fromPlayList: widget.fromPlaylist,
                isTrackDownloaded: isTrackDownloaded,
                composerMix: _track.composerMix,
              ),

              //next button
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: GestureDetector(
                    child: RewindOrForwardIcon(
                      isRewind: false,
                      isVisible: showForward15,
                    ),
                    onTap: () async {
                      if (musicLocator.getCurrentTrack()?.id == _track?.id) {
                        musicLocator.seekForwardSinglePlayer("");
                        if (mounted) setState(() => showForward15 = true);
                        Timer(Duration(seconds: 5), () {
                          if (mounted) setState(() => showForward15 = false);
                        });
                      }
                    }),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final sizeManager = ResponsiveFlutter.of(context);
    // Track _track = musicLocator.currentTrack;
    int compareTrackTitle = 30;

    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    if (width > 600) {
      compareTrackTitle = 60;
    }

    sliderSize = setSliderSize(width, height);
    return WillPopScope(
      onWillPop: () async {
        if (musicLocator.currentTrack.value.showTimer) {
          final _playingTrack = musicLocator.getCurrentTrack();
          if (_playingTrack != null &&
              _playingTrack.id == musicLocator.currentTrack.value.id) {
            Navigator.of(context).pop();
          } else {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          }
        } else {
          Navigator.of(context).pop();
        }

        return Future.value(true);
      },
      child: PagesWrapperWithBackground(
        customPaddingHoz: 0.0,
        showMiniPlayer: false,
        showBannerAds: locator<AdsModelService>().adsData.showSinglePlayer,
        child: Scaffold(
            backgroundColor: Colors.transparent,
            bottomNavigationBar: commonOfflineSnackBar(width),
            body: BlocListener<MusicplayerBloc, MusicplayerState>(
              listener: (context, state) {
                if (mounted) setState(() {});
              },
              child: SafeArea(
                top: true,
                child: BlocBuilder<MusicplayerBloc, MusicplayerState>(
                  builder: (context, state) {
                    return ValueListenableBuilder<Track>(
                        valueListenable: musicLocator.currentTrack,
                        builder: (context, _track, _) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              buildTopActions(context, width),
                              SizedBox(
                                height: sizeManager.hp(6),
                              ),
                              _track.title.length < compareTrackTitle
                                  ? Container(
                                padding:
                                EdgeInsets.symmetric(horizontal: 15),
                                child: Center(
                                  child: Container(
                                    width: MediaQuery.of(context)
                                        .size
                                        .width *
                                        0.8,
                                    child: Center(
                                      child: Text(
                                        _track.title,
                                        overflow: TextOverflow.ellipsis,
                                        style: AppConfig.isTablet
                                            ? Theme.of(context)
                                            .textTheme
                                            .headline6
                                            .copyWith(
                                            color: Colors.white)
                                            : Theme.of(context)
                                            .textTheme
                                            .headline5
                                            .copyWith(
                                            color: Colors.white),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                                  : Container(
                                width: width * 0.8,
                                height: sizeManager.hp(4.23),
                                child: ScrollingText(
                                  text: _track.title ?? " ",
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .button
                                      .copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(height: sizeManager.hp(3)),
                              CircularSlider(
                                  size: sliderSize,
                                  duration: duration,
                                  innerChild: buildPlayerInnerChild()),
                              SizedBox(height: sizeManager.hp(2.5)),
                              MusicDuration(),
                              SizedBox(height: sizeManager.hp(2)),
                              buildBottomActions(),
                              if (_track.composerMix != null)
                                _buildGoToMixerButton(context),
                            ],
                          );
                        });
                  },
                ),
              ),
            )),
      ),
    );
  }

  CustomRoundedButttonWithSplash _buildGoToMixerButton(BuildContext context) {
    return CustomRoundedButttonWithSplash(
      height: ScreenUtil().setHeight(75),
      hozMargin: 0.0,
      verticalMargin: 0.0,
      width: width * 0.5,
      gradient: LinearGradient(
          colors: [whiteColor.withOpacity(0.3), whiteColor.withOpacity(0.3)]),
      centerWidget: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(CupertinoIcons.mic_solid, color: whiteColor),
          SizedBox(width: ScreenUtil().setWidth(30)),
          Text(
            "Mixer",
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(color: whiteColor),
          )
        ],
      ),
      onPressed: () {
        var composerService = locator<ComposerService>();
        // if (composerService.group != null &&
        //     composerService
        //         .playingIds.value.isNotEmpty) {

        var some = showBottomSheet<ComposerControl>(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: 0.0,
            context: context,
            builder: (context) {
              return ComposerControl(
                isfromBottomSheet: true,
              );
            });
        // } else {
        //   showToastMessage(
        //       message:
        //           "you have not added any sounds");
        // }
      },
    );
  }

  Widget buildBottomActions() {
    final sizeManager = ResponsiveFlutter.of(context);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TimerButton()),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: InkWell(
                  onTap: () async {
                    var dynamicLink = await locator<DynamicLinkService>()
                        .createTrackDynamicLink(
                        track: locator<MusicService>().currentTrack.value);

                    var trackTitle =
                        musicLocator.currentTrack.value.title ?? "";
                    await Share.share("$dynamicLink",
                        sharePositionOrigin: Rect.fromLTWH(-28, height*0.65 , width, height));
                  },
                  customBorder: CircleBorder(),
                  child: IconWithCircularBackground(icon: Icons.share),
                ),
              ),
              DownloadButton(isPaidUser: isPaidUser),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: sizeManager.hp(1.4)),
            child: DownloadPercentUnderButton(),
          )
        ],
      ),
    );
  }

  Widget buildTopActions(BuildContext context, double screenWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
             CupertinoIcons.back,
              color: Colors.white,
              size: AppConfig.isTablet ? 15.w : 25.w,
            ),
          ),
        ),
        FavoriteButton(musicLocator: musicLocator),
      ],
    );
  }
}
