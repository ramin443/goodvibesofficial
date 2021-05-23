import 'dart:io';

class AppUpdateModel {
  final String version;
  final String updatedAt;
  final String whatsNew;
  final bool isForce;

  const AppUpdateModel(
      {this.version, this.updatedAt, this.whatsNew, this.isForce});

  factory AppUpdateModel.fromAndroid(Map<String, dynamic> json) {
    return AppUpdateModel(
      version: json["version"],
      isForce: json["is_force"],
      updatedAt: json["updated_at"],
      whatsNew: json['whats_new'],
    );
  }
  factory AppUpdateModel.fromIOS(Map<String, dynamic> json) {
    return AppUpdateModel(
      version: json["version"],
      isForce: json["is_force"],
      updatedAt: json["updated_at"],
      whatsNew: json['whats_new'],
    );
  }
  factory AppUpdateModel.fromJson(Map<String, dynamic> json) {
    var data = json["app_version"];
    var _json = Platform.isAndroid ? data["android"] : data["iOS"];

    return AppUpdateModel(
      version: _json["version"],
      isForce: _json["is_force"],
      updatedAt: _json["updated_at"],
      whatsNew: _json['whats_new'] ?? "",
    );
  }
}
