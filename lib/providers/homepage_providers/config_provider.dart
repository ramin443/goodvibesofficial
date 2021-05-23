import 'package:goodvibesoffl/services/api_service.dart';
import 'package:goodvibesoffl/utils/strings/string_constants.dart';

import '../../locator.dart';

class ConfigProvider {
  String _count;
  int _unopen_notif;
  String _playstoreAppVersion = "";
  String get playstoreAppVersion => _playstoreAppVersion;

  String get count => _count;
  int get unopenNotif => _unopen_notif;

  bool _hasError = false;
  bool get hasError => _hasError;
  bool _isBusy = false;
  bool get isBusy => _isBusy;
  String error = "";

  getCofig() async {
    _isBusy = true;
    Map response = await locator<ApiService>().getConfig();

    if (response == null) {
      _hasError = true;
      error = some_error_occured;
    } else if (response.containsKey("error")) {
      _hasError = true;
      error = response["error"];
    } else if (response.containsKey("data")) {
      var count = response["data"]["meditating_now"].toString();

      // TODO: to use the actual key for play store version
      _playstoreAppVersion = response["data"]["meditating_now"].toString();

      if (count.contains(".")) {
        _count = count.split(".").first;
      } else {
        _count = count;
      }

      _unopen_notif = response["data"]["unseen_notifications"];
    }
    _isBusy = false;
  }
}
