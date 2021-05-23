import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:goodvibesoffl/models/music_model.dart';
import 'package:goodvibesoffl/models/playlist_model.dart';
import 'package:goodvibesoffl/screens/music/playlist_page.dart';
import 'package:goodvibesoffl/routes.dart';
import 'package:goodvibesoffl/services/api_service.dart';
import 'package:goodvibesoffl/services/login_dialog_service.dart';
import 'package:goodvibesoffl/services/navigation_service.dart';
import 'package:goodvibesoffl/services/player_service.dart';
import 'package:goodvibesoffl/services/shared_pref_service.dart';
import 'package:goodvibesoffl/services/user_service.dart';
import 'package:goodvibesoffl/widgets/common_widgets/common_widgets_methods.dart';
import 'package:rxdart/rxdart.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/push_notification_model.dart';
import 'login_provider.dart';

class NotificationProvider {
  BehaviorSubject<Map> pushNotificaitonStrem = BehaviorSubject<Map>();
  final List<String> _unNavigableRoutes = [
    single_player,
    genre_songs_page,
    // albumsongs_page,
    invite_page,
    settings_page,
    "playlist_page",
    ask_question_page,
  ];

  final _apiLocator = ApiService();
  bool hasPushNotification = false;
  final FirebaseMessaging _fcm = FirebaseMessaging();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  initialiseFCM() async {
    // print('push notification initialised');

    if (Platform.isIOS)
      _fcm.requestNotificationPermissions(IosNotificationSettings());

    var initializationSettingsAndroid =
    new AndroidInitializationSettings("app_icon");

    var initializationSettingsIOS = new IOSInitializationSettings(
        onDidReceiveLocalNotification:
            (int id, String title, String body, String payload) =>
            onSelecetedLocal(payload));

    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: onSelecetedLocal,
    );

    _fcmConfig();

    _getToken();
  }

  Future<Null> _getToken() async {
    bool hasDeviceTokenRegistered =
        await SharedPrefService().getHasDeviceTokenRegistered() ?? false;

    String token = await _fcm.getToken();
    print('fcm token: $token');
    if (!hasDeviceTokenRegistered) {
      String token = await _fcm.getToken();
      // // print('fcm token: $token');
      var storedToken = await SharedPrefService().getNotificationToken() ?? " ";
      if (storedToken != token)
        await SharedPrefService().setDeviceNotificationToken(token);
      await SharedPrefService().setHasDeviceTokenRegistered(true);
    }

    _fcm.onTokenRefresh.listen(
          (data) async {
        var storedToken =
            await SharedPrefService().getNotificationToken() ?? " ";

        if (storedToken != data) {
          await SharedPrefService().setDeviceNotificationToken(data);
          if (UserService().user.value.isLoggedIn == true)
            registerDeviceTokenToServer(data);
        }
      },
    );
  }

  registerDeviceTokenToServer(String deviceToken) {
    LoginProvider().setDeviceToken();
  }

  void _fcmConfig() {
    //  // print('in config fcm');
    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        if (message != null) _handleForegroundNotification(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        if (message != null) _handleNotificationData(message);
      },
      onResume: (Map<String, dynamic> message) async {
        if (message != null) _handleNotificationData(message);
      },
    );
  }

  Future onSelecetedLocal(String payload) {
    if (Platform.isIOS) {
      if (payload.contains("type")) {
        Map decodedPayload = json.decode(payload);
        if (decodedPayload.containsKey("type")) {
          // print("here");
          handleLocalNotification(decodedPayload);
        }
      }
    }
  }

  _sendPushNotificationOpenedStatus(String id) async {
    var token = await SharedPrefService().getNotificationToken();
    await _apiLocator.postOpenedPushNotification(id, token);
  }

  _handleNotificationData(Map<String, dynamic> message) async {
    // print(message);

    var data;

    //  Logger log = Logger();
    if (Platform.isAndroid)
      data = message['data'];
    else
      data = message;

    if (data != null) {
      hasPushNotification = true;
      pushNotificaitonStrem.add(data);
      await _sendPushNotificationOpenedStatus(
          data["push_notification_id"].toString());
    }
  }

  _performTasksAccordingToType({String type, PushNotifictionData data}) async {
    var _data = data;
    switch (type) {
      case "nav":
        if (_unNavigableRoutes.contains(_data.pageName)) {
          if (_data.pageName != null && _data.pageId != null) {
            var pageName = _data.pageName;
            var pageId = _data.pageId;
            await _checkPageNameAndNavigate(pageName: pageName, pageId: pageId);
          }
        } else if (!_unNavigableRoutes.contains(_data.pageName)) {
          _navigationToSpecifiedRoute(_data.pageName);
        }
        break;
      case "external_link":
      ////// open external link
        var _url = _data.link ?? " ";
        if (await canLaunch(_url)) await launch(_url);
        break;
      case "message":

      /// show toast message
        showToastMessage(message: _data.message ?? "Its time for good vibes");
        break;
    }
  }

  pushN(var data, {bool isFromNotificationsList = false}) async {
    var type = data["type"];

    var _json =
    isFromNotificationsList ? data['data'] : json.decode(data["data"]);
    PushNotifictionData _data = PushNotifictionData.fromJson(_json);
    _performTasksAccordingToType(type: type, data: _data);
  }

  _checkPageNameAndNavigate({String pageName, var pageId}) async {
    if (pageName.contains(single_player)) {
//------ to the single player page-----
      var routeName = single_player;

      var context = NavigationService()
          .navigationKey
          .currentState
          .overlay
          .context;
   DialogService().showLoadingDialog(context);
      var response = await _apiLocator.getSingleTrack(pageId);
      Navigator.of(context, rootNavigator: true).pop();
      if (response != null && response.containsKey("data")) {
        final track = Track.fromJson(response['data']);
        // Navigator.of(context, rootNavigator: true).pop();
        if (track != null) {
          MusicService().currentTrack.value = track;
   MusicService().trackId.value = track.id;
          _navigationToSpecifiedRoute(routeName);
        }
      }
    } else if (pageName.contains(genre_songs_page)) {
      // can navigate to genre songs page but
      // its ui depends on the result of previous page
      _navigationToSpecifiedRoute(discover_page);
    }

    /// sleep page
    else if (pageName.contains(sleep_page)) {
      _navigationToSpecifiedRoute(sleep_page);
    }
    // meditate page
    else if (pageName.contains(meditate_page)) {
      _navigationToSpecifiedRoute(meditate_page);
    }

    // plalist page
    else if (pageName.contains(playlist_page)) {
      var response = await _apiLocator.getSinglePlaylist(pageId);

      if (response != null && response.containsKey("data")) {
        PlayList playlist = PlayList.fromJson(response["data"]);
        // print(playlist.slug);
        if (playlist != null) {
         NavigationService().navigationKey.currentState.push(
              MaterialPageRoute(
                  builder: (_) => PlayListPage(playlist: playlist)));
        }
      }
    } else {
      _navigationToSpecifiedRoute(home_page);
    }
  }

  _navigationToSpecifiedRoute(String routeName) async {
    bool _isLoggedIn = UserService().user.value.isLoggedIn;

    _isLoggedIn
        ? NavigationService()
        .navigationKey
        .currentState
        .pushNamed(routeName)
        : NavigationService()
        .navigationKey
        .currentState
        .pushNamed(login_page);
  }

  _handleForegroundNotification(Map message) async {
    hasPushNotification = true;
    int id = Random().nextInt(100) + Random().nextInt(1000);
    Map data;

    if (Platform.isAndroid)
      data = message['data'];
    else
      data = message;

    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        '9840060186', 'Codeforcore', 'Mobile app for good vibes',
        importance: Importance.Max, priority: Priority.High);

    var iOSPlatformChannelSpecifics = new IOSNotificationDetails(
      presentAlert: true,
      // badgeNumber: 1,
      // presentBadge: true,
    ); //add sound : 'file name'

    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    if (Platform.isAndroid) data = message['data'];

    var type, innerData, localTitle, localBody;

    if (Platform.isIOS) {
      localTitle = message["aps"]["alert"]["title"];

      localBody = message["aps"]["alert"]["body"];
    } else if (Platform.isAndroid) {
      localTitle = message["notification"]["title"];
      localBody = message["notification"]["body"];
    }

    type = data["type"];
    innerData = data["data"];
    String payloadMessage = """{"data":$innerData, "type":"$type"}""";

    flutterLocalNotificationsPlugin.show(
      id,
      localTitle,
      localBody,
      platformChannelSpecifics,
      payload: payloadMessage,
    );

    if (data.containsKey(["push_notification_id"]))
      _sendPushNotificationOpenedStatus(data["push_notification_id"]);
  }

  Future handleLocalNotification(Map data) async {
    // // print(data);
    PushNotifictionData _data;
    if (data != null) {
      if (data.containsKey("data") && data.containsKey("type")) {
        _data = PushNotifictionData.fromJson(data["data"]);
        var type = data["type"];
        _performTasksAccordingToType(type: type, data: _data);
      }
    }
  }

  Future showNotificationWithSound(int id, Time time, Day day) async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      'Good Vibes Application',
      'Good Vibes',
      'Mobile app for good vibes',
      importance: Importance.Max,
      priority: Priority.High,
    );
    var iOSPlatformChannelSpecifics =
    new IOSNotificationDetails(); //add sound : 'file name'

    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
        id,
        'Good Vibes Official',
        'Its time to listen goodvibes, relax and sleep healthy.',
        day,
        time,
        platformChannelSpecifics);
  }

  void cancelAllNotiFication() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  void cancelAllNotiFicationById(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  void cancelMultipleNotifications(List<int> ids) {
    ids.forEach((int id) async {
      await flutterLocalNotificationsPlugin.cancel(id);
    });
  }
}
