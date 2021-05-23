import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:goodvibesoffl/models/tag_model.dart';
import 'package:goodvibesoffl/providers/homepage_providers/what_brings_you_provider.dart';
import '../../locator.dart';
part 'what_brins_you_here_event.dart';
part 'what_brins_you_here_state.dart';

class WhatBrinsYouHereBloc
    extends Bloc<WhatBrinsYouHereEvent, WhatBrinsYouHereState> {
  WhatBrinsYouHereBloc() : super(WhatBrinsYouHereInitial());

  final _optionsProvider = locator<WhatBringYouHereProvider>();
  @override
  Stream<WhatBrinsYouHereState> mapEventToState(
      WhatBrinsYouHereEvent event,
      ) async* {
    // print(state);
    // print(event);
    if (event is FetchOptions) {
      _optionsProvider.clearLists();
      _optionsProvider
          .addAllIntoSelectedList(event.usersAlreadySelectedOptions);
      yield LoadingOptions();
      await _optionsProvider.getAllChoices();
      if (_optionsProvider.hasError) {
        yield OptionsError(errorMessage: _optionsProvider.error);
      } else if (_optionsProvider.optionsList.isEmpty) {
        yield NoOptionsData();
      } else {
        yield FetchedOptions(
          optionsList: _optionsProvider.optionsList,
          selectedOptionsList: event.usersAlreadySelectedOptions,
          // unselectdOptionsList:
          //     _optionsProvider.optionsList.map((e) => e.id).toList(),
        );
      }
    } else if (event is SelectOptionEvent) {
      yield LoadingOptions();
      var id = event.id;
      _optionsProvider.selectOption(id);
      yield FetchedOptions(
        optionsList: _optionsProvider.optionsList,
        selectedOptionsList: _optionsProvider.selectedList,
      );
    } else if (event is UnselectOptionEvent) {
      yield LoadingOptions();
      var id = event.id;
      _optionsProvider.unselectOption(id);
      yield FetchedOptions(
        optionsList: _optionsProvider.optionsList,
        selectedOptionsList: _optionsProvider.selectedList,
      );
    } else if (event is ConfirmOptionsEvent) {
      yield ApiFetchLoadingState();
      await _optionsProvider.postChoicesToApi();
      if (_optionsProvider.hasError) {
        yield ApiFetchErrorState(errorMessage: _optionsProvider.error);
      } else {
        yield ApiFetchSuccessState();
      }
    } else if (event is NavigateToOptionsPageFromProfile) {
      _optionsProvider
          .addAllIntoSelectedList(event.usersAlreadySelectedOptions);
      yield LoadingOptions();
      await _optionsProvider.getAllChoices();
      if (_optionsProvider.hasError) {
        yield OptionsError(errorMessage: _optionsProvider.error);
      } else if (_optionsProvider.optionsList.isEmpty) {
        yield NoOptionsData();
      } else {
        // print(event.usersAlreadySelectedOptions);
        yield FetchedOptions(
            optionsList: _optionsProvider.optionsList,
            selectedOptionsList: event
                .usersAlreadySelectedOptions // [...event.usersAlreadySelectedOptions]
          // unselectdOptionsList:
          //     _optionsProvider.optionsList.map((e) => e.id).toList(),
        );
        // print('thsi');
      }
    }
  }
}
