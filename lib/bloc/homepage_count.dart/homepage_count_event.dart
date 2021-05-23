part of 'homepage_count_bloc.dart';

abstract class HomepageCountEvent extends Equatable {
  const HomepageCountEvent();
}

class FetchConfigEvent extends HomepageCountEvent {
  @override
  List<Object> get props => [];
}
