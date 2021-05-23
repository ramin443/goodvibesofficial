part of 'genrepage_bloc.dart';

abstract class GenrePageEvent extends Equatable {
  const GenrePageEvent();
}

class GenrePageFetchGenreData extends GenrePageEvent {
  @override
  List<Object> get props => [];
}

class GenrePageRetryFetch extends GenrePageEvent {
  @override
  List<Object> get props => [];
}

class GenrePageSearchTracks extends GenrePageEvent {
  final String searchTerm;
  GenrePageSearchTracks({@required this.searchTerm});
  @override
  List<Object> get props => [];
}

class GenrePageSearchRetry extends GenrePageEvent {
  final String searchTerm;
  GenrePageSearchRetry({@required this.searchTerm});
  @override
  List<Object> get props => [];
}

class GenrePageSearchFetchMoreData extends GenrePageEvent {
  GenrePageSearchFetchMoreData();
  @override
  List<Object> get props => [];
}

class BackToGenreResults extends GenrePageEvent {
  @override
  List<Object> get props => [];
}

class GenrePageRefresh extends GenrePageEvent {
  @override
  List<Object> get props => [];
}

class GenreResearch extends GenrePageEvent {
  final String searchTerm;
  GenreResearch({@required this.searchTerm});
  @override
  List<Object> get props => [searchTerm];
}
