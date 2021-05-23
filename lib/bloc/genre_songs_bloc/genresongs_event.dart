part of 'genresongs_bloc.dart';

abstract class GenresongsEvent extends Equatable {
  const GenresongsEvent({this.categoryId, this.genreId});
  final int categoryId;
  final int genreId;
}

class FetchInitialGenreSongs extends GenresongsEvent {
  final int id;
  const FetchInitialGenreSongs({this.id}) : super(genreId: id);
  @override
  List<Object> get props => [];
}

class FetchFilterdGenreSongs extends GenresongsEvent {
  final int id;
  const FetchFilterdGenreSongs({this.id}) : super(categoryId: id);
  @override
  List<int> get props => [id];
}

class RetryFetchSongs extends GenresongsEvent {
  final int id;
  const RetryFetchSongs({this.id}) : super(genreId: id);
  @override
  List<Object> get props => [];
}

class RetryFilterFetchSongs extends GenresongsEvent {
  final int id;
  const RetryFilterFetchSongs({this.id}) : super(categoryId: id);
  @override
  List<int> get props => [id];
}

class LoadMoreGenreSongs extends GenresongsEvent {
  final int id;
  final bool isFilter;
  const LoadMoreGenreSongs({this.id, this.isFilter});
  @override
  List<Object> get props => [];
}

class RefreshGenreSongs extends GenresongsEvent {
  final int id;
  final int filterId;

  const RefreshGenreSongs({this.id, this.filterId});
  @override
  List<Object> get props => [];
}

class AllCategoryClicked extends GenresongsEvent {
  @override
  List<Object> get props => [];
}
