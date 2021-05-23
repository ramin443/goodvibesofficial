import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:goodvibesoffl/providers/favorites_provider.dart';
import 'package:goodvibesoffl/providers/genre_provider.dart';
import 'package:goodvibesoffl/providers/homepage_providers/config_provider.dart';
import 'package:goodvibesoffl/providers/homepage_providers/recommend_dialog_provider.dart';
import 'package:goodvibesoffl/providers/homepage_providers/what_brings_you_provider.dart';
import 'package:goodvibesoffl/providers/login_provider.dart';
import 'package:goodvibesoffl/providers/music_providers/composer_provider.dart';
import 'package:goodvibesoffl/providers/music_providers/genre_songs_provider.dart';
import 'package:goodvibesoffl/providers/music_providers/music_repository.dart';
import 'package:goodvibesoffl/providers/notification_provider.dart';
import 'package:goodvibesoffl/providers/reminder_db_provider.dart';
import 'package:goodvibesoffl/providers/search_provider.dart';
import 'package:goodvibesoffl/providers/startup_provider.dart';
import 'package:goodvibesoffl/services/adsManagerService.dart';
import 'package:goodvibesoffl/services/adsModelService.dart';
import 'package:goodvibesoffl/services/api_service.dart';
import 'package:goodvibesoffl/services/app_update_service.dart';
import 'package:goodvibesoffl/services/composer_service.dart';
import 'package:goodvibesoffl/services/connectivity_service.dart';
import 'package:goodvibesoffl/services/dynamic_link_service.dart';
import 'package:goodvibesoffl/services/login_dialog_service.dart';
import 'package:goodvibesoffl/services/navigation_service.dart';
import 'package:goodvibesoffl/services/player_service.dart';
import 'package:goodvibesoffl/services/remote_config_service.dart';
import 'package:goodvibesoffl/services/session_service.dart';
import 'package:goodvibesoffl/services/user_service.dart';

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
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => StartupProvider());
  locator.registerLazySingleton(() => MusicService());
  // locator.registerLazySingleton(() => AdsProvider());
  locator.registerLazySingleton(() => ApiService());
  locator.registerLazySingleton(() => selectNotificationSubject);
  locator.registerLazySingleton(() => LoginProvider());
  //locator.registerLazySingleton(() => PaymentProvider());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => UserService());
  locator.registerLazySingleton(() => ReminderDbProvider());
  locator.registerLazySingleton(() => FavoritesProvider());
  locator.registerLazySingleton(() => FavoriteIconProvider(false));
  locator.registerFactory(() => ConnectivityService());
  //locator.registerLazySingleton(() => MusicProvider());
  locator.registerLazySingleton(() => DynamicLinkService());
  var remoteConfigService = await RemoteConfigService.getInstance();
  locator.registerLazySingleton(() => remoteConfigService);
  locator.registerLazySingleton(() => SessionService());
  locator.registerLazySingleton(() => NotificationProvider());
  locator.registerLazySingleton(() => GenreProvider());
  locator.registerLazySingleton(() => GenreSongsProvider());
  locator.registerLazySingleton(() => SearchProvider());
  locator.registerLazySingleton(() => MusicProvider());
  locator.registerLazySingleton(() => RecommendDialogButtonProvider());
  locator.registerLazySingleton(() => WhatBringYouHereProvider());
 // locator.registerLazySingleton(() => NotificationPageProvider());
  //locator.registerLazySingleton(() => SubscriptionDetailsProvider());
  locator.registerLazySingleton(() => ConfigProvider());
  locator.registerLazySingleton(() => IsInitizalise());
  locator.registerLazySingleton(() => AdsModelService());
  locator.registerLazySingleton(() => AdsManagerService());
  locator.registerLazySingleton(() => RewardStatus());
  locator.registerLazySingleton(() => appThemeDataStream);
  locator.registerLazySingleton(() => rewardedStatusStream);

//  locator.registerLazySingleton(() => InAppService());

  locator.registerLazySingleton(() => ComposerService());
  locator.registerLazySingleton(() => ComposerProvider());
 // locator.registerLazySingleton(() => InviteProvider());

  locator.registerLazySingleton(() => AppUpdateService());

}
