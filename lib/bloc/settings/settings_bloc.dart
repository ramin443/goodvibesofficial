import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:goodvibesoffl/models/settings_model.dart';
import 'package:goodvibesoffl/repository/settingsRepository.dart';
import 'package:goodvibesoffl/services/user_service.dart';

import '../../locator.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final _settingsRepository = SettingsRepository();

  SettingsBloc() : super(SettingsInitial());

  @override
  Stream<SettingsState> mapEventToState(
    SettingsEvent event,
  ) async* {
    // print("state: $state  and  event: $event");

    if (event is FetchSettings) {
      yield SettingsLoading();
      await _settingsRepository.getSettings();
      yield SettingsFetched(settings: _settingsRepository.settings);
    } else if (event is GetuserAccountDetails) {
      if (state is SettingsLoading) {
        // print(event.props);
        event.nameController.text = locator<UserService>().user.value.name;
        event.emailController.text = locator<UserService>().user.value.email;
      } else if (state is SettingsFetched) {
        event.nameController.text = locator<UserService>().user.value.name;
        event.emailController.text = locator<UserService>().user.value.email;
      }

      /// if user navigates to edit account from profile
      else {
        event.nameController.text = locator<UserService>().user.value.name;
        event.emailController.text = locator<UserService>().user.value.email;
      }
    } else if (event is ToggleSettingsSwitch) {
      var key = event.key;
      bool value = event.value;

      _settingsRepository.notificationMap[key] = value;
      _settingsRepository.updateNotificationSettings(context: event.context);

      if (state is NotificationSettingsChanged)
        yield SettingsFetched(settings: _settingsRepository.settings);
      else if (state is SettingsFetched) {
        yield NotificationSettingsChanged(
            settings: _settingsRepository.settings);
      }
      // } else {
      //   yield NotificationSettingsChanged(
      //       settings: _settingsRepository.settings);
      // }

      // if (_settingsRepository.hasNotificationToggleError) {
      //   _settingsRepository.notificationMap[key] = !value;
      //   _settingsRepository.updateSettingsVariable();
      //   yield NotificationSettingToggleError(
      //       errorMessage: "this is error",
      //       settings: _settingsRepository.settings);
      // }
    }
  }
}
