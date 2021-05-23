part of "favourite_bloc.dart";

abstract class FavouriteState extends Equatable {
  const FavouriteState();
}

class InitialState extends FavouriteState {
  @override
  List<Object> get props => [];
}

class LoadingState extends FavouriteState {
  @override
  List<Object> get props => [];
}

class FavouriteDataFetched extends FavouriteState {
  final List<Track> tracksList;
  const FavouriteDataFetched({@required this.tracksList});
  @override
  List<Object> get props => [...tracksList];
}

class FavouriteSuccess extends FavouriteState {
  @override
  List<Object> get props => [];
}

class FavouriteFail extends FavouriteState {
  @override
  List<Object> get props => [];
}

class FavouriteActionLoading extends FavouriteState {
  @override
  List<Object> get props => [];
}

class FavouriteNoData extends FavouriteState {
  @override
  List<Object> get props => [];
}

class FavouriteDataFetchError extends FavouriteState {
  final String errorMessage;
  const FavouriteDataFetchError({@required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

class FavoriteApiLoading extends FavouriteState {
  @override
  List<Object> get props => [];
}
