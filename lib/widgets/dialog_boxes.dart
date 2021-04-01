import 'dart:async';
import 'dart:io';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:goodvibesofficial/locator.dart';
//import 'package:goodvibesofficial/models/app_update_model.dart';
import 'package:goodvibesofficial/models/composer_audio_model.dart';
import 'package:goodvibesofficial/models/music_model.dart';
import 'package:goodvibesofficial/screens/initial/goals.dart';
//import 'package:goodvibesofficial/pages/payments/subscription.dart';
//import 'package:goodvibesofficial/services/adsManagerService.dart';
//import 'package:goodvibesofficial/services/adsModelService.dart';
//import 'package:goodvibesofficial/services/app_version.dart';
import 'package:goodvibesofficial/services/navigation_service.dart';
import 'package:goodvibesofficial/services/services.dart';
import 'package:goodvibesofficial/services/user_service.dart';
import 'package:goodvibesofficial/utils/common_functiona.dart';
import 'package:goodvibesofficial/utils/strings/string_constants.dart';
import 'package:goodvibesofficial/utils/theme/style.dart';
import 'package:goodvibesofficial/utils/theme/text_style.dart';
import 'package:goodvibesofficial/widgets/common_widgets_methods.dart';
//import 'package:goodvibesofficial/widgets/music_timer_dialog.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:rxdart/rxdart.dart';
//import 'common_widgets/custom_rounded_button.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

import 'music_timer_dialog.dart';

enum DialogBoxAlignType { ROW, COLUMN }

class DialogBoxTwoActions extends StatelessWidget {
  final Function cancelAction;
  final Function proceedAction;
  final String title;
  final String proceedActionTitle;
  final String cancelActionTitle;
  final DialogBoxAlignType alignType;
  final image;

  DialogBoxTwoActions(
      {this.cancelAction,
        this.proceedAction,
        this.title,
        this.proceedActionTitle,
        this.cancelActionTitle,
        this.image,
        this.alignType});
  @override
  Widget build(BuildContext context) {
    DialogBoxAlignType _alignTyp = alignType ?? DialogBoxAlignType.ROW;
    final sM = ResponsiveFlutter.of(context);
    return DialogWrapper(
      padding: EdgeInsets.symmetric(
        vertical: sM.wp(5),
        horizontal: sM.wp(5),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(title,
              style: whiteText14.copyWith(
                  fontSize: sM.scale(18), fontFamily: poppinsRegular),
              textAlign: TextAlign.center),
          SizedBox(height: sM.scale(5)),
          _alignTyp == DialogBoxAlignType.ROW
              ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: DialogBoxButton(
                  title: proceedActionTitle ?? remove_t,
                  onPressed: () {
                    proceedAction();
                  },
                  decoration: BoxDecoration(
                      borderRadius: circularBorderRadius8,
                      gradient: dialogButtonGradient),
                ),
              ),
              SizedBox(width: sM.scale(10)),
              Expanded(
                child: DialogBoxButton(
                  isCancel: true,
                  title: cancelActionTitle ?? cancel_t.toUpperCase(),
                  onPressed: () {
                    Navigator.pop(context);
                    //if null not is cancel
                    if (cancelAction != null) cancelAction();
                  },
                  decoration: BoxDecoration(
                      borderRadius: circularBorderRadius8,
                      gradient: dialogButtonGradient),
                ),
              ),
            ],
          )
              : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              DialogBoxButton(
                title: proceedActionTitle ?? remove_t,
                onPressed: () {
                  proceedAction();
                },
                decoration: BoxDecoration(
                    borderRadius: circularBorderRadius8,
                    gradient: dialogButtonGradient),
              ),
              DialogBoxButton(
                isCancel: true,
                title: cancelActionTitle ?? cancel_t.toUpperCase(),
                onPressed: () {
                  Navigator.pop(context);
                  //if null not is cancel
                  if (cancelAction != null) cancelAction();
                },
                decoration: BoxDecoration(
                    borderRadius: circularBorderRadius8,
                    gradient: dialogButtonGradient),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DialogBoxWithOneAction extends StatelessWidget {
  final String title;
  final Function action;
  final image;
  final String actionTitle;
  DialogBoxWithOneAction(
      {this.title, this.image, this.action, this.actionTitle});
  @override
  Widget build(BuildContext context) {
    final sM = ResponsiveFlutter.of(context);
    return DialogWrapper(
      padding: EdgeInsets.symmetric(
        vertical: sM.hp(5),
        horizontal: sM.wp(5),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(title,
              style: whiteText14.copyWith(
                  fontSize: sM.scale(18), fontFamily: poppinsRegular),
              textAlign: TextAlign.center),
          SizedBox(height: sM.scale(5)),
          DialogBoxButton(
            title: actionTitle,
            onPressed: action,
            decoration: BoxDecoration(
                borderRadius: circularBorderRadius8,
                gradient: dialogButtonGradient),
          ),
        ],
      ),
    );
  }
}

class DialogBoxButton extends StatelessWidget {
  final title;
  final decoration;
  final onPressed;
  final bool isCancel;
  DialogBoxButton({this.title, this.decoration, this.onPressed, this.isCancel});

  @override
  Widget build(BuildContext context) {
    final sM = ResponsiveFlutter.of(context);

    return InkWell(
      onTap: () {
        onPressed();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Container(
          decoration: decoration,
          width: double.infinity,
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(sM.scale(10)),
              child: Text(
                title,
                style: Theme.of(context).textTheme.subtitle1.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DialogBoxReward extends StatefulWidget {
  final Function rewardAction;
  final Track track;
  DialogBoxReward({this.rewardAction, this.track});

  @override
  _DialogBoxRewardState createState() => _DialogBoxRewardState();
}

class _DialogBoxRewardState extends State<DialogBoxReward> {
  final _rewardStatus = locator<RewardStatus>();
  StreamSubscription<RewardVideoStatus> _rewardedStatusStream;
  @override
  void initState() {
    super.initState();
    _rewardedStatusStream =
        locator<BehaviorSubject<RewardVideoStatus>>().listen((value) {
          if (value == RewardVideoStatus.REWARDED) {
 //           locator<AdsManagerService>().addRewardedTrack(widget.track);
            widget.rewardAction();
          }
        });
  }

  @override
  void dispose() {
    _rewardedStatusStream.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sM = ResponsiveFlutter.of(context);
    return DialogWrapper(
      padding: EdgeInsets.symmetric(
        vertical: sM.hp(5),
        horizontal: sM.wp(5),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("This track is only available to paid users",
              style: whiteText14.copyWith(
                  fontSize: sM.scale(18), fontFamily: poppinsRegular),
              textAlign: TextAlign.center),
          SizedBox(height: sM.scale(5)),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              DialogBoxButton(
                title: "Subscribe",
                onPressed: () {

                  Navigator.pop(context);

                  Navigator.push(context,
                      CupertinoPageRoute(builder: (_) => Goals()));
                },
                decoration: BoxDecoration(
                    borderRadius: circularBorderRadius8,
                    gradient: dialogButtonGradient),
              ),
              DialogBoxButton(
                title: "Watch an Ad to listen for free",
                onPressed: () async {

                },
                decoration: BoxDecoration(
                    borderRadius: circularBorderRadius8,
                    gradient: dialogButtonGradient),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


replaceUrlInErrorMessage(String error) {
  var tempError;
  if (error.contains("http")) {
    tempError = error.replaceAll("http", "****");
  }
  if (error.contains("cloudfront")) {
    tempError = error.replaceAll("cloudfront", "***");
  }
  return tempError;
}



showComposerItemsBeingDownloadedDialog() {
  var context =
      locator<NavigationService>().navigationKey.currentState.overlay.context;

  showDialog(
      context: context,
      builder: (context) => DialogWrapper(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: ScreenUtil().setHeight(30)),
              Text("This audio is being downloaded.",
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(color: whiteColor)),
              SizedBox(height: ScreenUtil().setHeight(30)),
            ],
          )));
}
