import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:goodvibesoffl/services/appConfig.dart';

Widget customAppBar(
    {@required BuildContext context,
      @required String title,
      bool backButton = true}) {
  final width = MediaQuery.of(context).size.width;
  return AppBar(
    centerTitle: false,
    titleSpacing: backButton ? 1.0 : NavigationToolbar.kMiddleSpacing,
    automaticallyImplyLeading: false,
    leading: backButton
        ? IconButton(
      icon: Icon(
        CupertinoIcons.back,
        size: AppConfig.isTablet ? 15.w : 25.w,
      ),
      onPressed: () => Navigator.of(context).pop(),
    )
        : null,
    title: Text(
      title,
      style: AppConfig.isTablet
          ? Theme.of(context).textTheme.subtitle2.copyWith(color: Colors.white)
          : Theme.of(context).textTheme.button.copyWith(color: Colors.white),
    ),
  );
}
