import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:goodvibesoffl/models/music_model.dart';
import 'package:goodvibesoffl/providers/genre_provider.dart';
import 'package:goodvibesoffl/providers/search_provider.dart';
import '../../locator.dart';
part "genre_page_event.dart";
part "genrepage_state.dart";

class GenrePageBloc extends Bloc<GenrePageEvent, GenrePageState> {
  final _genreLocator = locator<GenreProvider>();
  final _searchLocator = locator<SearchProvider>();

  GenrePageBloc() : super(GenrePageInitial());

  @override
  Stream<GenrePageState> mapEventToState(
    GenrePageEvent event,
  ) async* {
    /// this event is always created when navigated through bottom nav
    if (event is GenrePageFetchGenreData) {
      //---- first state when button on bottom nav is clikced
      if (state is GenrePageInitial) {
        yield GenrePageLoading();
        await _genreLocator.getGenre();
        if (_genreLocator.hasError)
          yield GenrePageWithError(errorMessage: _genreLocator.genreError);
        else if (_genreLocator.genre.isEmpty)
          yield GenrePageWithNoData();
        else
          yield GenrePageFetchGenre(genreList: _genreLocator.genre);
      }
      //// if genre was already fetched
      else if (state is GenrePageFetchGenre) {
        if (_genreLocator.genre.isNotEmpty)
          yield GenrePageFetchGenre(genreList: _genreLocator.genre);
        else {
          yield GenrePageLoading();
          await _genreLocator.getGenre();
          if (_genreLocator.hasError)
            yield GenrePageWithError(errorMessage: _genreLocator.genreError);
          else if (_genreLocator.genre.isEmpty)
            yield GenrePageWithNoData();
          else
            yield GenrePageFetchGenre(genreList: _genreLocator.genre);
        }
      }

      /// if search was fetched
      else if (state is GenrePageSearchFetch) {
        if (_genreLocator.genre.isEmpty) {
          yield GenrePageWithNoData();
        } else if (_genreLocator.genre.isNotEmpty) {
          yield GenrePageFetchGenre(genreList: _genreLocator.genre);
        } else {
          yield GenrePageWithError(errorMessage: _genreLocator.genreError);
        }
        // await _genreLocator.getGenre();
        // if (_genreLocator.hasError)
        //   yield GenrePageWithError(errorMessage: _genreLocator.genreError);
        // else if (_genreLocator.genre.isEmpty)
        //   yield GenrePageWithNoData();
        // else
        //   yield GenrePageFetchGenre(genreList: _genreLocator.genre);
      } else {
        yield GenrePageLoading();
        await _genreLocator.getGenre();
        if (_genreLocator.hasError)
          yield GenrePageWithError(errorMessage: _genreLocator.genreError);
        else if (_genreLocator.genre.isEmpty)
          yield GenrePageWithNoData();
        else
          yield GenrePageFetchGenre(genreList: _genreLocator.genre);
      }
    }

///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ///---------------second event= performing searcj------------------------------------------------
    else if (event is GenrePageSearchTracks) {
      var searchTerm = event.searchTerm;
      //============= this is repeated in all of the states in the event GenrePageSearchTracks
      if (state is GenrePageInitial) {
        yield GenrePageSearchLoading();
      } else if (state is GenrePageFetchGenre) {
        yield GenrePageSearchLoading();

        await _searchLocator.getSearchDetails(text: searchTerm);

        if (_searchLocator.hasError)
          yield GenrePageSearchWithError(
              errorMessage: _searchLocator.searchError);
        else if (_searchLocator.tracks.isEmpty)
          yield GenrePageWithNoData();
        else
          yield GenrePageSearchFetch(tracksList: _searchLocator.tracks);

        //----------------------------------------------------------------------------//
      } else {
        yield GenrePageSearchLoading();
        await _searchLocator.getSearchDetails(
            text: searchTerm, isNewSearch: true);
        if (_searchLocator.hasError)
          yield GenrePageSearchWithError(
              errorMessage: _searchLocator.searchError);
        else if (_searchLocator.tracks.isEmpty)
          yield GenrePageWithNoData();
        else
          yield GenrePageSearchFetch(tracksList: _searchLocator.tracks);
      }
      /////  genre  retry event
    } else if (event is GenrePageRetryFetch) {
      yield GenrePageLoading();
      await _genreLocator.getGenre();
      if (_genreLocator.hasError)
        yield GenrePageWithError(errorMessage: _genreLocator.genreError);
      else if (_genreLocator.genre.isEmpty)
        yield GenrePageWithNoData();
      else
        yield GenrePageFetchGenre(genreList: _genreLocator.genre);
    }

    /// search retry event
    else if (event is GenrePageSearchRetry) {
      var searchTerm = event.searchTerm;
      yield GenrePageSearchLoading();

      await _searchLocator.getSearchDetails(text: searchTerm);

      if (_searchLocator.hasError)
        yield GenrePageSearchWithError(
            errorMessage: _searchLocator.searchError);
      else if (_searchLocator.tracks.isEmpty)
        yield GenrePageWithNoData();
      else
        yield GenrePageSearchFetch(tracksList: _searchLocator.tracks);
    }
    //////////////////////////////////////////////////
    ///// genre page fetch more data
    else if (event is GenrePageSearchFetchMoreData) {
      yield GenrePageSearchFetchMoreLoading(tracksList: _searchLocator.tracks);
      await _searchLocator.getSearchDetails(isNewSearch: false);

      if (_searchLocator.hasError) {
        yield GenrePageSearchFetchMoreError(tracksList: _searchLocator.tracks);
      } else {
        yield GenrePageSearchFetch(tracksList: _searchLocator.tracks);
      }
    } else if (event is BackToGenreResults) {
      yield GenrePageFetchGenre(genreList: _genreLocator.genre);
    } else if (event is GenrePageRefresh) {
      yield GenreApiLoading();
      await _genreLocator.getGenre(isRefreshRequest: true);
      if (_genreLocator.hasError)
        yield GenrePageWithError(errorMessage: _genreLocator.genreError);
      else if (_genreLocator.genre.isEmpty)
        yield GenrePageWithNoData();
      else
        yield GenrePageFetchGenre(genreList: _genreLocator.genre);
    } else if (event is GenreResearch) {
      var searchTerm = event.searchTerm;
      yield GenreApiLoading();

      await _searchLocator.getSearchDetails(
          text: searchTerm, isNewSearch: true);

      if (_searchLocator.hasError)
        yield GenrePageSearchWithError(
            errorMessage: _searchLocator.searchError);
      else if (_searchLocator.tracks.isEmpty)
        yield GenrePageWithNoData();
      else
        yield GenrePageSearchFetch(tracksList: _searchLocator.tracks);
    }
  }
}
