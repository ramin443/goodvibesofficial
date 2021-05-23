part of 'profilepage_bloc.dart';

abstract class ProfilepageEvent extends Equatable {
  const ProfilepageEvent();
}

class ProfileFetchData extends ProfilepageEvent {
  @override
  List<Object> get props => [];
}

class ProfileUpdateProfile extends ProfilepageEvent {
  final File image;

  ProfileUpdateProfile({@required this.image});

  @override
  List<Object> get props => throw UnimplementedError();
}

class ProfileRefreshData extends ProfilepageEvent {
  @override
  List<Object> get props => [];
}
