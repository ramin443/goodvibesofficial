import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:goodvibesoffl/providers/homepage_providers/config_provider.dart';

import '../../locator.dart';

part 'homepage_count_event.dart';
part 'homepage_count_state.dart';

class HomepageCountBloc extends Bloc<HomepageCountEvent, HomepageCountState> {
  DateTime time = DateTime.now();

  HomepageCountBloc() : super(CountInitial());

  final _configProvider = locator<ConfigProvider>();
  @override
  Stream<HomepageCountState> mapEventToState(
    HomepageCountEvent event,
  ) async* {
    if (event is FetchConfigEvent) {
      if (state is CountInitial) {
        await _configProvider.getCofig();
        if (_configProvider.hasError) {
          yield ConfigFetchError();
        } else if (_configProvider.count == null) {
          yield NoConfigData();
        } else {
          time = DateTime.now();

          yield ConfigFetched(
              count: _configProvider.count,
              unseenNotifs: _configProvider.unopenNotif);
        }
      } else {
        var timeDifference = DateTime.now().difference(time).inSeconds;

        if (timeDifference > 30) {
          if (!_configProvider.isBusy) {
            yield CountLoading(
                count: _configProvider.count,
                unseenNotifs: _configProvider.unopenNotif);
            await _configProvider.getCofig();
            if (_configProvider.hasError) {
              yield ConfigFetchError();
            } else if (_configProvider.count == null) {
              yield NoConfigData();
            } else {
              time = DateTime.now();

              yield ConfigFetched(
                  count: _configProvider.count,
                  unseenNotifs: _configProvider.unopenNotif);
            }
          }
        }
      }
    }
  }
}
