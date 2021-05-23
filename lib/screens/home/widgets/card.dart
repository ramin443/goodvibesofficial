import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:goodvibesoffl/utils/common_functiona.dart';
import 'package:goodvibesoffl/utils/image_paths.dart';
import 'package:goodvibesoffl/utils/theme/style.dart';
import 'package:goodvibesoffl/utils/theme/text_style.dart';
import 'package:goodvibesoffl/widgets/common_widgets/customCacheNetworkImage.dart';
import 'package:jiffy/jiffy.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

class VerticalCard extends StatelessWidget {
  final title;
  final image;
  final subtitle;
  final Function onPressed;
  final bool hasSubtitle;
  final Color titleColor;
  final Color subtitleColor;
  final Widget titleWidget;
  final Widget subtitleWidget;
  final bool showLock;
  final bool isUsedInResponsiveGrid;
  final DateTime dateTime;
  final Widget favoriteButtonWidget;

  VerticalCard({
    this.title,
    this.image,
    this.subtitle,
    this.onPressed,
    this.hasSubtitle = false,
    this.titleColor,
    this.subtitleColor,
    this.titleWidget,
    this.showLock = false,
    this.subtitleWidget,
    this.isUsedInResponsiveGrid = false,
    this.dateTime,
    this.favoriteButtonWidget,
  });

  @override
  Widget build(BuildContext context) {
    final sizeManager = ResponsiveFlutter.of(context);
    final width = MediaQuery.of(context).size.width;
    ScreenUtil.init(context, width: 720, height: 1280, allowFontScaling: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: width > 600
                ? ScreenUtil().setHeight(300)
                : ScreenUtil().setHeight(380),
            width: isUsedInResponsiveGrid
                ? null
                : width > 600
                ? ScreenUtil().setWidth(170)
                : ScreenUtil().setWidth(320),
            decoration: BoxDecoration(),
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                image.toString().isEmpty
                    ? Image.asset(
                  placeholder_image,
                  fit: BoxFit.cover,
                )
                    : LayoutBuilder(builder: (context, constraints) {
                  return CustomCacheNetworkImage(
                    imageUrl: image,
                    boxfit: BoxFit.cover,
                    height: constraints.maxHeight,
                    width: constraints.maxWidth,
                  );
                }),
                if (showLock)
                  Positioned(
                    top: ScreenUtil().setWidth(10),
                    left: favoriteButtonWidget == null
                        ? null
                        : ScreenUtil().setWidth(15),
                    right: favoriteButtonWidget == null
                        ? ScreenUtil().setWidth(15)
                        : null,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: blackColor.withOpacity(0.5),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(ScreenUtil().setSp(9)),
                        child: Icon(
                          Icons.lock,
                          color: whiteColor,
                          size: width > 600
                              ? ScreenUtil().setSp(20)
                              : ScreenUtil().setSp(35),
                        ),
                      ),
                    ),
                  ),
                if (dateTime != null)
                  Positioned(
                    bottom: ScreenUtil().setHeight(10),
                    right: ScreenUtil().setWidth(15),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(15),
                        vertical: ScreenUtil().setWidth(5),
                      ),
                      child: Text(
                        Jiffy(dateTime).format("MMM dd"),
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                Positioned.fill(
                  child: Material(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: onPressed,
                      child: Container(
                        height: width > 600
                            ? ScreenUtil().setHeight(300)
                            : ScreenUtil().setHeight(380),
                        width: isUsedInResponsiveGrid
                            ? null
                            : width > 600
                            ? ScreenUtil().setWidth(170)
                            : ScreenUtil().setWidth(290),
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ),
                if (favoriteButtonWidget != null)
                  Positioned(
                    top: ScreenUtil().setHeight(1),
                    right: ScreenUtil().setWidth(10),
                    child: favoriteButtonWidget,
                  ),
              ],
            ),
          ),
        ),
        SizedBox(height: sizeManager.scale(5)),
        Container(
          width: width > 600
              ? ScreenUtil().setWidth(170)
              : ScreenUtil().setWidth(260),
          child: Text(title + "\n" ?? "",
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: width > 600
                  ? Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: titleColor ?? whiteColor)
                  : Theme.of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(color: titleColor ?? whiteColor)),
        ),
        !hasSubtitle
            ? Container()
            : Text(
          subtitle ?? "",
          style: width > 600
              ? Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(color: titleColor ?? whiteColor)
              : Theme.of(context)
              .textTheme
              .subtitle2
              .copyWith(color: titleColor ?? whiteColor),
        ),
      ],
    );
  }
}

class HorizontalCard extends StatelessWidget {
  final Function onPressed;
  final DateTime dateTime;
  final Widget favoriteButtonWidget;
  final title;
  final subtile;
  final image;
  final bool showLock;
  final bool hasSubtitle;
  final bool isUsedInResponsiveGrid;

  HorizontalCard(
      {this.onPressed,
        @required this.title,
        this.subtile,
        this.favoriteButtonWidget,
        this.hasSubtitle,
        this.showLock = false,
        this.dateTime,
        @required this.image,
        this.isUsedInResponsiveGrid = false});
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final sizeManager = ResponsiveFlutter.of(context);

    ScreenUtil.init(context, width: 720, height: 1280, allowFontScaling: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: ScreenUtil().setHeight(200),
            width: isUsedInResponsiveGrid
                ? null
                : width > 600
                ? ScreenUtil().setWidth(170)
                : ScreenUtil().setWidth(290),
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                image.toString().isEmpty
                    ? Image.asset(
                  hoz_placehoder_image,
                  height: ScreenUtil().setHeight(200),
                  width: isUsedInResponsiveGrid
                      ? null
                      : width > 600
                      ? ScreenUtil().setWidth(170)
                      : ScreenUtil().setWidth(290),
                  fit: BoxFit.cover,
                )
                    : CustomCacheNetworkImage(
                  imageUrl: image,
                  placeholder: hoz_placehoder_image,
                  height: ScreenUtil().setHeight(200),
                  width: width > 600
                      ? ScreenUtil().setWidth(170)
                      : ScreenUtil().setWidth(290),
                  boxfit: BoxFit.cover,
                ),
                if (dateTime != null)
                  Positioned(
                    bottom: ScreenUtil().setHeight(10),
                    right: ScreenUtil().setWidth(15),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(15),
                        vertical: ScreenUtil().setWidth(5),
                      ),
                      child: Text(
                        Jiffy(dateTime).format("MMM dd"),
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                if (showLock)
                  Positioned(
                    top: ScreenUtil().setWidth(10),
                    left: favoriteButtonWidget == null
                        ? null
                        : ScreenUtil().setWidth(15),
                    right: favoriteButtonWidget == null
                        ? ScreenUtil().setWidth(15)
                        : null,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withOpacity(0.5),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(ScreenUtil().setSp(9)),
                        child: Icon(
                          Icons.lock,
                          color: whiteColor,
                          size: width > 600
                              ? ScreenUtil().setSp(20)
                              : ScreenUtil().setSp(35),
                        ),
                      ),
                    ),
                  ),
                Positioned.fill(
                  child: Material(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: onPressed,
                      child: Container(
                        height: ScreenUtil().setHeight(200),
                        width: width > 600
                            ? ScreenUtil().setWidth(170)
                            : ScreenUtil().setWidth(290),
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ),
                if (favoriteButtonWidget != null)
                  Positioned(
                    top: ScreenUtil().setHeight(1),
                    right: ScreenUtil().setWidth(10),
                    child: favoriteButtonWidget,
                  ),
              ],
            ),
          ),
        ),
        SizedBox(height: sizeManager.scale(10)),
        Container(
          width: isUsedInResponsiveGrid
              ? null
              : width > 600
              ? ScreenUtil().setWidth(170)
              : ScreenUtil().setWidth(290),
          child: Text(
            title,
            maxLines: 2,
            textAlign: TextAlign.left,
            overflow: TextOverflow.ellipsis,
            style: whiteText12.copyWith(
              fontSize: width > 600 ? 12 : getFontSize(context, 1.8),
            ),
          ),
        ),
      ],
    );
  }
}
