import 'dart:async';
import 'dart:math';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:goodvibesoffl/bloc/composer/composer_bloc.dart';
import 'package:goodvibesoffl/models/composer_audio_model.dart';
import 'package:goodvibesoffl/screens/music/common_functions/musicFilterClip.dart';
import 'package:goodvibesoffl/screens/music/single_player/music_widgets.dart';
import 'package:goodvibesoffl/providers/music_providers/composer_provider.dart';
import 'package:goodvibesoffl/screens/premium/getpremium.dart';
import 'package:goodvibesoffl/services/appConfig.dart';
import 'package:goodvibesoffl/services/composer_service.dart';
import 'package:goodvibesoffl/services/user_service.dart';
import 'package:goodvibesoffl/utils/common_functiona.dart';
import 'package:goodvibesoffl/utils/image_paths.dart';
import 'package:goodvibesoffl/utils/strings/audio_constants.dart';
import 'package:goodvibesoffl/utils/theme/style.dart';
import 'package:goodvibesoffl/utils/theme/text_style.dart';
import 'package:goodvibesoffl/utils/theme/theme.dart';
import 'package:goodvibesoffl/widgets/common_widgets/common_widgets_methods.dart';
import 'package:goodvibesoffl/widgets/common_widgets/customCacheNetworkImage.dart';
import 'package:goodvibesoffl/widgets/common_widgets/custom_rounded_button.dart';
import 'package:goodvibesoffl/widgets/common_widgets/streamBuilder.dart';
import 'package:goodvibesoffl/widgets/music_timer_dialog.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:responsive_flutter/scaling_query.dart';
import '../../../locator.dart';
import 'composer_control.dart';
import 'package:flutter_screenutil/size_extension.dart';

class ComposerFilterChips extends StatefulWidget {
  final List<ComposerCategory> categories;
  const ComposerFilterChips({this.categories});

  @override
  _ComposerFilterChipsState createState() => _ComposerFilterChipsState();
}

class _ComposerFilterChipsState extends State<ComposerFilterChips> {
  List<ComposerCategory> categories = [];
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    categories = widget.categories;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(70),
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(
                left: index == 0 ? symmetricHorizonatalPadding : 0.0),
            child: MusicFilterChip(
              isSelected: index == _selectedIndex,
              title: categories[index].name,
              onPressed: () {
                if (mounted)
                  setState(() {
                    _selectedIndex = index;
                  });

                if (index == 0) {
                  BlocProvider.of<ComposerBloc>(context)
                      .add(AllCategoryClickEvent());
                } else {
                  BlocProvider.of<ComposerBloc>(context).add(
                    FilterCategoryEvent(id: categories[index].id),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}

class ComposerGridListItem extends StatefulWidget {
  final circleSize;
  final bool userPaidStatus;
  final ComposerAudio item;
  const ComposerGridListItem(
      {@required this.circleSize,
        @required this.userPaidStatus,
        @required this.item});

  @override
  _ComposerGridListItemState createState() => _ComposerGridListItemState();
}

class _ComposerGridListItemState extends State<ComposerGridListItem>
    with WidgetsBindingObserver {
  final composerService = locator<ComposerService>();
  var _circleSize;
  var user;

  bool _isBuffering = false;

  Widget _pauseIconWidget;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    user = locator<UserService>().user.value;
    _circleSize = widget.circleSize;

    _pauseIconWidget = Container(
      height: _circleSize,
      width: _circleSize,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xff618BFA).withOpacity(0.3),
                Color(0xff618BFA).withOpacity(0.3),
              ])),
      child: Icon(
        Icons.pause,
        color: whiteColor,
        size: ScreenUtil().setHeight(40),
      ),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  /// this funnction helps to do nothing on double click
  /// which was causing issue of same item being played multiple times
  /// and could not be stopped

  onPressedComposerItem(List<int> playingIds) async {
    if (composerService.addedButNotPlayingList.value.contains(widget.item.id) &&
        !playingIds.contains(widget.item.id)) {
      /// if pressed do nothing, this part is to avoid double click
      /// even if clicked multiple times it will do nothing
      // print("do nothing");
    } else {
      composerService.addedButNotPlayingList.value.remove(widget.item.id);

      await composerService.onPressedSingleItem(item: widget.item);

//// show buffering only when playing network tracks
      if (widget.item.audioPathType == audio_network) {
        if (composerService.addedButNotPlayingList.value
            .contains(widget.item.id)) {
          _isBuffering = true;
          setState(() {});
        }
      }
      /////
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<int>>(
        valueListenable: composerService.playingIds,
        child: Center(
            child: Container(
              width: ScreenUtil().setWidth(80),
              height: ScreenUtil().setHeight(90),
              child: CachedNetworkImage(
                color: lightPink,
                cacheManager: ComposerCacheManager.instance,
                imageUrl: widget.item.image,
                placeholder: (context, image) => buildCircularPlaceholder(),
                errorWidget: (context, image, other) => buildCircularPlaceholder(),
                fit: BoxFit.contain,
              ),
            )),
        builder: (context, playingIds, child) {
          bool contains;

          contains = playingIds.contains(widget.item.id);

///// do buffering stuff only for network audio
          if (widget.item.audioPathType == audio_network) {
            if (contains) {
              var audios = composerService.group.audios;

              var _audio = audios.firstWhere(
                      (aud) => aud.metas.extra['id'] == widget.item.id,
                  orElse: () => null);

              if (_audio != null) {
                AssetsAudioPlayer player =
                composerService.getSinglePlayerForAudioInGroup(_audio);

                _isBuffering = player.isBuffering.value;

                _isBuffering = false;
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  setState(() {});
                });
              } else {
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  // Timer.periodic();

                  if (mounted) setState(() {});
                });
              }
            }
          }

          return Column(
            children: <Widget>[
              InkWell(
                onDoubleTap: null,
                onTap: () async {
                  if (widget.item.isPaid) {
                    if (user.paid) {
                      await onPressedComposerItem(playingIds);
                    } else {
                      recordAnalyticsToSubscriptionPage(
                          source: "composition paid item click");
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (_) => GetPremium()));
                    }
                  } else {
                    await onPressedComposerItem(playingIds);
                  }
                },
                customBorder: CircleBorder(),
                child: Stack(
                  children: <Widget>[
                    Container(
                        height: _circleSize,
                        width: _circleSize,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: !contains
                                ? composerItemInactiveG
                                : composerItemActiveG),
                        child: child),
                    if (widget.item.isPaid && !user.paid)
                      Positioned(
                        right: 0,
                        child: Icon(
                          Icons.lock,
                          color: whiteColor,
                          size: ScreenUtil().setHeight(40),
                        ),
                      ),
                    if (_isBuffering)
                      Positioned(
                        left: _circleSize * 0.3,
                        top: _circleSize * 0.3,
                        child: showCenterCircularIndicator(),
                      ),
                    if (contains && !_isBuffering) _pauseIconWidget
                  ],
                ),
              ),
              Text("${widget.item.audioTitle}")
            ],
          );
        });
    // });
  }
}

buildCircularPlaceholder() {
  return ClipRRect(
      borderRadius: BorderRadius.circular(ScreenUtil().setWidth(60)),
      child: Image.asset(composer_paceholder_image, color: lightPink));
}

class NewMiniPlayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final composerService = locator<ComposerService>();

    final sizeManager = ResponsiveFlutter.of(context);

    return Container(
      child: StreamBuilder<List<int>>(
          stream: composerService.playingItemsListStream.stream,
          builder: (context, snapshot) {
            return ValueListenableBuilder<List<int>>(
                valueListenable: composerService.playingIds,
                builder: (context, value, child) {
                  return value.isEmpty
                      ? Container()
                      : StreamBuilder2<List<int>, bool>(
                    composerService.playingItemsListStream.stream,
                    composerService.group?.isPlaying,
                    firstInitialValue: [],
                    secondInitialValue: false,
                    builder: (context, playingItems, playingStatus) {
                      playingStatus = playingStatus ?? false;
                      List<PlayingAudio> pAudios =
                          composerService.group.playingAudios;

                      var audioTitles = "";
                      var _mixTitle = "CURRENT MIX";

                      if (pAudios.isNotEmpty) {
                        pAudios.forEach((aud) {
                          audioTitles = audioTitles == ""
                              ? aud.audio.metas.title
                              : audioTitles +
                              " ," +
                              aud.audio.metas.title;
                        });

                        var _title = audioTitles;

                        int substringCount = AppConfig.isTablet ? 60 : 35;

                        if (_title.length > substringCount)
                          _title = _title.substring(0, substringCount);

                        audioTitles = _title;
                      }

                      if (composerService.playingSavedMixId.value !=
                          -111) {
                        _mixTitle = composerService
                            .playingComposerMix?.value?.title;
                      }

                      return miniPlayerUi(
                        context: context,
                        composerService: composerService,
                        width: width,
                        sizeManager: sizeManager,
                        playingIds: value,
                        audioTitles: audioTitles,
                        mixTitle: _mixTitle,
                        playingStatus: playingStatus,
                      );
                    },
                  );
                });
          }),
    );
  }

  Widget miniPlayerUi(
      {BuildContext context,
        ScalingQuery sizeManager,
        var width,
        var audioTitles,
        List<int> playingIds,
        bool playingStatus,
        ComposerService composerService,
        String mixTitle}) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => ComposerControl(isfromBottomSheet: false)));
      },
      child: Container(
        width: width * 0.9,
        padding: EdgeInsets.only(
          left: sizeManager.wp(5),
          right: sizeManager.wp(12),
        ),
        height: width > 600 ? sizeManager.scale(40.0) : sizeManager.scale(60.0),
        decoration: BoxDecoration(
          gradient: timerDialogGradient,
          borderRadius: BorderRadius.circular(
            ScreenUtil().setSp(55),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Transform.rotate(
                angle: pi / 2,
                child: IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) =>
                                  ComposerControl(isfromBottomSheet: false)));
                    },
                    icon: Icon(CupertinoIcons.back,
                        color: whiteColor, size: ScreenUtil().setSp(38))),
              ),
            ),
            Expanded(
              child: Container(
                //  color: Colors.pink,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      mixTitle,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(color: whiteColor),
                    ),
                    if (audioTitles != "")
                      Text(
                        "${playingIds.length} TRACKS  ($audioTitles)",
                        style: Theme.of(context).textTheme.bodyText2.copyWith(
                            fontWeight: FontWeight.bold, color: whiteColor),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                      )
                  ],
                ),
              ),
            ),
            InkWell(
              customBorder: CircleBorder(),
              onTap: () {
                composerService.group.playOrPause();
              },
              child: CircleAvatar(
                backgroundColor: whiteColor,
                radius: ScreenUtil().setWidth(45),
                child: Icon(
                  playingStatus ? Icons.pause : Icons.play_arrow,
                  color: Color(0xff3F3FB6),
                  size: width > 600
                      ? ScreenUtil().setSp(40)
                      : ScreenUtil().setSp(60),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

buildCachedComposerImage(
    {@required String url,
      double imageSize,
      double hozPadding,
      double verticalPadding}) {
  var _padding = EdgeInsets.symmetric(
      horizontal: hozPadding, vertical: verticalPadding ?? 0);

  return ClipRRect(
    child: Container(
      height: imageSize,
      width: imageSize,
      decoration: BoxDecoration(
        color: whiteColor,
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          stops: [0.03, 0.9],
          tileMode: TileMode.repeated,
          colors: [
            Color(0xff6619A6).withAlpha(255),
            Color(0xff3F26B3),
          ],
        ),
        borderRadius: BorderRadius.circular(imageSize),
      ),
      child: Center(
          child: url == null
              ? Image.asset(composer_paceholder_image,
              height: ScreenUtil().setWidth(30),
              width: ScreenUtil().setWidth(45),
              color: lightPink)
              : CachedNetworkImage(
            imageUrl: url,
            cacheManager: CustomCacheManager.instance,
            placeholder: (c, b) => Image.asset(composer_paceholder_image,
                height: ScreenUtil().setWidth(30),
                width: ScreenUtil().setWidth(45),
                color: lightPink),
            errorWidget: (a, b, c) => Image.asset(
              composer_paceholder_image,
              color: lightPink,
              height: imageSize,
              width: imageSize,
            ),
            height: ScreenUtil().setWidth(45),
            width: ScreenUtil().setWidth(45),
          )),
    ),
  );
}

buildComposerItemWithClipping(
    {@required String url,
      double imageSize,
      double hozPadding,
      double verticalPadding}) {
  var _padding = EdgeInsets.symmetric(
      horizontal: hozPadding, vertical: verticalPadding ?? 0);

  return ClipRRect(
      borderRadius: BorderRadius.circular(imageSize),
      child: buildCachedComposerImage(
          url: url,
          imageSize: imageSize,
          verticalPadding: verticalPadding,
          hozPadding: hozPadding));
}

buildComposerItemImageForDialog(
    {@required String url,
      double imageSize,
      double hozPadding,
      double verticalPadding}) {
  var _padding = EdgeInsets.symmetric(
      horizontal: hozPadding, vertical: verticalPadding ?? 0);

  return Padding(
    padding: EdgeInsets.symmetric(horizontal: hozPadding),
    child: Container(
      height: imageSize,
      child: url == null
          ? Image.asset(composer_paceholder_image,
          fit: BoxFit.contain, color: lightPink)
          : CachedNetworkImage(
          imageUrl: url,
          cacheManager: CustomCacheManager.instance,
          placeholder: (c, b) =>
              Image.asset(placeholder_image, fit: BoxFit.contain),
          errorWidget: (a, b, c) =>
              Image.asset(placeholder_image, fit: BoxFit.contain),
          fit: BoxFit.contain),
    ),
  );
}

class ComposerMixCard extends StatefulWidget {
  final ComposerSavedMix mix;
  final int index;
  final bool showDetailsIcon;
  const ComposerMixCard({this.mix, this.index, this.showDetailsIcon = false});

  @override
  _ComposerMixCardState createState() => _ComposerMixCardState();
}

class _ComposerMixCardState extends State<ComposerMixCard> {
  var _width = AppConfig.isTablet
      ? ScreenUtil().setWidth(170)
      : ScreenUtil().setWidth(330);
  var _height = AppConfig.isTablet
      ? ScreenUtil().setHeight(300)
      : ScreenUtil().setHeight(380);

  var _borderRadius = BorderRadius.circular(ScreenUtil().setSp(40));

  final _composerService = locator<ComposerService>();
  var imageSize = ScreenUtil().setWidth(90);

  bool _mixClicked = false;
  bool _mixItemsLoading = true;

  @override
  Widget build(BuildContext context) {
    ComposerSavedMix mix = widget.mix;

    final width = MediaQuery.of(context).size.width;
    var _aLength = widget.mix.audios.length;
    final _titleStyle =
    Theme.of(context).textTheme.subtitle1.copyWith(color: whiteColor);
    var _stackdeImagesContainerSize;

    if (_aLength == 1) {
      _stackdeImagesContainerSize = imageSize;
    } else if (_aLength == 2) {
      _stackdeImagesContainerSize = 2 * imageSize - ScreenUtil().setWidth(20);
    } else if (_aLength > 2) {
      _stackdeImagesContainerSize = 3 * imageSize - ScreenUtil().setWidth(30);
    }

    Widget _buildPlaceholderImage() {
      return Image.asset(
        composer_paceholder_image,
        height: 40.w,
        width: 40.w,
        color: lightPink,
      );
    }

    return Padding(
      padding: EdgeInsets.only(
          left: widget.index == 0 ? symmetricHorizonatalPadding : 0.0,
          right: symmetricHorizonatalPadding),
      child: ValueListenableBuilder<int>(
          valueListenable: _composerService.playingSavedMixId,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: _height,
                width: _width,
                decoration: BoxDecoration(
                    color: Color(0xff4624B0),
                    gradient: musicPlayerDialogGradient,
                    borderRadius: _borderRadius),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      height: AppConfig.isTablet ? 100.w : 150.w,
                      width: AppConfig.isTablet ? 100.w : 150.w,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: lightBluePinkGradientT2B),
                      child: Icon(Icons.mic,
                          color: whiteColor, size: 40),
                    ),
                    SizedBox(height: AppConfig.isTablet ? 15.w : 30.w),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                          mix.audios.length > 2 ? 3 : mix.audios.length,
                              (index) {
                            var _audio = mix.audios[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Container(
                                  height: 70.w,
                                  width: 70.w,
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: lightPink)),
                                  child: _audio.image != null &&
                                      _audio.image.isNotEmpty &&
                                      _audio.image != " "
                                      ? CachedNetworkImage(
                                    height: 40.w,
                                    width: 40.w,
                                    imageUrl: _audio.image,
                                    placeholder: (a, b) =>
                                        _buildPlaceholderImage(),
                                    errorWidget: (a, b, c) =>
                                        _buildPlaceholderImage(),
                                  )
                                      : _buildPlaceholderImage()),
                            );
                          }),
                    )
                  ],
                ),
              ),
              Text(mix.title + "\n", style: _titleStyle)
            ],
          ),
          builder: (context, playingMixId, child) {
            return InkWell(
              customBorder: RoundedRectangleBorder(borderRadius: _borderRadius),
              highlightColor: tpt,
              splashColor: tpt,
              onTap: () async {
                if (mix.id != _composerService.playingSavedMixId.value) {
                  _mixClicked = true;
                  _mixItemsLoading = true;

                  setState(() {});

                  if (_composerService.group == null) {
                    _composerService.initComposer(context);
                  }

                  await _composerService.clearAll();

                  _composerService.playingSavedMixId.value = mix.id;
                  _composerService.playingComposerMix.value = mix;

                  await _composerService.addAdudiosInGroup(
                      audios: mix.audios, context: context);

                  locator<ComposerProvider>().updateMixPlayCount(mix.id);
                } else if (mix.id == _composerService.playingSavedMixId.value) {
                  _composerService.clearAll();
                  _mixClicked = false;
                  _mixItemsLoading = false;
                  setState(() {});
                }
              },
              child: Stack(
                children: <Widget>[
                  child,
                  if (playingMixId == mix.id)
                    Container(
                        height: _height,
                        width: _width,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color(0xff188DF8).withOpacity(0.5),
                                Color(0xffA63FE0).withOpacity(0.5),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            borderRadius: _borderRadius),
                        child: Center(
                          child: Icon(
                            Icons.pause,
                            size: ScreenUtil().setSp(50),
                            color: whiteColor,
                          ),
                        )),
                  if (mix.audios.length > 5 && _mixClicked && _mixItemsLoading)
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: ValueListenableBuilder<List<int>>(
                        valueListenable: _composerService.playingIds,
                        child: showCenterCircularIndicator(color: Colors.white),
                        builder: (context, snapshot, child) {
                          return (mix.audios.length == snapshot.length)
                              ? Container(height: 0.5, width: 0.5)
                              : child;
                        },
                      ),
                    ),
                ],
              ),
            );
          }),
    );
  }
}

showComposerMixInfoDialog(
    {BuildContext context, ComposerSavedMix mix, double width}) {
  showDialog(
      context: context,
      builder: (context) {
        return DialogWrapper(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.of(context, rootNavigator: true).pop(true);
                    },
                    child: Icon(
                      Icons.close,
                      color: whiteColor,
                      size: ScreenUtil().setSp(35),
                    ),
                  )
                ],
              ),
              Text(mix.title,
                  style: Theme.of(context)
                      .textTheme
                      .button
                      .copyWith(color: whiteColor, fontWeight: w600)),
              SizedBox(height: ScreenUtil().setHeight(20)),
              Container(
                height: ScreenUtil().setHeight(120),
                width: width,
                child: Center(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: mix.audios.length,
                    shrinkWrap: true,
                    itemBuilder: (context, int index) {
                      var item = mix.audios[index];
                      return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            buildComposerItemImageForDialog(
                                url: item.image,
                                hozPadding: ScreenUtil().setWidth(10),
                                imageSize: ScreenUtil().setWidth(70)),
                            SizedBox(height: ScreenUtil().setHeight(10)),
                            Text(
                              !item.audioTitle.contains(" ")
                                  ? item.audioTitle
                                  : item.audioTitle.split(" ").first,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(color: whiteColor),
                            )
                          ]);
                    },
                  ),
                ),
              ),
              Divider(color: whiteColor.withOpacity(0.3)),
              SizedBox(height: ScreenUtil().setHeight(20)),
              InkWell(
                onTap: () {
                  Navigator.of(context, rootNavigator: true).pop(true);
                  showNameYourMixDialog(
                      context: context, width: width, mix: mix, isUpdate: true);
                },
                child: Text(
                  "Change Name",
                  style: Theme.of(context)
                      .textTheme
                      .button
                      .copyWith(color: whiteColor),
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(20)),
              InkWell(
                onTap: () {
                  BlocProvider.of<ComposerBloc>(context)
                      .add(DeleteSavedcMixEvent(mixId: mix.id));
                  Navigator.pop(context);
                },
                child: Text(
                  "Delete",
                  style: Theme.of(context)
                      .textTheme
                      .button
                      .copyWith(color: whiteColor),
                ),
              )
            ],
          ),
        );
      });
}

showNameYourMixDialog(
    {BuildContext context, double width, ComposerSavedMix mix, bool isUpdate}) {
  TextEditingController _controller = TextEditingController();
  if (mix != null) _controller.text = mix.title;
  showDialog(
      context: context,
      builder: (context) {
        return DialogWrapper(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                //color: Colors.black,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.of(context, rootNavigator: true).pop(true);
                      },
                      child: Icon(Icons.close, color: whiteColor),
                    )
                  ],
                ),
              ),
              Text("Name Your Mix",
                  style: Theme.of(context)
                      .textTheme
                      .button
                      .copyWith(color: whiteColor, fontWeight: w600)),
              Divider(color: lightPink.withOpacity(0.3), thickness: 0.3),
              Container(
                margin:
                EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(20)),
                width: width * 0.7,
                decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius:
                    BorderRadius.circular(ScreenUtil().setSp(15))),
                child: TextField(
                  controller: _controller,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: blackColor),
                  decoration: InputDecoration(
                      hintText: "Name of your mix",
                      contentPadding:
                      EdgeInsets.only(left: ScreenUtil().setWidth(15)),
                      border: InputBorder.none,
                      hintStyle: Theme.of(context)
                          .textTheme
                          .bodyText2
                          .copyWith(color: greyColor)),
                  onSubmitted: (value) {},
                ),
              ),
              Divider(color: lightPink.withOpacity(0.3), thickness: 0.3),
              SizedBox(height: ScreenUtil().setHeight(15)),
              CustomRoundedButttonWithSplash(
                titleText: "Save",
                width: width * 0.55,
                height: ScreenUtil().setHeight(75),
                hozMargin: 10.0,
                borderRadius: ScreenUtil().setSp(15),
                onPressed: () async {
                  await onPressedSaveMix(
                      context: context,
                      mixName: _controller.text,
                      isUpdate: isUpdate,
                      alreadySavedAudios: mix != null ? mix.audios : null,
                      mixId: mix != null ? mix.id : null);

                  Navigator.of(context, rootNavigator: true).pop(true);
                },
                verticalMargin: ScreenUtil().setHeight(20),
              ),
              Text("Cancel", style: Theme.of(context).textTheme.button)
            ],
          ),
        );
      });
}

Future<void> onPressedSaveMix(
    {String mixName,
      BuildContext context,
      bool isUpdate,
      List<ComposerAudio> alreadySavedAudios,
      int mixId}) async {
  final composerService = locator<ComposerService>();

  List<ComposerAudio> audios =
  composerService.group.audios.map<ComposerAudio>((audio) {
    Map extra = audio.metas.extra;

    var _defaultVolume = 0.5;
    if (audio != null) {
      var player = composerService.getSinglePlayerForAudioInGroup(audio);
      _defaultVolume = player?.volume?.value;
    }

    return ComposerAudio(
        id: extra["id"],
        url: extra["url"],
        downloadUrl: extra["downloadUrl"],
        image: extra["image"],
        isPaid: extra["idpaid"],
        category: extra["category"],
        categoryId: extra["categoryId"],
        audioTitle: audio.metas.title,
        defaultVolume: _defaultVolume,
        fileName: extra['fileName'],
        audioPathType: audio.audioType.toString());
  }).toList();

  BlocProvider.of<ComposerBloc>(context).add(SaveComposeMIxesEvent(
      mixName: mixName,
      audios: isUpdate ? alreadySavedAudios : audios,
      context: context,
      isUpdate: isUpdate,
      mixId: mixId));
}
