class SettingsModel {
  final int id;
  final String email;
  final String fullName;
  final String country;
  final String city;
  final String state;
  final String address;
  final String key;
  final dynamic device;
  final bool paid;
  final bool freeTrail;
  final String loginType;
  final bool admin;
  final String userImage;
  final String userImageStandard;
  final bool active;
  final String createdAt;
  final String plan;
  final String status;
  final bool passwordSet;
  final Settings settings;
  final dynamic dob;
  final dynamic disabled;
  final dynamic deactivated;
  final dynamic deactivateReason;
  final List<Tag> tags;
  final List<dynamic> tagGroups;
  final String gender;
  bool dailyUpdatesPush;
  bool offersPush;
  bool othersPush;
  bool isEligibleForIntroPrice;

  SettingsModel(
      {this.id,
        this.email,
        this.fullName,
        this.country,
        this.city,
        this.state,
        this.address,
        this.key,
        this.device,
        this.paid,
        this.freeTrail,
        this.loginType,
        this.admin,
        this.userImage,
        this.userImageStandard,
        this.active,
        this.createdAt,
        this.plan,
        this.status,
        this.passwordSet,
        this.settings,
        this.dob,
        this.disabled,
        this.deactivated,
        this.deactivateReason,
        this.tags,
        this.tagGroups,
        this.dailyUpdatesPush,
        this.offersPush,
        this.othersPush,
        this.gender,
        this.isEligibleForIntroPrice});

  factory SettingsModel.fromJson(Map<String, dynamic> json) {
    bool userPaidFromPlan =
    json['plan'].toString().toLowerCase() == "free" ? false : true;

    return SettingsModel(
        id: json["id"],
        email: json["email"],
        fullName: json["full_name"],
        country: json["country"],
        city: json["city"],
        state: json["state"],
        address: json["address"],
        key: json["key"],
        device: json["device"],
        paid: userPaidFromPlan //json["paid"]
        ,
        freeTrail: json["free_trail"],
        loginType: json["login_type"],
        admin: json["admin"],
        userImage: json["user_image"],
        userImageStandard: json["user_image_standard"],
        active: json["active"],
        createdAt: json["created_at"],
        plan: json["plan"],
        status: json["status"],
        passwordSet: json["password_set"],
        settings: Settings.fromJson(json["settings"]),
        dob: json["dob"],
        disabled: json["disabled"],
        deactivated: json["deactivated"],
        deactivateReason: json["deactivate_reason"],
        tags: List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x))),
        tagGroups: List<dynamic>.from(
          json["tag_groups"].map((x) => x),
        ),
        dailyUpdatesPush: json["settings"]["daily_updates_push"],
        offersPush: json["settings"]["offers_push"],
        othersPush: json["settings"]["others_push"],
        gender: json["gender"],
        isEligibleForIntroPrice: json['is_eligible_for_offer']);
  }
  factory SettingsModel.fromDb(Map<String, dynamic> json) {
    bool userPaidFromPlan =
    json['plan'].toString().toLowerCase() == "free" ? false : true;

    return SettingsModel(
      id: json["id"],
      email: json["email"],
      fullName: json["full_name"],
      country: json["country"],
      city: json["city"],
      state: json["state"],
      address: json["address"],
      key: json["key"],
      device: json["device"],
      paid: userPaidFromPlan, //getBool(json["paid"] ?? "0"),
      freeTrail: getBool(json["free_trail"] ?? "0"),
      loginType: json["login_type"],
      admin: getBool(json["admin"] ?? "0"),
      userImage: json["user_image"],
      userImageStandard: json["user_image_standard"],
      active: getBool(json["active"] ?? "0"),
      createdAt: json["created_at"],
      plan: json["plan"],
      status: json["status"],
      disabled: getBool(json["disabled"] ?? "0"),
      dailyUpdatesPush: getBool(json["daily_updates_push"] ?? "0"),
      offersPush: getBool(json["offers_push"] ?? "0"),
      othersPush: getBool(json["others_push"] ?? "0"),
      gender: json["gender"],
    );
  }

  static bool getBool(String value) {
    return value == "1";
  }
}

class Settings {
  final bool dailyUpdatesPush;
  final bool offersPush;
  final bool othersPush;

  Settings({
    this.dailyUpdatesPush,
    this.offersPush,
    this.othersPush,
  });

  factory Settings.fromJson(Map<String, dynamic> json) => Settings(
    dailyUpdatesPush: json["daily_updates_push"],
    offersPush: json["offers_push"],
    othersPush: json["others_push"],
  );
}

class Tag {
  final int id;
  final String name;

  Tag({this.id, this.name});

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
    id: json["id"],
    name: json["name"],
  );
}
