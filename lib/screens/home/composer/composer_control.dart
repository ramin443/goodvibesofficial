import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:goodvibesoffl/services/appConfig.dart';
import 'package:goodvibesoffl/services/composer_service.dart';
import 'package:goodvibesoffl/services/player_service.dart';
import 'package:goodvibesoffl/utils/theme/style.dart';
import 'package:goodvibesoffl/widgets/common_widgets/customCacheNetworkImage.dart';
import 'package:goodvibesoffl/widgets/common_widgets/custom_rounded_button.dart';
import 'package:goodvibesoffl/widgets/common_widgets/pages_wrapper_with_background.dart';
import 'package:rxdart/streams.dart';
import '../../../routes.dart';
import '../../../locator.dart';
import '../../../utils/image_paths.dart';
import '../../../screens/music/single_player/music_widgets.dart';
import 'compose_widgets.dart';
import 'mixes.dart';
import 'package:goodvibesoffl/routes.dart';

class ComposerControl extends StatefulWidget {
  final bool isfromBottomSheet;
  const ComposerControl({this.isfromBottomSheet});
  @override
  _ComposerControlState createState() => _ComposerControlState();
}

class _ComposerControlState extends State<ComposerControl> {
  final composerService = locator<ComposerService>();
  final musicService = locator<MusicService>();

  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return PagesWrapperWithBackground(
      hasScaffold: false,
      showMiniPlayer: false,
      customPaddingHoz: 0.0,
      child: Scaffold(
        backgroundColor: tpt,
        bottomNavigationBar: _buildBottomBar(width),
        appBar: _buildAppBar(context),
        body: SafeArea(
          top: true,
          child: centerScrollView(context, width),
        ),
      ),
    );
  }

  Widget _buildTopGapAboveAppBar() {
    return SizedBox(
        height: widget.isfromBottomSheet
            ? ScreenUtil().setHeight(40)
            : ScreenUtil().setHeight(20));
  }

  Widget _buildSoundsControlListView(
      var width,
      ) {
    return composerService.group == null ||
        composerService.playingIds.value.isEmpty
        ? Container()
        : Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Divider(color: whiteColor),
        Text(
          "Sounds ${composerService.group.playingAudios.length}/10 ",
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(color: whiteColor),
        ),
        Column(
            children: List.generate(
                composerService.group.playingAudios.length, (int index) {
              var playingAudios = composerService.group.playingAudios;

              var audiosWithPlayers = composerService.group.audiosWithPlayers;

              var singlePlayer =
              audiosWithPlayers[playingAudios[index].audio];

              return buildSliderRow(
                width: width,
                player: singlePlayer,
                index: index,
                audio: playingAudios[index].audio,
              );
            })),
      ],
    );
  }

  Widget centerScrollView(BuildContext context, var width) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: symmetricHorizonatalPadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildTopButtonsRow(context),
          _buildVolumneControlForMusicPlayer(width),
          StreamBuilder<List<int>>(
              stream: composerService.playingItemsListStream.stream,
              builder: (context, snapshot) {
                return _buildSoundsControlListView(width);
              }),

          composerService.group.playingAudios.length < 4
              ? Container()
              : CustomRoundedButttonWithSplash(
            onPressed: () async {
              await composerService.clearAll();

              setState(() {});
              Navigator.pop(context);
            },
            gradient: LinearGradient(
              colors: [
                whiteColor.withOpacity(0.3),
                whiteColor.withOpacity(0.3),
              ],
            ),
            centerWidget: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Clear all",
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(color: whiteColor),
                ),
                SizedBox(
                  width: width > 600
                      ? ScreenUtil().setWidth(40)
                      : ScreenUtil().setWidth(25),
                ),
                Icon(Icons.close,
                    color: whiteColor, size: ScreenUtil().setSp(35))
              ],
            ),
          )

          // CustomRoundedButttonWithSplash(
          //   onPressed: () async {
          //     await composerService.clearAll();

          //     setState(() {});
          //     Navigator.pop(context);
          //   },
          //   gradient: LinearGradient(
          //     colors: [
          //       whiteColor.withOpacity(0.3),
          //       whiteColor.withOpacity(0.3),
          //     ],
          //   ),
          //   centerWidget: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: <Widget>[
          //       Text(
          //         "Clear all",
          //         style: Theme.of(context)
          //             .textTheme
          //             .headline6
          //             .copyWith(color: whiteColor),
          //       ),
          //       SizedBox(
          //         width: width > 600
          //             ? ScreenUtil().setWidth(40)
          //             : ScreenUtil().setWidth(25),
          //       ),
          //       Icon(Icons.close,
          //           color: whiteColor, size: ScreenUtil().setSp(35))
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  Row _buildTopButtonsRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CustomRoundedButttonWithSplash(
            height: ScreenUtil().setHeight(70),
            borderRadius: ScreenUtil().setSp(50),
            hozMargin: 0.0,
            gradient: LinearGradient(colors: [
              whiteColor.withOpacity(0.2),
              whiteColor.withOpacity(0.2),
            ]),
            titleText: "Add Sounds",
            onPressed: () {
              //     Navigator.pushReplacementNamed(context, composer_page);
              if (widget.isfromBottomSheet)
                Navigator.pushReplacementNamed(context, composer_page);
              else
                Navigator.pop(context);
            },
            width: MediaQuery.of(context).size.width * 0.4),
        SizedBox(width: 20),
        CustomRoundedButttonWithSplash(
            height: ScreenUtil().setHeight(70),
            borderRadius: ScreenUtil().setSp(50),
            gradient: LinearGradient(colors: [
              whiteColor.withOpacity(0.2),
              whiteColor.withOpacity(0.2),
            ]),
            hozMargin: 0.0,
            titleText: "Saved Mixes",
            onPressed: () async {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => ComposerMixes()));
            },
            width: MediaQuery.of(context).size.width * 0.4),
      ],
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      leading: InkWell(
          child: Padding(
            padding: EdgeInsets.only(
                bottom: 10,
                top: widget.isfromBottomSheet ? 30.0 : 0.0,
                right: 10),
            child: Icon(
              CupertinoIcons.back,
              color: whiteColor,
              size: AppConfig.isTablet ? 15.w : 25.w,
            ),
          ),
          onTap: () => Navigator.pop(context)),
      centerTitle: false,
      titleSpacing: 1.0,
      title: Padding(
        padding: EdgeInsets.only(top: widget.isfromBottomSheet ? 30.0 : 0.0),
        child: Text("Mixes",
            style: Theme.of(context)
                .textTheme
                .button
                .copyWith(color: Colors.white)),
      ),
    );
  }

  Widget _buildVolumneControlForMusicPlayer(var width) {
    var _cirlceSize =
    width > 600 ? ScreenUtil().setWidth(100) : ScreenUtil().setWidth(130);

    return musicService.assetsAudioPlayer == null
        ? Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Music 0/1",
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(color: whiteColor)),
        SizedBox(height: ScreenUtil().setHeight(25)),
        Text(
          " You don't have music in this composer group.\n You can add onw from the music section",
          style: width > 600
              ? Theme.of(context).textTheme.headline6
              : Theme.of(context).textTheme.bodyText2,
        ),
      ],
    )
        : ValueListenableBuilder<ValueStream<PlayerState>>(
      // valueListenable: locator<MusicService>().currentTrack,
      valueListenable: locator<MusicService>().playingState,
      builder: (context, playingState, _) {
        var track = musicService.currentTrack.value;

        if (track == null || playingState.value == PlayerState.stop) {
          return Container();
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Music 1/1",
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(color: whiteColor)),
              Row(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      if (widget.isfromBottomSheet) {
                        Navigator.pop(context);
                      } else {
                        Navigator.pushReplacementNamed(
                            context, single_player);
                      }
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(_cirlceSize),
                      child: Container(
                          height: _cirlceSize,
                          width: _cirlceSize,
                          decoration: BoxDecoration(
                            gradient: composerItemInactiveG,
                            shape: BoxShape.circle,
                          ),
                          child: track.image == null
                              ? Image.asset(placeholder_image)
                              : CachedNetworkImage(
                            imageUrl: track.image,
                            cacheManager:
                            ComposerCacheManager.instance,
                            errorWidget: (context, value, an) =>
                                Image.asset(placeholder_image),
                            placeholder: (context, value) =>
                                Image.asset(placeholder_image),
                          )),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(track.title.toString().trim(),
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis),
                              StreamBuilder<double>(
                                  stream: musicService
                                      .assetsAudioPlayer?.volume,
                                  builder: (context, snapshot) {
                                    return Slider(
                                      value: snapshot.data ?? 0.5,
                                      min: 0,
                                      max: 1,
                                      activeColor: whiteColor,
                                      inactiveColor: lightPink,
                                      onChanged: (value) {
                                        musicService.assetsAudioPlayer
                                            .setVolume(value);
                                      },
                                      onChangeEnd: (value) {},
                                      onChangeStart: (value) {},
                                    );
                                  }),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.close,
                            color: whiteColor,
                          ),
                          onPressed: () {
                            musicService.assetsAudioPlayer.stop();
                            Navigator.pop(context);
                            setState(() {});
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
              // Divider(color: whiteColor)
            ],
          );
        }
      },
    );
  }

  Widget _buildBottomBar(var width) {
    return composerService.group == null ||
        composerService.playingIds.value.isEmpty
        ? Container(
      height: 0,
      color: lightPink,
    )
        : Padding(
      padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(20)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            width: width,
            child: Center(
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      children: [
                        TimerButton(),
                        Text("Set Timer"),
                      ],
                    ),
                    StreamBuilder<bool>(
                        stream: composerService.group?.isPlaying,
                        builder: (context, snapshot) {
                          var isPlay = snapshot.data ?? false;

                          return InkWell(
                            onTap: () {
                              //       composerService.group.pause();
                              composerService.group.playOrPause();
                            },
                            child: isPlay
                                ? SvgPicture.asset(
                              pause_icon,
                              height: ScreenUtil().setHeight(70),
                              width: ScreenUtil().setHeight(70),
                            )
                                : SvgPicture.asset(
                              play_icon,
                              height: ScreenUtil().setHeight(70),
                              width: ScreenUtil().setHeight(70),
                            ),
                          );
                        }),
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            showNameYourMixDialog(
                                context: context,
                                width: width,
                                isUpdate: false
                              //  onPressed: () => onPressedSaveMix(),
                            );
                          },
                          child: IconWithCircularBackground(
                            icon: Icons.favorite_border,
                            iconColor: whiteColor,
                          ),
                        ),
                        Text("Save")
                      ],
                    )
                  ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSliderRow(
      {double width, AssetsAudioPlayer player, int index, Audio audio}) {
    var _cirlceSize =
    width > 600 ? ScreenUtil().setWidth(100) : ScreenUtil().setWidth(130);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(_cirlceSize),
          child: Container(
            height: _cirlceSize,
            width: _cirlceSize,
            decoration: BoxDecoration(
              gradient: composerItemInactiveG,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Container(
                height: ScreenUtil().setHeight(50),
                width: ScreenUtil().setWidth(50),
                child: audio.metas.extra['image'] == null
                    ? Image.asset(composer_paceholder_image, color: lightPink)
                    : CachedNetworkImage(
                    imageUrl: audio.metas.extra['image'],
                    errorWidget: (context, url, error) => Image.asset(
                        composer_paceholder_image,
                        color: lightPink,
                        fit: BoxFit.contain),
                    placeholder: (context, value) => Image.asset(
                        composer_paceholder_image,
                        color: lightPink,
                        fit: BoxFit.contain),
                    fit: BoxFit.contain),
              ),
            ),
          ),
        ),
        Expanded(
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: ScreenUtil().setWidth(20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(audio.metas.title,
                          style: Theme.of(context).textTheme.bodyText2),
                      StreamBuilder<double>(
                          stream: player.volume,
                          builder: (context, snapshot) {
                            var vol = snapshot.data;

                            return SliderTheme(
                              data: SliderThemeData(
                                trackShape: CustomTrackShape(),
                              ),
                              child: Slider(
                                key: ValueKey("key: $index"),
                                min: 0.0,
                                max: 1.0,
                                activeColor: whiteColor,
                                inactiveColor: lightPink,
                                value: vol == null || vol > 1 ? 0.5 : vol,
                                onChanged: (double value) async {
                                  await player.setVolume(value);
                                },
                                onChangeStart: (value) async {
                                  await player.setVolume(value);
                                },
                                onChangeEnd: (value) async {
                                  await player.setVolume(value);
                                },
                              ),
                            );
                          }),
                    ],
                  ),
                ),
              ),
              IconButton(
                onPressed: () async {
                  var playingAudios = composerService.group.audiosWithPlayers;

                  if (playingAudios.length > 1) {
                    var singlePlayer = playingAudios[audio];

                    singlePlayer.stop();

                    composerService.removeAudioFromGroup(audio);

                    setState(() {});
                  } else if (playingAudios.length == 1) {
                    composerService.clearAll();
                    setState(() {});
                  }
                },
                icon: Icon(
                  Icons.close,
                  color: whiteColor,
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  Rect getPreferredRect({
    @required RenderBox parentBox,
    Offset offset = Offset.zero,
    @required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
