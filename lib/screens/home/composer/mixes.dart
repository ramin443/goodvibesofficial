import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goodvibesoffl/bloc/composer/composer_bloc.dart';
import 'package:goodvibesoffl/models/composer_audio_model.dart';
import 'package:goodvibesoffl/screens/home/widgets/common_widgets.dart';
import 'package:goodvibesoffl/services/appConfig.dart';
import 'package:goodvibesoffl/utils/theme/style.dart';
import 'package:goodvibesoffl/widgets/common_widgets/common_widgets_methods.dart';
import 'package:goodvibesoffl/widgets/common_widgets/loading_shimmer.dart';
import 'package:goodvibesoffl/widgets/common_widgets/pages_wrapper_with_background.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../locator.dart';
import '../../../services/composer_service.dart';
import 'compose_widgets.dart';
import 'saved_composer_mixes.dart';

class ComposerMixes extends StatefulWidget {
  @override
  _ComposerMixesState createState() => _ComposerMixesState();
}

class _ComposerMixesState extends State<ComposerMixes> {
  ScrollController _showHideFloatButtonController = ScrollController();
  RefreshController _refreshController;

  bool _isComposerItemRefershing = false;

  final composerService = locator<ComposerService>();
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ComposerBloc>(context).add(GetSavedMixes());

    _refreshController = RefreshController(initialRefresh: false);

    composerService.miniPlayerHideStream.add(false);
    _showHideFloatButtonController.addListener(() {
      if (_showHideFloatButtonController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        composerService.miniPlayerHideStream.add(true);
      } else {
        composerService.miniPlayerHideStream.add(false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final listviewTitleTextStyle = width > 600
        ? Theme.of(context).textTheme.subtitle2.copyWith(color: Colors.white)
        : Theme.of(context).textTheme.headline6.copyWith(color: Colors.white);
    final subtitleTextStyle = width > 600
        ? Theme.of(context).textTheme.bodyText1
        : Theme.of(context).textTheme.subtitle1;

    AppBar _buildAppBar(BuildContext context) {
      return AppBar(
        leading: InkWell(
            child: Padding(
              padding: EdgeInsets.only(bottom: 10, top: 10, right: 10),
              child: Icon(
                CupertinoIcons.back,
                color: whiteColor,
                size: AppConfig.isTablet ? 15.w : 25.w,
              ),
            ),
            onTap: () => Navigator.pop(context)),
        centerTitle: false,
        titleSpacing: 1.0,
        title: Text("Mixes",
            style: Theme.of(context)
                .textTheme
                .button
                .copyWith(color: Colors.white)),
      );
    }

    return PagesWrapperWithBackground(
        hasScaffold: false,
        showMiniPlayer: false,
        customPaddingHoz: 0.0,
        child: Scaffold(
          appBar: _buildAppBar(context),
          backgroundColor: tpt,
          floatingActionButton: StreamBuilder<bool>(
              stream: composerService.miniPlayerHideStream.stream,
              builder: (context, snapshot) {
                bool hide = snapshot.data ?? false;
                return Visibility(
                  visible: hide ? false : true,
                  child: NewMiniPlayer(),
                );
              }),
          body: SmartRefresher(
            controller: _refreshController,
            header: getMaterialHeader(),
            onRefresh: () {
              BlocProvider.of<ComposerBloc>(context).add(RefreshEvent());
              _isComposerItemRefershing = true;
            },
            child: SingleChildScrollView(
              controller: _showHideFloatButtonController,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  //      PaddingChild(child: _buildAppBar(context)),
                  SizedBox(height: ScreenUtil().setHeight(20)),
                  SavedComposerMixes(),
                  SizedBox(height: ScreenUtil().setHeight(20)),
                  Flexible(
                    child: BlocListener<ComposerBloc, ComposerState>(
                      listener: (context, state) {
                        if (state is RefreshErrorState ||
                            state is RefreshedItemsFetched) {
                          if (_isComposerItemRefershing) {
                            _isComposerItemRefershing = false;
                            _refreshController.refreshCompleted();
                            setState(() {});
                          }
                        }
                      },
                      child: BlocBuilder<ComposerBloc, ComposerState>(
                        buildWhen: (oldState, newState) {
                          if (newState is ComposerLoadingState ||
                              newState is ComposerItemsFetched ||
                              newState is ComposerItemsFiltered ||
                              newState is ComposerFilterNoData ||
                              newState is ComposerItemsFetchError ||
                              newState is SavedMixesFetched ||
                              newState is MixesRefreshingState ||
                              newState is RefreshErrorState ||
                              newState is DummyState) return false;
                          return true;
                        },
                        builder: (context, state) {
                          if (state is SavedMixesLoading) {
                            return Column(
                              children: [
                                VerticalShimmer(),
                                SizedBox(height: ScreenUtil().setHeight(30)),
                                VerticalShimmer(),
                              ],
                            );
                          } else if (state is SavedMixesNoData) {
                            return showNoDataAvailable();
                          } else if (state is ComposerItemsFetchError) {
                            return ErrorTryAgain(
                              errorMessage: state.errorMessage,
                            );
                          } else if (state is CombinedCompositionsFetched ||
                              state is RefreshErrorState ||
                              state is RefreshedItemsFetched) {
                            var composerMixes = state.combinedCompositions;

                            if (composerMixes.isNotEmpty) {
                              return _buildNestedListViewBuilders(
                                datum: composerMixes,
                                listviewTitleTextStyle: listviewTitleTextStyle,
                                subtitleTextStyle: subtitleTextStyle,
                                width: width,
                              );
                            } else {
                              return buildNoDataState(
                                  listviewTitleTextStyle, subtitleTextStyle);
                            }
                          } else
                            return Container();
                        },
                      ),
                    ),
                  ),

                  SizedBox(height: ScreenUtil().setHeight(200)),
                ],
              ),
            ),
          ),
        ));
  }

  Column buildNoDataState(
      TextStyle listviewTitleTextStyle, TextStyle subtitleTextStyle) {
    return Column(
      children: [
        buildTitleAndSubtitleText(
          title: "Most Popular",
          subtitle: "Most Popular mixes in our community",
          titleStyle: listviewTitleTextStyle,
          subtitleStyle: subtitleTextStyle,
        ),
        Container(
          height: AppConfig.isTablet
              ? ScreenUtil().setWidth(350)
              : ScreenUtil().setWidth(200),
          alignment: Alignment.center,
          child: Text("No data available", style: subtitleTextStyle),
        ),
        SizedBox(height: 20),
        buildTitleAndSubtitleText(
          title: "Most Recent",
          subtitle: "Most Recent mixes from our community",
          titleStyle: listviewTitleTextStyle,
          subtitleStyle: subtitleTextStyle,
        ),
        Container(
            height: AppConfig.isTablet
                ? ScreenUtil().setWidth(350)
                : ScreenUtil().setWidth(200),
            alignment: Alignment.center,
            child: Text("No data available", style: subtitleTextStyle)),
      ],
    );
  }

  _buildNestedListViewBuilders(
      {width,
        List<CombinedCompositions> datum,
        listviewTitleTextStyle,
        subtitleTextStyle}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        datum.length,
            (index) {
          var combinedCompose = datum[index];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              buildTitleAndSubtitleText(
                  title: combinedCompose.title,
                  subtitle: combinedCompose.subtitle,
                  titleStyle: listviewTitleTextStyle,
                  subtitleStyle: subtitleTextStyle),
              SizedBox(height: ScreenUtil().setHeight(15)),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    datum[index].mixes.length,
                        (int childIndex) {
                      var item = datum[index].mixes[childIndex];
                      return ComposerMixCard(mix: item, index: childIndex);
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
