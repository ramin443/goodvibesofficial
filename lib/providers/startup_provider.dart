import 'dart:io';
import 'package:connectivity/connectivity.dart';
//import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:goodvibesoffl/models/music_model.dart';
import 'package:goodvibesoffl/models/user_model.dart';
import 'package:goodvibesoffl/repository/settingsRepository.dart';
import 'package:goodvibesoffl/screens/premium/getpremium.dart';
import 'package:goodvibesoffl/services/api_service.dart';
import 'package:goodvibesoffl/services/app_update_service.dart';
import 'package:goodvibesoffl/services/composer_service.dart';
import 'package:goodvibesoffl/services/appConfig.dart';
import 'package:goodvibesoffl/services/connectivity_service.dart';
import 'package:goodvibesoffl/services/database_service.dart';
import 'package:goodvibesoffl/services/dynamic_link_service.dart';
import 'package:goodvibesoffl/services/navigation_service.dart';
import 'package:goodvibesoffl/services/remote_config_service.dart';
import 'package:goodvibesoffl/services/shared_pref_service.dart';
import 'package:goodvibesoffl/services/user_service.dart';
import 'package:goodvibesoffl/utils/common_functiona.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../routes.dart';

class StartupProvider with ChangeNotifier {
  bool _firstRun;
  bool _isLoggedIn = false;
  bool _networkConnected = false;
  bool isUserDataFetchedInLoginSession = false;
  User _user = User();
  final DynamicLinkService _dynamicLinkService = DynamicLinkService();
  final RemoteConfigService _remoteConfigService =
      RemoteConfigService();

  bool get firstrun => _firstRun;
  bool get networkStatus => _networkConnected;
  User get user => _user;

  handleStartup(context) async {
    recordCrashlyticsLog("starting starup");

    if (AppConfig.isPlayServiceAvailable == PlayServiceStatus.Available)
      await _remoteConfigService.initialise();

    await checkConnectivity();
    ConnectivityService().checkConnectionInitailly();
    await _initAppUserState();
    await getUserData();

    /// to fetch local audio files list during app startup
    // await locator<ComposerService>().loadAudioAssetsFileNames(context);
    await ComposerService().getAndSetDownloadedComposerFileNamesList();

    if (Platform.isIOS) await _dynamicLinkService.handleDynamicLinks();

    if (AppConfig.isPlayServiceAvailable == PlayServiceStatus.Available)
      await _dynamicLinkService.handleDynamicLinks();

    // check login in status of user
    await checkLoginStatus();

    /// if login is is true, pre fetch homepages items
    /// otherwise handle navigation as usual i.e is go to login page or show offline page
    if (isLoggedIn) {
      await preFetchHomePageItems(context);
    } else {
      handleStartupNavigation();
    }
  }

  checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      // _navigationToSpecifiedRoute(offline_page);
      _networkConnected = false;
    } else {
      _networkConnected = true;
    }

    notifyListeners();
    return _networkConnected;
  }

  bool get isLoggedIn => _isLoggedIn;

  Future<bool> checkLoginStatus() async {
    bool res = await SharedPrefService().getIsLoggedIn() ?? false;
    _isLoggedIn = res;
  }

  _initAppUserState() async {
    var fr = await SharedPrefService().getFirstRunStatus();
    if (fr == null) {
      _firstRun = true;
      SharedPrefService().setFirstRunStatus(false);
    } else {
      _firstRun = false;
      SharedPrefService().setFirstRunStatus(false);
    }

    notifyListeners();
  }

  Future<User> getUserData() async {
    recordCrashlyticsLog("Gettting user data during startup");
    List<Map<String, dynamic>> _userData;
    try {
      _userData = await DatabaseService().getUser();

      if (_userData.isNotEmpty) {
        _user = User.fromDB(_userData.first);
        bool migrationStatus = await SharedPrefService().getMigrationStatus;
        if (migrationStatus == null) {
          SharedPrefService().setMigrationStatus(true);
          migrationStatus = true;
        }
        if (!migrationStatus) {
          getDownloadMigration();
        }
       UserService().user.value = _user;
        _isLoggedIn = _user.isLoggedIn;

        await SettingsRepository().getSettings();

        return _user;
      } else {
        bool isLoggedIn = await SharedPrefService().getIsLoggedIn() ?? false;
        if (!isLoggedIn) {
          _user = null;
          UserService().user.value = _user;
          _isLoggedIn = false;
          return _user;
        } else {
          final token = await SharedPrefService().getUserBearerToken();
          if (token != null) {
            await SharedPrefService().setMigrationStatus(false);
          }

          UserService().user.value = User(authToken: token);

          final Map res = await ApiService().getSettings();
          if (res.containsKey("data")) {
            _user = User(
              authToken: token,
              uid: res["data"]["id"].toString(),
              address: res["data"]["address"] ?? "",
              email: res["data"]["email"] ?? "",
              isLoggedIn: true,
              paid: res["data"]["paid"] ?? false,
              passwordSet: res["data"]["password_set"] ?? false,
              city: res["data"]["city"],
              freeTrial: res["data"]["free_trail"] ?? false,
              country: res["data"]["country"],
              dob: res["data"]["dob"],
              image: res["data"]["user_image"],
              name: res["data"]["full_name"],
              state: res["data"]["state"],
              type: res["data"]["login_type"],
              plan: res['data']['plan'],
              userPlanType: getUserPlanType(plan: res['data']['plan']),
              gender: res['data']['gender'],
            );
            UserService().user.value = _user;
            await getDownloadMigration();
            await DatabaseService().insertIntoUserTable(_user);
            await SharedPrefService().clearUserEntriesOnLogout();
            _isLoggedIn = _user.isLoggedIn;
            return _user;
          } else {
            _user = null;
           UserService().user.value = _user;
            _isLoggedIn = false;
            return _user;
          }
        }
      }
    } catch (e) {
      _userData = [];
      _user = null;
      UserService().user.value = _user;
      _isLoggedIn = false;
      return _user;
    }
  }

  getDownloadMigration() async {
    recordCrashlyticsLog("Gettting download migration");
    try {
      final download = await DatabaseService().getDownloads();
      final List<Track> downloadList =
          download.map((e) => Track.fromDb(e)).toSet().toList();
      if (downloadList.isEmpty) return;
      final res = await ApiService().getDownloads();
      List<Track> apiDownloadedTrack = [];
      if (res != null && res.containsKey("data")) {
        apiDownloadedTrack = (res['data'] as List)
            .map<Track>((value) => Track.fromDownloadJson(value))
            .toSet()
            .toList();
        await SharedPrefService().setMigrationStatus(true);
      } else {
        await SharedPrefService().setMigrationStatus(false);
        return;
      }
      Directory directory = await getApplicationDocumentsDirectory();
      String initialPath =
          Platform.isAndroid ? directory.parent.path : directory.path;
      var path = join(initialPath, 'files', 'sounds');
      await Directory(path).create(recursive: true);
      final dbPath = await getDatabasesPath();
      for (int i = 0; i < downloadList.length; i++) {
        var trackFile = File(
          getRelativeFilePath(downloadList[i].url, dbPath),
        );
        if (trackFile.existsSync()) {
          recordCrashlyticsLog("Moving  migration  files");
          File tempFile =
              await moveFile(trackFile, join(path, downloadList[i].filename));
          if (tempFile.existsSync()) {
            int index = apiDownloadedTrack
                .indexWhere((element) => element.id == downloadList[i].id);
            if (index != -1) {
              DatabaseService().removedAndInsertTrackInDownloadTable(
                track: apiDownloadedTrack[index].copyWith(
                  downloaded: 1,
                  url: tempFile.path,
                ),
              );
            } else {
              DatabaseService().deleteDownloadItem(trackId: downloadList[i].id);
            }
          }
        } else {
          int index = apiDownloadedTrack
              .indexWhere((element) => element.id == downloadList[i].id);
          if (index != -1) {
            DatabaseService().removedAndInsertTrackInDownloadTable(
              track: apiDownloadedTrack[index].copyWith(
                downloaded: 0,
              ),
            );
          } else {
            DatabaseService().deleteDownloadItem(trackId: downloadList[i].id);
          }
        }
      }
    } catch (e, s) {
      // }
 //     final _crashLytics = FirebaseCrashlytics.instance;
   //   if (_user != null) {
     //   await _crashLytics.setUserIdentifier(_user.email);
       // await _crashLytics.setUserIdentifier(_user.name);
//      }
  //    await _crashLytics.recordError(e, s,
    //      reason: "Email: ${_user.email} Name: ${_user.name}");
      //return;
    }
  }

  String getRelativeFilePath(String url, String docsPath) {
    if (Platform.isIOS) {
      var fileOnlyName;
      if (url.isNotEmpty) {
        var split = url.split("/");
        fileOnlyName = split.last;
      }
      var temp = join(docsPath, fileOnlyName);
      return temp;
    } else
      return url;
  }

  Future<File> moveFile(File sourceFile, String newPath) async {
    try {
// prefer using rename as it is probably faster
      return await sourceFile.rename(newPath);
    } on FileSystemException catch (e) {
// if rename fails, copy the source file and then delete it
      final newFile = await sourceFile.copy(newPath);
      await sourceFile.delete();
      return newFile;
    }
  }

  handleStartupNavigation() async {
    recordCrashlyticsLog("Handling  startup naviagtion");

    bool isloggedin = await SharedPrefService().getIsLoggedIn() ?? false;
    if (isloggedin) {
      if (user?.paid == true) {
        _navigationToSpecifiedRoute(home_page);
      } else {
        Future.delayed(Duration.zero, () {
          NavigationService()
              .navigationKey
              .currentState
              .pushReplacement(MaterialPageRoute(
                  builder: (_) =>
                      GetPremium()));
        });
      }
    } else {
      _navigationToSpecifiedRoute(login_page);
    }
    AppUpdateService().initUpdateService();
  }

  _navigationToSpecifiedRoute(String routeName) {
    Future.delayed(Duration.zero, () {
      NavigationService()
          .navigationKey
          .currentState
          .pushReplacementNamed(routeName);
    });
  }
}
