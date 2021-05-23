part of "composer_bloc.dart";

abstract class ComposerState extends Equatable {
  final List<ComposerAudio> audios;
  final List<ComposerCategory> categories;

  final List<CombinedCompositions> combinedCompositions;

  const ComposerState(
      {this.audios, this.categories, this.combinedCompositions});
}

class ComposerLoadingState extends ComposerState {
  @override
  List<Object> get props => [];
}

class ComposerItemsFetched extends ComposerState {
  final List<ComposerAudio> audios;
  final List<ComposerCategory> categories;

  const ComposerItemsFetched({this.audios, this.categories})
      : super(audios: audios, categories: categories);

  @override
  List<Object> get props => [];
}

class ComposerItemsFiltered extends ComposerState {
  final List<ComposerAudio> audios;
  final List<ComposerCategory> categories;

  const ComposerItemsFiltered({this.audios, this.categories})
      : super(audios: audios, categories: categories);
  @override
  List<Object> get props => [];
}

class ComposerFilterNoData extends ComposerState {
  @override
  List<Object> get props => [];
}

class ComposerItemsFetchError extends ComposerState {
  final String errorMessage;
  const ComposerItemsFetchError({this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

class SavedMixesLoading extends ComposerState {
  @override
  List<Object> get props => [];
}

class SavedMixesError extends ComposerState {
  final String errorMessage;
  const SavedMixesError({this.errorMessage});
  @override
  List<Object> get props => [];
}

class SavedMixesNoData extends ComposerState {
  @override
  List<Object> get props => [];
}

class SavedMixesFetched extends ComposerState {
  final List<ComposerSavedMix> mixes;
  const SavedMixesFetched({this.mixes});
  @override
  List<Object> get props => [...mixes];
}

class CombinedCompositionsFetched extends ComposerState {
  final List<CombinedCompositions> compositionsLists;
  const CombinedCompositionsFetched({this.compositionsLists})
      : super(combinedCompositions: compositionsLists);
  @override
  List<Object> get props => [...compositionsLists];
}

class MixesRefreshingState extends ComposerState {
  final List<CombinedCompositions> compositionsLists;
  const MixesRefreshingState({this.compositionsLists})
      : super(combinedCompositions: compositionsLists);
  @override
  List<Object> get props => [];
}

class RefreshedItemsFetched extends ComposerState {
  final List<CombinedCompositions> compositionsLists;
  const RefreshedItemsFetched({this.compositionsLists})
      : super(combinedCompositions: compositionsLists);
  @override
  List<Object> get props => [...compositionsLists];
}

class RefreshErrorState extends ComposerState {
  final List<CombinedCompositions> compositionsLists;
  const RefreshErrorState({this.compositionsLists})
      : super(combinedCompositions: compositionsLists);
  @override
  List<Object> get props => [...compositionsLists];
}

class DummyState extends ComposerState {
  final List<ComposerAudio> audios;
  final List<ComposerCategory> categories;

  const DummyState({this.audios, this.categories})
      : super(audios: audios, categories: categories);

  @override
  List<Object> get props => [];
}
