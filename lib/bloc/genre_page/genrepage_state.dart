part of "genrepage_bloc.dart";

abstract class GenrePageState extends Equatable {
  const GenrePageState();
}

class GenrePageInitial extends GenrePageState {
  @override
  List<Object> get props => [];
}

class GenrePageOffline extends GenrePageState {
  @override
  List<Object> get props => [];
}

class GenrePageLoading extends GenrePageState {
  @override
  List<Object> get props => [];
}

class GenrePageFetchGenre extends GenrePageState {
  final List<Genre> genreList;

  GenrePageFetchGenre({
    @required this.genreList,
  });
  @override
  List<Object> get props => [...genreList];
}

class GenrePageWithNoData extends GenrePageState {
  @override
  List<Object> get props => null;
}

class GenrePageWithError extends GenrePageState {
  final String errorMessage;

  GenrePageWithError({@required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

class GenrePageSearchLoading extends GenrePageState {
  @override
  List<Object> get props => [];
}

class GenrePageSearchFetch extends GenrePageState {
  GenrePageSearchFetch({@required this.tracksList});
  final List<Track> tracksList;
  @override
  List<Track> get props => [...tracksList];
}

class GenrePageSearchWithNoData extends GenrePageState {
  @override
  List<Object> get props => null;
}

class GenrePageSearchWithError extends GenrePageState {
  final String errorMessage;

  GenrePageSearchWithError({@required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

class GenrePageSearchFetchMoreLoading extends GenrePageState {
  final List<Track> tracksList;
  const GenrePageSearchFetchMoreLoading({this.tracksList});

  @override
  List<Track> get props => [...tracksList];
}

class GenrePageSearchFetchMoreSuccess extends GenrePageState {
  final List<Track> tracksList;
  const GenrePageSearchFetchMoreSuccess({this.tracksList});

  @override
  List<Track> get props => [...tracksList];
}

class GenrePageSearchFetchMoreError extends GenrePageState {
  final List<Track> tracksList;
  const GenrePageSearchFetchMoreError({this.tracksList});

  @override
  List<Track> get props => [...tracksList];
}

class GenreApiLoading extends GenrePageState {
  @override
  List<Object> get props => [];
}
