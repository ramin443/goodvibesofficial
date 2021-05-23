part of 'homepage_count_bloc.dart';

abstract class HomepageCountState extends Equatable {
  const HomepageCountState();
}

class CountInitial extends HomepageCountState {
  @override
  List<Object> get props => [];
}

class CountLoading extends HomepageCountState {
  final String count;
  final int unseenNotifs;
  const CountLoading({this.count, this.unseenNotifs});
  @override
  List<Object> get props => [];
}

class ConfigFetched extends HomepageCountState {
  final String count;
  final int unseenNotifs;
  const ConfigFetched({this.count, this.unseenNotifs});
  @override
  List<Object> get props => [];
}

class ConfigFetchError extends HomepageCountState {
  @override
  List<Object> get props => [];
}

class NoConfigData extends HomepageCountState {
  @override
  List<Object> get props => [];
}
