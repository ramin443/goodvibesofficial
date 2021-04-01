import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_firebase_performance/dio_firebase_performance.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:goodvibesofficial/services/app_Config.dart';
import 'package:goodvibesofficial/services/session_service.dart';
import 'package:goodvibesofficial/services/shared_prefs_service.dart';
import 'package:goodvibesofficial/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:goodvibesofficial/utils/common_functiona.dart';
import 'package:goodvibesofficial/utils/strings/string_constants.dart';
import '../locator.dart';

class ApiService{
  Dio _dio = Dio();

  final sessionService = locator<SessionService>();

  static const success_key = 'success';
  static const authorization_key = "Authorization";

  final List<String> _nonCachhableEndpoints = [];

  /// funnction which returns map for authorization header
  getAuthorization() {
    var tokenFromLocator = locator<UserService>().user.value.authToken;

    ////// //print('token from locator: $tokenFromLocator');
    return {"Authorization": tokenFromLocator};
  }
  getAuthorizationWithSessionId() {
    var token = locator<UserService>().user.value.authToken;
    var sessionId = sessionService.sessionId;
    //print("session id is: $sessionId");

    // //print(token);
    return (sessionService.hasSessionIdSet && sessionId != null)
        ? {authorization_key: token, 'SessionId': sessionId}
        : {authorization_key: token};
  }

//// map of cancel tokens for canceling http requests
  final Map<String, dynamic> cancelTokens = {};

//// music and album related methods

  setDeviceToken({
    String token,
    String platform,
    String uid,
    String manufacture,
    String version,
  }) async {
    final url = "$baseUrl/devices";
    var response = await postRequest(
        url: url,
        data: {
          "token": token,
          "platform": platform,
          "version": version,
          "name": manufacture,
          "udid": uid
        },
        options: Options(
          headers: getAuthorization(),
        ));
    // //print(response);
  }

  socialLogin({String provider, String accessToken}) async {
    var url = "$baseUrl/login";

    var data = {"provider": provider, "access_token": accessToken};

    final response = await postRequest(url: url, data: data);

    //log.i(response);

    // return {"error": "login error"};
    return response;
  }

  login({String email, String password}) async {
    final url = '$baseUrl/api/v2/login';
    final Map<String, String> body = {'email': email, 'password': password};
    final response = await postRequest(url: url, data: body);
    return response;

  }
  signUpUserEmailAndPass(
      {String email, String password, String fullName}) async {
    final url = '$baseUrl/signup';
    final Map<String, String> body = {
      'email': email,
      'password': password,
      "full_name": fullName ?? ""
    };
    Map response = await postRequest(url: url, data: body);
    return response;
  }

  forgotPassword({String email}) async {
    var url = '$baseUrl/password_resets';

    Map response = await postRequest(url: url, data: {"email": email});

    return response;
  }

  confirmEmail(
      {String email, String password, String confirmationToken}) async {
    var url = '$baseUrl/confirmations/$confirmationToken';
    var response = await Dio().put(url, data: {
      "email": email,
      "password": password,
    });
    return response;
  }

  resendEmailConfirmation({@required var email}) async {
    final url = "$baseUrl/confirmations/resend_confirmation";
    final response = await postRequest(
        url: url,
        data: {"email": email},
        options: Options(
          headers: getAuthorization(),
        ));
    return response;
  }

  resetPassword({String oldPassword, String newPassword}) async {
    var url = '$baseUrl/password_resets';
    var response = await Dio().put(url, data: {
      "password": oldPassword,
    });
    return response;
  }

  changePassword({String oldPassword, String newPassword}) async {
    var url = '$baseUrl/users/update_password';
    try {
      Dio _dio = Dio(BaseOptions(receiveDataWhenStatusError: true));
      if (oldPassword == null) {
        var response = await _dio.put(
          url,
          data: {
            "new_password": newPassword,
          },
          options: Options(
            headers: getAuthorizationWithSessionId(),
          ),
        );
        return response.data;
      } else {
        var response = await _dio.put(url,
            data: {
              "current_password": oldPassword,
              "new_password": newPassword,
            },
            options: Options(
              headers: getAuthorizationWithSessionId(),
            ));
        return response.data;
      }
    } on DioError catch (e) {
      return e.response.data;
    }
  }
  changeName({String name, Map body}) async {
    var url = '$baseUrl/users/update';
    try {
      Dio _dio = Dio(BaseOptions(receiveDataWhenStatusError: true));
      var response = await _dio.put(
        url,
        data: body,
        options: Options(
          headers: getAuthorizationWithSessionId(),
        ),
      );
      return response.data;
    } on DioError catch (e) {
      return e.response.data;
    }
  }

  changeProfileImage({File image}) async {
    var url = '$baseUrl/users/update';
    try {
      Dio _dio = Dio(BaseOptions(receiveDataWhenStatusError: true));
      var response = await _dio.put(
        url,
        data: FormData.fromMap(
          {
            "image": await MultipartFile.fromFile(image.path,
                filename: image.path.split('/').last),
          },
        ),
        options: Options(
          headers: getAuthorizationWithSessionId(),
        ),
      );
      return response.data;
    } on DioError catch (e) {
      return e.response.data;
    }
  }

  userSignUp({String email, String uuid}) async {
    final url = '$baseUrl/signup';
    FormData formData = new FormData.fromMap({
      "email": email,
      "uuid": uuid,
    });


    final response = await postRequest(
      url: url,
      data: formData,
    );
    var bearer;
    if (response != null && response.containsKey('data')) {
      bearer = response['data'][auth_token_key];
      await SharedPrefService().setUserToken(bearer);
    }

    return response;
  }

  getCurrentUser({String uid}) async {
    final url = '$baseUrl/users/present_user';
    final response = await getRequest(
        nonCachableList: _nonCachhableEndpoints,
        url: url,
        options: Options(
          headers: {'UUID': uid},
        ));

    return response;
  }

  logOutUser({String uid}) async {
    final url = "$baseUrl/logout";

    final response = await postRequest(
        url: url,
        data: {"device_id": uid},
        options: Options(
          headers: getAuthorizationWithSessionId(),
        ));
    // //print(response);

    locator<SessionService>().hasSessionIdSet = false;

    return response;
  }

  getSettings() async {
    // //print(getAuthorizationWithSessionId());
    final url = "$baseUrl/settings";

    _nonCachhableEndpoints.add(url);

    final response = await getRequest(
      nonCachableList: _nonCachhableEndpoints,
      url: url,
      options: Options(headers: getAuthorizationWithSessionId()),
    );
    return response;
  }

  updateNotificationSttings(
      {bool dailyUpdates, bool offersPush, bool others, Map body}) async {
    final url = "$baseUrl/settings";
    // //print(getAuthorizationWithSessionId());
    final response = await postRequest(
        url: url,
        data: body,
        options: Options(
          headers: getAuthorizationWithSessionId(),
        ));
    return response;
  }

  postOpenedPushNotification(String id, String deviceToken) async {
    final url = "$baseUrl/push_notifications/$id/open";
    final response = await postRequest(
      url: url,
      data: {"device_token": deviceToken},
      options: Options(
        headers: getAuthorizationWithSessionId(),
      ),
    );

    // //print(response);
    return response;
  }

  getAllNotifications() async {
    final url = "$baseUrl/notifications";
    final response = await getRequest(
      nonCachableList: _nonCachhableEndpoints,
      url: url,
      options: Options(
        headers: getAuthorizationWithSessionId(),
      ),
    );

    return response;
  }

  clearAllNotifications() async {
    final url = "$baseUrl/notifications/bulk_clear";
    // //print(url);
    final response = await Dio().delete(
      url,
      options: Options(headers: getAuthorizationWithSessionId()),
    );
    // //print(response);
    return response;
  }

  readSingleNotification(var id) async {
    final url = "$baseUrl/notifications/$id";
    final Map response = await getRequest(
      nonCachableList: _nonCachhableEndpoints,
      url: url,
      options: Options(
        headers: getAuthorizationWithSessionId(),
      ),
    );
    return response;
  }

  clearANotification(var id) async {
    final url = "$baseUrl/notifications/$id";
    // //print(url);
    final response = await Dio().delete(
      url,
      options: Options(headers: getAuthorizationWithSessionId()),
    );
    // //print(response);
    return response;
  }

  updateUser({Map<String, dynamic> body}) async {
    final url = "$baseUrl/users/update";
    final Map response = await postRequest(
      url: url,
      data: body,
      options: Options(
        headers: getAuthorizationWithSessionId(),
      ),
    );
    //print(response);
    return response;
  }

  deactivateUser({String reason}) async {
    final url = "$baseUrl/deactivate";
    final response = await postRequest(
      url: url,
      data: {"reason": reason ?? " "},
      options: Options(headers: getAuthorizationWithSessionId()),
    );
    return response;
  }

  getUserProfileData() async {
    // //print("------------Authorization ID");
    // //print(getAuthorizationWithSessionId());
    final url = "$baseUrl/users/profile";
    _nonCachhableEndpoints.add(url);
    final response = await getRequest(
        nonCachableList: _nonCachhableEndpoints,
        url: url,
        options: Options(headers: getAuthorizationWithSessionId()));
    return response;
  }

  uploadImageAndUpateUser({String imagePath, String uid}) async {
    final updateUrl = '$baseUrl/users/update_current_user';

    final _formData =
    FormData.fromMap({'image': await MultipartFile.fromFile(imagePath)});

    await _dio.put(
      updateUrl,
      data: _formData,
      options: Options(
        headers: {'UUID': uid},
      ),
    );
  }

  Future<bool> sendMail({String name, String email}) async {
    final url = '$baseUrl/users/user_id/send_mail';

    final _data = FormData.fromMap({'name': name, 'email': email});

    await postRequest(
      url: url,
      data: _data,
      options: Options(
        headers: getAuthorizationWithSessionId(),
      ),
    );
    return true;
  }

  // get push notifications

  getPushNotifications({int page, int perpage}) async {
    final response = await getRequest(
      nonCachableList: _nonCachhableEndpoints,
      url: '$baseUrl/push_notifications',
      queryParameters: {'page': page, 'per_page': perpage},
      options: Options(
        headers: {'Authorization': getAuthorization()},
      ),
    );

    return response;
  }

  /// method to send subscription info to server
  /// after purchase is complete
  /// subscribeuser part












  getUserSubscriptionDetails() async {
    final url = "$baseUrl/subscriptions";
    _nonCachhableEndpoints.add(url);

    final response = await getRequest(
      nonCachableList: _nonCachhableEndpoints,
      url: url,
      options: Options(
        headers: getAuthorizationWithSessionId(),
      ),
    );
    return response;
  }
  getASession() async {}
  getAllSessions() async {}
  getCurrentSession() async {}

  getConfig() async {
    final url = "$baseUrl/config";
    _nonCachhableEndpoints.add(url);
    final Map response = await getRequest(
        nonCachableList: _nonCachhableEndpoints,
        url: url,
        options: Options(headers: getAuthorizationWithSessionId()));
    // //print(response);
    return response;
  }

}
Map<String, String> convertMapDynamicToString(Map<String, dynamic> json) {
  Map<String, String> temp = {};

  json.forEach((key, v) {
    temp[key] = v.toString();
  });

  return temp;
}

Future<Map<String, dynamic>> getRequest(
    {var queryParameters,
      @required var url,
      Options options,
      bool isRefreshRequest = false,
      List<String> nonCachableList}) async {
  Map<String, dynamic> httpResponse = {};
  Dio _dio = Dio();
  // print(url);
  recordCrashlyticsLog("get request at $url");

  final _sessionService = locator<SessionService>();

  bool _isUrlNonCachable = false;

  if (nonCachableList != null && !isRefreshRequest) {
    _isUrlNonCachable = nonCachableList.contains(url);
  }

  if (_isUrlNonCachable == false) {
    final tempUri = Uri.https(
        "",
        url,
        queryParameters == null
            ? null
            : convertMapDynamicToString(queryParameters));

    var some = tempUri.toString();
    var urlAddress =
    Uri.parse("https://" + tempUri.toString().split("https://").last);

    final _config = CacheConfig(
      baseUrl: url,
      defaultMaxStale: Duration(days: 2),
      databaseName: "dio-http-cache",
      skipMemoryCache: true,
      defaultMaxAge: Duration(hours: 6),
    );

    final _cacheManager = DioCacheManager(_config);

    final firebasePerformanceInterceptor = DioFirebasePerformanceInterceptor();
    _dio.interceptors.add(firebasePerformanceInterceptor);

    if (isRefreshRequest)
      _cacheManager.deleteByPrimaryKeyWithUri(urlAddress, requestMethod: "GET");

    _dio.interceptors.add(_cacheManager.interceptor);
  }

  try {
    final response = await _dio.get(
      url,
      //options: options,
      options: _isUrlNonCachable
          ? options
          : buildCacheOptions(
        Duration(hours: 6),
        options: options,
        maxStale: Duration(days: 1),
      ),
      queryParameters: queryParameters,
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response != null) {
        handleSession(response, _sessionService);

        if (!_isUrlNonCachable) {
          _sessionService.sessionId = null;
          _sessionService.hasSessionIdSet = false;
        }

        if (response.data['success'] == true) {
          httpResponse['data'] = response.data['data'];
          if (response.data.containsKey("page_meta"))
            httpResponse['page_meta'] = response.data["page_meta"];
          if (response.data.containsKey("description"))
            httpResponse['description'] = response.data["description"];
        } else {
          //// //print(response.data["error"]);
          httpResponse["error"] = response.data["error"];
        }
      }

      return httpResponse;
    }
  } on DioError catch (e, stackTrace) {
    //print("error:$e   at url : $url");
    Crashlytics.instance.recordError(
        'Api get request error at $url \n with message ${e.toString()} ',
        stackTrace);

    handleError(e: e.toString(), httpResponse: httpResponse, stack: stackTrace);
    if (e.toString().toLowerCase().contains("socketexception")) {
      httpResponse["error"] = "No internet connection";
      return httpResponse;
    }

    return httpResponse;
  }
}

Future<Map<String, dynamic>> postRequest(
    {var queryParameters, var data, Options options, @required var url}) async {
  SessionService _sessionService = locator<SessionService>();
  Map<String, dynamic> httpResponse = {};

  Dio _dio = Dio(BaseOptions(receiveDataWhenStatusError: true));
  final firebasePerformanceInterceptor = DioFirebasePerformanceInterceptor();
  _dio.interceptors.add(firebasePerformanceInterceptor);

  recordCrashlyticsLog("post request at $url");
  // print(url);
  try {
    var response = await _dio.post(
      url,
      data: data,
      options: options,
      queryParameters: queryParameters,
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      handleSession(response, _sessionService);

      if (response != null) {
        if (response.data["success"] == true) {
          httpResponse['data'] = response.data['data'];
          if (response.data.containsKey("message"))
            httpResponse["message"] = response.data["message"];
        } else {
          //// //print(response.data["error"]);
          httpResponse["error"] = response.data["error"];
        }

        return httpResponse;
      } // end of checking response

    }
  } on DioError catch (e, stackTrace) {
    var errorRes = e.response.data;
    print(errorRes);
    if (e.toString().toLowerCase().contains("socketexception")) {
      httpResponse["error"] = "No internet connection";
      return httpResponse;
    }
    if (errorRes is Map) {
      if (errorRes.containsKey("error")) {
        httpResponse["error"] = errorRes["error"];
        return httpResponse;
      }
    }

    handleError(e: e.toString(), httpResponse: httpResponse, stack: stackTrace);

    return httpResponse;
  }
}

handleError({String e, Map httpResponse, StackTrace stack}) {
  // //print('dio  error: ${e.toString()}');

  if (e != null) {
    String error = e.toString().toLowerCase();
    if (error.contains('404')) {
      httpResponse['error'] = error_msg_404;
    } else if (error.contains('500')) {
      httpResponse['error'] = error_msg_500;
    } else if (error.contains('401')) {
      httpResponse['error'] = unauthorized_error;
    } else if (error.contains('408')) {
      httpResponse['error'] = error_msg_408;
    } else if (error.contains('timeout')) {
      httpResponse['error'] = error_msg_timeout;
    } else if (error.contains('422')) {
      httpResponse['error'] = error_mdg_422;
    } else {
      FirebaseCrashlytics.instance.recordError(e, stack);

      httpResponse['error'] = error_error;
    }
  }
}

handleSession(Response response, SessionService service) {
  if (response.headers != null) {
    if (!service.hasSessionIdSet) {
      var sessionId = response.headers.value('sessionid');

      if (sessionId != null) {
        service.sessionId = sessionId;
        service.hasSessionIdSet = true;
      }
    }
  } // end of get/set header
}

throwErrorFunction(e) {
  throw Exception(['$e']);
}
