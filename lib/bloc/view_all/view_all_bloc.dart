import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:goodvibesoffl/providers/music_providers/music_repository.dart';

import '../../locator.dart';

part 'view_all_event.dart';
part 'view_all_state.dart';

class ViewAllBloc extends Bloc<ViewAllEvent, ViewAllState> {
  String slug = "";

  ViewAllBloc() : super(ViewAllInitial());

  final _musicProvider = locator<MusicProvider>();

  @override
  Stream<ViewAllState> mapEventToState(
      ViewAllEvent event,
      ) async* {
    print(state);
    print(event);

    if (event is ViewAllFetchData || event is ViewAllReFetchData) {
      yield ViewAllLoading();
      await _musicProvider.getViewAll(slug);
      if (_musicProvider.hasViewAllError)
        yield ViewAllError(errorMessage: _musicProvider.viewAllError);
      else if (_musicProvider.viewAllUpdatedTracks.isEmpty)
        yield ViewAllSuccessWithNoData();
      else
        yield ViewAllSuccessWithData(
            tracks: _musicProvider.viewAllUpdatedTracks);
    }
    //// fetch more data
    else if (event is ViewAllFetchMoreData) {
      yield ViewAllApiLoading(tracks: _musicProvider.viewAllUpdatedTracks);
      await _musicProvider.getViewAll(slug);
      if (_musicProvider.hasViewAllError)
        yield ViewAllApiError(
            errorMessage: _musicProvider.viewAllError,
            tracks: _musicProvider.viewAllUpdatedTracks);
      else {
        yield ViewAllSuccessWithData(
            tracks: _musicProvider.viewAllUpdatedTracks);
      }
    }

    //// refresh view
    else if (event is ViewAllRefreshTrack) {
      _musicProvider.resetViewAllPageCount();
      yield ViewAllRefreshApiLoading();
      await _musicProvider.getViewAll(slug, isRefreshRequest: true);
      if (_musicProvider.hasViewAllError)
        yield ViewAllError(errorMessage: _musicProvider.viewAllError);
      else if (_musicProvider.viewAllUpdatedTracks.isEmpty)
        yield ViewAllSuccessWithNoData();
      else
        yield ViewAllSuccessWithData(
            tracks: _musicProvider.viewAllUpdatedTracks);
    }

    /// initially passing values to list
    else if (event is InitialViewAllEvent) {
      slug = event.slug;

      _musicProvider.clearViewAlItems();
      _musicProvider.resetViewAllPageCount();

      _musicProvider.addItemsIntoEmptyViewAllList(event.tracks);
      yield InitialStateWithAlreadyData(tracks: event.tracks);
    }
  }
}
