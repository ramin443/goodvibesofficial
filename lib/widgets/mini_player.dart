import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:goodvibesoffl/models/model.dart';
import 'package:goodvibesoffl/screens/music/single_player_red.dart';
import 'package:goodvibesoffl/services/appConfig.dart';
import 'package:goodvibesoffl/services/player_service.dart';
import 'package:goodvibesoffl/services/services.dart';
import 'package:goodvibesoffl/utils/image_paths.dart';
import 'package:goodvibesoffl/utils/theme/theme.dart';
import 'package:goodvibesoffl/utils/utils.dart';

import '../locator.dart';
import '../utils/theme/style.dart';
import '';

class MiniPlayer extends StatefulWidget {
  @override
  _MiniPlayerState createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer> {
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _darkBlue = Color(0xff0D023B);
    final musicService = MusicService();
    final theme = Theme.of(context);

    final ttileStyle = theme.textTheme.subtitle1;
    Widget buildUI() {
      Track _track = musicService.getCurrentTrack();

      if (_track == null) {
        return Container();
      } else
        return Padding(
          padding: EdgeInsets.only(
              bottom: 20.0,
              left: symmetricHorizonatalPadding,
              right: symmetricHorizonatalPadding),
          child: Container(
            // width: _width,
            height: AppConfig.isTablet ? 80.w : 120.w,
            decoration: BoxDecoration(
                gradient: bluePurpleGradientL2R,
                borderRadius: BorderRadius.circular(60.w)),
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(CupertinoPageRoute(
                                builder: (_) => SingplePlayerRedesign(
                                    fromPlaylist: false)));
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(40.w),
                            child: Container(
                                color: whiteColor,
                                height: AppConfig.isTablet ? 60.w : 80.w,
                                width: AppConfig.isTablet ? 60.w : 80.w,
                                child: FadeInImage(
                                  placeholder: AssetImage(placeholder_image),
                                  image: NetworkImage(_track.image),
                                  fit: BoxFit.cover,
                                )),
                          ),
                        ),
                      ),
                      SizedBox(width: 30.w),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(CupertinoPageRoute(
                              builder: (_) =>
                                  SingplePlayerRedesign(fromPlaylist: false)));
                        },
                        child: Container(
                          width: AppConfig.isTablet
                              ? _width * 0.45
                              : _width * 0.38,
                          child: Text(
                            _track.title ?? "",
                            maxLines: 2,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: ttileStyle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: AppConfig.isTablet ? 20.w : 20.w),
                          child: Icon(
                            Icons.fast_rewind_rounded,
                            color: whiteColor,
                            size: AppConfig.isTablet ? 35.w : 40.w,
                          ),
                        ),
                        onTap: () {
                          musicService.seekRewindSinglePlayer('');
                        },
                      ),
                      ValueListenableBuilder<Stream<PlayerState>>(
                        valueListenable: musicService.playingState,
                        builder: (context, stream, m) {
                          return StreamBuilder<PlayerState>(
                              stream: stream,
                              builder: (context, snapshot) {
                                return InkWell(
                                  onTap: () {
                                    musicService.playOrPausePlayer();
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: whiteColor,
                                    radius: AppConfig.isTablet ? 35.w : 40.w,
                                    child: Icon(
                                      snapshot?.data == PlayerState.play
                                          ? Icons.pause_rounded
                                          : Icons.play_arrow_rounded,
                                      color: Color(0xff3F3FB6),
                                      size: AppConfig.isTablet ? 35.w : 50.w,
                                    ),
                                  ),
                                );
                              });
                        },
                      ),
                      InkWell(
                        splashColor: whiteColor.withOpacity(0.5),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: AppConfig.isTablet ? 20.w : 25.w),
                          child: Icon(
                            Icons.fast_forward_rounded,
                            color: whiteColor,
                            size: AppConfig.isTablet ? 35.w : 40.w,
                          ),
                        ),
                        onTap: () {
                          musicService.seekForwardSinglePlayer('');
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
    }

    return ValueListenableBuilder<Stream<PlayerState>>(
        valueListenable: musicService.playingState,
        key: ValueKey("new mini player"),
        builder: (context, stream, child) {
          return StreamBuilder(
              stream: stream,
              initialData: PlayerState.stop,
              builder: (context, snapshot) {
                dPrint(snapshot.connectionState);
                dPrint(snapshot?.data);

                if (snapshot?.data == null ||
                    snapshot?.data == PlayerState.stop) {
                  return Container();
                } else {
                  return buildUI();
                }
              });

          // return child;
        });
  }
}
