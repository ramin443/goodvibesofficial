part of 'downloadpage_bloc.dart';

abstract class DownloadpageState extends Equatable {
  final List<PlayList> playlists;
  const DownloadpageState({this.playlists});
}

class DownloadPageInitial extends DownloadpageState {
  @override
  List<Object> get props => [];
}

class DownloadPageLoading extends DownloadpageState {
  @override
  List<Object> get props => [];
}

class DownloadPageSuccessWithDBNoData extends DownloadpageState {
  final List<String> filterCategory;
  final String currentFilter;
  DownloadPageSuccessWithDBNoData(
      {@required this.filterCategory, @required this.currentFilter});
  @override
  List<Object> get props => [...filterCategory, currentFilter];
}

class DownloadPageSuccessWithServerNoData extends DownloadpageState {
  final List<String> filterCategory;
  final String currentFilter;
  DownloadPageSuccessWithServerNoData(
      {@required this.filterCategory, @required this.currentFilter});
  @override
  List<Object> get props => [...filterCategory, currentFilter];
}

class DownloadPageSuccessWithDBData extends DownloadpageState {
  final List<Track> downloadedTracks;
  final List<String> filterCategory;
  final String currentFilter;
  final List<PlayList> playlists;

  DownloadPageSuccessWithDBData(
      {@required this.downloadedTracks,
        @required this.filterCategory,
        @required this.currentFilter,
        this.playlists})
      : super(playlists: playlists);
  @override
  List<Object> get props =>
      [...downloadedTracks, ...filterCategory, currentFilter];
}

class DownloadPageSuccessWithServerData extends DownloadpageState {
  final List<Track> downloadedTracks;
  final List<String> filterCategory;
  final List<PlayList> playlists;
  final String currentFilter;

  DownloadPageSuccessWithServerData(
      {@required this.downloadedTracks,
        @required this.filterCategory,
        @required this.currentFilter,
        this.playlists})
      : super(playlists: playlists);

  @override
  List<Object> get props =>
      [...downloadedTracks, ...filterCategory, currentFilter];
}

class DownloadPageWithError extends DownloadpageState {
  final String errorMessage;

  DownloadPageWithError({@required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

class DownloadPageApiFetchError extends DownloadpageState {
  final String errorMessage;
  DownloadPageApiFetchError({@required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

class DownloadPageApiLoading extends DownloadpageState {
  @override
  List<Object> get props => [];
}
