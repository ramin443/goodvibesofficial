part of 'view_all_bloc.dart';

abstract class ViewAllState extends Equatable {
  const ViewAllState();
}

class ViewAllInitial extends ViewAllState {
  @override
  List<Object> get props => [];
}

class ViewAllLoading extends ViewAllState {
  @override
  List<Object> get props => [];
}

class ViewAllError extends ViewAllState {
  final String errorMessage;

  ViewAllError({@required this.errorMessage});
  @override
  List<Object> get props => [];
}

class ViewAllSuccessWithData<Playable> extends ViewAllState {
  final List<Playable> tracks;
  ViewAllSuccessWithData({@required this.tracks});
  @override
  List<Playable> get props => [...tracks];
}

class ViewAllSuccessWithNoData extends ViewAllState {
  @override
  List<Object> get props => [];
}

class ViewAllApiLoading<Playable> extends ViewAllState {
  final List<Playable> tracks;
  const ViewAllApiLoading({this.tracks});
  @override
  List<Playable> get props => [...tracks];
}

class ViewAllApiError<Playable> extends ViewAllState {
  final String errorMessage;
  final List<Playable> tracks;
  ViewAllApiError({@required this.errorMessage, this.tracks});
  @override
  List<Playable> get props => [...tracks];
}

class ViewAllRefreshApiLoading extends ViewAllState {
  @override
  List<Object> get props => [];
}

class InitialStateWithAlreadyData<Playable> extends ViewAllState {
  final List<Playable> tracks;
  const InitialStateWithAlreadyData({this.tracks});
  @override
  List<Playable> get props => [...tracks];
}
