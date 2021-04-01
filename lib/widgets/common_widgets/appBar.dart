import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:goodvibesofficial/services/app_Config.dart';

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
        size:15,
      ),
      onPressed: () => Navigator.of(context).pop(),
    )
        : null,
    title: Text(
      title,
      style: TextStyle(color: Colors.white,fontSize: 22),
    ),
  );
}
