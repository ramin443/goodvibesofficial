import 'package:assets_audio_player/assets_audio_player.dart' as prefix;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goodvibesoffl/locator.dart';
import 'package:goodvibesoffl/models/music_model.dart';
import 'package:goodvibesoffl/models/playable_model.dart';
import 'package:goodvibesoffl/models/playlist_model.dart';
import 'package:goodvibesoffl/screens/home/widgets/card.dart';
import 'package:goodvibesoffl/screens/music/single_player/music_widgets.dart';
import 'package:goodvibesoffl/screens/music/view_all.dart';
import 'package:goodvibesoffl/services/appConfig.dart';
import 'package:goodvibesoffl/services/player_service.dart';
import 'package:goodvibesoffl/services/services.dart';
import 'package:goodvibesoffl/services/user_service.dart';
import 'package:goodvibesoffl/theme.dart';
import 'package:goodvibesoffl/utils/common_functiona.dart';
import 'package:goodvibesoffl/utils/image_paths.dart';
import 'package:goodvibesoffl/utils/theme/style.dart';
import 'package:goodvibesoffl/utils/theme/text_style.dart';
import 'package:goodvibesoffl/widgets/common_widgets/common_widgets_methods.dart';
import 'package:goodvibesoffl/widgets/common_widgets/customCacheNetworkImage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

class MeditateVerticalCard extends StatelessWidget {
  final Playablee _playable;
  final bool isUserPaid = locator<UserService>().user.value.paid ?? false;
  final musicService = locator<MusicService>();

  MeditateVerticalCard({
    @required Playablee playable,
  }) : _playable = playable;

  @override
  Widget build(BuildContext context) {
    final sizeManager = ResponsiveFlutter.of(context);
    final width = MediaQuery.of(context).size.width;
    PlayList _playlist;
    Track _track;
    bool _isPlayList = _playable.type == PlayableType.Playlist ||
        _playable.type == PlayableType.Rituals;
    if (_isPlayList) {
      _playlist = _playable.playList;
      _track = null;
    } else {
      _playlist = null;
      _track = _playable.track;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        InkWell(
          onTap: () {
            navigateToMusicIntermediatePage(
                playable: _playable, sourcePage: 'sleep or medidate page');

            // if (_isPlayList) {
            //   Navigator.of(context).push(
            //     MaterialPageRoute(
            //       builder: (context) => PlayListPage(playlist: _playlist),
            //     ),
            //   );
            // } else {
            //   checkTrackPaidStatusAndNavigate(
            //       sourcePage: "mediate page",
            //       track: _track,
            //       isPaidUser: isUserPaid,
            //       context: context);
            // }
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              height: width > 600
                  ? ScreenUtil().setHeight(300)
                  : ScreenUtil().setHeight(380),
              decoration: BoxDecoration(),
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  LayoutBuilder(builder: (context, constraints) {
                    return _isPlayList
                        ? _playlist.image.isEmpty
                        ? Image.asset(
                      placeholder_image,
                      fit: BoxFit.cover,
                    )
                        : CustomCacheNetworkImage(
                      imageUrl: _playlist.image,
                      height: constraints.maxHeight,
                      width: constraints.maxWidth,
                    )
                        : _track.image.isEmpty
                        ? Image.asset(
                      placeholder_image,
                      fit: BoxFit.cover,
                    )
                        : CustomCacheNetworkImage(
                      imageUrl: _track.image,
                      height: constraints.maxHeight,
                      width: constraints.maxWidth,
                    );
                  }),
                  if (!isUserPaid && _track != null && _track.paid)
                    Positioned(
                      top: sizeManager.wp(2),
                      right: sizeManager.wp(2),
                      child: _track.paid
                          ? Container(
                        width: sizeManager.scale(30),
                        height: sizeManager.scale(30),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: blackColor.withOpacity(0.5),
                        ),
                        child: Icon(
                          Icons.lock,
                          color: whiteColor,
                          size: sizeManager.scale(18),
                        ),
                      )
                          : Container(),
                    ),
                  if (_isPlayList)
                    Positioned(
                      bottom: sizeManager.wp(3),
                      right: sizeManager.wp(2),
                      child: Container(
                        height: sizeManager.scale(20),
                        width: sizeManager.scale(60),
                        padding: EdgeInsets.symmetric(
                          horizontal: sizeManager.wp(2),
                        ),
                        decoration: BoxDecoration(
                          color: blackColor.withOpacity(0.35),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            _playable.type == PlayableType.Playlist
                                ? "Programs"
                                : "Rituals",
                            style: whiteText12.copyWith(
                              fontSize: getFontSize(context, 1.3),
                            ),
                          ),
                        ),
                      ),
                    )
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: sizeManager.scale(5)),
        Container(
          child: Text(_isPlayList ? _playlist.title : _track.title + "\n" ?? "",
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: width > 600
                  ?
              getCustomTheme(context).textTheme
                  .bodyText1
                  :  getCustomTheme(context).textTheme
                  .subtitle2),
        ),
      ],
    );
  }
}

Widget getMaterialHeader() {
  return MaterialClassicHeader(
    color: bluishPurple,
  );
}

buildTitleAndSubtitleText({
  String title,
  String subtitle,
  Function onPressedViewAll,
  TextStyle titleStyle,
  TextStyle subtitleStyle,
}) {
  return PaddingChild(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(title, style: titleStyle),
            onPressedViewAll == null
                ? Container()
                : InkWell(
              onTap: onPressedViewAll,
              child: Text("View All"),
            ),
          ],
        ),
        if (subtitle != null) Text(subtitle, style: subtitleStyle),
      ],
    ),
  );
}

class VerticalCardStack extends StatelessWidget {
  final int index;
  final width;
  final Playablee item;
  final image;
  final title;
  final Function onPressed;
  final String sourcePage;

  VerticalCardStack({
    this.index,
    this.width,
    this.item,
    this.image,
    this.title,
    this.onPressed,
    this.sourcePage,
  });

  @override
  Widget build(BuildContext context) {
    var _item = item;
    bool isPaidUser = locator<UserService>().user.value.paid;
    return Padding(
      padding: EdgeInsets.only(
        left: index == 0 ? symmetricHorizonatalPadding : 0,
        right: ScreenUtil().setWidth(20),
      ),
      child: Stack(
        children: <Widget>[
          VerticalCard(
            title: title ?? "",
            image: image,
            hasSubtitle: false,
            subtitle: "",
            onPressed: onPressed ??
                    () {
                  navigateToMusicIntermediatePage(
                    playable: item,
                    sourcePage: sourcePage,
                  );
                },
          ),
          if (!isPaidUser &&
              _item.type == PlayableType.Track &&
              _item.track.paid)
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: blackColor.withOpacity(0.5),
                ),
                child: Icon(
                  Icons.lock,
                  color: whiteColor,
                  size: width > 600 ? 20.sp : 35.sp,
                ),
              ),
            ),
          if (_item.type == PlayableType.Playlist && onPressed == null)
            Positioned(
              bottom: width > 600 ? 70.h : 100.w,
              right: 10,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: blackColor.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(30.sp),
                ),
                child: Center(child: Text("Programs")),
              ),
            ),
          if (_item.type == PlayableType.Rituals)
            Positioned(
              bottom: width > 600 ? 70.h : 100.w,
              left: 10,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 5.h),
                decoration: BoxDecoration(
                  gradient: ritualsCardGradientV,
                  borderRadius: BorderRadius.circular(30.sp),
                ),
                child: Center(
                  child: Text("${item.playList.playablesCount} sessions",
                      style: TextStyle(color: whiteColor)),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

Widget buildSizedBoxAtBottom({double height}) {
  final _service = locator<MusicService>();

  return StreamBuilder<prefix.PlayingAudio>(
    stream: _service.playingAudio.value,
    builder: (context, snapshot) {
      return SizedBox(height: snapshot?.data != null ? height ?? 120.h : 0.0);
    },
  );
}

buildViewAllCard(Map data, BuildContext context) {
  final _height = AppConfig.isTablet ? 300.h : 380.h;
  final _width = AppConfig.isTablet ? 170.w : 320.w;
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ViewAllPage(
            playablesList: data['playables'],
            slug: data['slug'],
            pageTitle: data['title'],
          ),
        ),
      );
    },
    child: Column(
      children: [
        Container(
            margin: EdgeInsets.only(right: symmetricHorizonatalPadding),
            height: _height,
            width: _width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: lightBluePinkGradientT2B),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconWithCircularBackground(
                  icon: Icons.add,
                  iconColor: whiteColor,
                  containerDimension: AppConfig.isTablet ? 60.w : 100.w,
                  backgroundColor: whiteColor.withOpacity(0.3),
                  iconSize: AppConfig.isTablet ? 24.sp : 80.sp,
                ),
                SizedBox(height: ScreenUtil().setHeight(10)),
                Text("VIEW ALL",
                    style: TextStyle(
                        fontSize: AppConfig.isTablet ? 24 : 18,
                        color: whiteColor),
                    textAlign: TextAlign.center),
              ],
            )),
        Text("\n\n")
      ],
    ),
  );
}
