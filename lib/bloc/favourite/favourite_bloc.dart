import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:goodvibesoffl/models/music_model.dart';
import 'package:goodvibesoffl/providers/favorites_provider.dart';

import '../../locator.dart';

part "favourite_state.dart";
part "favourite_event.dart";

class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {
  FavouriteBloc() : super(InitialState());

  @override
  FavouriteState get initialState => InitialState();

  final _fProvider = locator<FavoritesProvider>();
  @override
  Stream<FavouriteState> mapEventToState(
    FavouriteEvent event,
  ) async* {
    if (event is FetchFavourite) {
      if (state is InitialState) {
        yield LoadingState();
        await _fProvider.getFavsFromApi();
        if (_fProvider.hasFavError) {
          yield FavouriteDataFetchError(errorMessage: _fProvider.favError);
        } else if (_fProvider.favList.isEmpty) {
          yield FavouriteNoData();
        } else {
          yield FavouriteDataFetched(tracksList: _fProvider.favList);
        }
      } else {
        yield LoadingState();
        await _fProvider.getFavsFromApi();
        if (_fProvider.hasFavError) {
          yield FavouriteDataFetchError(errorMessage: _fProvider.favError);
        } else if (_fProvider.favList.isEmpty) {
          yield FavouriteNoData();
        } else {
          yield FavouriteDataFetched(tracksList: _fProvider.favList);
        }
      }
    } else if (event is FavoriteRefreshData) {
      yield FavoriteApiLoading();
      await _fProvider.getFavsFromApi(isRefreshRequest: true);
      if (_fProvider.hasFavError) {
        yield FavouriteDataFetchError(errorMessage: _fProvider.favError);
      } else if (_fProvider.favList.isEmpty) {
        yield FavouriteNoData();
      } else {
        yield FavouriteDataFetched(tracksList: _fProvider.favList);
      }
    }
  }
}
