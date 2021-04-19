import 'package:connectivity/connectivity.dart';

checkIfOffline() async {
  var result = await Connectivity().checkConnectivity();
  if (result == ConnectivityResult.none) {
    return true;
  }
  return false;
}
recordCrashlyticsLog(String value) {
//  FirebaseCrashlytics.instance.log(value);
}
void dPrint(message) {
  // print(message);
}
getSecondsFromDurationString(String duration) {
  var list = duration.split(":");

  if (list.isNotEmpty) {
    var seconds = double.parse(list[0]) * 60 * 60 +
        double.parse(list[1]) * 60 +
        double.parse(list[2]);

    return seconds;
  } else {
    return 0.0;
  }
}
recordNavigationAnalytics(
    {String source, String destination, String pageEventName}) {
//  final _fbEvent = FacebookAppEvents();


}

bool getBoolFromInt(int numb) {
  return numb == 1;
}
Duration getDurationFromDouble(double duration) {
  return Duration(milliseconds: duration.floor() * 1000);
}
trimDownloadFilename(String filename) {
  if (filename.length > 50) {
    /// i,.e get file extension from full filename and  append file extension .mp3, .ogg afterwards
    var extensionType = filename.substring(filename.length - 4);

    return filename.substring(0, 50).trim() + extensionType;
  } else {
    return filename;
  }
}