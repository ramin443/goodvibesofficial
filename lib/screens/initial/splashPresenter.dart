import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:goodvibesoffl/services/remote_config_service.dart';

class SplashPresenter {
  BuildContext _context;

  SplashPresenter(this._context);

  onSplashStart() async {
    final RemoteConfig remoteConfig = await RemoteConfig.instance;
    RemoteConfigService remoteConfigService =
        RemoteConfigService(remoteConfig: remoteConfig);
    await remoteConfigService.initialise();
  }
}

