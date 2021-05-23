part of 'what_brins_you_here_bloc.dart';

abstract class WhatBrinsYouHereState extends Equatable {
  const WhatBrinsYouHereState();
}

class WhatBrinsYouHereInitial extends WhatBrinsYouHereState {
  @override
  List<Object> get props => [];
}

class LoadingOptions extends WhatBrinsYouHereState {
  @override
  List<Object> get props => [];
}

class FetchedOptions extends WhatBrinsYouHereState {
  final List<OptionsTag> optionsList;
  final List<int> selectedOptionsList;

  const FetchedOptions({this.optionsList, this.selectedOptionsList});
  @override
  List<Object> get props => [...optionsList];
}

class NoOptionsData extends WhatBrinsYouHereState {
  @override
  List<Object> get props => [];
}

class OptionsError extends WhatBrinsYouHereState {
  final String errorMessage;
  const OptionsError({this.errorMessage});
  @override
  List<Object> get props => [];
}

class OptionsSelectionChangedState extends WhatBrinsYouHereState {
  final List<int> selectedOptionsList;

  const OptionsSelectionChangedState({this.selectedOptionsList});
  @override
  List<Object> get props => throw UnimplementedError();
}

class ApiFetchLoadingState extends WhatBrinsYouHereState {
  @override
  List<Object> get props => [];
}

class ApiFetchSuccessState extends WhatBrinsYouHereState {
  @override
  List<Object> get props => [];
}

class ApiFetchErrorState extends WhatBrinsYouHereState {
  final String errorMessage;

  ApiFetchErrorState({@required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
