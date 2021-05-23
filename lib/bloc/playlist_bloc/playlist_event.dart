part of 'playlist_bloc.dart';

abstract class PlaylistEvent extends Equatable {
  const PlaylistEvent({this.slug});
  final String slug;
}

class PlaylistFetch extends PlaylistEvent {
  final String slug;
  PlaylistFetch({@required this.slug}) : super(slug: slug);
  @override
  List<String> get props => [slug];
}

class PlaylistReFetch extends PlaylistEvent {
  final String slug;
  PlaylistReFetch({@required this.slug}) : super(slug: slug);
  @override
  List<String> get props => [slug];
}

class FetchMorePlaylistData extends PlaylistEvent {
  @override
  List<Object> get props => [];
}
