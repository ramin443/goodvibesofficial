
import 'package:goodvibesoffl/models/user_model.dart';

class InviteModel {
  int id;
  String email;
  bool active;

  bool accpted;
  String date;
  User user;
  InviteModel(
      {this.id, this.email, this.accpted, this.active, this.date, this.user});

  factory InviteModel.fromJson(Map<String, dynamic> json) {
    return InviteModel(
      id: json["id"],
      email: json['email'],
      active: json['active'],
      accpted: json['accepted'],
      date: json["created_at"],
      user: (json.containsKey("user")) ? User.fromJson(json) : null,
    );
  }
}
