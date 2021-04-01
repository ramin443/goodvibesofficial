import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goodvibesofficial/utils/theme/style.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:goodvibesofficial/utils/theme/text_style.dart';

final ThemeData defaultTheme = ThemeData(
  fontFamily: "Poppins",
  appBarTheme: AppBarTheme(
    color: Colors.transparent,
    elevation: 0,
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(fontSize: 12.0, color: lightPink), // 12 fontSize
    bodyText2: TextStyle(fontSize: 14.0, color: lightPink), // 14 fontSize
    subtitle1: TextStyle(fontSize: 16.0, color: lightPink), // 16 fontSize
    subtitle2: TextStyle(fontSize: 18.0, color: lightPink), // 18 fontSize
    button: TextStyle(fontSize: 20.0, color: lightPink), // 20 fontSize
    headline6: TextStyle(fontSize: 22.0, color: lightPink), // 22 fontSize
    headline5: TextStyle(fontSize: 24.0, color: lightPink), // 24 fontSize
    headline4: TextStyle(fontSize: 26.0, color: lightPink), // 26 fontSize
    headline3: TextStyle(fontSize: 28.0, color: lightPink), // 28 fontSize
    headline2: TextStyle(fontSize: 32.0, color: lightPink), // 32 fontSize
    headline1: TextStyle(fontSize: 36.0, color: lightPink), // 36 fontSize
  ),
);

ThemeData getCustomTheme(BuildContext context) {
  ScreenUtil.init(context, width: 720, height: 1280, allowFontScaling: true);
  final width = MediaQuery.of(context).size.width;
  return ThemeData(
    fontFamily: 'ProximaNova',
    appBarTheme: AppBarTheme(
      color: Colors.transparent,
      elevation: 0,
    ),
    textTheme: TextTheme(
      bodyText1: TextStyle(
          fontSize: width > 600 ? 12.sp : 19.04.sp,
          color: lightPink), // 12 fontSize
      bodyText2: TextStyle(
          fontSize: width > 600 ? 14.sp : 22.22.sp,
          color: lightPink), // 14 fontSize
      subtitle1: TextStyle(
          fontSize: width > 600 ? 16.sp : 25.5.sp,
          color: lightPink), // 16 fontSize
      subtitle2: TextStyle(
          fontSize: width > 600 ? 18.sp : 28.5.sp,
          color: lightPink), // 18 fontSize
      button: TextStyle(
          fontSize: width > 600 ? 20.sp : 31.7.sp,
          color: lightPink), // 20 fontSize
      headline6: TextStyle(
          fontSize: width > 600 ? 22.sp : 34.9.sp,
          color: lightPink), // 22 fontSize
      headline5: TextStyle(
          fontSize: width > 600 ? 24.sp : 38.1.sp,
          color: lightPink), // 24 fontSize
      headline4: TextStyle(
          fontSize: width > 600 ? 26.sp : 41.26.sp,
          color: lightPink), // 26 fontSize
      headline3: TextStyle(
          fontSize: width > 600 ? 28.sp : 44.44.sp,
          fontWeight: FontWeight.bold,
          color: lightPink), // 28 fontSize
      headline2: TextStyle(
          fontSize: width > 600 ? 32.sp : 50.7.sp,
          fontWeight: FontWeight.bold,
          color: lightPink), // 32 fontSize
      headline1: TextStyle(
          fontSize: width > 600 ? 36.sp : 65.14.sp,
          fontWeight: FontWeight.bold,
          color: lightPink), // 36 fontSize
    ),
  );
}
