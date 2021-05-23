part of 'playlist_bloc.dart';

abstract class PlaylistState extends Equatable {
  const PlaylistState();
}

class PlaylistInitial extends PlaylistState {
  @override
  List<Object> get props => [];
}

class PlaylistLoading extends PlaylistState {
  @override
  List<Object> get props => [];
}

class PlaylistError extends PlaylistState {
  final String errorMessage;
  PlaylistError({@required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

class PlaylistNoData extends PlaylistState {
  @override
  List<Object> get props => [];
}

class PlaylistWithData extends PlaylistState {
  final List<Track> tracks;

  PlaylistWithData({@required this.tracks});
  @override
  List<Track> get props => [...tracks];
}

class PlaylistFetchMoreLoading extends PlaylistState {
  final List<Track> tracks;

  PlaylistFetchMoreLoading({@required this.tracks});
  @override
  List<Track> get props => [...tracks];
}

class PlaylistFetchMoreError extends PlaylistState {
  final List<Track> tracks;

  PlaylistFetchMoreError({@required this.tracks});
  @override
  List<Track> get props => [...tracks];
}
