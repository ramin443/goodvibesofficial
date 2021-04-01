import 'package:goodvibesofficial/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  static const user_bearer_token = 'bearer_token';
  static const payment_date = 'payment_date';
  static const subs_type = 'subscription_type';
  static const monthly_sub = 'monthly';
  static const yearly_sub = 'yearly';

  /// login and user related
  static const auth_token = 'auth_token';
  static const is_user_data_fetched = 'isUserDataFetchedInThisSession';
  static const is_logged_in = 'islogedin';
  static const user_uid = 'uid';
  static const is_admin = 'admin';
  static const user_image = 'image';
  static const user_name = 'name';
  static const user_email = 'email';
  static const user_paid = 'paid';
  static const user_type = 'type';
  static const deeplink_data = 'deeplinkData';
  static const has_deeplink = 'hasdeeplink';
  static const has_device_token_registered = 'hasDeviceTokenRegistererd';
  static const has_push_notification = 'hasPushNotification';
  static const set_password = "password_set";

  static const has_asked_for_update = 'is_user_asked_for_app_update';
  static const update_dialog_shown_date = 'update_dialog_shown_date';
  static const free_user_dloads_deleted = "free_users_download_deleted";

// notification

  static const notification_device_token = 'notificatioToken';

// startup

  static const first_run = 'first_run';
  static const is_favourite_data_pulled = 'favourite_pulled';
  static const app_version_number = 'appVersion';
  static const notification_settings = "notification settings";

  static const has_seen_what_brings_page = "what brings you here page";
  static const is_migrated = "is_migrated";

  static const ads_after_count_single_player = "ads_after_count_single_player";

  /// EMAIL VERIFICATION

  SharedPreferences _pref;

  SharedPrefService() {
    getInstance();
  }

  getInstance() async {
    _pref = await SharedPreferences.getInstance();
  }

  setString(String key, String data) async {
    _pref = await SharedPreferences.getInstance();
    return _pref.setString(key, data);
  }

  getString(String key) async {
    _pref = await SharedPreferences.getInstance();
    return _pref.getString(key);
  }

  setBool(String key, bool data) async {
    _pref = await SharedPreferences.getInstance();
    return _pref.setBool(key, data);
  }

  getBool(String key) async {
    _pref = await SharedPreferences.getInstance();
    return _pref.getBool(key);
  }

  remove(String key) async {
    _pref = await SharedPreferences.getInstance();
    _pref.remove(key);
  }

  /// fetching data methods

  clearUserEntriesOnLogout() async {
    _pref = await SharedPreferences.getInstance();
    _pref.setBool(is_logged_in, false);
    _pref.remove(auth_token);
    _pref.remove('id');
    _pref.remove(user_name);
    _pref.setBool(user_paid, false);
    _pref.remove(user_image);
    _pref.remove(user_email);
    _pref.remove(user_type);
    _pref.remove(user_uid);
    _pref.setBool(first_run, false);
    //  _pref.clear();
  }

////// user related methods

  Future<String> getUserBearerToken() async {
    _pref = await SharedPreferences.getInstance();

    return _pref.getString(user_bearer_token);
  }

  setUserToken(value) async {
    _pref = await SharedPreferences.getInstance();
    _pref.setString(user_bearer_token, value);
  }

  Future<String> getUserUid() async {
    _pref = await SharedPreferences.getInstance();

    return _pref.getString(user_uid);
  }

  setUserUid(value) async {
    _pref = await SharedPreferences.getInstance();
    _pref.setString(user_uid, value);
  }

  Future<String> getUsername() async {
    _pref = await SharedPreferences.getInstance();

    return _pref.getString(user_name);
  }

  setUsername(value) async {
    _pref = await SharedPreferences.getInstance();
    _pref.setString(user_name, value);
  }

  setUserImage(String value) async {
    _pref = await SharedPreferences.getInstance();
    await _pref.setString(user_image, value);
  }

  Future<String> getUserImage() async {
    _pref = await SharedPreferences.getInstance();

    return _pref.getString(user_image);
  }

  setUserPaidStatus(value) async {
    _pref = await SharedPreferences.getInstance();
    await _pref.setBool(user_paid, value);
  }

  Future<bool> getUserPaidStatus() async {
    _pref = await SharedPreferences.getInstance();
    return _pref.getBool(user_paid);
  }

  setUserEmail(value) async {
    _pref = await SharedPreferences.getInstance();
    await _pref.setString(user_email, value);
  }

  Future<String> getUserEmail() async {
    _pref = await SharedPreferences.getInstance();
    return _pref.getString(user_email);
  }

  setUserType(value) async {
    _pref = await SharedPreferences.getInstance();
    await _pref.setString(user_type, value);
  }

  Future<String> getUserType() async {
    _pref = await SharedPreferences.getInstance();
    return _pref.getString(user_type);
  }

  Future<bool> getUserSetPasswordStatus() async {
    _pref = await SharedPreferences.getInstance();

    return _pref.getBool(set_password);
  }

  setMultipleUserData(User user) async {
    _pref = await SharedPreferences.getInstance();
    await Future.wait<dynamic>([
      _pref.setBool(is_logged_in, true),
      _pref.setString(user_uid, user.uid),
      _pref.setString(user_email, user.email),
      _pref.setString(user_image, user.image),
      _pref.setString(user_name, user.name),
      _pref.setBool(set_password, user.passwordSet),
    ]);
  }

  /// methods related to startup

  Future<String> getNotificationToken() async {
    _pref = await SharedPreferences.getInstance();
    return _pref.getString(notification_device_token);
  }

  setDeviceNotificationToken(value) async {
    _pref = await SharedPreferences.getInstance();
    await _pref.setString(notification_device_token, value);
  }

  getFirstRunStatus() async {
    _pref = await SharedPreferences.getInstance();
    return _pref.getBool(first_run);
  }

  setFirstRunStatus(value) async {
    _pref = await SharedPreferences.getInstance();
    await _pref.setBool(first_run, value);
  }

  Future<bool> getIsLoggedIn() async {
    _pref = await SharedPreferences.getInstance();
    return _pref.getBool(is_logged_in);
  }

  setIsLoggedIn(value) async {
    _pref = await SharedPreferences.getInstance();
    await _pref.setBool(is_logged_in, value);
  }

  Future<bool> getIsFavouritePulled() async {
    _pref = await SharedPreferences.getInstance();
    return _pref.getBool(is_favourite_data_pulled);
  }

  setIsFavouritePulled(value) async {
    _pref = await SharedPreferences.getInstance();
    await _pref.setBool(is_favourite_data_pulled, value);
  }

  setAppVersionNumber(value) async {
    _pref = await SharedPreferences.getInstance();
    await _pref.setString(app_version_number, value);
  }

  getAppVersion() async {
    _pref = await SharedPreferences.getInstance();
    return _pref.getString(app_version_number);
  }

  Future<bool> getHasDeviceTokenRegistered() async {
    _pref = await SharedPreferences.getInstance();
    return _pref.getBool(has_device_token_registered);
  }

  setHasDeviceTokenRegistered(bool value) async {
    _pref = await SharedPreferences.getInstance();
    await _pref.setBool(has_device_token_registered, value);
  }

  Future<bool> getHasPushNotification() async {
    _pref = await SharedPreferences.getInstance();
    return _pref.getBool(has_push_notification);
  }

  setHasPushNotification(bool value) async {
    _pref = await SharedPreferences.getInstance();
    await _pref.setBool(has_push_notification, value);
  }

  removeHasPushNotification() async {
    _pref = await SharedPreferences.getInstance();
    await _pref.remove(has_push_notification);
  }

  addSettigns(String value) async {
    _pref = await SharedPreferences.getInstance();
    await _pref.setString(notification_settings, value);
  }

  getPushSettigns() async {
    _pref = await SharedPreferences.getInstance();
    await _pref.get(notification_settings);
  }

  getHasSeenWhatBringsPage() async {
    _pref = await SharedPreferences.getInstance();
    return _pref.get(has_seen_what_brings_page);
  }

  setHasSeenWhatBringsPage(value) async {
    _pref = await SharedPreferences.getInstance();
    await _pref.setBool(has_seen_what_brings_page, value);
  }

  Future<bool> get getMigrationStatus async {
    _pref = await SharedPreferences.getInstance();
    bool value = _pref.getBool(is_migrated);
    return value;
  }

  setMigrationStatus(val) async {
    _pref = await SharedPreferences.getInstance();
    _pref.setBool(is_migrated, val);
  }

  setIsAskedForAppUpdate(bool value) async {
    _pref = await SharedPreferences.getInstance();
    _pref.setBool(has_asked_for_update, value);
  }

  Future<bool> get getIsAskedForAppUpdate async {
    _pref = await SharedPreferences.getInstance();
    bool value = _pref.getBool(has_asked_for_update);
    return value;
  }

  setUpdateDialogShownDate(value) async {
    _pref = await SharedPreferences.getInstance();
    _pref.setString(update_dialog_shown_date, value);
  }

  getUpdateDialogShownDate() async {
    _pref = await SharedPreferences.getInstance();
    return _pref.getString(update_dialog_shown_date);
  }

// ads_after_count_single_player

  setAdsAfterCount(int val) async {
    _pref = await SharedPreferences.getInstance();
    _pref.setInt(ads_after_count_single_player, val);
  }

  getAdAfterCount() async {
    _pref = await SharedPreferences.getInstance();
    return _pref.getInt(ads_after_count_single_player);
  }

  setFreeUsersDloadDeleted(bool val) async {
    _pref = await SharedPreferences.getInstance();
    await _pref.setBool(free_user_dloads_deleted, val);
  }

  getFreeUsersDloadDeleted() async {
    _pref = await SharedPreferences.getInstance();
    return _pref.getBool(free_user_dloads_deleted);
  }
}
