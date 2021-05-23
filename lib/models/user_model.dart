import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:goodvibesoffl/models/tag_model.dart';

class User {
  String uid,
      email,
      name,
      image,
      type,
      authToken,
      country,
      state,
      address,
      city,
      plan,
      gender;
  bool isLoggedIn, paid = false, passwordSet, freeTrial;

  bool isEligibleForIntroPrice;
  int meditationDay, minToday, badgeLevel;

  UserPlanType userPlanType;

  String dob;
  List<OptionsTag> tags = [];

  User(
      {this.uid,
        this.email,
        this.name,
        this.image,
        this.type,
        this.paid,
        this.isLoggedIn,
        this.authToken,
        this.passwordSet,
        this.meditationDay,
        this.minToday,
        this.badgeLevel,
        this.tags,
        this.freeTrial,
        this.address,
        this.city,
        this.country,
        this.dob,
        this.state,
        this.userPlanType,
        this.plan,
        this.gender,
        this.isEligibleForIntroPrice});

  factory User.fromJson(Map<String, dynamic> data) {
    bool userPaidFromPlan =
    data['user']['plan'].toString().toLowerCase() == "free" ? false : true;

    var _user = User(
        name: data['user']['full_name'],
        email: data['user']['email'],
        image: data["user"]['user_image'],
        type: data['user']['login_type'],
        uid: data['user']['id'].toString(),
        authToken: data['auth_token'],
        isLoggedIn: true,
        paid: userPaidFromPlan,
        //  data['user']['plan'].toString().toLowerCase() == "free"
        //     ? false
        //     : true,
        passwordSet: data['user']['password_set'],
        freeTrial: data["user"]["free_trail"],
        address: data["user"]["address"],
        city: data["user"]["city"],
        country: data["user"]["country"],
        dob: data["user"]["dob"] == null ? null : data["user"]["dob"],
        state: data["user"]["state"],
        plan: data['user']['plan'],
        tags: (!data["user"].containsKey("tag_groups")
            ? []
            : data["user"]["tag_groups"] as List)
            .map((e) => OptionsTag.fromJson(e))
            .toList(),
        userPlanType: getUserPlanType(plan: data["user"]['plan']),
        gender: data['user']["gender"],
        isEligibleForIntroPrice: data['user']['is_eligible_for_offer']);

    return _user;
  }

  factory User.fromDB(Map<String, dynamic> data) {
    return User(
      uid: data['uid'],
      email: data['email'],
      image: data['image'],
      name: data['name'],
      type: data['type'],
      authToken: data['authToken'],
      isLoggedIn: data['isLoggedIn'] == 1 ? true : false,
      paid: data['paid'] == 1 ? true : false,
      passwordSet: data['passwordSet'] == 1 ? true : false,
      badgeLevel: data["badgeLevel"],
      meditationDay: data["meditationDay"],
      minToday: data["minToday"],
      tags: (json.decode(data["tags"]) as List)
          ?.map((e) => OptionsTag.fromJson(e))
          ?.toList(),
      freeTrial: data["freeTrial"] == 1 ? true : false,
      country: data["country"],
      city: data["city"],
      state: data["state"],
      address: data["address"],
      dob: data["dob"] == null ? null : data["dob"],
      gender: data['gender'],
      userPlanType: getUserPlanType(
        plan: data['plan'],
      ),
    );
  }

  User copyWith(
      {String name,
        String email,
        String image,
        String type,
        String uid,
        String authToken,
        bool isLoggedIn,
        bool paid,
        bool passwordSet,
        int meditationDay,
        int minToday,
        int badgeLevel,
        List<OptionsTag> tags,
        bool freeTrial,
        String country,
        String city,
        String state,
        String address,
        String dob,
        String plan,
        String gender,
        bool isEligibleForIntroPrice,
        UserPlanType userPlanType}) {
    return User(
        name: name ?? this.name,
        authToken: authToken ?? this.authToken,
        email: email ?? this.email,
        image: image ?? this.image,
        type: type ?? this.type,
        uid: uid ?? this.uid,
        isLoggedIn: isLoggedIn ?? this.isLoggedIn,
        paid: paid ?? this.paid,
        passwordSet: passwordSet ?? this.passwordSet,
        badgeLevel: badgeLevel ?? this.badgeLevel,
        meditationDay: meditationDay ?? this.meditationDay,
        minToday: minToday ?? minToday,
        tags: tags ?? this.tags,
        freeTrial: freeTrial ?? this.freeTrial,
        address: address ?? this.address,
        city: city ?? this.city,
        country: country ?? this.country,
        dob: dob ?? this.dob,
        state: state ?? this.state,
        plan: plan,
        userPlanType: userPlanType ?? this.userPlanType,
        gender: gender ?? this.gender);
  }
}

UserPlanType getUserPlanType({@required String plan}) {
  switch (plan) {
    case free_user:
      return UserPlanType.Free;
      break;
    case free_trail_user:
      return UserPlanType.FreeTrial;
      break;
    case monthly_user:
      return UserPlanType.Monthly;
      break;
    case yearly_user:
      return UserPlanType.Yearly;
      break;
    case invitation_user:
      return UserPlanType.Invitation;
      break;
    case promo_user:
      return UserPlanType.Promo;
      break;
    default:
      return UserPlanType.Free;
  }
}

enum UserPlanType { Yearly, Monthly, Promo, Invitation, Free, FreeTrial }

const free_user = "Free";
const free_trail_user = "7 Days Trial";
const monthly_user = "monthly";
const yearly_user = "yearly";
const promo_user = "promo";
const invitation_user = "invitation";
