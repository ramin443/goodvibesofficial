import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:goodvibesoffl/models/music_model.dart';

part 'favouriteicon_event.dart';
part 'favouriteicon_state.dart';

class FavouriteiconBloc extends Bloc<FavouriteiconEvent, FavouriteiconState> {
  FavouriteiconBloc() : super(FavouriteiconInitial());

  @override
  Stream<FavouriteiconState> mapEventToState(
    FavouriteiconEvent event,
  ) async* {
    if (state is FavouriteiconInitial) {
      if (event is RemoveFavourite) {
        yield FavouriteiconActionLoading();
        // await _favIconProvider.removeFavourite(event.track);
        // if (!_favIconProvider.hasError) {
        //   yield FavouriteFalse();
        // }
      }
    } else if (state is FavouriteFalse) {
      if (event is AddFavourite) {
        yield FavouriteiconActionLoading();
        // await _favIconProvider.removeFavourite(event.track);
      }
    } else if (state is FavouriteTrue) {
      if (event is RemoveFavourite) {
        yield FavouriteiconActionLoading();
        // await _favIconProvider.removeFavourite(event.track);
        yield FavouriteiconActionLoading();
        //   await _favIconProvider.removeFavourite(_track);
        yield FavouriteFalse();
      }
    } else if (event is AddFavourite) {
      // Track _track = event.track;

      yield FavouriteiconActionLoading();
      //  await _favIconProvider.addFavourite(_track);
      yield FavouriteTrue();
    }
  }
}
