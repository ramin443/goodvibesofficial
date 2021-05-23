import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:goodvibesoffl/providers/music_providers/genre_songs_provider.dart';
import '../../models/music_model.dart';
import '../.././locator.dart';
part 'genresongs_event.dart';
part 'genresongs_state.dart';

class GenresongsBloc extends Bloc<GenresongsEvent, GenresongsState> {
  final songsProvider = locator<GenreSongsProvider>();

  GenresongsBloc() : super(GenresongsInitial());
  @override
  Stream<GenresongsState> mapEventToState(
    GenresongsEvent event,
  ) async* {
    // print(state);
    // print(event);

    if (event is FetchInitialGenreSongs || event is RetryFetchSongs) {
      yield GenreSongsLoading();
      songsProvider.clearGenreTracks();
      songsProvider.clearGenreMeta();

      await songsProvider.getGenreTracks(id: event.genreId);
      if (songsProvider.hasError) {
        yield GenreSongsFetchError(errorMessage: songsProvider.error);
      } else if (songsProvider.genreTracks.isEmpty) {
        yield GenreSongsNoData();
      } else if (songsProvider.genreTracks.isNotEmpty) {
        yield GenreSongsFetchedWithData(tracks: songsProvider.genreTracks);
      }
    }
    /////////////// fetch track by filter
    else if (event is FetchFilterdGenreSongs ||
        event is RetryFilterFetchSongs) {
      yield GenreSongsFilterLoading(
        filterId: event.categoryId,
      );
      songsProvider.clearOldFilterPageMetaForNewFilter();
      songsProvider.clearGenreTracks();

      await songsProvider.getGenreTrackByCategory(categoryId: event.categoryId);

      if (songsProvider.hasError) {
        yield GenreSongsFilterError(errorMessage: songsProvider.error);
      } else if (songsProvider.genreTracks.isEmpty) {
        yield GenreSongsNoData();
      } else if (songsProvider.genreTracks.isNotEmpty) {
        yield GenreSongsFetchedWithData(tracks: songsProvider.genreTracks);
      }
    }
    ////  refresh tracks / pull to refresh
    else if (event is RefreshGenreSongs) {
      yield GenreSongsRefreshing(tracks: songsProvider.genreTracks);
      if (event.filterId != null) {
        await songsProvider.getGenreTrackByCategory(
            genreId: event.id, isRefreshRequest: true);
      } else {
        await songsProvider.getGenreTracks(
            id: event.id, isRefreshRequest: true);
      }
      yield GenreSongsFetchedWithData(tracks: songsProvider.genreTracks);
    }
    /////// when all is presed again from some other filter
    else if (event is AllCategoryClicked) {
      if (songsProvider.genreSongsDetails.containsKey(-1)) {
        /// if data exist in map return the data otherwise fetch again
        songsProvider.clearGenreTracksAndUpdateMetaForAllFilter();
        var data = songsProvider.genreSongsDetails[-1];
        if (data.tracks.isNotEmpty) {
          yield GenreSongsFetchedWithData(tracks: data.tracks);

          ///
        } else {
          //// get all tracks again
          yield GenreSongsLoading();
          songsProvider.clearGenreTracks();
          await songsProvider.getGenreTracks();
          if (songsProvider.hasError) {
            yield GenreSongsFetchError(errorMessage: songsProvider.error);
          } else if (songsProvider.genreTracks.isEmpty) {
            yield GenreSongsNoData();
          } else if (songsProvider.genreTracks.isNotEmpty) {
            yield GenreSongsFetchedWithData(tracks: songsProvider.genreTracks);
          }
        }
      }
    }

    //// to load more genre songs by category or all
    else if (event is LoadMoreGenreSongs) {
      yield GenreSongsLoadMoreLoading(tracks: songsProvider.genreTracks);

      if (event.isFilter) {
        // songsProvider.clearOldFilterPageMetaForNewFilter();

        await songsProvider.getGenreTrackByCategory();
      } else {
        await songsProvider.getGenreTracks();
      }

      if (songsProvider.hasError) {
        yield GenreSongsLoadMoreError(tracks: songsProvider.genreTracks);
      } else if (songsProvider.genreTracks.isNotEmpty) {
        yield GenreSongsFetchedWithData(tracks: songsProvider.genreTracks);
      }
    }
  }
}
