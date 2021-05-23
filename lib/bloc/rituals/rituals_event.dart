part of 'rituals_bloc.dart';

abstract class RitualsEvent extends Equatable {
  const RitualsEvent();

  @override
  List<Object> get props => [];
}

class FetchRitualsPlaylists extends RitualsEvent {}

class FetchRitualsTracks extends RitualsEvent {
  final int ritualId;

  const FetchRitualsTracks({@required this.ritualId});
}

class RefreshRitualsTracks extends RitualsEvent {
  final int ritualId;

  const RefreshRitualsTracks({@required this.ritualId});
}

class RefreshRitualsPlaylist extends RitualsEvent {}

class DownloadRitualsPlaylist extends RitualsEvent {
  final int playlistId;

  const DownloadRitualsPlaylist({this.playlistId});
}

class CancelRitualsDownload extends RitualsEvent {
  final int playlistId;

  const CancelRitualsDownload({this.playlistId});
}

class RitualsFavouriteEvent extends RitualsEvent {
  final int playlistId;

  const RitualsFavouriteEvent({this.playlistId});
}

class FetchMoreRituals extends RitualsEvent {}

class RefreshMoreRituals extends RitualsEvent {}

class FetchStartedRituals extends RitualsEvent {}

class RefreshStartedRituals extends RitualsEvent {}

class FavouriteButtonPressed extends RitualsEvent {
  final PlayList playlist;

  const FavouriteButtonPressed(this.playlist);
}

class CheckRitualFavouriteStatus extends RitualsEvent {
  final PlayList playlist;

  const CheckRitualFavouriteStatus(this.playlist);
}
