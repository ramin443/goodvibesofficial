import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:goodvibesoffl/models/playable_model.dart';
import 'package:goodvibesoffl/providers/rituals_provider.dart';
import 'package:goodvibesoffl/models/playlist_model.dart';
part 'package:goodvibesoffl/bloc/rituals/rituals_event.dart';
part 'package:goodvibesoffl/bloc/rituals/rituals_state.dart';

class RitualsBloc extends Bloc<RitualsEvent, RitualsState> {
  RitualsBloc() : super(RitualsTrackLoading());

  final _ritualsProvider = RitualsProvider();
  @override
  Stream<RitualsState> mapEventToState(RitualsEvent event) async* {
    if (event is FetchRitualsTracks) {
      yield RitualsTrackLoading();
      await _ritualsProvider.getRitualsTracks(ritualId: event.ritualId);
      if (_ritualsProvider.ritualsTracks.isEmpty) {
        yield RitualsNoData();
      } else if (_ritualsProvider.hasError) {
        yield RitualsError(message: _ritualsProvider.ritualsTrackError);
      } else if (_ritualsProvider.ritualsTracks.isNotEmpty) {
        yield RitualsTracksFetched(trackList: _ritualsProvider.ritualsTracks);
      }
    }

    /// fetch in homepage
    else if (event is FetchRitualsPlaylists) {
      if (_ritualsProvider.ritualsPlaylists.isEmpty) {
        yield RitualsPlaylistLoading();
      } else if (_ritualsProvider.ritualsPlaylists.isNotEmpty) {
        yield RitualsPlaylistsFetched(
            playlists: _ritualsProvider.ritualsPlaylists,
            startedPlaylists: _ritualsProvider.startedRituals);
      }
      await _ritualsProvider.getRitualsPlaylists(isRefreshRequest: false);
      await _ritualsProvider.getFavouriteTituals();

      if (_ritualsProvider.ritualsPlaylists.isEmpty) {
        yield RitualsPlaylistNoData();
      } else if (_ritualsProvider.hasRitualsPlaylistError) {
        yield RitualsPlaylistsError(
            message: _ritualsProvider.ritualsPlaylistsError);
      } else if (_ritualsProvider.ritualsPlaylists.isNotEmpty) {
        yield RitualsPlaylistsFetched(
            playlists: _ritualsProvider.ritualsPlaylists,
            startedPlaylists: _ritualsProvider.startedRituals);
      }

      if (_ritualsProvider.ritualsPlaylists.isNotEmpty &&
          _ritualsProvider.startedRituals.isNotEmpty) {
        yield RitualsPlaylistsFetched(
            playlists: _ritualsProvider.ritualsPlaylists,
            startedPlaylists: _ritualsProvider.startedRituals);
      }
    }

    ///
    else if (event is RefreshRitualsTracks) {
      yield RitualsTracksRefreshing(trackList: _ritualsProvider.ritualsTracks);

      await _ritualsProvider.getRitualsTracks(
          ritualId: event.ritualId, isRefreshRequest: true);

      yield RitualsTracksFetched(trackList: _ritualsProvider.ritualsTracks);
    }

    ///
    else if (event is RefreshRitualsPlaylist) {
      yield RitualsPlaylistRefreshing(
          startedRituals: _ritualsProvider.startedRituals,
          playlist: _ritualsProvider.ritualsPlaylists);
      await _ritualsProvider.getRitualsPlaylists(isRefreshRequest: true);

      yield RitualsPlaylistsFetched(
          playlists: _ritualsProvider.ritualsPlaylists,
          startedPlaylists: _ritualsProvider.startedRituals);
    }

    ///
    else if (event is CancelRitualsDownload) {
    }

    ///
    else if (event is RitualsFavouriteEvent) {
    }

    ///
    else if (event is FetchMoreRituals) {
      yield MoreRitualsLoading();
      await _ritualsProvider.getMoreRituals();
      if (_ritualsProvider.hasMoreRitualsError) {
        yield MoreRitualsError(message: _ritualsProvider.moreRitualsError);
      } else if (_ritualsProvider.moreRituals.isEmpty) {
        yield MoreRitualsNoData();
      } else if (_ritualsProvider.moreRituals.isNotEmpty) {
        yield MoreRitualsFetched(playlists: _ritualsProvider.moreRituals);
      }
    }

    ///
    else if (event is RefreshMoreRituals) {
      yield MoreRitualsRefreshing(playlists: _ritualsProvider.moreRituals);
      await _ritualsProvider.getMoreRituals(isRefreshRequest: true);

      yield MoreRitualsFetched(playlists: _ritualsProvider.moreRituals);
    }

    ///
    else if (event is FetchStartedRituals) {
      yield StartedRitualsLoading();
      await _ritualsProvider.getStartedRituals();
      if (_ritualsProvider.startedRituals.isEmpty) {
        yield StartedRitualsNoData();
      } else if (_ritualsProvider.startedRituals.isNotEmpty) {
        yield StartedRitualsFetched(playlists: _ritualsProvider.startedRituals);
      }
    }

    ///
    else if (event is FavouriteButtonPressed) {
      List<PlayList> playlists =
      _ritualsProvider.onFavoriteButtonPressed(event.playlist);
      yield DummyState();
      yield FavouriteButtonState(playlists);
    } else if (event is CheckRitualFavouriteStatus) {
      // var playlist = event.playlist;

      // var _exists = _ritualsProvider.favouriteRituals.firstWhere(
      //     (element) => element.id == playlist.id,
      //     orElse: () => null);

      yield FavouriteButtonState(_ritualsProvider.favouriteRituals);
    }
  }
}
