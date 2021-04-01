import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goodvibesofficial/utils/theme/style.dart';
import 'package:goodvibesofficial/widgets/dialog_boxes.dart';
import 'package:goodvibesofficial/widgets/music_timer_dialog.dart';
import 'package:goodvibesofficial/widgets/popup_message.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

class DialogService {
  ValueNotifier<bool> isBusy = ValueNotifier(false);
  ValueNotifier<bool> hasErrorOccured = ValueNotifier(false);
  ValueNotifier<String> statusMessage = ValueNotifier('Loading..');
  ValueNotifier<Widget> statusWidget =
  ValueNotifier(CupertinoActivityIndicator());

  ValueNotifier<bool> dialogDismissable = ValueNotifier(false);

  showLoadingDialog(BuildContext context, {String message}) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)),
            child: Container(
              height: ScreenUtil().setHeight(220),
              width: ResponsiveFlutter.of(context).wp(70),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: bluePurpleGradientT2B,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: ScreenUtil().setHeight(50),
                    width: ScreenUtil().setHeight(50),
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Color(0xff42A5F5)),
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(30),
                  ),
                  Text(
                    message ?? "Loading...",
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        .copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
          );
        });
  }

  showCancelledDialog(BuildContext context) {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return DialogWrapper(
            child: Container(
              height: ScreenUtil().setHeight(220),
              child: LoadingDialog(
                widget: Icon(
                  Icons.error,
                  color: whiteColor,
                  size: ScreenUtil().setHeight(80),
                ),
                message: 'Login Cancelled!',
              ),
            ),
          );

          // return CupertinoAlertDialog(
          //   content: LoadingDialog(
          //     widget: Icon(Icons.error),
          //     message: 'Login Cancelled!',
          //   ),
          // );
        });
  }

  showErrorDialog(
      {BuildContext context, String message, Widget errorMessageWithWdiget}) {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return DialogWrapper(
            child: Container(
              height: ScreenUtil().setHeight(220),
              child: LoadingDialog(
                  errorMessageWithExtraWdiget: errorMessageWithWdiget,
                  widget: Icon(
                    Icons.error,
                    color: whiteColor,
                    size: ScreenUtil().setHeight(80),
                  ),
                  message: message ?? 'An Error Ocurred'),
            ),
          );

          // return CupertinoAlertDialog(
          //   content: LoadingDialog(
          //     widget: Icon(Icons.error),
          //     message: message ?? "An Error Ocurred",
          //   ),
          // );
        });
  }

  showSuccessDialog({BuildContext context, String message}) {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return DialogWrapper(
            child: Container(
              height: ScreenUtil().setHeight(220),
              child: LoadingDialog(
                widget: Icon(
                  Icons.check_circle,
                  color: whiteColor,
                  size: ScreenUtil().setHeight(80),
                ),
                message: message ?? "Login Successful\n Welcome!",
              ),
            ),
          );

          // return CupertinoAlertDialog(
          //   content: LoadingDialog(
          //     widget: Icon(Icons.check_circle),
          //     message: message ?? "Login Successful\n Welcome!",
          //   ),
          // );
        });
  }

  showOfflineDialog({@required BuildContext context}) {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return DialogBoxWithOneAction(
            actionTitle: "Cancel",
            title: "You cannot change settings while you are offline.",
            action: () => Navigator.pop(context),
          );
        });
  }
}
