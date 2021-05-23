import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goodvibesoffl/services/appConfig.dart';
import 'package:goodvibesoffl/utils/theme/style.dart';

///  Custom Button with default gradient and splash and rounded border
/// can be customized as per need
class CustomRoundedButttonWithSplash extends StatelessWidget {
  const CustomRoundedButttonWithSplash(
      {this.width,
        this.borderRadius,
        this.titleText,
        this.splashColor,
        this.verticalMargin,
        this.height,
        this.hozMargin,
        this.gradient,
        this.onPressed,
        this.centerWidget,
        this.childWidget});

  /// custom width of the button, no default width is provided
  final width;
  // height of the button
  final height;

  /// desired border radius
  final borderRadius;

  /// pass the text if you want button with text on it
  final titleText;

  /// custom splash color
  final splashColor;

  final verticalMargin;
  final hozMargin;

  /// custom gradeint, default is [dialogButtonGradient]
  final LinearGradient gradient;

  /// onpress for button
  final Function onPressed;

  /// pass this if you want to pass any widget in the center  of the button
  final Widget centerWidget;

  /// custom widget on the button
  final Widget childWidget;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, height: 1280, width: 720, allowFontScaling: false);
    return Container(
      height: height ?? 80.h,
      decoration: BoxDecoration(
          gradient: gradient ?? dialogButtonGradient,
          borderRadius: BorderRadius.circular(borderRadius ?? 25.sp)),
      margin: EdgeInsets.symmetric(
        vertical: verticalMargin ?? 30.h,
        horizontal: hozMargin ?? 0,
      ),
      width: width,
      child: ButtonTheme(
        // height: height ?? 80.h,
        buttonColor: tpt,
        child: RaisedButton(
          elevation: 0,
          highlightColor: tpt,
          highlightElevation: 0,
          hoverColor: tpt,
          focusColor: tpt,
          color: tpt,
          splashColor: splashColor ?? whiteColor.withOpacity(0.5),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 25.sp)),
          onPressed: onPressed,
          child: childWidget ??
              Center(
                child: centerWidget ??
                    Text(
                      titleText,
                      style: AppConfig.isTablet
                          ? Theme.of(context)
                          .textTheme
                          .subtitle2
                          .copyWith(color: whiteColor)
                          : Theme.of(context)
                          .textTheme
                          .button
                          .copyWith(color: whiteColor),
                    ),
              ),
        ),
      ),
    );
  }
}
