part of 'downloadpage_bloc.dart';

abstract class DownloadpageEvent extends Equatable {
  const DownloadpageEvent();
}

class DownloadPageFetchData extends DownloadpageEvent {
  @override
  List<Object> get props => [];
}

class DownloadPageFilterData extends DownloadpageEvent {
  final String filterString;
  DownloadPageFilterData({@required this.filterString});
  @override
  List<Object> get props => [filterString];
}

class DownloadPageAddTrack extends DownloadpageEvent {
  final Track track;
  DownloadPageAddTrack({@required this.track});

  @override
  List<Object> get props => [track];
}

class DownloadPageRefreshTracks extends DownloadpageEvent {
  @override
  List<Object> get props => [];
}

class DownloadPageDeleteTrack extends DownloadpageEvent {
  final Track track;
  DownloadPageDeleteTrack({@required this.track});

  @override
  List<Object> get props => [track];
}

class DownloadPageReFetchTrack extends DownloadpageEvent {
  @override
  List<Object> get props => [];
}

class DeletePlayList extends DownloadpageEvent {
  final PlayList playlist;

  const DeletePlayList({this.playlist});

  @override
  List<Object> get props => throw UnimplementedError();
}
