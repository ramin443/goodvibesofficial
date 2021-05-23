import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:goodvibesoffl/locator.dart';
import 'package:goodvibesoffl/models/music_model.dart';
import 'package:goodvibesoffl/providers/music_providers/music_repository.dart';
import 'package:goodvibesoffl/services/player_service.dart';

part 'playlist_event.dart';
part 'playlist_state.dart';

class PlaylistBloc extends Bloc<PlaylistEvent, PlaylistState> {
  final _musicProvider = locator<MusicProvider>();

  PlaylistBloc() : super(PlaylistInitial());

  @override
  PlaylistState get initialState => PlaylistInitial();

  @override
  Stream<PlaylistState> mapEventToState(
      PlaylistEvent event,
      ) async* {
    // print(state);
    // print(event);

    if (event is PlaylistFetch || event is PlaylistReFetch) {
      String slug = "";

      if (event is PlaylistFetch || event is PlaylistReFetch) {
        slug = event.slug;

        yield PlaylistLoading();
        _musicProvider.resetPlaylistPageCount();
        await _musicProvider.getPlayList(slug: slug);
        if (_musicProvider.hasPlayListError)
          yield PlaylistError(errorMessage: _musicProvider.playListError);
        else if (_musicProvider.playlist.isEmpty)
          yield PlaylistNoData();
        else
          yield PlaylistWithData(tracks: _musicProvider.playlist);
      }
    } //// playlist load more data
    else if (event is FetchMorePlaylistData) {
      yield PlaylistFetchMoreLoading(tracks: _musicProvider.playlist);
      await _musicProvider.getPlayList(isFetchMoreData: true);
      if (_musicProvider.hasPlayListError) {
        yield PlaylistFetchMoreError(tracks: _musicProvider.playlist);
      } else {
        locator<MusicService>()
            .updateplaylist(myPlaylistTracks: _musicProvider.playlist);
        yield PlaylistWithData(tracks: _musicProvider.playlist);
      }
    }
  }
}
