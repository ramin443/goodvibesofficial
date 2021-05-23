part of 'favouriteicon_bloc.dart';

abstract class FavouriteiconEvent extends Equatable {
  const FavouriteiconEvent();
}

class FavouriteIconAction extends FavouriteiconEvent {
  final Track track;
  const FavouriteIconAction({@required this.track});
  @override
  List<Object> get props => [];
}

class AddFavourite extends FavouriteiconEvent {
  final Track track;
  const AddFavourite({@required this.track});
  @override
  List<Object> get props => [];
}

class RemoveFavourite extends FavouriteiconEvent {
  final Track track;
  const RemoveFavourite({@required this.track});

  @override
  List<Object> get props => [];
}
