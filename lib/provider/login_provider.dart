import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
import 'package:goodvibesofficial/models/user_model.dart';
import 'package:goodvibesofficial/screens/auth/login.dart';
import 'package:goodvibesofficial/screens/initial/goals.dart';
import 'package:goodvibesofficial/services/api_service.dart';
import 'package:goodvibesofficial/services/database_service.dart';
import 'package:goodvibesofficial/services/login_dialog_service.dart';
import 'package:goodvibesofficial/services/navigation_service.dart';
import 'package:goodvibesofficial/services/shared_prefs_service.dart';
import 'package:goodvibesofficial/services/user_service.dart';
import 'package:goodvibesofficial/utils/strings/string_constants.dart';
import 'package:goodvibesofficial/widgets/common_widgets_methods.dart';
import 'package:package_info/package_info.dart';
import '../locator.dart';

enum FormMode { LOGIN, SIGNUP }
enum LoginStatus { BUSY, SUCCESS, FAILED }

class LoginProvider with ChangeNotifier {
  final _dialogService = locator<DialogService>();

  final _apiLocator = locator<ApiService>();
  var status;
  Widget statusWidget;
  String userEmailTobeConfimed = " ";
  var _userBeforeLogin = locator<UserService>().user.value;
  BuildContext _loginPageBuildContext;


  _handleNavigation(
      {String route,
        @required BuildContext context,
        bool shouldFetchWhatBringsYouHereOptions = false}) {
    var user = locator<UserService>().user.value;


    locator<NavigationService>()
        .navigationKey
        .currentState
        .pushAndRemoveUntil(route ?? Goals(),
            (Route<dynamic> route) => false);
  }


  _handleLoginResponse(
      {Map response, BuildContext context, bool isConnectAction}) async {
    if (response.containsKey("data")) {
      await _setUser(user: response['data']);
      await SharedPrefService().setIsLoggedIn(true);

      //  if (_userBeforeLogin == null) {
  //    _prefetchHomePageTracks(_loginPageBuildContext);
      // }

      await _handleNavigation(
          context: context, shouldFetchWhatBringsYouHereOptions: true);

      await setDeviceToken();
    } else {
      Navigator.of(context, rootNavigator: true).pop(true);
print('error');
      _dialogService.showErrorDialog(
          context: context, message: response["error"] ?? " ");

      var error = response["error"].toString();
      if (error.toLowerCase() == "user not confirmed" ||
          error.contains("confirmed")) {
        await Future.delayed(Duration(seconds: 2), () {
          Navigator.of(context, rootNavigator: true).pop(true);
Navigator.push(context, MaterialPageRoute(builder: (context)=>Goals()));
        });
      }
    }
  }

  setDeviceToken() async {
    var token = await SharedPrefService().getNotificationToken();
    PackageInfo info = await PackageInfo.fromPlatform();
    final _user = locator<UserService>().user.value;

    final deviceInfo = await getDeviceInfo();
    await _apiLocator.setDeviceToken(
      token: token,
      platform: Platform.isIOS ? 'ios' : 'android',
      manufacture: deviceInfo == null
          ? Platform.isIOS
          ? "apple"
          : "android"
          : deviceInfo["manufacture"],
      uid: deviceInfo == null
          ? base64Encode(utf8.encode(_user?.uid))
          : base64Encode(utf8.encode("${deviceInfo["uid"]}${_user?.uid}")),
      version: info.version,
    );
  }

  Future<Map<String, String>> getDeviceInfo() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    Map<String, String> deviceInfo;
    try {
      if (Platform.isAndroid) {
        final androidInfo = await deviceInfoPlugin.androidInfo;

        deviceInfo = {
          "manufacture": androidInfo.manufacturer + " " + androidInfo.model,
          "uid": androidInfo.androidId,
        };
      } else {
        final iosInfo = await deviceInfoPlugin.iosInfo;

        deviceInfo = {
          "manufacture": "apple" + " " + iosInfo.localizedModel,
          "uid": iosInfo.identifierForVendor,
        };
      }
      return deviceInfo;
    } on PlatformException catch (e) {
      // print(e.message);
      return deviceInfo;
    }
  }

  _setUser({Map user}) async {
    User _user = User.fromJson(user);
    locator<UserService>().user.value = _user;

    await DatabaseService().insertIntoUserTable(_user);
notifyListeners();  }

  updateUserTable({User user}) async {
    locator<UserService>().user.value = user;
    // await SharedPrefService().setMultipleUserData(_user);
    await DatabaseService().updateUserTable(user);
    notifyListeners();
  }

  login({String email, String password, BuildContext context}) async {
    _loginPageBuildContext = context;
    _dialogService.showLoadingDialog(context);
    userEmailTobeConfimed = email;
    Map response = await _apiLocator.login(email: email, password: password);
    if (response.containsKey("data")) {
      Navigator.of(context, rootNavigator: true).pop(true);

      _dialogService.showSuccessDialog(
          message: "Log in success", context: context);
    }
    await _handleLoginResponse(response: response, context: context);
  }

  singup({email, password, fullName, BuildContext context}) async {
    userEmailTobeConfimed = email;
    _dialogService.showLoadingDialog(context);
    Map response = await _apiLocator.signUpUserEmailAndPass(
        fullName: fullName, email: email, password: password);

    //  // print(response);
    if (response.containsKey("data")) {
      Navigator.of(context, rootNavigator: true).pop(true);

      _dialogService.showSuccessDialog(
          message: "Sign up Sucessful", context: context);
      await Future.delayed(Duration(seconds: 2), () {});
Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Goals()));    } else {
      Navigator.of(context, rootNavigator: true).pop(true);

      _dialogService.showErrorDialog(
          context: context, message: response["error"] ?? " ");
    }
  }

  Future<bool> forgotPassword({String email, BuildContext context}) async {
    _dialogService.showLoadingDialog(context);
    Map response = await _apiLocator.forgotPassword(email: email);
    var message;
    if (response.containsKey("message")) message = response["message"];
    Navigator.of(context, rootNavigator: true).pop(true);
    if (message.toString().toLowerCase().contains("invalid")) {
      _dialogService.showErrorDialog(context: context, message: message);
      return false;
    } else {
      _dialogService.showSuccessDialog(
          context: context,
          message: "Password reset link sent succesfully\n Check your mail.");
      return true;
    }
  }

  resetPassword({String oldPassword, String newPassword}) async {
    var reponse = await _apiLocator.resetPassword(
        oldPassword: oldPassword, newPassword: newPassword);
    return reponse;
  }

  changePassword({String oldPassword, String newPassword}) async {
    var response = await _apiLocator.changePassword(
        oldPassword: oldPassword, newPassword: newPassword);
    return response;
  }

  changeName({String name, Map body}) async {
    var response = await _apiLocator.changeName(body: body);
    final _user = locator<UserService>().user;
    if (response["success"]) {
      _user.value = _user.value.copyWith(name: response["data"]["full_name"]);
      await updateUserTable(
        user: _user.value,
      );
      return {
        "success": true,
      };
    } else {
      return {
        "success": false,
        "error": response["error"],
      };
    }
  }

  changeProfileImage({File image}) async {
    var response = await _apiLocator.changeProfileImage(image: image);
    final _user = locator<UserService>().user;
    if (response["success"]) {
      _user.value = _user.value.copyWith(image: response["data"]["user_image"]);
      await updateUserTable(
        user: _user.value,
      );
      return {
        "success": true,
      };
    } else {
      return {
        "success": false,
        "error": response["error"],
      };
    }
  }

  confirmEmail(email, password) async {
    var response =
    await _apiLocator.confirmEmail(email: email, password: password);
  }

  handleEmailConfirmation() async {}

  handleLoginException(e, s, {String errorFrom}) {
    FirebaseCrashlytics.instance
        .recordError(e, s, reason: '$errorFrom login failed');
  }

  logout(BuildContext context) async {
    _dialogService.showLoadingDialog(context);
    final _user = locator<UserService>().user.value;
    final deviceInfo = await getDeviceInfo();

    Map response = await _apiLocator.logOutUser(
      uid: base64Encode(
        utf8.encode(deviceInfo == null
            ? "${_user?.uid}"
            : "${deviceInfo["uid"]}${_user?.uid}"),
      ),
    );

    // print(response);

    if (response == null || response.containsKey("error")) {
      Navigator.of(context, rootNavigator: true).pop(true);

      showToastMessage(
          message: "Could not clear your online session at the moment!");
      await Future.delayed(Duration(seconds: 2), () {});
    }

    await DatabaseService().deleteUserFromUserTable();
    await SharedPrefService().clearUserEntriesOnLogout();

    // await _apiLocator.logOutUser(deviceToken: deviceToken);
    // await SharedPrefService().clearUserEntriesOnLogout();
    notifyListeners();
  }

  Future<bool> resendEmailConfirmation() async {
    final Map response =
    await _apiLocator.resendEmailConfirmation(email: userEmailTobeConfimed);

    if (response == null || response.containsKey("error")) {
      return false;
    }
    return true;
  }

  updateUser(Map body) async {
    final response = await _apiLocator.updateUser(body: body);
    return response;
  }

  Future<bool> deactivateAccount(
      {BuildContext context, String reason = " "}) async {
    _dialogService.showLoadingDialog(context);
    Map response = await _apiLocator.deactivateUser(reason: reason);
    if (response == null) {
      Navigator.of(context, rootNavigator: true).pop();
      _dialogService.showErrorDialog(
        context: context,
        message: some_error_occured,
      );
      return false;
    } else if (response.containsKey("error")) {
      Navigator.of(context, rootNavigator: true).pop();
      _dialogService.showErrorDialog(
        context: context,
        message: some_error_occured,
      );
    } else {
      Navigator.of(context, rootNavigator: true).pop();
      _dialogService.showSuccessDialog(
          context: context,
          message: "Deactivated succesfully!\nWe are sad to see you go.");
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Login()), (route) => false);
    }
    return true;
  }
}
