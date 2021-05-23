import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:goodvibesoffl/services/appConfig.dart';
import 'package:goodvibesoffl/utils/theme/style.dart';
import 'package:goodvibesoffl/widgets/common_widgets/common_widgets_methods.dart';
import 'package:shimmer/shimmer.dart';

final shimmerTextDecoration =
BoxDecoration(color: whiteColor, borderRadius: BorderRadius.circular(10));

class VerticalShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 720, height: 1280, allowFontScaling: false);
    final width = MediaQuery.of(context).size.width;

    final titleTextWidthidth = AppConfig.isTablet
        ? ScreenUtil().setWidth(170)
        : ScreenUtil().setWidth(290);

    return Container(
      height: AppConfig.isTablet
          ? ScreenUtil().setHeight(400)
          : ScreenUtil().setHeight(480),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Shimmer.fromColors(
              baseColor: whiteColor.withOpacity(0.5),
              highlightColor: greyColor,
              direction: ShimmerDirection.ltr,
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: 6,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 8,
                        bottom: 8,
                        right: 8,
                        left: index == 0 ? symmetricHorizonatalPadding : 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            height: AppConfig.isTablet
                                ? ScreenUtil().setHeight(300)
                                : ScreenUtil().setHeight(380),
                            width: AppConfig.isTablet
                                ? ScreenUtil().setWidth(170)
                                : ScreenUtil().setWidth(320),
                            decoration: BoxDecoration(
                                color: whiteColor,
                                borderRadius: BorderRadius.circular(20)),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 3.0),
                        ),
                        Container(
                          height: 15,
                          width: titleTextWidthidth,
                          decoration: shimmerTextDecoration,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 3.0),
                        ),
                        Container(
                          height: 15,
                          width: 100,
                          decoration: shimmerTextDecoration,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HorizontalShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 720, height: 1280, allowFontScaling: false);
    final width = MediaQuery.of(context).size.width;

    return Container(
      height: AppConfig.isTablet
          ? ScreenUtil().setHeight(400)
          : ScreenUtil().setHeight(290),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Shimmer.fromColors(
              baseColor: whiteColor.withOpacity(0.5),
              highlightColor: greyColor,
              direction: ShimmerDirection.ltr,
              child: ListView.builder(
                itemCount: 6,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, i) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Padding(
                    padding: i == 0
                        ? EdgeInsets.only(
                        right: 8.0,
                        top: 8.0,
                        bottom: 8.0,
                        left: symmetricHorizonatalPadding)
                        : const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            height: AppConfig.isTablet
                                ? ScreenUtil().setHeight(400)
                                : ScreenUtil().setHeight(400),
                            width: AppConfig.isTablet
                                ? ScreenUtil().setWidth(170)
                                : ScreenUtil().setWidth(290),
                            decoration: BoxDecoration(
                                color: whiteColor,
                                borderRadius: BorderRadius.circular(20)),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 3.0),
                        ),
                        Container(
                            height: 10,
                            width: 150,
                            decoration: shimmerTextDecoration),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 3.0),
                        ),
                        Container(
                            height: 10,
                            width: 100,
                            // color: blackColor,
                            decoration: shimmerTextDecoration),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ComposerSavedMixShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Container(
      child: Shimmer.fromColors(
        baseColor: whiteColor.withOpacity(0.5),
        highlightColor: greyColor,
        direction: ShimmerDirection.ltr,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PaddingChild(
              child: Container(
                width: 100,
                height: ScreenUtil().setHeight(25),
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(ScreenUtil().setSp(20)),
                ),
              ),
            ),
            SizedBox(height: 10),
            PaddingChild(
              child: Container(
                width: 200,
                height: ScreenUtil().setHeight(25),
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(ScreenUtil().setSp(20)),
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: AppConfig.isTablet
                  ? ScreenUtil().setWidth(170)
                  : ScreenUtil().setWidth(330),
              child: ListView.builder(
                itemCount: AppConfig.isTablet ? 6 : 3,
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, i) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Padding(
                    padding: i == 0
                        ? EdgeInsets.only(left: symmetricHorizonatalPadding)
                        : EdgeInsets.symmetric(
                        horizontal: symmetricHorizonatalPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            width: AppConfig.isTablet
                                ? ScreenUtil().setWidth(170)
                                : ScreenUtil().setWidth(330),
                            height: AppConfig.isTablet
                                ? ScreenUtil().setWidth(170)
                                : ScreenUtil().setWidth(330),
                            decoration: BoxDecoration(
                                color: whiteColor,
                                borderRadius: BorderRadius.circular(20)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FullWidthCardShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 720, height: 1280, allowFontScaling: false);
    final width = MediaQuery.of(context).size.width;

    return Container(
      height: AppConfig.isTablet
          ? ScreenUtil().setHeight(400)
          : ScreenUtil().setHeight(450),
      child: Shimmer.fromColors(
        baseColor: whiteColor.withOpacity(0.5),
        highlightColor: greyColor,
        direction: ShimmerDirection.ltr,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: NeverScrollableScrollPhysics(),
          child: Row(
              children: List.generate(
                5,
                    (i) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Padding(
                    padding: i == 0
                        ? EdgeInsets.only(
                        right: 8.0,
                        top: 8.0,
                        bottom: 8.0,
                        left: symmetricHorizonatalPadding)
                        : const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            width: AppConfig.isTablet ? width * 0.4 : width * 0.8,
                            decoration: BoxDecoration(
                                color: whiteColor,
                                borderRadius: BorderRadius.circular(20)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
