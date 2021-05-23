import 'dart:async';

import 'package:goodvibesoffl/models/app_update_model.dart';
import 'package:goodvibesoffl/services/remote_config_service.dart';

import 'package:version/version.dart';

import '../locator.dart';
import 'app_version.dart';

class AppUpdateService {
  // AppUpdateModel appUpdateData;

  StreamController<AppUpdateModel> appUpdateStream =
      StreamController<AppUpdateModel>.broadcast();

  initUpdateService() async {
    var appUpdateData = locator<RemoteConfigService>().appUpdateModel;

    var _currentVersion = AppVersion().appVersion;
    var _versionFromConfig = appUpdateData?.version;

    if (_currentVersion != "" &&
        _versionFromConfig != "" &&
        _versionFromConfig != null) {
      var currentVersion = Version.parse(_currentVersion);
      var versionFromConfig = Version.parse(_versionFromConfig);

      if (currentVersion < versionFromConfig) {
        // only update now

        appUpdateStream.add(appUpdateData);
      }
    }
  }
}
