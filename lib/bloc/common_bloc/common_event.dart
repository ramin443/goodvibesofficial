import 'package:equatable/equatable.dart';

abstract class CommonEvent extends Equatable {
  const CommonEvent();
}

class FetchTracks extends CommonEvent {
  @override
  List<Object> get props => [];
}

class RetryFetchTrcks extends CommonEvent {
  @override
  List<Object> get props => [];
}

class RefreshItems extends CommonEvent {
  @override
  List<Object> get props => [];
}
