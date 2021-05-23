import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:goodvibesoffl/models/composer_download_task_model.dart';
import 'package:goodvibesoffl/models/models.dart';
import 'package:goodvibesoffl/models/music_model.dart';
import 'package:goodvibesoffl/models/playlist_model.dart';
import 'package:goodvibesoffl/screens/music/single_player/music_widgets.dart';
import 'package:goodvibesoffl/screens/rituals/rituals_playlist.dart';
import 'package:goodvibesoffl/services/appConfig.dart';
import 'package:goodvibesoffl/services/player_service.dart';
import 'package:goodvibesoffl/utils/image_paths.dart';
import 'package:goodvibesoffl/utils/theme/text_style.dart';
import 'package:goodvibesoffl/widgets/common_widgets/common_widgets_methods.dart';
import 'package:goodvibesoffl/widgets/common_widgets/customCacheNetworkImage.dart';
import 'rituals.dart';
import 'package:goodvibesoffl/providers/rituals_provider.dart';
import 'package:goodvibesoffl/services/services.dart';
import 'package:goodvibesoffl/utils/common_functiona.dart';
//import 'package:goodvibesofficial/utils/theme/rituals_icons_icons.dart';
import 'package:goodvibesoffl/utils/theme/style.dart';
import 'package:goodvibesoffl/utils/theme/theme.dart';
import 'package:goodvibesoffl/utils/utils.dart';
import 'package:rxdart/streams.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import '../../locator.dart';
import 'package:flutter_screenutil/size_extension.dart';

class DownloadProgressIndicator extends StatefulWidget {
  @override
  _DownloadProgressIndicatorState createState() =>
      _DownloadProgressIndicatorState();
}

class _DownloadProgressIndicatorState extends State<DownloadProgressIndicator> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
        valueListenable: RitualsProvider().totalProgress,
        child: InkWell(
          onTap: () {
            RitualsProvider().cancelDownload();
          },
          child: Icon(Icons.close, color: whiteColor, size: 50.sp),
        ),
        builder: (context, progress, child) {
          if (progress > 100) progress = 100;

          return SleekCircularSlider(
            innerWidget: (value) => child,
            initialValue: progress ?? 0.0,
            min: -0.01,
            max: 100,
            appearance: CircularSliderAppearance(
              size: 50,
              startAngle: -90,
              angleRange: 360.0,
              animationEnabled: false,
              customWidths:
              CustomSliderWidths(progressBarWidth: 5, handlerSize: 0.001),
              customColors: CustomSliderColors(
                trackColor: whiteColor,
                progressBarColors: [
                  Color(0xff1C91FB),
                  Color(0xffFD729E2),
                ],
                gradientStartAngle: -90.0,
                gradientEndAngle: 270.0,
              ),
            ),
          );
        });
  }
}

class SuffixIcon extends StatefulWidget {
  final bool _isItemDownloading;
  final Track _track;
  final int index;
  final bool unlocked;

  SuffixIcon({bool isItemDownloading, Track track, this.index, this.unlocked})
      : _isItemDownloading = isItemDownloading,
        _track = track;

  @override
  _SuffixIconState createState() => _SuffixIconState();
}

class _SuffixIconState extends State<SuffixIcon> {
  @override
  void initState() {
    super.initState();

    RitualsProvider().downloadingItemsStream.stream.listen((event) {
      if (event != null) {
        /// just rebuild the icon when the new update is added into the download items stream
        if (mounted) setState(() {});
      }
    });
  }

  Future<IconData> checkIfPlaybackCompleted() async {
    var res = await DatabaseService()
        .getTrackFromRitualTable(widget._track.id, widget._track.playlistId);

    // await db.rawQuery(
    //     ''' SELECT * from  "rituals_table" WHERE id=${widget._track.id} AND playlist_id=${widget._track.playlistId}''');

    // print('each item length in database: ${res.length}');
    if (res.isEmpty) {
      return Icons.play_circle_filled_outlined;
    } else {
      var _status = res[DatabaseService.Column_completion_status];

      if (_status.toString() == CompletionStatus.Complete.toString()) {
        return Icons.check_circle_outline_outlined;
      } else if (_status == CompletionStatus.Started.toString()) {
        return Icons.rotate_90_degrees_ccw;
      } else {
        return Icons.play_circle_filled_outlined;
      }
    }
  }

  static const Color color = Color(0xff8FD988);
  static final Color darkBlue = Color(0xff03012A);
  @override
  Widget build(BuildContext context) {
    /// The differnt  cases for this small ui section which mostly
    ///  contains only one icon:

    /// 1.  `Icons.play_circle_filled_outlined` , if track is not yet played
    /// 2. Stack of  RitualsIcons.dot  and circle,
    /// if track is has been started but not completed
    /// in this case also show progress bar for that track

    /// 3. Icons.check_circle_outline_outlined, if track is completed
    /// 4. Download progress circle with percentage, if the track is being downlaoded
    /// 5. Icons.rotate, Icons.lock, if the track is paid
    /// 6. Icons.lock , in Icons With circular background , if track is premium
    ///
    ///
    final _user = locator<UserService>().user.value;
    dPrint('index: ${widget.index}  user type: ${_user.userPlanType}');

    bool _userPaid = _user.userPlanType == UserPlanType.Monthly ||
        _user.userPlanType == UserPlanType.Yearly ||
        _user.userPlanType == UserPlanType.Promo;

    if (_user.userPlanType == UserPlanType.Free && widget.index > 0) {
      return IconWithCircularBackground(
        backgroundColor: darkBlue,
        icon: Icons.lock,
        iconColor: whiteColor,
        iconSize: 20.w,
        containerDimension: 40.w,
      );
    } else if (_user.userPlanType == UserPlanType.FreeTrial &&
        widget.index > 6) {
      return IconWithCircularBackground(
        backgroundColor: darkBlue,
        icon: Icons.lock,
        iconColor: whiteColor,
        iconSize: 20.w,
        containerDimension: 40.w,
      );
    } else if (!widget.unlocked) {
      return Container(
        child: Stack(
          children: [
            Icon(AntDesign.reload1, color: color, size: 50.w),
            Positioned(
              top: 20.w,
              left: 15.w,
              child: Icon(Icons.lock, color: color, size: 20.w),
            )
          ],
        ),
      );
    } else {
      return ValueListenableBuilder<List<DownloadTaskModel>>(

        /// child is save some peformance in value listenable
        /// used down below.
        /// it retuns  case 1
          child: Icon(
            Icons.play_circle_filled_outlined,
            color: color,
            size: AppConfig.isTablet ? 50.sp : 40.sp,
          ),
          valueListenable: RitualsProvider().dowloadingPlaylistItems,
          builder: (context, list, child) {
            var percent = 0;

            var downloadItem = list.firstWhere(
                    (downloadItem) => downloadItem.audioId == widget._track.id,
                orElse: () => null);

            if (downloadItem != null) {
              percent = downloadItem.progress ?? 0;
            }

            /// case 4
            if (downloadItem != null) {
              return Container(
                height: 60.w,
                width: 60.w,
                child: Stack(
                  children: [
                    CircularProgressIndicator(
                      value: double.parse(percent.toString()) / 100,
                      valueColor: AlwaysStoppedAnimation(Colors.blue),
                      backgroundColor: whiteColor,
                      strokeWidth: 2.0,
                    ),
                    Positioned(
                      left: 12.w,
                      top: 12.w,
                      child: Text(" ${percent}"),
                    ),
                  ],
                ),
              );
            } else {
              /// when the suffix icon's track  is the not the one being downloaded
              /// but other tracks are still downloading
              /// this is done to fix blinking issue because of state rebuild
              /// triggerd on tracks whose download are completed

              if (list.isNotEmpty) {
                return child;
              }

              /// cases other than no 4
              else {
                return FutureBuilder(
                    future: checkIfPlaybackCompleted(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState != ConnectionState.done) {
                        return Container();
                      } else {
                        /// only if case 2
                        if (snapshot.data == Icons.rotate_90_degrees_ccw) {
                          final _containerSize =
                          AppConfig.isTablet ? 30.w : 40.w;
                          final _dotSize = AppConfig.isTablet ? 14.w : 24.w;
                          return Container(
                            height: 40.w,
                            width: _containerSize,
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Icon(snapshot.data,
                                      color: color,
                                      size: AppConfig.isTablet ? 25.sp : 40.sp),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    height: _dotSize,
                                    width: _dotSize,
                                    decoration: BoxDecoration(
                                      color: color,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        }

                        /// case 1 or 3
                        else {
                          return Icon(snapshot.data,
                              color: color,
                              size: AppConfig.isTablet ? 30.sp : 40.sp);
                        }
                      }
                    });
              }
            }
          });
    }
  }
}

class RitualPlaylistItemPlayButton extends StatelessWidget {
  RitualPlaylistItemPlayButton(
      {@required Track track, @required PlayList playlist, this.onPressed})
      : _playlist = playlist,
        _singleTrack = track;

  final musicLocator = locator<MusicService>();
  final PlayList _playlist;
  final Track _singleTrack;
  final bool _isPaidUser = locator<UserService>().user.value.paid;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    var _iconSize = AppConfig.isTablet ? 30.sp : 40.sp;
    final _color = Color(0xff3D1481);

    return ValueListenableBuilder<int>(
      valueListenable: musicLocator.currentPlaylistID,
      builder: (context, index, _) {
        return ValueListenableBuilder<ValueStream<bool>>(
            valueListenable: musicLocator.currentTrackStatus,
            builder: (context, trackStatusStream, _) {
              return StreamBuilder<bool>(
                stream: trackStatusStream,
                initialData: false,
                builder: (context, trackStatus) {
                  return InkWell(
                    onTap: () async {
                      await onPressed();
                    },
                    child: Container(
                      height: AppConfig.isTablet ? 30.w : 60.w,
                      width: AppConfig.isTablet ? 30.w : 60.w,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: whiteColor),
                      child: Stack(
                        fit: StackFit.expand,
                        children: <Widget>[
                          /// play or pause icon for each track
                          Builder(builder: (context) {
                            Track _track = musicLocator.getCurrentTrack();
                            if (_singleTrack.id == _track?.id) {
                              return Icon(
                                  trackStatus.data
                                      ? Icons.pause
                                      : Icons.play_arrow_rounded,
                                  color: _color,
                                  size: _iconSize);
                            } else {
                              return Icon(Icons.play_arrow_rounded,
                                  color: _color, size: _iconSize);
                            }
                          }),
                          // show loading indicator while track is loading
                          Builder(builder: (context) {
                            Track _track = musicLocator.getCurrentTrack();
                            if (_track?.id == _singleTrack.id) {
                              return ValueListenableBuilder<ValueStream<bool>>(
                                  valueListenable:
                                  musicLocator.currentTrackBufferingStatus,
                                  builder: (context, bufferingStatusStream, _) {
                                    return StreamBuilder(
                                        stream: bufferingStatusStream,
                                        initialData: false,
                                        builder: (context, bufferingStatus) {
                                          return bufferingStatus.data
                                              ? SpinKitCircle(
                                              size: _iconSize,
                                              color: Colors.black26)
                                              : Container();
                                        });
                                  });
                            }
                            return Container();
                          }),
                        ],
                      ),
                    ),
                  );
                },
              );
            });
      },
    );
  }
}

class CourseProgressIndicator extends StatefulWidget {
  const CourseProgressIndicator(
      {int playlistId,
        int length,
        bool showProgressText = true,
        Color color,
        double height,
        @required PlayList playlist})
      : _playlistId = playlistId,
        this.length = length,
        _playlist = playlist,
        _color = color,
        _height = height,
        _showProgressText = showProgressText;

  final int _playlistId;
  final int length;
  final bool _showProgressText;
  final Color _color;
  final PlayList _playlist;
  final double _height;

  @override
  _CourseProgressIndicatorState createState() =>
      _CourseProgressIndicatorState();
}

class _CourseProgressIndicatorState extends State<CourseProgressIndicator> {
  Future<List<Map<String, dynamic>>> getRitualsTableItems() async {
    return await DatabaseService()
        .getAllFromRitualsTableWithFromPlaylist(widget._playlistId);
    // await _db.rawQuery(
    //     '''SELECT * FROM rituals_table WHERE playlist_id=${widget._playlistId} ''');
  }

  @override
  void initState() {
    super.initState();
    locator<MusicService>().playbackDurationController.stream.listen((data) {
      if (data != null) {
        if (mounted) {
          setState(() {});
        }
      }
    });
  }

  double _lastPercentage = 0.0;
  double _last_width = 0.0;

  getPercentageOfApi(PlayList playlist) {
    var _stat = playlist.playableStat;
    if (_stat == null) {
      return 0.0;
    }
    if (_stat.playedDuration == 0) {
      return 0.0;
    } else if (_stat.totalDuration == 0) {
      return 0.0;
    } else {
      return _stat.playedDuration / _stat.totalDuration;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bodyText2 =
    Theme.of(context).textTheme.subtitle1.copyWith(color: whiteColor);
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30.w),
      child: Container(
        child: FutureBuilder<List<Map<String, dynamic>>>(
            future: getRitualsTableItems(),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return buildCourseIndicatorOnly(
                  width: width,
                  color: widget._color,
                  height: widget._height,
                  percent: _lastPercentage,
                  roundedPercent: (_lastPercentage * 100).toStringAsFixed(2),
                  bodyText2: bodyText2,
                  showProgressText: widget._showProgressText,
                );
              } else {
                var _percent = 0.0;
                var roundedPercent = "0.0";

                if (snapshot.data.isEmpty) {
                  _percent = getPercentageOfApi(widget._playlist);
                  roundedPercent = (_percent * 100).toStringAsFixed(2);
                } else {
                  var _perApi = getPercentageOfApi(widget._playlist);

                  _percent = getCourseCompletionPercentage(
                      playedItems: snapshot.data.toList(),
                      totalItemsLength: widget.length);

                  roundedPercent = (_percent * 100).toStringAsFixed(2);
                  _lastPercentage = _percent;

                  DatabaseService().updateRituaslPlaylistTable(
                      totalProgress: roundedPercent,
                      playlistId: widget._playlistId);
                }

                return buildCourseIndicatorOnly(
                    color: widget._color,
                    width: width,
                    percent: _percent,
                    height: widget._height,
                    roundedPercent: roundedPercent,
                    bodyText2: bodyText2,
                    showProgressText: widget._showProgressText);
              }
            }),
      ),
    );
  }
}

Future<Map<String, dynamic>> checkRitualTrackPosition(
    int trackId, int playlistId) async {
  var res =
  await DatabaseService().getTrackFromRitualTable(trackId, playlistId);

  // print("res in check tack positoin function: $res");
  return res;
}

class RitualCard extends StatelessWidget {
  final PlayList item;
  final bool fullScreenWidth;
  const RitualCard({@required this.item, this.fullScreenWidth = false});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    final _darkBlue = Color(0xff541EAB);
    final theme = Theme.of(context);
    final titleStyle = theme.textTheme.headline5
        .copyWith(color: whiteColor, fontFamily: proxima, fontWeight: w500);

    final bodyText2 = theme.textTheme.subtitle1.copyWith(color: whiteColor);

    final _cardHeight = AppConfig.isTablet ? 230.w : 380.w;
    final _subtitleStyle = theme.textTheme.subtitle2;
    bool _isCourseStarted =
        item.playableStat.status != CompletionStatus.NonStarted;
    return Container(
      width: fullScreenWidth
          ? width
          : AppConfig.isTablet
          ? width * 0.6
          : width * 0.8,
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (_) => RitualPlaylist(playlist: item)));
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40.w),
          child: Column(
            children: [
              Container(
                height: AppConfig.isTablet ? _cardHeight : _cardHeight * 0.95,
                child: Stack(
                  children: [
                    Container(
                      decoration:
                      BoxDecoration(gradient: lightBluePinkGradientT2B),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            item.image != null &&
                                item.image.isNotEmpty &&
                                item.image != " "
                                ? CachedNetworkImage(
                                height: _cardHeight * 0.8,
                                fit: BoxFit.cover,
                                imageUrl: item.image,
                                errorWidget: (context, _, __) {
                                  return Image.asset(
                                      ritals_card_placeholder);
                                },
                                placeholder: (context, image) =>
                                    Image.asset(ritals_card_placeholder),
                                cacheManager: CustomCacheManager.instance)
                                : Image.asset(ritals_card_placeholder),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: AppConfig.isTablet ? 0 : 10,
                      left: AppConfig.isTablet ? 25.w : 40.w,
                      child: Container(
                        height: AppConfig.isTablet ? 120.sp : 150.sp,
                        width: 100,
                        child: Stack(
                          children: [
                            Positioned(
                              top: 0,
                              child: Text(
                                "${item.playablesCount != 1 ? item.playablesCount - 1 : 1} ",
                                style: TextStyle(
                                  fontSize: AppConfig.isTablet ? 65.sp : 80.sp,
                                  color: whiteColor,
                                  fontWeight: bold,
                                ),
                              ),
                            ),
                            Positioned(
                              top: AppConfig.isTablet ? 65.sp : 80.sp,
                              child: Text(
                                  item.playablesCount != 1 ? 'DAYS' : "DAY",
                                  style: TextStyle(
                                    color: whiteColor,
                                    fontSize:
                                    AppConfig.isTablet ? 25.sp : 35.sp,
                                  )),
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                        right: 10,
                        bottom: AppConfig.isTablet ? 8.w : 18.w,
                        child: Container(
                            padding: EdgeInsets.only(
                                top: AppConfig.isTablet ? 8.w : 10.w,
                                bottom: AppConfig.isTablet ? 8.w : 10.w,
                                left: 15.w,
                                right: 1),
                            decoration: BoxDecoration(
                                color: whiteColor,
                                borderRadius: BorderRadius.circular(
                                    AppConfig.isTablet ? 20.sp : 30.sp)),
                            child: Center(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(_isCourseStarted ? 'CONTINUE' : 'START',
                                      style: TextStyle(
                                          color: _darkBlue,
                                          fontFamily: "ProximaNova",
                                          fontSize: AppConfig.isTablet
                                              ? 10.sp
                                              : 24.sp)),
                                  Icon(
                                    Icons.play_arrow_rounded,
                                    color: _darkBlue,
                                  )
                                ],
                              ),
                            )))
                  ],
                ),
              ),
              Container(
                height: AppConfig.isTablet ? 180 : 235.w,
                padding: EdgeInsets.only(
                    left: 30.w,
                    right: 30.w,
                    bottom: AppConfig.isTablet ? 15.w : 30.w),
                decoration: BoxDecoration(gradient: ritualsCardGradientV),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    (_isCourseStarted)
                        ? Column(
                      children: [
                        CourseProgressIndicator(
                          playlistId: item.id,
                          playlist: item,
                          showProgressText: true,
                          color: whiteColor,
                          height: 3,
                          length: item.playablesCount,
                        ),
                      ],
                    )
                        : Container(height: 7),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item.title ?? "",
                                  style: titleStyle,
                                  maxLines: _isCourseStarted ? 2 : 3,
                                  overflow: TextOverflow.ellipsis),
                              if (_isCourseStarted)
                                Text('DAY ${getCurrentDayForRituals(item)}',
                                    style: _subtitleStyle)
                            ],
                          ),
                        ),
                      ],
                    )
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
