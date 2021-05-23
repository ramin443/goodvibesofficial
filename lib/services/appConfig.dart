import 'dart:io';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/widgets.dart';
import 'package:goodvibesoffl/locator.dart';
import 'package:goodvibesoffl/providers/notification_provider.dart';
import 'package:goodvibesoffl/services/adsManagerService.dart';
import 'package:goodvibesoffl/services/interstitialAdsService.dart';
import 'package:goodvibesoffl/utils/common_functiona.dart';
import 'package:goodvibesoffl/utils/strings/ads_ids_strings.dart';
import 'package:google_api_availability/google_api_availability.dart';
import 'package:rxdart/rxdart.dart';

enum PlayServiceStatus {
  Available,
  Unavailable,
  OutDated,
  Disabled,
}

class AppConfig {
  static final AppConfig _appConfig = AppConfig._internal();

  static bool _isTablet = false;
  static double _width;
  static double _height;

  static const int _freeUserDownloadsDeleteAfter = 30;

  static PlayServiceStatus _playServiceAvailable =
      PlayServiceStatus.Unavailable;
  static bool _enableFirebase = false;
  factory AppConfig() {
    return _appConfig;
  }

  AppConfig._internal();

  Future<void> initPlayService(bool showDialogBox) async {
    if (Platform.isAndroid) {
      GooglePlayServicesAvailability availability = await GoogleApiAvailability
          .instance
          .checkGooglePlayServicesAvailability(showDialogBox);

      switch (availability) {
        case GooglePlayServicesAvailability.notAvailableOnPlatform:
        case GooglePlayServicesAvailability.serviceMissing:
        case GooglePlayServicesAvailability.serviceInvalid:
        case GooglePlayServicesAvailability.unknown:
          _playServiceAvailable = PlayServiceStatus.Unavailable;
          break;
        case GooglePlayServicesAvailability.serviceDisabled:
          _playServiceAvailable = PlayServiceStatus.Disabled;
          break;
        case GooglePlayServicesAvailability.serviceVersionUpdateRequired:
        case GooglePlayServicesAvailability.serviceUpdating:
          _playServiceAvailable = PlayServiceStatus.OutDated;
          break;
        case GooglePlayServicesAvailability.success:
          _playServiceAvailable = PlayServiceStatus.Available;
          _enableFirebase = true;

          break;
        default:
          _playServiceAvailable = PlayServiceStatus.Unavailable;
      }
    } else {
      _playServiceAvailable = PlayServiceStatus.Available;
      _enableFirebase = true;
    }
  }

  init(BuildContext context) {
    _isTablet = MediaQuery.of(context).size.width > 600;
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
  }

  Future<bool> enableFirebaseServices() async {
    if (_enableFirebase &&
        _playServiceAvailable == PlayServiceStatus.Available) {
      await Firebase.initializeApp();

      locator<NotificationProvider>().initialiseFCM();

      FirebaseAdMob.instance.initialize(
        appId: getAdsAppID,
      );
      var res =
      await FirebasePerformance.instance.isPerformanceCollectionEnabled();

      if (!res)
        FirebasePerformance.instance.setPerformanceCollectionEnabled(true);

      RewardedVideoAd.instance
          .load(adUnitId: getRewardID, targetingInfo: adtargetingInfo);
      RewardedVideoAd.instance.listener =
          (RewardedVideoAdEvent event, {String rewardType, int rewardAmount}) {
        if (event == RewardedVideoAdEvent.loaded) {
          locator<RewardStatus>().status = RewardVideoStatus.LOADED;
          locator<BehaviorSubject<RewardVideoStatus>>()
              .add(RewardVideoStatus.LOADED);
        } else if (event == RewardedVideoAdEvent.rewarded) {
          locator<BehaviorSubject<RewardVideoStatus>>()
              .add(RewardVideoStatus.REWARDED);
        } else if (event == RewardedVideoAdEvent.completed ||
            event == RewardedVideoAdEvent.closed) {
          locator<BehaviorSubject<RewardVideoStatus>>()
              .add(RewardVideoStatus.CLOSED);
          RewardedVideoAd.instance
              .load(adUnitId: getRewardID, targetingInfo: adtargetingInfo);
        } else if (event == RewardedVideoAdEvent.started) {
          locator<RewardStatus>().status = RewardVideoStatus.NOTLOADED;
          locator<AdsManagerService>().rewardAdsShown = true;
        }
      };
      InterstitialAdsService().reload();
      _enableFirebase = true;
      return true;
    } else {
      return false;
    }
  }

  static bool get isTablet => _isTablet;
  static double get width => _width;
  static double get height => _height;
  static int get freeUserDownloadsDeleteAfter => _freeUserDownloadsDeleteAfter;

  static PlayServiceStatus get isPlayServiceAvailable => _playServiceAvailable;
}
