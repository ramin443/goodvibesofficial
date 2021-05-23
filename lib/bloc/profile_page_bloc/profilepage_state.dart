part of 'profilepage_bloc.dart';

abstract class ProfilepageState extends Equatable {
  const ProfilepageState();
}

class ProfilepageInitial extends ProfilepageState {
  @override
  List<Object> get props => [];
}

class ProfileLoading extends ProfilepageState {
  @override
  List<Object> get props => [];
}

class ProfileSuccess extends ProfilepageState {
  final ProfileModel profile;

  ProfileSuccess({@required this.profile});

  @override
  List<Object> get props => [profile];
}

class ProfileError extends ProfilepageState {
  final String errorMessage;

  ProfileError({@required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

class ProfileApiLoading extends ProfilepageState {
  ProfileApiLoading();
  @override
  List<Object> get props => [];
}

class ProfileUploadLoading extends ProfilepageState {
  ProfileUploadLoading();
  @override
  List<Object> get props => [];
}

class ProfileUploadError extends ProfilepageState {
  final String errorMessage;
  ProfileUploadError({@required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
