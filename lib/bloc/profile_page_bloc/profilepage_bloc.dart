import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
//import 'package:goodvibesoffl/locator.dart';
import 'package:goodvibesoffl/models/profile_model.dart';
import 'package:goodvibesoffl/providers/homepage_providers/recommend_dialog_provider.dart';
import 'package:goodvibesoffl/providers/login_provider.dart';
import 'package:goodvibesoffl/services/api_service.dart';
import 'package:goodvibesoffl/services/user_service.dart';

part 'profilepage_event.dart';
part 'profilepage_state.dart';

class ProfilepageBloc extends Bloc<ProfilepageEvent, ProfilepageState> {
  final apiService = ApiService();
  final loginService = LoginProvider();
  final user = UserService().user;

  ProfilepageBloc() : super(ProfilepageInitial());

  @override
  Stream<ProfilepageState> mapEventToState(
    ProfilepageEvent event,
  ) async* {
    if (event is ProfileFetchData) {
      if (user.value == null)
        yield ProfileLoading();
      else
        yield ProfileApiLoading();
      final response =
          await apiService.getUserProfileData() as Map<String, dynamic>;
      if (response == null) {
        yield ProfileSuccess(profile: null);
      } else if (response.containsKey("data")) {
        final data = ProfileModel.fromJson(response['data']);

        int _level = int.tryParse(data.level);
        user.value = user.value.copyWith(
          minToday: data.appTimeToday,
          meditationDay: data.activeDayCount,
          badgeLevel:
              (_level == null || _level < 1 || _level > 10) ? 1 : _level,
          tags: data.tags,
        );

        RecommendDialogButtonProvider()
            .addIntoSelectedList(data.taggingsIdList);

        loginService.updateUserTable(user: user.value);
        yield ProfileSuccess(profile: data);
      } else if (response.containsKey("error")) {
        yield ProfileSuccess(profile: null);
      }
    } else if (event is ProfileUpdateProfile) {
      final profile = (state as ProfileSuccess).profile;
      yield ProfileUploadLoading();
      final response =
          await LoginProvider().changeProfileImage(image: event.image);
      if (response["success"]) {
        yield ProfileSuccess(profile: profile);
      } else {
        yield ProfileUploadError(errorMessage: response["error"]);
        yield ProfileSuccess(profile: profile);
      }
    } else if (event is ProfileRefreshData) {
      final profile = (state as ProfileSuccess).profile;
      yield ProfileLoading();
      yield ProfileSuccess(profile: profile);
    }
  }
}
