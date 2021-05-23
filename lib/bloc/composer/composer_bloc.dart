import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:goodvibesofficial/bloc/common_bloc/common_state.dart';

import 'package:goodvibesoffl/providers/music_providers/composer_provider.dart';

import '../../locator.dart';
import 'package:equatable/equatable.dart';
import '../../models/composer_audio_model.dart';

part 'composer_event.dart';
part "composer_state.dart";

class ComposerBloc extends Bloc<ComposerEvent, ComposerState> {
  ComposerBloc() : super(ComposerLoadingState());

  int _downloadCompleteCount = 0;

  final _composerProvider = locator<ComposerProvider>();
  @override
  Stream<ComposerState> mapEventToState(ComposerEvent event) async* {
    if (event is GetComposerItemsEvent) {
      yield ComposerLoadingState();
      if (_composerProvider.hasFetchedFromApi) {
        yield ComposerItemsFetched(
            audios: _composerProvider.composeItems,
            categories: _composerProvider.composerCategoryList);
        return;
      }

      // if (_composerProvider.composeItems.isNotEmpty) {
      //   yield ComposerItemsFetched(
      //       audios: _composerProvider.composeItems,
      //       categories: _composerProvider.composerCategoryList);
      //   return;
      // }

      await _composerProvider.getComposeItemx();

      if (_composerProvider.hasGetComposeError) {
        yield ComposerItemsFetchError(
            errorMessage: _composerProvider.getComposeError);
      } else if (_composerProvider.composeItems.isNotEmpty) {
        yield ComposerItemsFetched(
            audios: _composerProvider.composeItems,
            categories: _composerProvider.composerCategoryList);
      }
    }

    /// filtered lists

    else if (event is FilterCategoryEvent) {
      yield ComposerLoadingState();
      _composerProvider.filterComposerTracks(event.id);

      yield ComposerItemsFetched(
          audios: _composerProvider.filteredAudios,
          categories: _composerProvider.composerCategoryList);
    } else if (event is SaveComposeMIxesEvent) {
      await _composerProvider.saveComposerMix(
          title: event.mixName,
          audios: event.audios,
          context: event.context,
          isUpdate: event.isUpdate,
          mixId: event.mixId);
    }

    //// when "All" filter is clicked
    else if (event is AllCategoryClickEvent) {
      yield ComposerLoadingState();
      yield ComposerItemsFetched(
          audios: _composerProvider.composeItems,
          categories: _composerProvider.composerCategoryList);
    }
    //// get saved composer mixes
    else if (event is GetSavedMixes) {
      yield SavedMixesLoading();

      await Future.wait<dynamic>([
        _composerProvider.getCombinedCompositions(),
        _composerProvider.getAllSavedMixes(),
      ]);

      //   await _composerProvider.getCombinedCompositions();

      if (_composerProvider.hasComposerSavedMixesError) {
        yield SavedMixesError(
            errorMessage: _composerProvider.composerSavedMixesError);
      } else if (_composerProvider.savedComposerMixes.isEmpty) {
        yield SavedMixesNoData();
      } else if (_composerProvider.savedComposerMixes.isNotEmpty) {
        yield SavedMixesFetched(mixes: _composerProvider.savedComposerMixes);
      }

      if (_composerProvider.compositionsLists.isNotEmpty) {
        yield CombinedCompositionsFetched(
            compositionsLists: _composerProvider.compositionsLists);
      } else if (_composerProvider.compositionsLists.isEmpty) {
        yield CombinedCompositionsFetched(compositionsLists: []);
      }
    }

    //// update the compose items list when download of an item is completeed
    else if (event is DloadCompleteUpdateComposerItems) {
      _downloadCompleteCount++;

      _composerProvider
          .checkComposerDownloadedItemAndUpdateCurrentList(event.trackId);

      // yield ComposerLoadingState();
      yield DummyState(
          audios: _composerProvider.composeItems,
          categories: _composerProvider.composerCategoryList);

      yield ComposerItemsFetched(
          audios: _composerProvider.composeItems,
          categories: _composerProvider.composerCategoryList);
    }
    //// delete composer mix
    else if (event is DeleteSavedcMixEvent) {
      var id = event.mixId;

      await _composerProvider.deleteComposerMix(id: id);

      yield SavedMixesFetched(mixes: _composerProvider.savedComposerMixes);
    }

    //// refresh event

    else if (event is RefreshEvent) {
      List<CombinedCompositions> tempList = _composerProvider.compositionsLists;

      yield MixesRefreshingState(compositionsLists: tempList);
      _composerProvider.clearCombinedCompositionsList();
      await _composerProvider.getCombinedCompositions(isRefreshRequest: true);

////
      if (_composerProvider.hasCombinedCompositionFetchError) {
        yield RefreshErrorState(compositionsLists: tempList);
      } else if (_composerProvider.compositionsLists.isNotEmpty) {
        yield RefreshedItemsFetched(
            compositionsLists: _composerProvider.compositionsLists);
      }
    }
  }
}
