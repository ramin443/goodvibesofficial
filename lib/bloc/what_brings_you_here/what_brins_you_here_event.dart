part of 'what_brins_you_here_bloc.dart';

abstract class WhatBrinsYouHereEvent extends Equatable {
  const WhatBrinsYouHereEvent();
}

class FetchOptions extends WhatBrinsYouHereEvent {
  final List<int> usersAlreadySelectedOptions;
  FetchOptions({@required this.usersAlreadySelectedOptions});
  @override
  List<Object> get props => [...usersAlreadySelectedOptions];
}

class SelectOptionEvent extends WhatBrinsYouHereEvent {
  final id;
  const SelectOptionEvent({this.id});
  @override
  List<Object> get props => [];
}

class UnselectOptionEvent extends WhatBrinsYouHereEvent {
  final id;
  const UnselectOptionEvent({this.id});
  @override
  List<Object> get props => [];
}

class ConfirmOptionsEvent extends WhatBrinsYouHereEvent {
  final options;
  const ConfirmOptionsEvent({@required this.options});
  @override
  List<Object> get props => [];
}

class NavigateToOptionsPageFromProfile extends WhatBrinsYouHereEvent {
  final List<int> usersAlreadySelectedOptions;
  const NavigateToOptionsPageFromProfile({this.usersAlreadySelectedOptions});
  @override
  List<Object> get props => [...usersAlreadySelectedOptions];
}
