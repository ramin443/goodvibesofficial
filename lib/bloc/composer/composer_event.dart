part of "composer_bloc.dart";

abstract class ComposerEvent extends Equatable {
  const ComposerEvent();
}

class GetComposerItemsEvent extends ComposerEvent {
  @override
  List<Object> get props => throw UnimplementedError();
}

class AllCategoryClickEvent extends ComposerEvent {
  @override
  List<Object> get props => throw UnimplementedError();
}

class FilterCategoryEvent extends ComposerEvent {
  final int id;
  const FilterCategoryEvent({this.id});

  @override
  List<Object> get props => throw UnimplementedError();
}

class SaveComposeMIxesEvent extends ComposerEvent {
  final String mixName;
  final List<ComposerAudio> audios;
  final BuildContext context;
  final bool isUpdate;
  final int mixId;
  const SaveComposeMIxesEvent({
    this.mixName,
    this.audios,
    this.context,
    this.isUpdate,
    this.mixId,
  });

  @override
  List<Object> get props => [];
}

class DeleteSavedcMixEvent extends ComposerEvent {
  final int mixId;
  const DeleteSavedcMixEvent({this.mixId});

  @override
  List<Object> get props => [];
}

class GetSavedMixes extends ComposerEvent {
  @override
  List<Object> get props => throw UnimplementedError();
}

class DloadCompleteUpdateComposerItems extends ComposerEvent {
  final int trackId;
  const DloadCompleteUpdateComposerItems({this.trackId});

  @override
  List<Object> get props => [];
}

class RefreshEvent extends ComposerEvent {
  @override
  List<Object> get props => [];
}
