import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:goodvibesofficial/services/api_service.dart';
import 'package:goodvibesofficial/services/connectivity_service.dart';
import 'package:goodvibesofficial/services/session_service.dart';
import 'package:rxdart/rxdart.dart';

GetIt locator = GetIt.instance;

enum NotifInitializationStatus {
  UNINITIALIZED,
  INITIALIZED,
  PATRIALINITIALIZED,
}

enum RewardVideoStatus { LOADED, NOTLOADED, REWARDED, CLOSED }

class RewardStatus {
  RewardVideoStatus status = RewardVideoStatus.NOTLOADED;
}

class IsInitizalise {
  NotifInitializationStatus isInitialize =
      NotifInitializationStatus.UNINITIALIZED;
}
Future<void> setupLocator(
    BehaviorSubject<String> selectNotificationSubject,
    BehaviorSubject<ThemeData> appThemeDataStream,
    BehaviorSubject<RewardVideoStatus> rewardedStatusStream,
    ) async {

  locator.registerLazySingleton(() => ApiService());
  locator.registerLazySingleton(() => selectNotificationSubject);
 // locator.registerLazySingleton(() => LoginProvider());
  locator.registerFactory(() => ConnectivityService());
  locator.registerLazySingleton(() => SessionService());
  locator.registerLazySingleton(() => IsInitizalise());
  locator.registerLazySingleton(() => RewardStatus());
  locator.registerLazySingleton(() => appThemeDataStream);
  locator.registerLazySingleton(() => rewardedStatusStream);

}
