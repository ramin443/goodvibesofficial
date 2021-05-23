import 'package:equatable/equatable.dart';

abstract class CommonState extends Equatable {
  const CommonState();
}

class InitialState extends CommonState {
  @override
  List<Object> get props => [];
}

class LoadingState extends CommonState {
  @override
  List<Object> get props => [];
}

class ErrorState extends CommonState {
  final errorMessage;
  const ErrorState({this.errorMessage});
  @override
  List<Object> get props => errorMessage;
}

class NoDataState extends CommonState {
  @override
  List<Object> get props => [];
}

class DataFetchedState<T> extends CommonState {
  final List<T> tracksList;
  DataFetchedState({this.tracksList});
  @override
  List<Object> get props => [...tracksList];
}

class AlreadyLoadedState<T> extends CommonState {
  final List<T> tracksList;
  const AlreadyLoadedState({this.tracksList});
  @override
  List<Object> get props => [...tracksList];
}

class RefreshingState<T> extends CommonState {
  final List<T> tracksList;
  RefreshingState({this.tracksList});
  @override
  List<Object> get props => [...tracksList];
}
