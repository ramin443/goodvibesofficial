import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:goodvibesoffl/bloc/rituals/rituals_bloc.dart';
import 'package:goodvibesoffl/locator.dart';
import 'package:goodvibesoffl/models/composer_download_task_model.dart';
import 'package:goodvibesoffl/models/models.dart';
import 'package:goodvibesoffl/models/music_model.dart';
import 'package:goodvibesoffl/models/playlist_model.dart';
import 'package:goodvibesoffl/screens/music/single_player/music_widgets.dart';
import 'package:goodvibesoffl/providers/rituals_provider.dart';
import 'package:goodvibesoffl/services/appConfig.dart';
import 'package:goodvibesoffl/services/player_service.dart';
import 'package:goodvibesoffl/services/services.dart';
import 'package:goodvibesoffl/utils/common_player_function.dart';
import 'package:goodvibesoffl/utils/strings/string_constants.dart';
import 'package:goodvibesoffl/utils/theme/style.dart';
import 'package:goodvibesoffl/utils/theme/text_style.dart';
import 'package:goodvibesoffl/utils/theme/theme.dart';
import 'package:goodvibesoffl/utils/utils.dart';
import 'package:goodvibesoffl/widgets/common_widgets/common_widgets_methods.dart';
import 'package:goodvibesoffl/widgets/common_widgets/pages_wrapper_with_background.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'widgets.dart';

class RitualPlaylist extends StatefulWidget {
  final PlayList _playlist;

  const RitualPlaylist({@required PlayList playlist}) : _playlist = playlist;
  @override
  _RitualPlaylistState createState() => _RitualPlaylistState();
}

class _RitualPlaylistState extends State<RitualPlaylist>
    with SingleTickerProviderStateMixin {
  final _color = Color(0xff3D1481);

  bool _isRefreshLoading = false;

  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    BlocProvider.of<RitualsBloc>(context)
        .add(FetchRitualsTracks(ritualId: widget._playlist.id));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width;
    var heading = theme.textTheme.headline2
        .copyWith(color: whiteColor, fontFamily: proxima);
    final descriptionStyle = theme.textTheme.button
        .copyWith(color: whiteColor.withOpacity(0.6), fontFamily: proxima);
    final subHeadingStyle = theme.textTheme.subtitle2
        .copyWith(color: whiteColor, fontFamily: proxima);

    return PagesWrapperWithBackground(
      hasScaffold: false,
      customPaddingHoz: 0.0,
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: BlocListener<RitualsBloc, RitualsState>(
          listener: (context, state) {
            if (state is RitualsTracksRefreshing) {
              _isRefreshLoading = true;
              setState(() {});
            } else {
              if (_isRefreshLoading) {
                _isRefreshLoading = false;
                _refreshController.refreshCompleted();
                setState(() {});
              }
            }
          },
          child: SmartRefresher(
            controller: _refreshController,
            onRefresh: () {
              BlocProvider.of<RitualsBloc>(context)
                  .add(RefreshRitualsTracks(ritualId: widget._playlist.id));
            },
            child: CustomScrollView(
              physics: ClampingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  floating: true,
                  elevation: 0.0,
                  backgroundColor: Color(0xff1C91FB),
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(CupertinoIcons.back,
                        color: whiteColor,
                        size: AppConfig.isTablet ? 20.w : 25.w),
                  ),
                  actions: [
                    RitualsFavoriteButton(widget._playlist),
                    SizedBox(width: 20.w),
                    BlocBuilder<RitualsBloc, RitualsState>(
                      builder: (context, state) {
                        if (!(state is RitualsError) &&
                            !(state is RitualsTrackLoading)) {
                          return ValueListenableBuilder<
                              List<DownloadTaskModel>>(
                              valueListenable:
                              RitualsProvider().dowloadingPlaylistItems,
                              builder: (context, list, child) {
                                if (list.isEmpty) {
                                  return IconWithCircularBackground(
                                    iconButton: IconButton(
                                      onPressed: () {
                                        if (!locator<UserService>()
                                            .user
                                            .value
                                            .paid) {
                                          showDialogBox(
                                            dialogType: cannot_download,
                                            context: context,
                                          );
                                        } else {
                                          RitualsProvider().downloadPlaylist(
                                            playlistId: widget._playlist.id,
                                            tracks: [
                                              ...state.trackList
                                                  .map<Track>((e) => e.track)
                                                  .toList()
                                            ],
                                          );
                                        }
                                      },
                                      icon: Icon(
                                        Icons.download_outlined,
                                        size: AppConfig.isTablet ? 25.w : 40.w,
                                      ),
                                    ),
                                    backgroundColor: _color,
                                    containerDimension:
                                    AppConfig.isTablet ? 40.w : 80.w,
                                  );
                                } else {
                                  return DownloadProgressIndicator();
                                }
                              });
                        } else {
                          return Container();
                        }
                      },
                    ),
                    SizedBox(width: 20.w),
                  ],
                ),
                SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (context, index) {
                        return Column(
                          children: [
                            _buildCurvedHeaderSection(width),
                            _buildScrollBodySection(
                                heading, subHeadingStyle, descriptionStyle, width),
                          ],
                        );
                      },
                      childCount: 1,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getHeight(String description) {
    if (description != null && description.isNotEmpty) {
      return AppConfig.isTablet ? 110.w : 230.w;
    } else {
      return AppConfig.isTablet ? 60.w : 150.w;
    }
  }

  Widget _buildScrollBodySection(TextStyle heading, TextStyle subHeadingStyle,
      TextStyle descriptionStyle, double width) {
    var _padding = symmetricHorizonatalPadding;
    return Padding(
      padding: EdgeInsets.only(
          left: AppConfig.isTablet ? _padding * 4 : _padding,
          right: AppConfig.isTablet ? _padding * 4 : _padding,
          top: 30.w),
      child: BlocBuilder<RitualsBloc, RitualsState>(
        buildWhen: (old, newState) {
          if (newState is RitualsTrackLoading ||
              newState is RitualsNoData ||
              newState is RitualsError ||
              newState is RitualsTracksFetched ||
              newState is RitualsTracksRefreshing) {
            return true;
          }
          return false;
        },
        builder: (context, state) {
          if (state is RitualsTrackLoading) {
            return showCenterCircularIndicator();
          } else if (state is RitualsNoData) {
            return showNoDataAvailable();
          } else if (state is RitualsError) {
            return ErrorTryAgain(
              errorMessage: state.message,
              onPressedTryAgain: () {
                BlocProvider.of<RitualsBloc>(context)
                    .add(RefreshRitualsTracks(ritualId: widget._playlist.id));
              },
            );
          } else if (state is RitualsTracksFetched ||
              state is RitualsTracksRefreshing) {
            var length = state.trackList.length;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CourseProgressIndicator(
                    length: state.trackList.length,
                    playlistId: widget._playlist.id,
                    playlist: widget._playlist),
                Text(widget._playlist.title ?? "", style: heading),
                Text("${length - 1} days course", style: subHeadingStyle),
                Container(
                  child: Text(
                    removeAllHtmlTags(widget._playlist.description ?? ""),
                    style: descriptionStyle,
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(height: 50.w),
                Column(
                  children: List.generate(state.trackList.length, (index) {
                    var item = state.trackList[index];
                    return RitualPlaylistItem(
                        playlist: widget._playlist,
                        track: item.track
                            .copyWith(playlistId: widget._playlist.id),
                        index: index);
                  }),
                ),
                SizedBox(height: 150),
              ],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget _buildCurvedHeaderSection(double width) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(70.w),
        bottomRight: Radius.circular(70.w),
      ),
      child: Container(
        width: width,
        height: AppConfig.isTablet
            ? 400.w - kToolbarHeight
            : 600.w - kToolbarHeight,
        decoration: BoxDecoration(
          gradient: lightBluePinkGradientT2B,
        ),
        child: widget._playlist.image == null || widget._playlist.image.isEmpty
            ? Image.asset('assets/images/ritual1.png')
            : FadeInImage(
          fit: BoxFit.cover,
          width: width,
          placeholder: AssetImage('assets/images/ritual1.png'),
          image: NetworkImage(widget._playlist.image),
        ),
      ),
    );
  }
}

class RitualPlaylistItem extends StatelessWidget {
  final PlayList playlist;
  final Track track;
  final int index;

  const RitualPlaylistItem({this.playlist, this.track, this.index});

  _onTrackUnlocked(Track track, BuildContext context, isUnlocked,
      bool navigateTosinglePlayer, bool togglePlayback) async {
    if (isUnlocked) {
      var _duration = await getLastPlayedDurationOfTrack(track);
      var _track = track.copyWith(
        playlistId: playlist.id,
        saveTrackDuration: true,
        lastPlayedDuration: _duration == Duration.zero ? null : _duration,
      );

      final _musicService = locator<MusicService>();

      _musicService.currentPlaylist.value = playlist;
      _musicService.currentTrack.value = _track;

      if (navigateTosinglePlayer) {
        navigateToSinglePlayerOnly(
            context, false, 'Single player page from rituals tracks');
      }
      await onPressedPlayPauseButton(togglePlayback: togglePlayback);
    } else {
      var _remainingDays = datediff(track) ?? 'later';
      showToastMessage(message: "This track will be unlocked $_remainingDays.");
    }
  }

  _checkIndexAndPlayOrNavigate(
      int indexBound,
      int trackIndex,
      Track track,
      BuildContext context,
      bool isUnlocked,
      bool navigateTosinglePlayer,
      bool togglePlayback) {
    if (trackIndex > indexBound) {
      navigateToSubsPage('Free  user trying to play more than intro');
    } else {
      _onTrackUnlocked(
          track, context, isUnlocked, navigateTosinglePlayer, togglePlayback);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final _color = Color(0xff3D1481);
    final width = MediaQuery.of(context).size.width;
    final descriptionStyle = theme.textTheme.button
        .copyWith(color: whiteColor.withOpacity(0.6), fontFamily: proxima);
    final subHeadingStyle = theme.textTheme.subtitle2
        .copyWith(color: whiteColor, fontFamily: proxima);

    bool _isCurrentDay = checkIfRitualTrackIsCurrentDay(playlist, index);
    User _user = locator<UserService>().user.value;

    bool _unlocked = !isTrackLockedForDay(index, playlist, track);

    var _readableDuration = getReadableHourMinute(track.duration);

    if (index >= 6) {
      print('this');
    }

    bool _userPaid = _user.userPlanType == UserPlanType.Monthly ||
        _user.userPlanType == UserPlanType.Yearly ||
        _user.userPlanType == UserPlanType.Promo;
    dPrint(symmetricHorizonatalPadding.toString());

    return Column(
      children: [
        Divider(
            color: whiteColor.withOpacity(0.7), thickness: 0.5, height: 20.h),
        InkWell(
          onTap: () async {
            if (_user.userPlanType == UserPlanType.Free) {
              _checkIndexAndPlayOrNavigate(
                  0, index, track, context, _unlocked, true, false);
            } else if (_user.userPlanType == UserPlanType.FreeTrial) {
              _checkIndexAndPlayOrNavigate(
                  6, index, track, context, _unlocked, true, false);
            } else if (_userPaid) {
              _onTrackUnlocked(track, context, _unlocked, true, false);
            }
          },
          customBorder:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.w)),
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: AppConfig.isTablet ? 20.w : 40.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: width,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RotatedBox(
                          quarterTurns: 3,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: _isCurrentDay ? 15 : 0,
                                vertical: _isCurrentDay ? 5 : 0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: _isCurrentDay ? whiteColor : tpt,
                            ),
                            child: Text(
                                "${index == 0 ? '' : 'day '}${index == 0 ? 'intro' : index}"
                                    .toUpperCase(),
                                style: subHeadingStyle.copyWith(
                                    color:
                                    _isCurrentDay ? _color : whiteColor)),
                          )),
                      SizedBox(width: 20.w),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              child: Padding(
                                padding: EdgeInsets.only(top: 5.w),
                                child: RitualPlaylistItemPlayButton(
                                  playlist: playlist,
                                  track: track,
                                  onPressed: () {
                                    if (_user.userPlanType ==
                                        UserPlanType.Free) {
                                      _checkIndexAndPlayOrNavigate(
                                          0,
                                          index,
                                          track,
                                          context,
                                          _unlocked,
                                          false,
                                          true);
                                    } else if (_user.userPlanType ==
                                        UserPlanType.FreeTrial) {
                                      _checkIndexAndPlayOrNavigate(
                                          6,
                                          index,
                                          track,
                                          context,
                                          _unlocked,
                                          false,
                                          true);
                                    } else if (_userPaid) {
                                      _onTrackUnlocked(track, context,
                                          _unlocked, false, true);
                                    }
                                  },
                                ),
                              ),
                            ),
                            SizedBox(width: 20.w),
                            Expanded(
                                flex: 100,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Text(track.title ?? "",
                                          maxLines: 1,
                                          textAlign: TextAlign.start,
                                          overflow: TextOverflow.ellipsis,
                                          style: descriptionStyle.copyWith(
                                              color: whiteColor)),
                                    ),
                                    (track.description != null &&
                                        track.description.isNotEmpty)
                                        ? Container(
                                      child: Text(
                                        removeAllHtmlTags(
                                            track.description),
                                        maxLines: 3,
                                        softWrap: true,
                                        textAlign: TextAlign.left,
                                        overflow: TextOverflow.ellipsis,
                                        style: subHeadingStyle.copyWith(
                                            color: whiteColor
                                                .withOpacity(0.6)),
                                      ),
                                    )
                                        : Container(height: 0),
                                    Text(_readableDuration,
                                        style: subHeadingStyle.copyWith(
                                            color:
                                            whiteColor.withOpacity(0.6))),
                                    PlaylistItemTrackProgress(track: track)
                                  ],
                                )),
                            Flexible(flex: 1, child: Container()),
                          ],
                        ),
                      ),
                      Container(
                        child: SuffixIcon(
                          unlocked: _unlocked,
                          index: index,
                          track: track,
                          isItemDownloading: RitualsProvider()
                              .downloadingTracksIds
                              .value
                              .contains(track.id),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class PlaylistItemTrackProgress extends StatefulWidget {
  final Track _item;
  const PlaylistItemTrackProgress({Track track}) : _item = track;

  @override
  _PlaylistItemTrackProgressState createState() =>
      _PlaylistItemTrackProgressState();
}

class _PlaylistItemTrackProgressState extends State<PlaylistItemTrackProgress> {
  double percentage = 0.0;

  @override
  void initState() {
    super.initState();

    locator<MusicService>().playbackDurationController.stream.listen((data) {
      if (data != null) {
        if (mounted) {
          if (data == widget._item.id) setState(() {});
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _buildIndicatorOnly(percent) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30.w),
          LayoutBuilder(builder: (context, constraints) {
            return Stack(
              children: [
                Container(
                  height: AppConfig.isTablet ? 5.w : 10.w,
                  decoration: BoxDecoration(
                      color: Color(0xff0D023B),
                      borderRadius: BorderRadius.circular(5.w)),
                ),
                Container(
                  height: AppConfig.isTablet ? 5.w : 10.w,
                  width: constraints.maxWidth * percent,
                  decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(5.w)),
                ),
              ],
            );
          }),
        ],
      );
    }

    return FutureBuilder<Map<String, dynamic>>(
        future:
        checkRitualTrackPosition(widget._item.id, widget._item.playlistId),
        builder: (context, snapshot) {
          Track _track = widget._item;

          var _trackCompletionStatus = _track.playableStat?.status.toString();

          if (snapshot.connectionState != ConnectionState.done) {
            if (_track.playableStat != null) {
              var _tempPercentage = getPercentageFromDurations(
                  current: _track.playableStat?.playedDuration,
                  total: double.parse(
                      getSecondsFromDurationString(widget._item.duration)
                          .toString()));

              if (_tempPercentage > percentage) {
                percentage = _tempPercentage;
              }
            }

            return _buildIndicatorOnly(percentage);
          } else {
            if (_trackCompletionStatus == null ||
                _trackCompletionStatus != CompletionStatus.Started.toString() &&
                    _track.playableStat?.status !=
                        CompletionStatus.NonStarted) {
              percentage = getPercentageFromDurations(
                  current: _track.playableStat?.playedDuration ?? 0.0,
                  total: double.parse(
                      getSecondsFromDurationString(widget._item.duration)
                          .toString()));

              return _buildIndicatorOnly(percentage);
            } else {
              var _completedDuration = snapshot.data["played_duration"];

              if (_track.playableStat != null && _completedDuration == null) {
                if (_track.playableStat.playedDuration != null) {
                  _completedDuration = _track.playableStat.playedDuration;
                }
              }

              var percent = getPercentageFromDurations(
                  current: double.tryParse(_completedDuration.toString()),
                  total: double.tryParse(
                      getSecondsFromDurationString(widget._item.duration)
                          .toString()));

              percentage = percent;

              if (percentage == 0) {
                return Container();
              } else
                return _buildIndicatorOnly(percent);
            }
          }
        });
  }
}

class RitualsFavoriteButton extends StatefulWidget {
  final PlayList _playlist;

  const RitualsFavoriteButton(PlayList playlist) : _playlist = playlist;
  @override
  _RitualsFavoriteButtonState createState() => _RitualsFavoriteButtonState();
}

class _RitualsFavoriteButtonState extends State<RitualsFavoriteButton> {
  static const _color = Color(0xff3D1481);

  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    List<PlayList> list = RitualsProvider().favouriteRituals;
    var item = list.firstWhere((element) => element.id == widget._playlist.id,
        orElse: () => null);
    if (item == null) {
      _isFavorite = false;
      setState(() {});
    } else {
      _isFavorite = true;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RitualsBloc, RitualsState>(
      listenWhen: (old, newState) {
        if (newState is FavouriteButtonState) {
          return true;
        }

        return false;
      },
      listener: (context, state) {
        if (state is FavouriteButtonState) {
          List<PlayList> list = state.playlists;
          // //print(list);
          // //print('listner');
          var item = list.firstWhere(
                  (element) => element.id == widget._playlist.id,
              orElse: () => null);

          if (item == null) {
            _isFavorite = false;
            //print('set favorite to false');
            setState(() {});
          } else {
            _isFavorite = true;
            //print('set favorite to true');
            setState(() {});
          }
        }
      },
      child: BlocBuilder<RitualsBloc, RitualsState>(
        buildWhen: (old, newState) => true,
        builder: (context, state) {
          //print(state);
          return IconWithCircularBackground(
            iconButton: IconButton(
              onPressed: () {
                BlocProvider.of<RitualsBloc>(context)
                    .add(FavouriteButtonPressed(widget._playlist));
              },
              icon: Icon(
                _isFavorite ? Icons.favorite : Icons.favorite_border,
                size: AppConfig.isTablet ? 25.w : 40.w,
              ),
            ),
            backgroundColor: _color,
            containerDimension: AppConfig.isTablet ? 40.w : 80.w,
          );
        },
      ),
    );
  }
}
