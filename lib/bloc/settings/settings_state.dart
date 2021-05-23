part of 'settings_bloc.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();
}

class SettingsInitial extends SettingsState {
  @override
  List<Object> get props => [];
}

class SettingsLoading extends SettingsState {
  @override
  List<Object> get props => [];
}

class SettingsFetched extends SettingsState {
  final SettingsModel settings;
  const SettingsFetched({this.settings});
  @override
  List<Object> get props => [settings];
}

class NotificationSettingsLoading extends SettingsState {
  @override
  List<Object> get props => [];
}

class NotificationSettingsChanged extends SettingsState {
  final SettingsModel settings;
  const NotificationSettingsChanged({this.settings});
  @override
  List<Object> get props => [settings];
}

class NotificationSettingToggleError extends SettingsState {
  final String errorMessage;
  final SettingsModel settings;
  const NotificationSettingToggleError({this.errorMessage, this.settings});
  @override
  List<Object> get props => [];
}
