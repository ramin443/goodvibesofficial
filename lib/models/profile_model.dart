import 'package:goodvibesoffl/models/tag_model.dart';
import 'package:goodvibesoffl/utils/strings/string_constants.dart';
import 'package:goodvibesoffl/models/tag_model.dart';

class ProfileModel {
  int activeDayCount;
  int appTimeToday;
  int appTimeLifeTime;
  List<OptionsTag> tags;
  List<int> taggingsIdList;
  String image;
  String level;

  ProfileModel(
      {this.activeDayCount,
      this.appTimeToday,
      this.appTimeLifeTime,
      this.tags,
      this.image,
      this.level,
      this.taggingsIdList});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    activeDayCount = json['active_day_count'];
    appTimeToday = json['app_time_today'];
    appTimeLifeTime = json['app_time_life_time'];
    if (json["tags"] != null) {
      var tagsList = json["tags"] as List;
      List<int> newList = tagsList.map<int>((t) => t["id"]).toList();

      //  print(" taggings list in model: $newList");
      taggingsIdList = newList;
    }

    if (json['tag_groups'] != null) {
      tags = new List<OptionsTag>();
      json['tag_groups'].forEach((v) {
        tags.add(OptionsTag.fromJson(v));
      });
    }
    image = json['image'] ?? placeholder_url;
    level = json['level'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['active_day_count'] = this.activeDayCount;
    data['app_time_today'] = this.appTimeToday;
    data['app_time_life_time'] = this.appTimeLifeTime;
    if (this.tags != null) {
      data['tag_groups'] = this.tags;
    }
    data['image'] = this.image;
    data['level'] = this.level;
    return data;
  }
}
