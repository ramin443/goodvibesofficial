import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'musicplayer_event.dart';
part 'musicplayer_state.dart';

class MusicplayerBloc extends Bloc<MusicplayerEvent, MusicplayerState> {
  MusicplayerBloc() : super(MusicplayerInitial());

  @override
  Stream<MusicplayerState> mapEventToState(
      MusicplayerEvent event,
      ) async* {
    if (event is MusicPlayerRefreshPage) {
      yield MusicPlayerRefreshed();
    }
  }
}
