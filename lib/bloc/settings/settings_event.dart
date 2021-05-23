part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();
}

class FetchSettings extends SettingsEvent {
  @override
  List<Object> get props => [];
}

class GetuserAccountDetails extends SettingsEvent {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController stateController;
  final TextEditingController cityController;
  final TextEditingController addressController;

  const GetuserAccountDetails({
    @required this.nameController,
    @required this.emailController,
    this.stateController,
    this.cityController,
    this.addressController,
  });
  @override
  List<Object> get props => [nameController, emailController];
}

class ToggleSettingsSwitch extends SettingsEvent {
  final String key;
  final bool value;
  final BuildContext context;
  const ToggleSettingsSwitch(
      {@required this.value, @required this.key, this.context});
  @override
  List<Object> get props => [];
}
