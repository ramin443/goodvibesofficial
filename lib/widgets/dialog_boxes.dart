import 'dart:async';
import 'dart:io';
import 'package:firebase_admob/firebase_admob.dart';
//import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:goodvibesoffl/constants/fontconstants.dart';
import 'package:goodvibesoffl/locator.dart';
import 'package:goodvibesoffl/models/app_update_model.dart';
import 'package:goodvibesoffl/models/composer_audio_model.dart';
import 'package:goodvibesoffl/models/music_model.dart';
import 'package:goodvibesoffl/screens/premium/getpremium.dart';
import 'package:goodvibesoffl/services/adsManagerService.dart';
import 'package:goodvibesoffl/services/adsModelService.dart';
import 'package:goodvibesoffl/services/app_version.dart';
import 'package:goodvibesoffl/services/navigation_service.dart';
import 'package:goodvibesoffl/services/player_service.dart';
import 'package:goodvibesoffl/services/services.dart';
import 'package:goodvibesoffl/services/user_service.dart';
import 'package:goodvibesoffl/utils/common_functiona.dart';
import 'package:goodvibesoffl/utils/strings/string_constants.dart';
import 'package:goodvibesoffl/utils/theme/style.dart';
import 'package:goodvibesoffl/widgets/common_widgets/common_widgets_methods.dart';
import 'package:goodvibesoffl/widgets/music_timer_dialog.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:rxdart/rxdart.dart';
import 'common_widgets/custom_rounded_button.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;
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
    String poppinsRegular=helveticaneueregular;
    final whiteText14 =
    TextStyle(color: whiteColor, fontSize: 14.0, fontFamily: 'Poppins');
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
    String poppinsRegular=helveticaneueregular;
    final whiteText14 =
    TextStyle(color: whiteColor, fontSize: 14.0, fontFamily: 'Poppins');
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
            locator<AdsManagerService>().addRewardedTrack(widget.track);
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
    String poppinsRegular=helveticaneueregular;
    final whiteText14 =
    TextStyle(color: whiteColor, fontSize: 14.0, fontFamily: 'Poppins');
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
                  recordAnalyticsToSubscriptionPage(
                      source:
                      "Paid track card dialog to either watch ad to listen or subscribe.");
                  Navigator.pop(context);

                  Navigator.push(context,
                      CupertinoPageRoute(builder: (_) => GetPremium()));
                },
                decoration: BoxDecoration(
                    borderRadius: circularBorderRadius8,
                    gradient: dialogButtonGradient),
              ),
              DialogBoxButton(
                title: "Watch an Ad to listen for free",
                onPressed: () async {
                  if (locator<AdsModelService>().adsData.showRewardAds) {
                    if (_rewardStatus.status == RewardVideoStatus.LOADED) {
                      final _musicService = locator<MusicService>();

                      if (_musicService?.assetsAudioPlayer != null && _musicService?.assetsAudioPlayer?.isPlaying?.value) {
                        _musicService?.stopPlayer();
                      }
                      RewardedVideoAd.instance.show();
                    } else {
                      showToastMessage(message: "No Ads Available");
                      Navigator.pop(context);
                    }
                  } else {
                    showToastMessage(message: "No Ads Available");
                    Navigator.pop(context);
                  }
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

showUpdateDialogSplash({BuildContext context, AppUpdateModel appUpdateData}) {
  showDialog(
      barrierDismissible: !appUpdateData.isForce,
      context: context,
      builder: (context) {
        return WillPopScope(
          onWillPop: () {},
          child: DialogWrapper(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if (!appUpdateData.isForce)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          locator<NavigationService>()
                              .navigationKey
                              .currentState
                              .pop();
                        },
                        icon: Icon(Icons.close, color: whiteColor),
                      ),
                    ],
                  ),
                Text("What's new(v${appUpdateData.version})",
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(28),
                    )),
                if (appUpdateData.whatsNew == "" ||
                    appUpdateData.whatsNew == null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(height: ScreenUtil().setHeight(25)),
                      Text(
                          "New update with fixes is available in the store. Please update to get the best out of the app.",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(28),
                          )),
                      SizedBox(height: ScreenUtil().setHeight(25)),
                    ],
                  ),
                Html(
                  data: appUpdateData.whatsNew,
                  customTextAlign: (item) => TextAlign.left,
                ),
                SizedBox(height: ScreenUtil().setHeight(20)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    if (!appUpdateData.isForce)
                      Expanded(
                        child: CustomRoundedButttonWithSplash(
                          width: ScreenUtil().setWidth(200),
                          titleText: "Later",
                          height: ScreenUtil().setHeight(55),
                          hozMargin: ScreenUtil().setWidth(20),
                          verticalMargin: 0.0,
                          onPressed: () async {
                            locator<NavigationService>()
                                .navigationKey
                                .currentState
                                .pop();
                          },
                        ),
                      ),
                    Expanded(
                      child: CustomRoundedButttonWithSplash(
                        width: ScreenUtil().setWidth(200),
                        titleText: "Update",
                        height: ScreenUtil().setHeight(55),
                        hozMargin: ScreenUtil().setWidth(20),
                        verticalMargin: 0.0,
                        onPressed: () async {
                          final url = Platform.isAndroid
                              ? google_play_store_url
                              : app_store_url;
                          if (await launcher.canLaunch(url)) {
                            if (!appUpdateData.isForce)
                              locator<NavigationService>()
                                  .navigationKey
                                  .currentState
                                  .pop();
                            await launcher.launch(url);
                          }
                        },
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      });
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

showSinglePlayerErrorDialog(
    {Track currentTrack, error, ComposerAudio composerAudio}) {
  var crashRecordPlayer = "";

  var _error = replaceUrlInErrorMessage(error.toString());

  if (currentTrack != null) {
    crashRecordPlayer = '''error occured while 
        playing audio wtih title:  ${currentTrack.title} 
         id: ${currentTrack.id}''';
  }

  var crashRecordComposer = "";

  if (composerAudio != null) {
    crashRecordComposer = ''' An error occured while
         playing audio wtih title :  ${composerAudio.audioTitle}
         id: ${composerAudio.id}''';
  }

//  FirebaseCrashlytics.instance.recordError(
  //    error, StackTrace.fromString(error_error),
    //  reason: composerAudio == null ? crashRecordPlayer : crashRecordComposer);

  showDialog(
      context: locator<NavigationService>()
          .navigationKey
          .currentState
          .overlay
          .context,
      builder: (context) {
        return DialogWrapper(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: ScreenUtil().setHeight(20)),
              Transform.scale(
                scale: 1.5,
                child: Icon(
                  Icons.error_outline,
                  color: whiteColor,
                  size: ScreenUtil().setSp(40),
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(10)),
              Text(
                "Could not play the audio at this time.",
                style: TextStyle(
                    color: whiteColor, fontSize: ScreenUtil().setSp(25)),
              ),
              InkWell(
                onTap: () async {
                  final appVersion = AppVersion().appVersion;
                  String platform = Platform.isAndroid ? 'Android' : 'Ios';
                  var userEmail = locator<UserService>().user.value.email;

                  var title = "", body = "";

                  if (composerAudio != null) {
                    title =
                    "Could not play '${composerAudio.audioTitle}'  sound";
                    body = '''
                    track id: ${composerAudio.id} 
                    track title: ${composerAudio.audioTitle}
                    track type:  ${composerAudio.audioPathType}
                    file name: ${composerAudio.fileName} 
                    platform : $platform
                    app version: $appVersion     
                    error log:
                    $_error
                              ''';
                  } else if (currentTrack != null) {
                    title = "Could not play '${currentTrack.title}' ";
                    body = '''
                              track id: ${currentTrack.id} 
                              track title: ${currentTrack.title}
                              platform : $platform
                              app version: $appVersion     
                              error log:
                              $_error
                              ''';
                  }

                  final Email email = Email(
                      subject: title,
                      body: body,
                      recipients: [good_vibes_email]);

                  String platformResponse;
                  try {
                    locator<NavigationService>()
                        .navigationKey
                        .currentState
                        .pop();
                    await FlutterEmailSender.send(email);
                    platformResponse = 'success';
                  } catch (error) {
                    platformResponse = error.toString();
                  }
                },
                child: Text(
                  "Report this error",
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.blue,
                      fontSize: ScreenUtil().setSp(25)),
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(20)),
            ],
          ),
        );
      });
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
