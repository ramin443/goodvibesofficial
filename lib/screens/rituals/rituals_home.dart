import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goodvibesoffl/bloc/rituals/rituals_bloc.dart';
import 'package:goodvibesoffl/models/playlist_model.dart';
import 'package:goodvibesoffl/screens/rituals/widgets.dart';
import 'package:goodvibesoffl/services/appConfig.dart';
import 'package:goodvibesoffl/services/services.dart';
import 'package:goodvibesoffl/utils/theme/style.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:goodvibesoffl/utils/theme/text_style.dart';
//import 'package:goodvibesoffl/widgets/common_widgets/common_widgets.dart';
import 'package:goodvibesoffl/widgets/common_widgets/common_widgets_methods.dart';
import 'package:goodvibesoffl/widgets/common_widgets/loading_shimmer.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../locator.dart';

class RitualsHome extends StatefulWidget {
  @override
  _RitualsHomeState createState() => _RitualsHomeState();
}

class _RitualsHomeState extends State<RitualsHome> {
  var user = locator<UserService>().user.value;
  final _darkBlue = Color(0xff0D023B);

  RefreshController _refreshController =
  RefreshController(initialRefresh: false);
  @override
  void initState() {
    super.initState();

    BlocProvider.of<RitualsBloc>(context).add(FetchRitualsPlaylists());
    BlocProvider.of<RitualsBloc>(context).add(FetchStartedRituals());
  }

  @override
  Widget build(BuildContext context) {
    bool _isRefreshloading = false;

    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width;
    final cardTitleStyle = theme.textTheme.headline2
        .copyWith(color: whiteColor, fontFamily: proxima);

    Widget _buildRitualsHozListView({List<PlayList> playlists}) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(playlists.length, (index) {
              var _course = playlists[index];

              return Padding(
                padding: EdgeInsets.only(
                    left: index == 0 ? symmetricHorizonatalPadding : 0.0,
                    right: 20.w),
                child: RitualCard(item: _course),
              );
            })),
      );
    }

    Widget _buildDailyRitualsList() {
      return BlocBuilder<RitualsBloc, RitualsState>(
        buildWhen: (old, newState) {
          if (newState is RitualsPlaylistLoading ||
              newState is RitualsPlaylistNoData ||
              newState is RitualsPlaylistsError ||
              newState is RitualsPlaylistsFetched ||
              newState is RitualsPlaylistRefreshing) {
            return true;
          }
          return false;
        },
        builder: (context, state) {
          //print(state);
          if (state is RitualsPlaylistLoading) {
            return Column(children: [
              FullWidthCardShimmer(),
            ]);
          } else if (state is RitualsPlaylistNoData) {
            return showNoDataAvailable();
          } else if (state is RitualsPlaylistsError) {
            return ErrorTryAgain(
              errorMessage: state.message,
              onPressedTryAgain: () {
                BlocProvider.of<RitualsBloc>(context)
                    .add(RefreshRitualsPlaylist());
              },
            );
          } else if (state is RitualsPlaylistsFetched ||
              state is RitualsPlaylistRefreshing) {
            List<PlayList> playlists = state.ritualsPlaylists;
            var _started = state.startedPlaylists;
            // var _syncedList = _getSynceList(all: playlists, started: _started);

            return _buildRitualsHozListView(
              playlists: playlists,
            );
          } else {
            return Container();
          }
        },
      );
    }

    return Container(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          PaddingChild(
            vertical: AppConfig.isTablet ? 25.w : 40.w,
            child: Text("Daily Rituals",
                style: cardTitleStyle

            ),
          ),

          BlocListener<RitualsBloc, RitualsState>(
            listener: (context, state) {
              if (state is RitualsPlaylistRefreshing) {
                _isRefreshloading = true;
              } else {
                if (_isRefreshloading) {
                  _isRefreshloading = false;
                  _refreshController.refreshCompleted();
                }
              }
            },
            child: Column(
              children: [_buildDailyRitualsList(), SizedBox(height: 40.h)],
            ),
          ),

          // _buildStartedRituals(),
        ],
      ),
    );
  }
}
