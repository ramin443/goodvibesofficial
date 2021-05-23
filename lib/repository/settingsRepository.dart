import 'package:flutter/cupertino.dart';
import 'package:goodvibesoffl/models/settings_model.dart';
import 'package:goodvibesoffl/models/user_model.dart';
import 'package:goodvibesoffl/providers/login_provider.dart';
import 'package:goodvibesoffl/services/api_service.dart';
import 'package:goodvibesoffl/services/database_service.dart';
import 'package:goodvibesoffl/services/login_dialog_service.dart';
import 'package:goodvibesoffl/services/user_service.dart';
import 'package:goodvibesoffl/utils/common_functiona.dart';
import 'package:goodvibesoffl/utils/strings/string_constants.dart';

import '../locator.dart';

class SettingsRepository {
  static final SettingsRepository _settingsRepository =
      SettingsRepository._internal();

  factory SettingsRepository() {
    return _settingsRepository;
  }

  SettingsRepository._internal();

  SettingsModel _settings;
  bool _hasNotificationSettingToggleError = false;
  bool _isSettingsFetched = false;
  String _notificationToggleError = "";
  Map notificationMap = {};

  getSettings() async {
    bool isOffline = await checkIfOffline();

    ///// we fetch settings from api only once in a session
    /// because every time we update notification settings or user, the same settings object is returned
    /// after the first time, we fetch settigs from the database
    if (!isOffline) {
      // await _getSettingsFromApi();

      // if (!_isSettingsFetched) {
      //   await _getSettingsFromApi();
      //   await DatabaseService().insertIntoSettingsTable(_settings);
      // } else {
      //   await _getSettingsFromDatabase();
      // }

      await getSettingsFromApi();
      await DatabaseService().insertIntoSettingsTable(_settings);

      // print(response);
    } else {
      await _getSettingsFromDatabase();
    }
  }

  _updateSettingsTable(SettingsModel settings) async {
    await DatabaseService().updateSettings(settings);
  }

  getSettingsFromApi({BuildContext context}) async {
    Map response = await locator<ApiService>().getSettings();

    if (response == null) {
    } else if (response.containsKey("error")) {
      _getSettingsFromDatabase();
      //if reponse has error
    } else if (response.containsKey("data")) {
      _settings = SettingsModel.fromJson(response["data"]);

      if (_settings != null) {
        var _user = locator<UserService>().user.value;

        var userplanType = getUserPlanType(plan: settings.plan.trim());

        locator<UserService>().user.value.paid = _settings.paid;

        locator<UserService>().user.value = _user.copyWith(
            paid: _settings.plan.toLowerCase() == "free" ? false : true,
            plan: _settings.plan,
            dob: _settings.dob,
            userPlanType: userplanType,
            country: _settings.country,
            gender: _settings.gender ?? _user.gender,
            isEligibleForIntroPrice: _settings.isEligibleForIntroPrice);

        locator<LoginProvider>()
            .updateUserTable(user: locator<UserService>().user.value);
      }

      _updateSettingsTable(_settings);

      notificationMap["daily_updates_push"] = _settings.dailyUpdatesPush;
      notificationMap["offers_push"] = settings.offersPush;
      notificationMap["others_push"] = settings.othersPush;

      // settings is settings fetcehd to false so that fetching from api is not repeated
      _isSettingsFetched = true;
      // print(response);
    }
  }

  _getSettingsFromDatabase() async {
    Map response = await DatabaseService().getSettings();
    // print(response);
    if (response != null) {
      _settings = SettingsModel();
      _settings = SettingsModel.fromDb(Map<String, dynamic>.from(response));

      // prin
      // print(_settings.email);

      ///updating values in hash map which will be used in toggling notificaiton settings
      notificationMap["daily_updates_push"] = _settings.dailyUpdatesPush;
      notificationMap["offers_push"] = settings.offersPush;
      notificationMap["others_push"] = settings.othersPush;
    }
  }

  // _updateSettingsVariable() {
  //   _settings.dailyUpdatesPush = notificationMap["daily_updates_push"];
  //   _settings.offersPush = notificationMap["offers_push"];
  //   _settings.othersPush = notificationMap["others_push"];
  // }

  updateNotificationSettings({BuildContext context}) async {
    bool isOffline = await checkIfOffline();

    if (isOffline) {
      locator<DialogService>().showOfflineDialog(context: context);
    } else {
      _settings.dailyUpdatesPush = notificationMap["daily_updates_push"];
      _settings.offersPush = notificationMap["offers_push"];
      _settings.othersPush = notificationMap["others_push"];

      final response = await locator<ApiService>()
          .updateNotificationSttings(body: notificationMap);

      if (response == null) {
        _hasNotificationSettingToggleError = true;
        _notificationToggleError = some_error_occured;
      } else if (response.containsKey("error")) {
        _hasNotificationSettingToggleError = true;
        _notificationToggleError = response["error"];
      } else if (response.containsKey("data")) {
        _settings = SettingsModel.fromJson(response["data"]);

        _updateSettingsTable(_settings);
      }
      // print(response);
    }
  }

  String get notificationToggleError => _notificationToggleError;
  bool get hasNotificationToggleError => _hasNotificationSettingToggleError;
  SettingsModel get settings => _settings;
}
