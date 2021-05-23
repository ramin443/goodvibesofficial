part of "favourite_bloc.dart";

abstract class FavouriteEvent extends Equatable {
  const FavouriteEvent();
}

class FetchFavourite extends FavouriteEvent {
  @override
  List<Object> get props => [];
}

class FavoriteRefreshData extends FavouriteEvent {
  @override
  List<Object> get props => [];
}
// class AddFavourite extends FavouriteEvent {
//   final int id;
//   const AddFavourite({@required this.id});
//   @override
//   List<Object> get props => [];
// }

// class RemoveFavourite extends FavouriteEvent {
//   final int id;
//   const RemoveFavourite({@required this.id});

//   @override
//   List<Object> get props => [];
// }
