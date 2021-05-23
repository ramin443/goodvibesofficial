import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:goodvibesoffl/bloc/playlist_bloc/playlist_bloc.dart';
import 'package:goodvibesoffl/locator.dart';
import 'package:goodvibesoffl/models/music_model.dart';
import 'package:goodvibesoffl/models/playlist_model.dart';
import 'package:goodvibesoffl/screens/premium/getpremium.dart';
import 'package:goodvibesoffl/services/adsModelService.dart';
import 'package:goodvibesoffl/services/appConfig.dart';
import 'package:goodvibesoffl/services/player_service.dart';
import 'package:goodvibesoffl/services/user_service.dart';
import 'package:goodvibesoffl/utils/common_functiona.dart';
import 'package:goodvibesoffl/utils/image_paths.dart';
import 'package:goodvibesoffl/utils/theme/style.dart';
import 'package:goodvibesoffl/widgets/common_widgets/appBar.dart';
import 'package:goodvibesoffl/widgets/common_widgets/common_widgets_methods.dart';
import 'package:goodvibesoffl/widgets/common_widgets/pages_wrapper_with_background.dart';
import 'package:goodvibesoffl/widgets/common_widgets/streamBuilder.dart';
import 'package:goodvibesoffl/widgets/common_widgets/valueListenableBuilder.dart';
import 'package:intl/intl.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:rxdart/rxdart.dart';
import '../../routes.dart';
import 'package:responsive_flutter/scaling_query.dart';

class PlayListPage extends StatefulWidget {
  final PlayList playlist;
  PlayListPage({@required this.playlist});
  @override
  _PlayListPageState createState() => _PlayListPageState();
}

class _PlayListPageState extends State<PlayListPage> {
  bool _isExpanded = false;
  final musicLocator = locator<MusicService>();
  bool isPaidUser = false;
  bool _isExceed = false;
  bool _isPaginateLoading = false;

  ScrollController _controller;

  @override
  void initState() {
    super.initState();

    _controller = ScrollController()
      ..addListener(() {
        var _position = _controller.position;
        if (_controller.offset >= _position.maxScrollExtent &&
            !_position.outOfRange) {
          if (_position.atEdge && _position.pixels != 0) {
            BlocProvider.of<PlaylistBloc>(context).add(FetchMorePlaylistData());
          }
        }
      });

    isPaidUser = locator<UserService>().user.value.paid;
    BlocProvider.of<PlaylistBloc>(context).add(
      PlaylistFetch(slug: widget.playlist.slug),
    );
  }

  @override
  Widget build(BuildContext context) {
    final sizeManager = ResponsiveFlutter.of(context);
    return PagesWrapperWithBackground(
      customPaddingHoz: 0.0,
      hasScaffold: true,
      showBannerAds: locator<AdsModelService>().adsData.showPlaylist,
      child: Container(
        height: sizeManager.hp(100),
        width: sizeManager.wp(100),
        child: Stack(
          children: <Widget>[
            buildBackgroundImage(sizeManager),
            buildBackgroundShade(context),
            buildAppBar(context),
            Positioned.fill(
              top: AppBar().preferredSize.height +
                  MediaQuery.of(context).padding.top,
              left: 18,
              right: 18,
              bottom: 10,
              child: SingleChildScrollView(
                child: Container(
                  child: BlocListener<PlaylistBloc, PlaylistState>(
                    listener: (context, state) {
                      if (state is PlaylistFetchMoreLoading) {
                        if (mounted)
                          setState(() {
                            _isPaginateLoading = true;
                          });
                      } else if (state is PlaylistFetchMoreError) {
                        if (mounted)
                          setState(() {
                            _isPaginateLoading = false;
                          });

                        showToastMessage(
                            message:
                            "An error occured while loading more data!");
                      } else {
                        if (mounted)
                          setState(() {
                            _isPaginateLoading = false;
                          });
                      }
                    },
                    child: BlocBuilder<PlaylistBloc, PlaylistState>(
                        builder: (context, state) {
                          if (state is PlaylistLoading)
                            return Container(
                              height: ResponsiveFlutter.of(context).hp(100),
                              width: ResponsiveFlutter.of(context).wp(100),
                              child: showCenterCircularIndicator(color: greyColor),
                            );
                          else if (state is PlaylistWithData ||
                              state is PlaylistFetchMoreLoading ||
                              state is PlaylistFetchMoreError) {
                            List<Track> tracks = state.props;

                            return Column(
                              children: <Widget>[
                                SizedBox(
                                  height: _isExpanded
                                      ? sizeManager.hp(4)
                                      : sizeManager.hp(8),
                                ),
                                if (widget.playlist.description.isNotEmpty)
                                  buildDescriptionText(sizeManager),
                                SizedBox(height: 10),
                                PlayListPlayPauseButton(
                                    playlist: widget.playlist, tracks: tracks),
                                ListView.builder(
                                  controller: _controller,
                                  itemCount: tracks.length,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    final _singleTrack = tracks[index];
                                    bool _isPaidUser =
                                        locator<UserService>().user.value.paid;
                                    return Padding(
                                      padding: EdgeInsets.only(bottom: 15.w),
                                      child: PlaylistCard(
                                        // tracks: tracks,
                                        playlist: widget.playlist,
                                        singleTrack: _singleTrack,
                                        isPaidUser: _isPaidUser,
                                      ),
                                    );
                                  },
                                ),
                                SizedBox(height: 10),
                                if (_isPaginateLoading)
                                  Padding(
                                      padding: EdgeInsets.only(bottom: 20),
                                      child: showCenterCircularIndicator()),
                              ],
                            );
                          } else if (state is PlaylistError)
                            return ErrorTryAgain(
                              errorMessage: state.errorMessage,
                              onPressedTryAgain: () {
                                BlocProvider.of<PlaylistBloc>(context).add(
                                  PlaylistReFetch(
                                    slug: widget.playlist.slug,
                                  ),
                                );
                              },
                            );
                          else if (state is PlaylistNoData)
                            return Container(
                              height: sizeManager.hp(80),
                              width: sizeManager.wp(100),
                              child: Center(
                                child: Text(
                                  "No Tracks Available",
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                              ),
                            );
                          else
                            return Container();
                        }),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  LayoutBuilder buildDescriptionText(ScalingQuery sizeManager) {
    return LayoutBuilder(
      builder: (context, constraints) {
        _isExceed = willTextOverFlow(
            mytext: widget.playlist.description ?? "",
            style: AppConfig.isTablet
                ? Theme.of(context).textTheme.bodyText2
                : Theme.of(context).textTheme.subtitle1,
            width: constraints.maxWidth,
            maxLine: 3,
            context: context,
            textAlign: TextAlign.center);
        return Column(
          children: <Widget>[
            Text(
              widget.playlist.description,
              textAlign: TextAlign.center,
              maxLines: _isExpanded ? null : 3,
              style: AppConfig.isTablet
                  ? Theme.of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(color: Colors.white)
                  : Theme.of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(color: Colors.white),
            ),
            SizedBox(
              height: 10,
            ),
            if (_isExceed)
              InkWell(
                onTap: () {
                  if (mounted)
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                },
                child: Container(
                  width: sizeManager.wp(100),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(
                        child: Divider(
                          color: Color(0xFF8264FD).withOpacity(0.7),
                        ),
                      ),
                      Icon(
                        _isExpanded
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: lightPink,
                      ),
                      Expanded(
                        child: Divider(
                          color: Color(0xFF8264FD).withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              )
          ],
        );
      },
    );
  }

  Positioned buildAppBar(BuildContext context) {
    return Positioned.fill(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        height: AppBar().preferredSize.height,
        width: AppBar().preferredSize.width,
        child: customAppBar(
          context: context,
          title: widget.playlist.title ?? "",
          backButton: true,
        ),
      ),
    );
  }

  Positioned buildBackgroundImage(ScalingQuery sizeManager) {
    return Positioned(
      child: Opacity(
        opacity: 0.4,
        child: widget.playlist.image.isEmpty
            ? Image.asset(
          hoz_placehoder_image,
          height: sizeManager.hp(50),
          width: double.infinity,
          fit: BoxFit.cover,
        )
            : CachedNetworkImage(
          imageUrl: widget.playlist.image,
          height: sizeManager.hp(50),
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Positioned buildBackgroundShade(BuildContext context) {
    return Positioned.fill(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        height: MediaQuery.of(context).size.width,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            end: FractionalOffset.topCenter, // Alignment.topCenter,
            begin: FractionalOffset.bottomCenter,
            colors: [
              Color(0xff0D033D),
              Color(0xff060853).withOpacity(0.3),
            ],
            tileMode: TileMode.clamp,
            stops: [0.4, 0.7],
          ),
        ),
      ),
    );
  }
}

class PlayListPlayPauseButton extends StatelessWidget {
  PlayListPlayPauseButton({
    @required List<Track> tracks,
    @required PlayList playlist,
  })  : _playlist = playlist,
        _tracks = tracks;

  final musicLocator = locator<MusicService>();
  final PlayList _playlist;
  final List<Track> _tracks;
  final bool paidStatus = locator<UserService>().user.value.paid;

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: AppConfig.isTablet ? Size(110.w, 110.w) : Size(140.w, 140.w),
      child: ClipOval(
        child: Material(
          color: Colors.transparent,
          child: ValueListenableBuilder3<int, ValueStream<bool>,
              ValueStream<bool>>(
            musicLocator.currentPlaylistID,
            musicLocator.currentTrackStatus,
            musicLocator.currentTrackBufferingStatus,
            builder: (context, playlistID, trackStatusStream,
                bufferStatusStream, _) {
              return InkWell(
                onTap: () {
                  if (_playlist.id == playlistID) {
                    musicLocator.playOrPausePlayer();
                  } else {
                    // musicLocator.playlistTracks = _tracks;
                    musicLocator.currentPlaylistID.value = _playlist.id;
                    musicLocator.currentTrack.value = _tracks.first;
                    musicLocator.trackId.value = _tracks.first.id;
                    musicLocator.playSinglePlayer(isFromPlaylist: true);
                    // musicLocator.playFromPlaylistPlayer(context: context);
                  }
                },
                child: Container(
                  height: AppConfig.isTablet ? 120.w : 140.w,
                  width: AppConfig.isTablet ? 120.w : 140.w,
                  decoration: BoxDecoration(
                    gradient: lightBluePinkGradientT2B,
                    shape: BoxShape.circle,
                  ),
                  child: _playlist.id != playlistID
                      ? Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                    size: AppConfig.isTablet ? 60.w : 80.w,
                  )
                      : StreamBuilder2<bool, bool>(
                    trackStatusStream,
                    bufferStatusStream,
                    firstInitialValue: false,
                    secondInitialValue: false,
                    builder: (context, trackStatus, bufferStatus) {
                      return Stack(
                        fit: StackFit.expand,
                        children: <Widget>[
                          Icon(
                            trackStatus ? Icons.pause : Icons.play_arrow,
                            color: Colors.white,
                            size: AppConfig.isTablet ? 60.w : 80.w,
                          ),
                          bufferStatus
                              ? SpinKitCircle(
                            size: AppConfig.isTablet ? 65.w : 85.w,
                            color: Colors.white30,
                          )
                              : Container()
                        ],
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class PlaylistCard extends StatelessWidget {
  PlaylistCard(
      {Key key,
        // @required List<Track> tracks,
        @required PlayList playlist,
        @required Track singleTrack,
        @required bool isPaidUser})
      : _playlist = playlist,
        _singleTrack = singleTrack,
  // _tracks = tracks,
        _isPaidUser = isPaidUser;

  final musicLocator = locator<MusicService>();
  // final List<Track> _tracks;
  final PlayList _playlist;
  final Track _singleTrack;
  final bool _isPaidUser;
  String getFormatedDuration(String time) {
    if (time.isEmpty) return "";
    final _time = DateFormat("hh:mm:ss").parse(time);
    return _time.hour == 0
        ? "${_time.minute} min ${_time.second} sec"
        : "${_time.hour} hrs ${_time.minute} min";
  }

  @override
  Widget build(BuildContext context) {
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
                  return ListTile(
                    onTap: () {
                      if (_singleTrack.paid) {
                        if (_isPaidUser) {
                          // musicLocator.playlistTracks = _tracks;
                          musicLocator.currentPlaylistID.value = _playlist.id;
                          musicLocator.currentTrack.value = _singleTrack;
                          musicLocator.trackId.value = _singleTrack.id;
                          navigateToMusicPlayer(context, _singleTrack,
                              fromPlayList: true);
                        } else {
                          recordAnalyticsToSubscriptionPage(
                              source: "play list page track click");

                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (_) => GetPremium()));
                        }
                      } else {
                        // musicLocator.playlistTracks = _tracks;
                        musicLocator.currentPlaylistID.value = _playlist.id;
                        musicLocator.currentTrack.value = _singleTrack;
                        musicLocator.trackId.value = _singleTrack.id;
                        navigateToMusicPlayer(context, _singleTrack,
                            fromPlayList: true);
                      }
                    },
                    leading: GestureDetector(
                      onTap: () {
                        if (_singleTrack.paid && !_isPaidUser) {
                          recordAnalyticsToSubscriptionPage(
                              source: "play list page track click");
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (_) => GetPremium()));
                        } else {
                          Track _track = musicLocator.getCurrentTrack();
                          // musicLocator.playlistTracks = _tracks;
                          musicLocator.currentPlaylistID.value = _playlist.id;
                          if (_track?.id == _singleTrack.id) {
                            musicLocator.playOrPausePlayer();
                          } else {
                            musicLocator.currentTrack.value = _singleTrack;
                            musicLocator.trackId.value = _singleTrack.id;
                            musicLocator.playSinglePlayer(isFromPlaylist: true);
                            // int index = _tracks.indexOf(_singleTrack);
                            // musicLocator.playFromPlaylistPlayer(
                            //   startIndex: index,
                            //   context: context,
                            // );
                          }
                        }
                      },
                      child: (_singleTrack.paid && !_isPaidUser)
                          ? Container(
                        height: AppConfig.isTablet ? 45.w : 90.w,
                        width: AppConfig.isTablet ? 45.w : 90.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Icon(
                          Icons.lock_outline,
                          color: blackColor,
                          size: AppConfig.isTablet ? 30.w : 50.w,
                        ),
                      )
                          : Container(
                        height: AppConfig.isTablet ? 40.w : 90.w,
                        width: AppConfig.isTablet ? 40.w : 90.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Stack(
                          fit: StackFit.expand,
                          children: <Widget>[
                            Builder(builder: (context) {
                              Track _track =
                              musicLocator.getCurrentTrack();
                              if (_track?.id == _singleTrack.id) {
                                return ValueListenableBuilder2<
                                    Stream<PlayingAudio>,
                                    ValueStream<Duration>>(
                                  musicLocator.playingAudio,
                                  musicLocator.currentTrackPosition,
                                  builder: (context, playingAudioStream,
                                      trackPositionStream, _) {
                                    return StreamBuilder2<PlayingAudio,
                                        Duration>(
                                      playingAudioStream,
                                      trackPositionStream,
                                      firstInitialValue: null,
                                      secondInitialValue: Duration.zero,
                                      builder: (context, playingTrack,
                                          duration) {
                                        if (playingTrack == null)
                                          return Container();
                                        final _progress = duration
                                            .inSeconds
                                            .toDouble() /
                                            playingTrack
                                                .duration.inSeconds
                                                .toDouble();
                                        return Padding(
                                          padding: EdgeInsets.all(
                                              AppConfig.isTablet
                                                  ? 1.w
                                                  : 2.w),
                                          child:
                                          CircularProgressIndicator(
                                            backgroundColor:
                                            Colors.transparent,
                                            semanticsLabel: "Playing",
                                            strokeWidth:
                                            AppConfig.isTablet
                                                ? 5.w
                                                : 8.w,
                                            value: _progress,
                                            valueColor:
                                            AlwaysStoppedAnimation(
                                              Color(0xff42A5F5),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                );
                              } else
                                return Container();
                            }),

                            /// play or pause icon for each track
                            Builder(builder: (context) {
                              Track _track =
                              musicLocator.getCurrentTrack();
                              if (_singleTrack.id == _track?.id) {
                                return Icon(
                                  trackStatus.data
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                  color: Colors.black,
                                  size: AppConfig.isTablet ? 35.w : 70.w,
                                );
                              } else
                                return Icon(
                                  Icons.play_arrow,
                                  color: Colors.black,
                                  size: AppConfig.isTablet ? 35.w : 70.w,
                                );
                            }),
                            // show loading indicator while track is loading
                            Builder(builder: (context) {
                              Track _track =
                              musicLocator.getCurrentTrack();
                              if (_track?.id == _singleTrack.id) {
                                return ValueListenableBuilder<
                                    ValueStream<bool>>(
                                    valueListenable: musicLocator
                                        .currentTrackBufferingStatus,
                                    builder: (context,
                                        bufferingStatusStream, _) {
                                      return StreamBuilder(
                                          stream: bufferingStatusStream,
                                          initialData: false,
                                          builder:
                                              (context, bufferingStatus) {
                                            return bufferingStatus.data
                                                ? SpinKitCircle(
                                              size:
                                              AppConfig.isTablet
                                                  ? 40.w
                                                  : 70.w,
                                              color: Colors.black26,
                                            )
                                                : Container();
                                          });
                                    });
                              }
                              return Container();
                            }),
                          ],
                        ),
                      ),
                    ),
                    title: Padding(
                      padding: EdgeInsets.only(right: 10.w),
                      child: Text(
                        _singleTrack.title ?? "",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppConfig.isTablet
                            ? Theme.of(context)
                            .textTheme
                            .bodyText2
                            .copyWith(color: Colors.white)
                            : Theme.of(context)
                            .textTheme
                            .subtitle1
                            .copyWith(color: Colors.white),
                      ),
                    ),
                    trailing: Text(
                      getFormatedDuration(_singleTrack.duration ?? ""),
                      style: AppConfig.isTablet
                          ? Theme.of(context).textTheme.bodyText1.copyWith(
                        color: Color(0xFFF2E1E1),
                      )
                          : Theme.of(context).textTheme.bodyText2.copyWith(
                        color: Color(0xFFF2E1E1),
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
