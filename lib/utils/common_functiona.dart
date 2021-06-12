import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:firebase_admob/firebase_admob.dart';

//import 'package:firebase_admob/firebase_admob.dart';
//import 'package:firebase_analytics/firebase_analytics.dart';
//import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_admob/native_admob_options.dart';
import 'package:goodvibesoffl/bloc/common_bloc/common_event.dart';
import 'package:goodvibesoffl/bloc/dynamic_homepage/dynamichomepagewidget_bloc.dart';
import 'package:goodvibesoffl/bloc/rituals/rituals_bloc.dart';
import 'package:goodvibesoffl/bloc/settings/settings_bloc.dart';

//import 'package:flutter_native_admob/native_admob_options.dart';
import 'package:goodvibesoffl/models/music_model.dart';
import 'package:goodvibesoffl/models/playable_model.dart';
import 'package:goodvibesoffl/models/playlist_model.dart';
import 'package:goodvibesoffl/screens/music/playlist_page.dart';
import 'package:goodvibesoffl/screens/music/single_player_red.dart';
import 'package:goodvibesoffl/screens/premium/getpremium.dart';
import 'package:goodvibesoffl/screens/rituals/rituals_details.dart';
import 'package:goodvibesoffl/screens/rituals/rituals_playlist.dart';
import 'package:goodvibesoffl/services/adsManagerService.dart';
import 'package:goodvibesoffl/services/appConfig.dart';
import 'package:goodvibesoffl/services/database_service.dart';
import 'package:goodvibesoffl/services/navigation_service.dart';
import 'package:goodvibesoffl/services/player_service.dart';
import 'package:goodvibesoffl/utils/strings/ads_ids_strings.dart';
import 'package:goodvibesoffl/utils/strings/string_constants.dart';
import 'package:goodvibesoffl/widgets/common_widgets/common_widgets_methods.dart';
import 'package:goodvibesoffl/widgets/dialog_boxes.dart';
import 'package:goodvibesoffl/widgets/music_timer_dialog.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:sqflite/sqflite.dart';
import 'package:url_launcher/url_launcher.dart';

import '../config.dart';
import '../locator.dart';

checkIfOffline() async {
  var result = await Connectivity().checkConnectivity();
  if (result == ConnectivityResult.none) {
    return true;
  }
  return false;
}

void navigateToMusicIntermediatePage({
  @required Playablee playable,
  @required String sourcePage,
}) {
  final context = locator<NavigationService>().navigationKey.currentContext;

  ///possible navigations:
  /// 1. to playlist page
  /// 2. to intermediate page
  /// 4. ritulas: to rituals details page when ritual is not started
  /// 5. rituals: to rituals playlist page when rituals is started

  /// 1
  if (playable.type == PlayableType.Playlist) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PlayListPage(playlist: playable.playList),
      ),
    );
    return;
  }
  //// 2
  else if (playable.type == PlayableType.Rituals) {
    Navigator.of(context).push(
      CupertinoPageRoute(builder: (context) {
        /// 4
        ///5

        return RitualPlaylist(playlist: playable.playList);
      }),
    );
  } else if (playable.type == PlayableType.Track) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => RitualDetails(object: playable),
      ),
    );
  }
}

void checkTrackPaidStatusAndNavigate({
  @required Track track,
  @required bool isPaidUser,
  @required BuildContext context,
  var sourcePage,
  bool isFromPlaylist = false,
}) {
  final playerService = locator<MusicService>();

  if (isPaidUser) {
    playerService.currentTrack.value = track;
    playerService.trackId.value = track.id;

    navigateToMusicPlayer(context, track, sourcePage: sourcePage);
  } else {
    switch (track.trackPaidType) {
      case TrackPaidType.Free:
        playerService.currentTrack.value = track;
        playerService.trackId.value = track.id;

        navigateToMusicPlayer(context, track,
            sourcePage: sourcePage, fromPlayList: isFromPlaylist);

        break;
      case TrackPaidType.Paid:
        final adsManager = locator<AdsManagerService>();
        if (!adsManager.showAdsToCurrentTrack(track)) {
          playerService.currentTrack.value = track;
          playerService.trackId.value = track.id;

          navigateToMusicPlayer(context, track,
              sourcePage: sourcePage, fromPlayList: isFromPlaylist);
        } else
          showDialog(
              context: context,
              builder: (context) {
                return DialogBoxReward(
                  track: track,
                  rewardAction: () {
                    Navigator.of(context).pop();
                    playerService.currentTrack.value = track;
                    playerService.trackId.value = track.id;
                    navigateToMusicPlayer(context, track,
                        sourcePage: sourcePage, fromPlayList: isFromPlaylist);
                  },
                );
              });

        break;
      case TrackPaidType.Premium:
        recordAnalyticsToSubscriptionPage(
            source: "click on PREMIUM TRACK card trackid: ${track.id}");

        locator<NavigationService>()
            .navigationKey
            .currentState
            .push(CupertinoPageRoute(builder: (_) => GetPremium()));
        break;

      default:
    }
  }
}

getPercentageFromDurations({double current, double total}) {
  // List _currentList = current.split(":");
  // List _totalList = total.split(":");

  // if (_currentList.isNotEmpty && _totalList.isNotEmpty) {
  //   var _currentSeconds = int.parse(_currentList[0]) * 60 * 60 +
  //       double.parse(_currentList[1]) * 60 +
  //       double.parse(_currentList[2]);

  //   var _totalSeconds = int.parse(_totalList[0]) * 60 * 60 +
  //       double.parse(_totalList[1]) * 60 +
  //       double.parse(_totalList[2]);

  //   var percent = _currentSeconds / _totalSeconds;
  //   return percent;
  // } else
  //   return 0.0;

  if (total == 0 || current == 0 || total == null || current == null) {
    return 0.0;
  } else {
    return current / total;
  }
}

getCourseCompletionPercentage(
    {List<Map<String, dynamic>> playedItems, int totalItemsLength}) {
  var percentage = 0.0;
  var playedDuration = 0.0;
  playedItems.forEach((item) {
    dPrint(item['duration']);

    var _itemPercent = getPercentageFromDurations(
      current: double.tryParse(
          item[DatabaseService.Column_completed_duration].toString()),
      total: double.tryParse(item['duration'].toString()),
    );
    var title = item['title'];

    if (item[DatabaseService.Column_completion_status] ==
        CompletionStatus.Complete.toString()) {
      _itemPercent = 1.0;
    }

    percentage += _itemPercent;
  });
  dPrint("total percentage = ${percentage / totalItemsLength}");
  return percentage / totalItemsLength;
}

int getCurrentDayForRituals(PlayList playlist) {
  var _started = playlist.playableStat.startedAt ?? DateTime.now();
  var _status = playlist.playableStat.status;
  var _current = DateTime.now();

  if (_status == CompletionStatus.Complete) {
    return playlist.playablesCount - 1;
  } else if (_status == CompletionStatus.Started) {
    if (_started == null) {
      return 1;
    }

    var _diff = _current.difference(_started).inDays;
    if (_diff <= playlist.playablesCount) {
      return _diff;
    } else {
      return playlist.playablesCount - 1;
    }
  }
}

recordCrashlyticsLog(String value) {
//  FirebaseCrashlytics.instance.log(value);
}

void dPrint(message) {
  if (!kReleaseMode) {
    print(message);
  }
}

MobileAdTargetingInfo adtargetingInfo = MobileAdTargetingInfo(
  keywords: <String>['music', 'meditate'],
  childDirected: true,
  nonPersonalizedAds: true,
);

InterstitialAd createInterstitialAd() {
  return InterstitialAd(
    adUnitId: getInterstitialID,
    targetingInfo: adtargetingInfo,
    listener: (MobileAdEvent event) {
      dPrint("InterstitialAd event $event");
    },
  );
}

showOfflineSnackBar({@required BuildContext context}) {
  Scaffold.of(context).showSnackBar(
    SnackBar(
      content: Text(
        "No Internet Connection",
        textAlign: TextAlign.center,
      ),
    ),
  );
}

showDialogBox({
  @required String dialogType,
  String customTitle,
  BuildContext context,
  ValueChanged proceedAction,
  Function proceedFunction,
  ValueChanged cancelAction,
  bool barrierDismissible = true,
}) {
  showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (_) {
        switch (dialogType) {
          case delete_download:
            return DialogBoxTwoActions(
              proceedAction: () {
                proceedAction(true);
                Navigator.pop(context);
              },
              title: delete_download_message,
            );
            break;

          case cancel_download:
            return DialogBoxTwoActions(
              proceedAction: () {
                proceedAction(true);
                Navigator.pop(context);
              },
              title: cancel_download_message,
              cancelActionTitle: 'NO',
              proceedActionTitle: 'YES',
            );
            break;

          case cannot_download:
            return DialogBoxTwoActions(
              proceedActionTitle: 'SUBSCRIBE',
              proceedAction: () {
                recordAnalyticsToSubscriptionPage(
                    source: "cannot download dialog");

                Navigator.push(
                    context, CupertinoPageRoute(builder: (_) => GetPremium()));
              },
              cancelActionTitle: 'CANCEL',
              title: customTitle ?? unpaid_user_download_message,
            );
            break;
          case logout_user:
            return DialogBoxTwoActions(
              proceedActionTitle: 'YES',
              proceedAction: proceedFunction,
              cancelActionTitle: 'NO',
              title: pre_logout_message,
            );
            break;
          case unpaid_user_offline_access:
            return DialogBoxWithOneAction(
              actionTitle: 'Retry',
              action: proceedFunction,
              title: not_logged_message,
            );
            break;
          case deactivate_account:
            return DialogBoxTwoActions(
              title: deactivate_account_message,
              proceedActionTitle: 'YES',
              proceedAction: proceedFunction,
              cancelActionTitle: 'NO',
            );
            break;
          case only_one_download:
            return DialogBoxWithOneAction(
              title: "Only one track can be downloaded at a time!",
              action: () => Navigator.pop(context),
              actionTitle: "OK",
            );
            break;
          case enablePlayServiceDialog:
            return DialogBoxTwoActions(
              title: "Enable Google PlayService",
              cancelActionTitle: "Exit App",
              proceedActionTitle: "Enable",
              proceedAction: () async {
                await AppConfig().initPlayService(true);
              },
              cancelAction: () {
                Navigator.pop(context);
                SystemNavigator.pop();
              },
            );

          case updatePlayServiceDialog:
            return DialogBoxWithOneAction(
              title: "Update Google PlayService",
              actionTitle: "Update",
              action: () async {
                try {
                  if (await canLaunch(playServiceUrl)) {
                    await launch(playServiceUrl);
                  } else {
                    showToastMessage(message: "Unable to open playstore");
                  }
                } catch (e, s) {
                  showToastMessage(message: "Unable to open playstore");
                  //         FirebaseCrashlytics.instance.recordError(e, s,
                  //           reason:
                  //         "Unable to open playstore for playService update");
                }
              },
            );
          case installPlayServiceDialog:
            return DialogBoxWithOneAction(
              title: "Install Google PlayService",
              actionTitle: "Install",
              action: () async {
                try {
                  if (await canLaunch(playServiceUrl)) {
                    await launch(playServiceUrl);
                  } else {
                    showToastMessage(message: "Unable to open playstore");
                  }
                } catch (e, s) {
                  showToastMessage(message: "Unable to open playstore");
                  //        FirebaseCrashlytics.instance.recordError(e, s,
                  //          reason:
                  //        "Unable to open playstore for playService update");
                }
              },
            );
            break;
          case cannotSaveMoreMix:
            return DialogBoxTwoActions(
              title:
                  "Free users can save only 2 mixes.\nSubscribe to save more. ",
              cancelActionTitle: "Cancel",
              proceedActionTitle: "Subscribe",
              alignType: DialogBoxAlignType.COLUMN,
              proceedAction: () async {
                recordAnalyticsToSubscriptionPage(
                    source: "try to save more than 2 coposition mix");
                locator<NavigationService>().navigationKey.currentState.pop();
                locator<NavigationService>()
                    .navigationKey
                    .currentState
                    .push(CupertinoPageRoute(builder: (_) => GetPremium()));
              },
              cancelAction: () {
                locator<NavigationService>().navigationKey.currentState.pop();
              },
            );

            break;

          // case premiumTrack:
          //   locator<NavigationService>()
          //       .navigationKey
          //       .currentState
          //       .push(CupertinoPageRoute(builder: (_) => SubscriptionPage()));
        }
      });
}

getTextSize(String text, TextStyle style) {
  final TextPainter painter = TextPainter(
    text: TextSpan(text: text, style: style),
    maxLines: 1,
    textDirection: TextDirection.ltr,
  );

  painter.layout(minWidth: 0.0, maxWidth: double.infinity);
  return painter.size;
}

getSecondsFromDurationString(String duration) {
  var list = duration.split(":");

  if (list.isNotEmpty) {
    var seconds = double.parse(list[0]) * 60 * 60 +
        double.parse(list[1]) * 60 +
        double.parse(list[2]);

    return seconds;
  } else {
    return 0.0;
  }
}

recordNavigationAnalytics(
    {String source, String destination, String pageEventName}) {
//  final _fbEvent = FacebookAppEvents();
}

recordAnalyticsToSubscriptionPage({String source}) {
  // FirebaseAnalytics().logEvent(name: "subsribe_page_visit", parameters: {
  // "navigation_from": source,
  // });
}

navigateToSinglePlayerOnly(
    BuildContext context, bool fromPlayList, String analyitcsString) {
  Navigator.of(context).push(CupertinoPageRoute(
    builder: (BuildContext context) {
      return SingplePlayerRedesign(
        fromPlaylist: fromPlayList,
      );
    },
    settings: RouteSettings(name: analyitcsString),
  ));
}

Future<bool> checkIfMusicFileExists(filename) async {
  // var downloadPath = await getDatabasesPath();
  // var downloadedLocation = downloadPath + '/$filename';
  Directory directory = await getApplicationDocumentsDirectory();

  String initialPath =
      Platform.isAndroid ? directory.parent.path : directory.path;
  var tempPath = join(initialPath, 'files', 'sounds');
  Directory dir = Directory(tempPath);
  String path = join(
    dir.path,
    filename,
  );

  // File file = File(downloadedLocation);
  File file = File(path);
  bool doFileExists = await file.exists();

  return doFileExists;
}

bool willTextOverFlow({
  @required String mytext,
  @required TextStyle style,
  @required double width,
  @required int maxLine,
  TextAlign textAlign = TextAlign.left,
  @required BuildContext context,
}) {
  final textScaleFactor = MediaQuery.textScaleFactorOf(context);
  final textHeightBehaviour = DefaultTextStyle.of(context).textHeightBehavior;
  final textWidthBasis = TextWidthBasis.parent;
  var span = TextSpan(
    text: mytext,
    style: style,
  );
  var tp = TextPainter(
    maxLines: maxLine,
    textAlign: textAlign,
    textDirection: TextDirection.ltr,
    text: span,
    textScaleFactor: textScaleFactor,
    textHeightBehavior: textHeightBehaviour,
    textWidthBasis: textWidthBasis,
  );
  tp.layout(maxWidth: width);
  var exceeded = tp.didExceedMaxLines;
  return exceeded;
}

navigateToMusicPlayer(BuildContext context, Track track,
    {String sourcePage,
    bool fromPlayList = false,
    bool isFromNotifications = false}) async {
  final musicService = locator<MusicService>();
  if (sourcePage != null) {
    recordNavigationAnalytics(
      pageEventName: "player_page_visit",
      source: sourcePage,
      destination: "player page",
    );
  }

  if (isFromNotifications) {
    navigateToSinglePlayerOnly(
        context, false, sourcePage ?? 'Single player page from notifications');
    return;
  }

  if (track.showTimer) {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (_) {
          if (musicService.playingAudio != null) {
            musicService.stopTimer();
          }

          return TimerDialogBox(
            isFromInterMediatePage: true,
            sourcePage: sourcePage,
            isFromPlaylist: fromPlayList,
          );
        });

    //     .then((res) {
    //   navigateToSinglePlayerOnly(
    //       context, fromPlayList, 'Single player page from $sourcePage');
    // });
  } else {
    navigateToSinglePlayerOnly(
        context, fromPlayList, 'Single player page from $sourcePage');
  }
}

Future<bool> returnFalse() async {
  return false;
}

preFetchHomePageItems(BuildContext context) async {
//  recordCrashlyticsLog("Prefetching homepage list items");

  BlocProvider.of<DynamichomepagewidgetBloc>(context).add(FetchTracks());

  BlocProvider.of<RitualsBloc>(context).add(FetchRitualsPlaylists());
  BlocProvider.of<SettingsBloc>(context).add(FetchSettings());
}

double getFontSize(BuildContext context, var size) {
  final fontSize = ResponsiveFlutter.of(context).fontSize(1);
  if (fontSize < 12) {
    return ResponsiveFlutter.of(context).fontSize(size);
  } else {
    return ResponsiveFlutter.of(context).fontSize(size - 0.5);
  }
}

NativeAdmobOptions get getNativeAdmobOption => NativeAdmobOptions(
      bodyTextStyle: NativeTextStyle(color: Colors.white),
      adLabelTextStyle: NativeTextStyle(color: Colors.white),
      advertiserTextStyle: NativeTextStyle(color: Colors.white),
      headlineTextStyle: NativeTextStyle(color: Colors.white),
      callToActionStyle: NativeTextStyle(color: Colors.white),
      priceTextStyle: NativeTextStyle(color: Colors.white),
      storeTextStyle: NativeTextStyle(color: Colors.white),
    );

bool getBoolFromInt(int numb) {
  return numb == 1;
}

Duration getDurationFromDouble(double duration) {
  return Duration(milliseconds: duration.floor() * 1000);
}

trimDownloadFilename(String filename) {
  if (filename.length > 50) {
    /// i,.e get file extension from full filename and  append file extension .mp3, .ogg afterwards
    var extensionType = filename.substring(filename.length - 4);

    return filename.substring(0, 50).trim() + extensionType;
  } else {
    return filename;
  }
}

String removeAllHtmlTags(String htmlText) {
  RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

  return htmlText.replaceAll(exp, '');
}

Future<Duration> getLastPlayedDurationOfTrack(Track item) async {
  Database db = await DatabaseService().db;
  var dbRes = await db.rawQuery(
      '''select "played_duration","completion_status" from "rituals_table" where id=${item.id}''');

  var playedDuration = 0.0;

  if (dbRes != null && dbRes.isNotEmpty) {
    playedDuration = double.tryParse(dbRes.first['played_duration'].toString());

    if (dbRes.first[DatabaseService.Column_completion_status] ==
        CompletionStatus.Complete.toString()) {
      return Duration.zero;
    } else {
      var _duration = getDurationFromDouble(playedDuration);
      return _duration;
    }
  } else {
    return Duration.zero;
  }
}

bool isTrackLockedForDay(int index, PlayList playlist, Track track) {
  var _unlockDate = track.unlockDate;
  var _current = DateTime.now();

  if (index == 0) {
    return false;
  } else {
    if (_unlockDate != null) {
      if (_current.isAfter(_unlockDate)) {
        return false;
      } else {
        var _diff = _unlockDate.difference(_current).inDays;
        return _diff != 0;
      }
    } else {
      return track.unlocked ?? true;
    }
  }
}

getReadableHourMinute(String duration) {
  var _list = duration.split(':');

  var _hr = int.parse(_list[0]);
  var _min = int.parse(_list[1]);

  if (_hr == 0) {
    return '$_min MIN';
  } else if (_hr != 0 && _min != 0) {
    return '$_hr HR $_min MIN';
  } else if (_hr != 0 && _min == 0) {
    return '$_hr HR';
  } else {
    return '';
  }
}

navigateToSubsPage(String sourcePage) {
  recordAnalyticsToSubscriptionPage(source: sourcePage);

  locator<NavigationService>()
      .navigationKey
      .currentState
      .push(CupertinoPageRoute(builder: (_) => GetPremium()));
}

datediff(Track track) {
  var _unlockDate = track.unlockDate;
  var _current = DateTime.now();

  if (_unlockDate != null) {
    var _diff = _unlockDate.difference(_current).inDays;
    if (_diff != 0) {
      if (_diff == 1) {
        return 'tomorrow';
      } else {
        return 'in ${_diff - 1} days';
      }
    }
  }
}

bool checkIfRitualTrackIsCurrentDay(PlayList playlist, int index) {
  var stat = playlist.playableStat;

  if (stat.status == CompletionStatus.NonStarted) {
    return index == 0;
  } else {
    return index == getCurrentDayForRituals(playlist);
  }
}
