import 'package:goodvibesoffl/models/music_model.dart';
import 'package:goodvibesoffl/services/api_service.dart';
import 'package:goodvibesoffl/widgets/common_widgets/common_widgets_methods.dart';
import '../../locator.dart';
import '../../utils/strings/string_constants.dart';

class GenreSongsProvider {
  final _apiLocator = ApiService();

  Map<String, List<Track>> tracksListMap = {};
  Map<String, List<Track>> filteredListMap = {};
  String currentCategory;
  bool _paginateBusy = false;
  bool get paginateBusy => _paginateBusy;

  int totalPages = 1;
  int currentPage = 1;

  bool _hasError = false;
  bool get hasError => _hasError;

  String _error = "";
  String get error => _error;

  List<Track> _genreTracks = [];
  List<Track> _filteredTracks = [];

  List get filteredTracks => _filteredTracks;
  List get genreTracks => _genreTracks;

  Map<int, GenreSongsMeta> genreSongsDetails = {};

  int _currentPage = 0;
  int _totalPages;

  int _filterCurrentPage = 0;
  int _filterTotalPages;

  int _currentFilterId;
  int _genreId;

  getGenreTracks(
      {int id,
      int page = 1,
      int perpage = 10,
      bool isRefreshRequest = false}) async {
    _hasError = false;
    if (id != null) {
      _genreId = id;
    }

    if (!isRefreshRequest) {
      if (_currentPage == _totalPages) return;
    }

    Map response = await _apiLocator.getGenreTracks(
      page: isRefreshRequest ? 1 : _currentPage + 1,
      perpage: 10,
      id: _genreId,
      isRefreshRequest: isRefreshRequest,
    );

    if (response == null) {
      _hasError = true;
      _error = some_error_occured;
    } else if (response.containsKey("error")) {
      _hasError = true;
      _error = response["error"];
    } else if (response.containsKey('data')) {
      List<dynamic> rsp = response['data'] as List;

      var a = rsp.map<Track>((json) => Track.fromJson(json));

      if (a.isNotEmpty && isRefreshRequest) {
        _genreTracks.clear();
      }
      _genreTracks.addAll(a);

      if (response.containsKey("page_meta")) {
        var totalItems = response["page_meta"]["total"];
        _totalPages = totalItems ~/ 9;

        _currentPage = response["page_meta"]["current_page"];

        List<Track> tempList = [];
        tempList.addAll(_genreTracks);
        if (response["data"].isEmpty) {
          _currentPage = 0;
        }

        try {
          genreSongsDetails[-1] = GenreSongsMeta(
              filterId: -1,
              tracks: tempList,
              currentPage: _currentPage,
              totalPages: _totalPages);
        } catch (e) {
          // print(e);
        }
      }
    }
  }

  getGenreTrackByCategory(
      {int genreId,
      int categoryId,
      int page = 1,
      int perpage = 10,
      String categoryName,
      bool isRefreshRequest = false}) async {
    _hasError = false;
    currentCategory = categoryName;

    if (categoryId != null) {
      _currentFilterId = categoryId;
    }

    if (!isRefreshRequest) if (_filterCurrentPage == _filterTotalPages) return;

    Map response = await _apiLocator.getCategoryTracks(
        page: isRefreshRequest ? 1 : _filterCurrentPage + 1,
        perpage: perpage,
        id: _currentFilterId,
        isRefreshRequest: isRefreshRequest);

    if (response == null) {
      _hasError = true;
      _error = some_error_occured;
    } else if (response.containsKey("error")) {
      _hasError = true;
      _error = response["error"];
    } else if (response != null && response.containsKey("data")) {
      List<dynamic> rsp = response['data'] as List;

      var a = rsp.map<Track>((json) => Track.fromJson(json));
      if (a.isNotEmpty && isRefreshRequest) {
        _genreTracks.clear();
      }
      _genreTracks.addAll(a);
      filteredListMap[categoryName] = _genreTracks;

      if (response.containsKey("page_meta")) {
        var totalItems = response["page_meta"]["total"];
        _filterTotalPages = totalItems ~/ 9;

        _filterCurrentPage = response["page_meta"]["current_page"];

        if (response["data"].isEmpty) {
          _filterCurrentPage = 0;
        }
      }
    }
  }

  clearGenreTracks() {
    _genreTracks.clear();
  }

  clearGenreTracksAndUpdateMetaForAllFilter() {
    _genreTracks.clear();
    _currentPage = genreSongsDetails[-1].currentPage;
    _totalPages = genreSongsDetails[-1].totalPages;
    _genreTracks.addAll(genreSongsDetails[-1].tracks);
  }

  clearGenreMeta() {
    _currentPage = 0;
    _totalPages = null;
  }

  clearOldFilterPageMetaForNewFilter() {
    _filterCurrentPage = 0;
    _filterTotalPages = -1;
  }
}

class GenreSongsMeta {
  final int filterId;
  final List<Track> tracks;
  final int currentPage;
  final int totalPages;

  const GenreSongsMeta(
      {this.filterId, this.tracks, this.currentPage, this.totalPages});
}
