part of 'rituals_bloc.dart';

abstract class RitualsState extends Equatable {
  const RitualsState(
      {this.trackList,
        this.ritualsPlaylists,
        this.playlistPlayables,
        this.startedPlaylists,
        this.favouritePlaylists});

  final List<Playablee> trackList;
  final List<PlayList> ritualsPlaylists;
  final List<PlayList> startedPlaylists;
  final List<Playablee> playlistPlayables;
  final List<PlayList> favouritePlaylists;

  @override
  List<Object> get props => [];
}

class RitualsTrackLoading extends RitualsState {}

class RitualsPlaylistLoading extends RitualsState {}

class RitualsTracksRefreshing extends RitualsState {
  final List<Playablee> trackList;
  const RitualsTracksRefreshing({this.trackList}) : super(trackList: trackList);
}

class RitualsPlaylistRefreshing extends RitualsState {
  final List<PlayList> playlist;
  final List<PlayList> startedRituals;
  const RitualsPlaylistRefreshing({this.playlist, this.startedRituals})
      : super(ritualsPlaylists: playlist, startedPlaylists: startedRituals);
}

class RitualsTracksFetched extends RitualsState {
  final List<Playablee> trackList;
  const RitualsTracksFetched({this.trackList}) : super(trackList: trackList);
}

class RitualsNoData extends RitualsState {}

class RitualsError extends RitualsState {
  final String message;
  const RitualsError({this.message});
}

class RitualsPlaylistNoData extends RitualsState {}

class RitualsPlaylistsError extends RitualsState {
  final message;
  const RitualsPlaylistsError({this.message});
}

class RitualsPlaylistsFetched extends RitualsState {
  final List<PlayList> playlists;
  final List<PlayList> startedPlaylists;
  const RitualsPlaylistsFetched({this.playlists, this.startedPlaylists})
      : super(ritualsPlaylists: playlists);
}

class MoreRitualsFetched extends RitualsState {
  final List<Playablee> playlists;
  const MoreRitualsFetched({this.playlists})
      : super(playlistPlayables: playlists);
}

class MoreRitualsLoading extends RitualsState {}

class MoreRitualsRefreshing extends RitualsState {
  final List<Playablee> playlists;
  const MoreRitualsRefreshing({this.playlists})
      : super(playlistPlayables: playlists);
}

class MoreRitualsError extends RitualsState {
  final String message;
  const MoreRitualsError({this.message});
}

class MoreRitualsNoData extends RitualsState {}

class StartedRitualsFetched extends RitualsState {
  final List<PlayList> playlists;
  const StartedRitualsFetched({this.playlists})
      : super(ritualsPlaylists: playlists);
}

class StartedRitualsLoading extends RitualsState {}

class StartedRitualsNoData extends RitualsState {}

class StartedRitualsRefreshing extends RitualsState {}

class FavouriteButtonState extends RitualsState {
  final List<PlayList> playlists;
  const FavouriteButtonState(this.playlists);
}

class DummyState extends RitualsState {}
