import 'dart:collection';
import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart' as Foundation;
import 'package:goodvibesoffl/locator.dart';
import 'package:goodvibesoffl/models/adsModel.dart';
import 'package:goodvibesoffl/models/app_update_model.dart';
import 'package:goodvibesoffl/models/introConfig.dart';
import 'package:goodvibesoffl/models/login_text_model.dart';
import 'package:goodvibesoffl/models/uiConfig.dart';
import 'package:goodvibesoffl/services/adsModelService.dart';
import 'package:goodvibesoffl/services/services.dart';
import 'package:goodvibesoffl/services/shared_pref_service.dart';
import 'package:goodvibesoffl/utils/remote_config_constants.dart';
import 'package:goodvibesoffl/utils/utils.dart';

const String _LoginText = "login_text";
const String _AdsInfoText = "admob_config";
const String _AppUpdateConfig = "configs";
const String _UiConfig = 'ui_config';
const String _IntroConfig = 'intro_offer';

class RemoteConfigService {
  final RemoteConfig _remoteConfig;

  static RemoteConfigService _instance;

  static Future<RemoteConfigService> getInstance() async {
    if (_instance == null) {
      _instance = RemoteConfigService(
        remoteConfig: await RemoteConfig.instance,
      );
    }

    return _instance;
  }

  RemoteConfigService({RemoteConfig remoteConfig})
      : _remoteConfig = remoteConfig;

  List<LoginTextModel> _loginTextModel = [];
  AppUpdateModel _appUpdateModel;

  AppUpdateModel get appUpdateModel => _appUpdateModel;
  bool _isLoaded = false;

  UIConfig _uIConfig;

  UIConfig get uIConfig => _uIConfig;

  IntroOfferConfig _introOfferConfig;

  IntroOfferConfig get introOfferConfig => _introOfferConfig;

  static final Map<String, dynamic> _appUdateDefaultConfig = {
    "app_version": {
      "iOS": {
        "is_force": false,
        "version": "",
        "updated_at": "",
        "whats_new": ""
      },
      "android": {
        "is_force": false,
        "version": "",
        "updated_at": "",
        "whats_new": ""
      }
    }
  };

  static final Map<String, dynamic> _uiRemoteconfigDefaultData = {
    'promos': {'android': false, 'ios': false}
  };
  static final Map<String, dynamic> intro_offer_ui_config = {
    "intro_offer_ui_config": {"ios": false, "android": false}
  };
  static final _introPriceConfig = {'ios': false, 'android': false};

  final defaults = <String, dynamic>{
    _LoginText: json.encode([
      {
        "text": "Binaural Beats",
        "description": "Listen more than 500+ Binaural Sound tracks"
      },
      {
        "text": "Meditation",
        "description":
            "Meditation is the key to Productivity, Happiness & Longevity"
      },
      {
        "text": "Enjoy Offline",
        "description": "Access your favorite Music anytime"
      },
    ]),
    _AdsInfoText: json.encode({
      "banner": true,
      "reward": true,
      "interstitial": true,
      "ad_after_tracks": -1
    }),
    _AppUpdateConfig: json.encode(_appUdateDefaultConfig),
    _UiConfig: json.encode(_uiRemoteconfigDefaultData),
    _IntroConfig: json.encode(_introPriceConfig),
    INTRO_UI_CONFIG: INTRO_UI_CONFIG_DEFAULT_VALUE
  };
  final List<LoginTextModel> defaultTextModel = [
    LoginTextModel(
        text: "Binaural Beats",
        description: "Listen more than 500+ Binaural Sound tracks"),
    LoginTextModel(
        text: "Meditation",
        description:
            "Meditation is the key to Productivity, Happiness & Longevity"),
    LoginTextModel(
        text: "Enjoy Offline",
        description: "Access your favorite Music anytime")
  ];

  List<LoginTextModel> get loginTextData =>
      UnmodifiableListView(_loginTextModel);

  Future initialise() async {
    try {
      await _remoteConfig.setDefaults(defaults);
      await _fetchAndActivate();

      fetchRemoteConfig();

      /// getting login screen data
      List<dynamic> data = json.decode(_remoteConfig.getString(_LoginText));
      _loginTextModel = data.map((i) => LoginTextModel.fromJson(i)).toList();

      /// getting ads info data from remote config

      Map<String, dynamic> adsInfo =
          json.decode(_remoteConfig.getString(_AdsInfoText));

      /// shared pref setup for ads after count remote config
      var _aftercount = adsInfo["ad_after_tracks"];

      /// -1 is default value for `ad_after_tracks`
      /// so look for shared pref, if latest remote config is not fetched
      if (_aftercount == -1) {
        var _adsAfterCountFromSPref =
            await SharedPrefService().getAdAfterCount() ??
                -1; // if there is no data in shared pref se value to -1

        if (_adsAfterCountFromSPref != -1) {
          _aftercount = _adsAfterCountFromSPref;
        } // set value from shard pref
        else {
          _aftercount = 3;
        } // 3 is the defualt value, if no data in shared pref
      } else {
        await SharedPrefService().setAdsAfterCount(_aftercount);
      }

      /// set value to map's key which is used for serializing
      adsInfo["ad_after_tracks"] = _aftercount;
      locator<AdsModelService>().adsData = AdsModel.fromJson(adsInfo);

      /// gettting udpate data
      var _updateData = json.decode(_remoteConfig.getString(_AppUpdateConfig));

      AppUpdateModel appUpdateData = AppUpdateModel.fromJson(_updateData);

      _appUpdateModel = appUpdateData;

      /// ui config
      ///
      var _uiRemoteConfig = json.decode(_remoteConfig.getString(_UiConfig));

      _uIConfig = UIConfig.fromJson(_uiRemoteConfig['promos']);

      dPrint(_uiRemoteConfig);

      /// intro config

      var _introConfigData = json.decode(_remoteConfig.getString(_IntroConfig));
      _introOfferConfig = IntroOfferConfig.fromJson(_introConfigData);

      dPrint(_introConfigData);
    } on FetchThrottledException catch (exception) {
      dPrint('Remote config fetch throttled: $exception');
    } catch (exception) {
      dPrint(
          'Unable to fetch remote config. Cached or default values will be used');
    }
  }

  fetchRemoteConfig() {
    var introUiConfig = _remoteConfig.getString(INTRO_UI_CONFIG);
    print(introUiConfig);

    //todo add to state management model
  }

  _fetchAndActivate() async {
    try {
      if (Foundation.kReleaseMode) {
        try {
          await _remoteConfig.fetch(expiration: const Duration(hours: 8));
          await _remoteConfig.activateFetched();
        } catch (e) {
          dPrint(e.toString());
        }
      } else {
        try {
          await _remoteConfig.fetch(expiration: const Duration(hours: 8));
          await _remoteConfig.activateFetched();
        } catch (e) {
          dPrint(e.toString());
        }
      }
    } catch (e) {
      dPrint(e.toString());
    }
  }

  bool get isLoaded => _isLoaded;
}
