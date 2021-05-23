import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:goodvibesoffl/models/models.dart';
import 'package:goodvibesoffl/models/music_model.dart';
import 'package:goodvibesoffl/models/playable_model.dart' as custom;
import 'package:goodvibesoffl/models/playable_model.dart';
import 'package:goodvibesoffl/screens/music/single_player/music_widgets.dart';
import 'package:goodvibesoffl/screens/rituals/rituals_playlist.dart';
import 'package:goodvibesoffl/services/appConfig.dart';
import 'package:goodvibesoffl/services/player_service.dart';
import 'package:goodvibesoffl/services/services.dart';
import 'package:goodvibesoffl/utils/common_functiona.dart';
import 'package:goodvibesoffl/utils/image_paths.dart';
import 'package:goodvibesoffl/utils/theme/style.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:goodvibesoffl/utils/theme/text_style.dart';
import 'package:goodvibesoffl/widgets/common_widgets/custom_rounded_button.dart';
import 'package:goodvibesoffl/widgets/common_widgets/pages_wrapper_with_background.dart';
import '../../locator.dart';

class RitualDetails extends StatefulWidget {
  final custom.Playable _object;

  const RitualDetails({@required custom.Playable object}) : _object = object;
  @override
  _RitualDetailsState createState() => _RitualDetailsState();
}

class _RitualDetailsState extends State<RitualDetails> {
  final _color = Color(0xff3D1481);
  final _musicService = locator<MusicService>();

  bool _isPlayingTrack = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    var heading = theme.textTheme.headline4.copyWith(
      color: whiteColor,
      fontFamily: proxima,
    );

    final descriptionStyle = theme.textTheme.button
        .copyWith(color: whiteColor.withOpacity(0.6), fontFamily: proxima);

    final buttonStyle = theme.textTheme.button.copyWith(color: whiteColor);
    Track playingTrack = _musicService.getCurrentTrack();

    if (playingTrack != null && widget._object.track.id == playingTrack?.id) {
      _isPlayingTrack = true;
    } else {
      _isPlayingTrack = false;
    }

    Widget buildButton(bool isPlayingAudio) {
      return CustomRoundedButttonWithSplash(
        centerWidget: Row(
          children: [
            IconWithCircularBackground(
              backgroundColor: whiteColor,
              icon: isPlayingAudio ? Icons.stop : Icons.play_arrow_rounded,
              containerDimension: AppConfig.isTablet ? 30.w : 40.w,
              iconColor: _color,
              iconSize: AppConfig.isTablet ? 20.sp : 30.sp,
            ),
            SizedBox(width: 20.w),
            Text(isPlayingAudio ? "STOP" : 'PLAY', style: buttonStyle),
          ],
        ),
        borderRadius: 50.sp,
        verticalMargin: 0.0,
        gradient: lightBluePinkGradientL2R,
        width: width * 0.3,
        onPressed: () async {
          if (widget._object.type == PlayableType.Track) {
            bool _isUserPaid = locator<UserService>().user.value.paid;
            Track _track = widget._object.track;
            Track _playingTrack = _musicService.getCurrentTrack();

            if (_playingTrack != null &&
                widget._object.track.id == _playingTrack?.id) {
              // stop
              await _musicService.stopPlayer();
              setState(() {});
            } else {
              checkTrackPaidStatusAndNavigate(
                track: widget._object.track,
                isPaidUser: _isUserPaid,
                context: context,
              );
            }
          } else {
            Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (_) =>
                        RitualPlaylist(playlist: widget._object.playList)));
          }
        },
      );
    }

    print('build again');
    return PagesWrapperWithBackground(
      hasScaffold: false,
      customPaddingHoz: 0.0,
      child: SafeArea(
        top: true,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                    bottomLeft:
                    Radius.circular(AppConfig.isTablet ? 50.w : 70.w),
                    bottomRight:
                    Radius.circular(AppConfig.isTablet ? 50.w : 70.w)),
                child: Stack(
                  children: [
                    Container(
                      // height: AppConfig.isTablet ? 350.w : 500.w,
                      width: width,
                      decoration:
                      BoxDecoration(gradient: lightBluePinkGradientT2B),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: AppConfig.isTablet ? 350.w : 700.w,
                            width: width,
                            child: widget._object.typeObject.image == null ||
                                widget._object.typeObject.image == " "
                                ?
                            Container(
                              child: Image.asset(
                                ritual_placeholder,
                                alignment: Alignment.bottomCenter,
                              ),
                            )
                                : CachedNetworkImage(
                                fit: BoxFit.cover,
                                alignment: Alignment.topCenter,
                                imageUrl: widget._object.typeObject.image,
                                errorWidget: (a, b, c) =>
                                    Image.asset(ritual_placeholder),
                                placeholder: (contexxt, a) =>
                                    Image.asset(ritual_placeholder)),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      left: 10,
                      top: 10,
                      child: IconButton(
                          icon: Icon(CupertinoIcons.back,
                              color: whiteColor,
                              size: AppConfig.isTablet ? 15.w : 25.w),
                          onPressed: () => Navigator.pop(context)),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: symmetricHorizonatalPadding * 2),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30.w),
                    Text(widget._object.typeObject.title ?? "", style: heading),
                    SizedBox(height: 30.w),
                    Html(
                        data: widget._object.typeObject.description ?? "",
                        customTextStyle: (a, b) => descriptionStyle),
                    SizedBox(height: 50.w),
                    ValueListenableBuilder<Stream<PlayingAudio>>(
                        valueListenable: _musicService.playingAudio,
                        builder: (context, data, _) {
                          return StreamBuilder<PlayingAudio>(
                            stream: data,
                            builder: (context,
                                AsyncSnapshot<PlayingAudio> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.active) {
                                print(snapshot.connectionState);
                                var _audio = snapshot.data;

                                if (_audio != null) {
                                  if (_audio.audio.metas.extra['track'].id ==
                                      widget._object.track.id) {
                                    return buildButton(true);
                                  } else {
                                    return buildButton(false);
                                  }
                                } else {
                                  return buildButton(false);
                                }
                              } else {
                                return buildButton(false);
                              }
                            },
                          );
                        }),
                    SizedBox(height: 200.h)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
