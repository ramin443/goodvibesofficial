part of 'view_all_bloc.dart';

abstract class ViewAllEvent extends Equatable {
  final String slug;
  const ViewAllEvent({this.slug});
}

class ViewAllFetchData extends ViewAllEvent {
  final String slug;
  const ViewAllFetchData({this.slug}) : super(slug: slug);
  @override
  List<Object> get props => [];
}

class ViewAllReFetchData extends ViewAllEvent {
  @override
  List<Object> get props => [];
}

class ViewAllFetchMoreData extends ViewAllEvent {
  @override
  List<Object> get props => [];
}

class ViewAllRefreshTrack extends ViewAllEvent {
  @override
  List<Object> get props => [];
}

class InitialViewAllEvent<T> extends ViewAllEvent {
  final List<T> tracks;
  final String slug;
  const InitialViewAllEvent({this.tracks, this.slug}) : super(slug: slug);
  @override
  List<Object> get props => [...tracks];
}
