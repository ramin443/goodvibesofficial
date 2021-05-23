import 'dart:async';

import 'package:bloc/bloc.dart';
import '../common_bloc/common_event.dart';

import '../common_bloc/common_state.dart';
import 'package:goodvibesoffl/providers/music_providers/music_repository.dart';

import '../../locator.dart';

class DynamichomepagewidgetBloc extends Bloc<CommonEvent, CommonState> {
  bool isPreFetchedFromSplashPage = false;

  DynamichomepagewidgetBloc() : super(LoadingState());

  final _musicProvider = MusicProvider();
  @override
  Stream<CommonState> mapEventToState(
    CommonEvent event,
  ) async* {
    if (event is FetchTracks || state is RetryFetchTrcks) {
      if (isPreFetchedFromSplashPage) return;

      yield LoadingState();
      await _musicProvider.getHomepageDynamicLists();

      if (_musicProvider.hasDynamicHomepageListError) {
        yield ErrorState(errorMessage: _musicProvider.dynamicHomepageError);
      } else if (_musicProvider.dynamicHomepageList.isEmpty) {
        yield NoDataState();
      } else if (_musicProvider.dynamicHomepageList.isNotEmpty) {
        isPreFetchedFromSplashPage = true;
        yield DataFetchedState(tracksList: _musicProvider.dynamicHomepageList);
      }
    } else if (event is RefreshItems) {
      yield RefreshingState(tracksList: _musicProvider.dynamicHomepageList);
      await _musicProvider.getHomepageDynamicLists(isRefreshRequest: true);

      if (!_musicProvider.hasDynamicHomepageListError &&
          _musicProvider.dynamicHomepageList.isNotEmpty) {
        yield DataFetchedState(tracksList: _musicProvider.dynamicHomepageList);
      }
    }
  }
}
