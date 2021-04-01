import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadingDialog extends StatelessWidget {
  final Widget widget;
  final String message;
  final Widget errorMessageWithExtraWdiget;
  LoadingDialog({this.widget, this.message, this.errorMessageWithExtraWdiget});
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            widget,
            SizedBox(height: ScreenUtil().setHeight(10)),

            /// if error message with extra widget is not present show only text
            errorMessageWithExtraWdiget ??
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      .copyWith(color: Colors.white),
                ),
          ],
        ));
  }
}
