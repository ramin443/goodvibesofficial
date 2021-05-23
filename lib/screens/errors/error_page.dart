import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goodvibesoffl/utils/image_paths.dart';
import 'package:goodvibesoffl/utils/strings/string_constants.dart';
import 'package:goodvibesoffl/utils/theme/style.dart';
import 'package:goodvibesoffl/utils/theme/text_style.dart';
import 'package:goodvibesoffl/widgets/common_widgets/common_widgets_methods.dart';
import 'package:goodvibesoffl/widgets/common_widgets/pages_wrapper_with_background.dart';
import 'package:package_info/package_info.dart';

void setErrorBuilder(BuildContext context) {
  final height = MediaQuery.of(context).size.height;
  final width = MediaQuery.of(context).size.width;
  ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
    return PagesWrapperWithBackground(
      child: Scaffold(
        backgroundColor: tpt,
        body: Container(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: height * 0.15),
                SvgPicture.asset(error_icon),
                SizedBox(height: height * 0.07),
                Text(
                  app_error_title,
                  style: whiteText32,
                ),
                SizedBox(height: 20),
                Text(app_error_message1, style: errorMessageStyle),
                Text(app_error_message2, style: errorMessageStyle),
                Text(app_error_message3, style: errorMessageStyle),
                SizedBox(height: 20),
                InkWell(
                  onTap: () async {
                    await sendEmail(
                      exception: errorDetails.exceptionAsString(),
                      stackTrace: errorDetails.stack,
                    );
                  },
                  child: Container(
                    height: 50,
                    width: width * 0.6,
                    decoration: BoxDecoration(
                        gradient: timerDialogGradient,
                        borderRadius: BorderRadius.circular(8)),
                    child: Center(
                      child: Text(report_us, style: whiteText18),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Theme(
                  data: ThemeData(
                      unselectedWidgetColor: whiteColor,
                      accentColor: whiteColor),
                  child: ExpansionTile(
                    title: Center(
                        child: Text('See Error Details', style: whiteText14)),
                    onExpansionChanged: (value) {},
                    children: <Widget>[
                      Container(
                        child: SingleChildScrollView(
                          child: Text(
                            errorDetails.toString(),
                            style: whiteText14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  };
}

Future<void> sendEmail({StackTrace stackTrace, String exception}) async {
  PackageInfo info = await PackageInfo.fromPlatform();
  final appVersion = info.version;
  String platform = Platform.isAndroid ? 'Android' : 'Ios';
  final Email email = Email(
    subject: "Crash report  $appVersion on $platform",
    recipients: [support_email],
    body:
        'version: $appVersion, platform:$platform\n  Exception: $exception \n Stacktrace:\n $stackTrace',
  );

  try {
    await FlutterEmailSender.send(email);
  } catch (error) {
    showToastMessage(message: 'Email could not be sent');
  }
}
