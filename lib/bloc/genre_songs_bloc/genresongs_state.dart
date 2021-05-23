part of 'genresongs_bloc.dart';

abstract class GenresongsState {
  const GenresongsState({this.tracks});
  final List<Track> tracks;
}

class GenresongsInitial extends GenresongsState {
  List<Track> get props => [];
}

class GenreSongsLoading extends GenresongsState {
  List<Track> get props => [];
}

class GenreSongsFilterLoading extends GenresongsState {
  final int filterId;

  const GenreSongsFilterLoading({this.filterId});

  List<int> get props => [filterId];
}

class GenreSongsFetchedWithData extends GenresongsState {
  final List<Track> tracks;
  const GenreSongsFetchedWithData({this.tracks}) : super(tracks: tracks);

  List<Track> get props => [...tracks];
}

class GenreSongsNoData extends GenresongsState {
  List<Track> get props => [];
}

class GenreSongsFetchError extends GenresongsState {
  final String errorMessage;
  const GenreSongsFetchError({this.errorMessage});

  List<Track> get props => [];
}

class GenreSongsFilterError extends GenresongsState {
  final String errorMessage;
  const GenreSongsFilterError({this.errorMessage});

  List<Track> get props => [];
}

class GenreSongsLoadMoreLoading extends GenresongsState {
  const GenreSongsLoadMoreLoading({this.tracks}) : super(tracks: tracks);
  final List<Track> tracks;

  List<Track> get props => [...tracks];
}

class GenreSongsLoadMoreError extends GenresongsState {
  const GenreSongsLoadMoreError({this.tracks}) : super(tracks: tracks);

  final List<Track> tracks;

  List<Track> get props => [...tracks];
}

class GenreSongsRefreshError extends GenresongsState {
  final String errorMessgae;
  final List<Track> tracks;
  const GenreSongsRefreshError({this.errorMessgae, this.tracks});

  List<Track> get props => [...tracks];
}

class GenreSongsRefreshing extends GenresongsState {
  final List<Track> tracks;
  const GenreSongsRefreshing({this.tracks}) : super(tracks: tracks);

  List<Track> get props => [...tracks];
}
