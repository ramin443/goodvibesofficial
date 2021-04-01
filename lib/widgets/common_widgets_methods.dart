import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:goodvibesofficial/screens/auth/login.dart';
import 'package:goodvibesofficial/screens/auth/signup.dart';

import 'package:goodvibesofficial/provider/login_provider.dart';
import 'package:goodvibesofficial/services/connectivity_service.dart';
import 'package:goodvibesofficial/utils/image_paths.dart';
import 'package:goodvibesofficial/utils/strings/string_constants.dart';
import 'package:goodvibesofficial/utils/theme/style.dart';
import 'package:goodvibesofficial/utils/theme/text_style.dart';
import 'package:goodvibesofficial/widgets/webview.dart';

import '../locator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

showToastMessage({String message}) {
  Fluttertoast.showToast(
    msg: message,
    backgroundColor: Colors.deepPurple,
    textColor: whiteColor,
  );
}

showCenterCircularIndicator({Color color, double size}) {
  return Container(
    child: Center(
      child: SpinKitCircle(
        color: color ?? whiteColor,
        size: size ?? 30,
      ),
    ),
  );
}

buildSongsImage({String image, Widget child}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: FadeInImage.assetNetwork(
      fit: BoxFit.cover,
      placeholder: placeholder_image,
      image: image,
    ),
  );
}

showNoDataAvailable({TextStyle style, String widgetSpecificMessage}) {
  return Center(
    child: Text(
      widgetSpecificMessage ?? no_data_available,
      style: style ?? TextStyle(color: lightPink),
    ),
  );
}

getTermsAndPrivacyPolicyTexts({BuildContext context, TextStyle style}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      FlatButton(
        child: Text(
          privacy_policy,
          textAlign: TextAlign.center,
          style: style,
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WebView(
                  appbarTitle: privacy_policy.toUpperCase(),
                  url: privacy_policy_url,
                ),
                settings: RouteSettings(name: 'Privacy policy page'),
              ));
        },
      ),
      Text('|', style: style),
      FlatButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WebView(
                  appbarTitle: terms_and_conditions.toUpperCase(),
                  url: terms_and_conditions_url,
                ),
                settings: RouteSettings(name: 'Terms and conditions page'),
              ));
        },
        child: Text(terms_of_user, textAlign: TextAlign.center, style: style),
      ),
    ],
  );
}

getDontHaveAccountRichText(BuildContext context) {
  return RichText(
    text: TextSpan(
        text: account_yet,
        style: Theme.of(context).textTheme.bodyText2,
        children: [
          TextSpan(
              text: sign_up,
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Login(),
                      settings: RouteSettings(name: 'Sign up page'),
                    ),
                  );
                })
        ]),
  );
}

getLoginSignupTermsOfUse(context) {
  return Center(
    child: RichText(
      textAlign: TextAlign.center,
      text: TextSpan(children: [
        TextSpan(text: by_proceeding),
        TextSpan(
            text: terms_of_user,
            style: yellowText,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WebView(
                        appbarTitle: terms_and_conditions.toUpperCase(),
                        url: terms_and_conditions_url,
                      ),
                      settings:
                      RouteSettings(name: 'Terms and conditions  page'),
                    ));
              }),
      ]),
    ),
  );
}

class PaddingChild extends StatelessWidget {
  const PaddingChild({this.child, this.vertical});
  final double vertical;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: symmetricHorizonatalPadding, vertical: vertical ?? 0.0),
        child: child);
  }
}

commonOfflineSnackBar(width, {bool isUnderNavigationBar}) {
  final _cService = locator<ConnectivityService>();

  return ValueListenableBuilder<ConnectivityStatus>(
    valueListenable: _cService.appConnectionStatus,
    child: Container(
      height: ScreenUtil().setHeight(40),
      color: Color(0xff1b1b1b),
      alignment: Alignment.center,
      child: Text("No Internet Connection"),
    ),
    builder: (BuildContext context, value, Widget child) {
      if (value == ConnectivityStatus.Offline) {
        _cService.previousConnectionStatus = ConnectivityStatus.Offline;
        return child;
      }
      // when value is null
      else if (value == null) {
        if (_cService.previousConnectionStatus == ConnectivityStatus.Offline) {
          return child;
        } else if (_cService.previousConnectionStatus ==
            ConnectivityStatus.WiFi ||
            _cService.previousConnectionStatus == ConnectivityStatus.Cellular) {
          return Container(height: ScreenUtil().setHeight(0.0));
        } else {
          return Container(height: ScreenUtil().setHeight(0.0));
        }
      }

      /// when online its container with zero
      else if (_cService.previousConnectionStatus == ConnectivityStatus.WiFi ||
          _cService.previousConnectionStatus == ConnectivityStatus.Cellular) {
        return Container(height: ScreenUtil().setHeight(0.0));
      } else
        return Container(height: ScreenUtil().setHeight(0.0));
    },
  );
}

buildCourseIndicatorOnly(
    {@required width,
      @required percent,
      @required roundedPercent,
      TextStyle bodyText2,
      double height,
      Color color,
      bool showProgressText = true}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      LayoutBuilder(builder: (context, constraints) {
        return Stack(
          children: [
            Container(
                width: width,
                height: height ?? 7,
                decoration: BoxDecoration(
                    color: Color(0xff0D023B),
                    borderRadius: BorderRadius.circular(10))),
            Container(
              height: height ?? 7,
              width: constraints.maxWidth * percent,
              decoration: BoxDecoration(
                color: color,
                gradient: color != null ? null : lightBluePinkGradientL2R,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ],
        );
      }),
      if (showProgressText) SizedBox(height: 10.w),
      if (showProgressText) Text("$roundedPercent % Complete", style: bodyText2)
    ],
  );
}

class ErrorTryAgain extends StatelessWidget {
  final String errorMessage;
  final Function onPressedTryAgain;
  final TextStyle errorMessageStyle;
  ErrorTryAgain(
      {this.errorMessage, this.onPressedTryAgain, this.errorMessageStyle});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              '${errorMessage ?? " "}',
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(color: errorMessageColor),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: onPressedTryAgain,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                    gradient: timerDialogGradient,
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  'Retry',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .copyWith(color: Colors.white),
                ),
              ),
            )
          ],
        ));
  }
}
