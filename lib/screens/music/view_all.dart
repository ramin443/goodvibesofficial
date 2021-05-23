import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goodvibesoffl/bloc/view_all/view_all_bloc.dart';
import 'package:goodvibesoffl/models/playable_model.dart';
import 'package:goodvibesoffl/screens/home/widgets/common_widgets.dart';
import 'package:goodvibesoffl/services/adsModelService.dart';
import 'package:goodvibesoffl/utils/theme/style.dart';
import 'package:goodvibesoffl/widgets/common_widgets/appBar.dart';
import 'package:goodvibesoffl/widgets/common_widgets/common_widgets_methods.dart';
import 'package:goodvibesoffl/widgets/common_widgets/pages_wrapper_with_background.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:responsive_grid/responsive_grid.dart';

import '../../locator.dart';

class ViewAllPage extends StatefulWidget {
  final List playablesList;
  final String pageTitle;
  final String slug;

  const ViewAllPage({this.playablesList, this.slug, this.pageTitle});

  @override
  _ViewAllPageState createState() => _ViewAllPageState();
}

class _ViewAllPageState extends State<ViewAllPage> {
  bool _isPginateLoading = false;
  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

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
            BlocProvider.of<ViewAllBloc>(context).add(ViewAllFetchMoreData());
          }
        }
      });

    BlocProvider.of<ViewAllBloc>(context).add(
        InitialViewAllEvent(tracks: widget.playablesList, slug: widget.slug));
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final sM = ResponsiveFlutter.of(context);

    return PagesWrapperWithBackground(
      showBannerAds: locator<AdsModelService>().adsData.showRecentUpdatedTracks,
      customPaddingHoz: 0.0,
      child: Scaffold(
        backgroundColor: tpt,
        appBar: customAppBar(context: context, title: widget.pageTitle),
        body: BlocConsumer<ViewAllBloc, ViewAllState>(
          listener: (context, state) {
            if (state is ViewAllRefreshApiLoading) {
              return;
            } else {
              _refreshController.refreshCompleted();
            }
            if (state is ViewAllApiLoading) {
              if (mounted)
                setState(() {
                  _isPginateLoading = true;
                });
            } else if (state is ViewAllApiError) {
              if (mounted)
                setState(() {
                  _isPginateLoading = false;
                });
              showToastMessage(
                  message: "An Error occured while fetching more data!");
            } else {
              if (mounted)
                setState(() {
                  _isPginateLoading = false;
                });
            }
          },
          buildWhen: (previousState, state) {
            if (state is ViewAllRefreshApiLoading) return false;
            return true;
          },
          builder: (context, state) {
            if (state is ViewAllLoading) {
              return showCenterCircularIndicator();
            } else if (state is ViewAllSuccessWithNoData) {
              return showNoDataAvailable();
            } else if (state is ViewAllError) {
              return ErrorTryAgain(
                errorMessage: state.errorMessage,
                onPressedTryAgain: () {},
              );
            } else if (state is ViewAllSuccessWithData ||
                state is ViewAllApiLoading ||
                state is ViewAllApiError ||
                state is InitialStateWithAlreadyData) {
              List _tracks = state.props;
              return Container(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: SmartRefresher(
                        primary: false,
                        scrollController: _controller,
                        controller: _refreshController,
                        header: getMaterialHeader(),
                        onRefresh: () {
                          BlocProvider.of<ViewAllBloc>(context)
                              .add(ViewAllRefreshTrack());
                        },
                        child: ListView(
                          padding: EdgeInsets.zero,
                          children: <Widget>[
                            ResponsiveGridList(
                              minSpacing: symmetricHorizonatalPadding,
                              scroll: false,
                              squareCells: false,
                              desiredItemWidth: width > 600
                                  ? ScreenUtil().setWidth(170)
                                  : ScreenUtil().setWidth(290),
                              children: List<Widget>.generate(_tracks.length,
                                      (index) {
                                    Playable item = _tracks[index];

                                    return MeditateVerticalCard(playable: item);
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ),
                    !_isPginateLoading
                        ? Container()
                        : Padding(
                      padding: EdgeInsets.only(bottom: sM.scale(10)),
                      child: showCenterCircularIndicator(),
                    ),
                    buildSizedBoxAtBottom(),
                  ],
                ),
              );
            } else
              return Container();
          },
        ),
      ),
    );
  }
}

class HomepageDynamicPlayable {
  final List playables;
  final String itemType;
  const HomepageDynamicPlayable({this.playables, this.itemType});
}
