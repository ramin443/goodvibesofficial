import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:goodvibesoffl/bloc/composer/composer_bloc.dart';
import 'package:goodvibesoffl/screens/home/widgets/common_widgets.dart';
import 'package:goodvibesoffl/widgets/common_widgets/common_widgets_methods.dart';
import 'package:goodvibesoffl/widgets/common_widgets/loading_shimmer.dart';
import 'compose_widgets.dart';
//import 'mixes.dart';

class SavedComposerMixes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final listviewTitleTextStyle = width > 600
        ? Theme.of(context).textTheme.subtitle2.copyWith(color: Colors.white)
        : Theme.of(context).textTheme.headline6.copyWith(color: Colors.white);
    final subtitleTextStyle = width > 600
        ? Theme.of(context).textTheme.bodyText1
        : Theme.of(context).textTheme.subtitle1;

    return BlocBuilder<ComposerBloc, ComposerState>(
        buildWhen: (oldState, newState) {
          if (newState is ComposerLoadingState ||
              newState is ComposerItemsFetched ||
              newState is ComposerItemsFiltered ||
              newState is ComposerFilterNoData ||
              newState is ComposerItemsFetchError ||
              newState is CombinedCompositionsFetched ||
              newState is MixesRefreshingState ||
              newState is RefreshErrorState ||
              newState is RefreshedItemsFetched ||
              newState is DummyState) return false;
          return true;
        }, builder: (context, state) {
      if (state is SavedMixesLoading) {
        return VerticalShimmer();
      } else if (state is SavedMixesNoData) {
        return Container(
            height: ScreenUtil().setHeight(100),
            child: Center(
              child: showNoDataAvailable(
                  widgetSpecificMessage: "You have not saved compositions yet"),
            ));
      } else if (state is ComposerItemsFetchError) {
        return ErrorTryAgain(
          errorMessage: state.errorMessage,
        );
      } else if (state is SavedMixesFetched) {
        var composerMixes = state.mixes;

        return Column(
          children: <Widget>[
            buildTitleAndSubtitleText(
              title: "My mixes",
              titleStyle: listviewTitleTextStyle,
              subtitleStyle: subtitleTextStyle,
            ),
            SizedBox(height: ScreenUtil().setHeight(15)),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                width: width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: List.generate(
                      state.mixes.length > 10 ? 10 : state.mixes.length,
                          (int index) {
                        var item = composerMixes[index];

                        return ComposerMixCard(
                            mix: item, index: index, showDetailsIcon: true);
                      }),
                ),
              ),
            ),
          ],
        );
      } else
        return Container();
    });
  }
}
