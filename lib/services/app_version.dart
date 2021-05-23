class AppVersion {
  static final AppVersion _instance = AppVersion._internal();
  AppVersion._internal();
  factory AppVersion() {
    return _instance;
  }

  String _appVersion = "";

  set setAppVersion(value) {
    // print("app version : $value");
    _appVersion = value;
  }

  String get appVersion => _appVersion;
}
