import 'package:goodvibesoffl/models/dynamic_homepage_model.dart';
import 'package:goodvibesoffl/models/music_model.dart';
import 'package:goodvibesoffl/models/playable_model.dart';
import 'package:goodvibesoffl/services/api_service.dart';
import 'package:goodvibesoffl/services/database_service.dart';
import 'package:goodvibesoffl/utils/strings/string_constants.dart';
import 'package:rxdart/rxdart.dart';
import '../../locator.dart';

class MusicProvider {
  BehaviorSubject<Track> trackPlay = BehaviorSubject<Track>();

  List<HomepageDynamicData> _dynamicHomepageList = [];

  String _dynamicHomepageError = "";

  bool _hasDynamicHomepageListError = false;

  List<Track> _trendingTracks = [];
  List<Track> _latestTracks = [];
  // List<Albums> _albums = [];
  List<Track> _albumTracks = [];
  List<Track> _recentlyPlayedTracks = [];
  List<HistoryTracks> _historyTracks = [];
  List<HomepageDynamicData> _meditates = [];
  List<Track> _playlist = [];
  List<Track> _userRecomendTracks = [];
  List<HomepageDynamicData> _sleep = [];
  List<Playable> _viewAllUpdatedTracks = [];

  List<Playable> _meditateHomePlayableList = [];

  bool _hasTrendingError = false;
  bool _hasLatestError = false;
  // bool _hasAlbumsError = false;
  // bool _hasAlbumSongsError = false;
  bool _hasRecentlyPlayedEror = false;
  bool _hasHistoryError = false;
  bool _hasMeditateError = false;
  bool _hasPlaylistError = false;
  bool _hasRecomendError = false;
  bool _hasSleepError = false;
  bool _hasViewAllError = false;
  bool _hasMeditateHomePlayableError = false;

  String _trendingError = "";
  String _latestError = "";
  // String _albumsError = " ";
  // String _albumSongsError = " ";
  String _recentlyPlayedError = "";
  String _recomendError = " ";
  String _historyError = "";
  String _meditateError = "";
  String _playListError = "";
  String _sleepError = "";
  String _viewAllError = "";
  String _meditateHomePlayableError = "";
  String _meditateDescription = "";
  String _sleepDescription = "";

  String _playlistSlug;

  int _historyCurrentPage = 0;
  int _historyTotalPage;

  int _meditateCurrentPage = 0;
  int _meditateTotalPage;

  int _sleepCurrentPage = 0;
  int _sleepTotalPage;

  int _viewAllCurrentPage = 0;
  int _viewAllTotalPage;

  int _popularTracksCurrentPage = 0;
  int _popularPageTotalPage;

  int _playlistCurrentPage = 0;
  int _playlistTotalPage;

  int _viewAllCurrentPageNumber = 1;
  int _viewAllTotalPages;

  final _apiLocator = locator<ApiService>();

  gettrending({bool isRefreshRequest = false}) async {
    _hasTrendingError = false;
    if (_popularTracksCurrentPage == _popularPageTotalPage) return;
    Map response = await _apiLocator.gettrending(
        isRefreshRequest: isRefreshRequest,
        page: _popularTracksCurrentPage + 1,
        perpage: 15);

    if (response != null && response.containsKey('data')) {
      List<dynamic> rsp = response['data'] as List;
      var a = rsp.map<Track>((json) => Track.fromJson(json));
      if (_popularTracksCurrentPage == 0) _trendingTracks.clear();
      _trendingTracks.addAll(a);

      if (response.containsKey("page_meta")) {
        Map<String, dynamic> pageMetaData = response['page_meta'];
        _popularTracksCurrentPage = pageMetaData["current_page"];
        _popularPageTotalPage = pageMetaData["total"];
      }
/////////////////////////////////
    } else if (response == null || response.containsKey('error')) {
      _hasTrendingError = true;
      if (response != null) {
        _trendingError = response['error'];
      } else {
        _trendingError = "Some error occured";
      }
    }
  }

  getLatestTracks({bool isRefreshRequest = false}) async {
    _hasLatestError = false;
    _latestTracks.clear();
    Map response = await _apiLocator.gettrending(
        page: 1, perpage: 8, isRefreshRequest: isRefreshRequest);

    if (response == null || response.containsKey('error')) {
      _hasLatestError = true;

      if (response != null) {
        _latestError = response['error'];
      } else {
        _latestError = "some error occured";
      }
    } else if (response.containsKey('data')) {
      List<dynamic> rsp = response['data'] as List;

      var a = rsp.map<Track>((json) => Track.fromJson(json));

      _latestTracks.addAll(a);
    }
  }

  getRecentlyPlayedTracks({bool isRefreshRequest = false}) async {
    _hasRecomendError = false;
    _recentlyPlayedTracks.clear();
    final response = await DatabaseService().getDistinctItemFromHistory();
    // getHistoryTracks();
    if (response == null) {
      _recentlyPlayedTracks = [];
    } else {
      //List<Map<String, dynamic>> reverseHistory = response.reversed.toList();

      var reversedList =
      // reverseHistory
      response.map<Track>((data) => Track.fromDb(data));
      _recentlyPlayedTracks.addAll(reversedList);
    }
  }

  getUserRecomendTracks({bool isRefreshRequest = false}) async {
    _hasRecomendError = false;
    _userRecomendTracks.clear();
    Map response = await _apiLocator.getUsersRecomendTracks(
        isRefreshRequest: isRefreshRequest);
    if (response == null || response.containsKey('error')) {
      _hasRecomendError = true;
      if (response != null) {
        _recomendError = response['error'];
      } else {
        _recomendError = some_error_occured;
      }
    } else if (response.containsKey('data')) {
      List<dynamic> rsp = response['data'] as List;
      var a = rsp.map<Track>((json) => Track.fromJson(json)).toList();
      _userRecomendTracks.addAll(a);
    }
  }

  getHistory({bool isRefreshRequest = false}) async {
    _hasHistoryError = false;
    if (_historyCurrentPage == _historyTotalPage) return;
    Map<String, dynamic> response = await _apiLocator.getAllPlayHistory(
        isRefreshRequest: isRefreshRequest,
        page: _historyCurrentPage + 1,
        perpage: 20);
    if (response == null) {
      _hasHistoryError = true;
      _historyError = "Some error occured";
    } else if (response != null && response.containsKey('data')) {
      List<dynamic> rsp = response['data'] as List;
      var a = rsp.map<HistoryTracks>((json) => HistoryTracks.fromJson(json));
      if (_historyCurrentPage == 0) _historyTracks.clear();
      _historyTracks.addAll(a);
      if (response.containsKey("page_meta")) {
        Map<String, dynamic> pageMetaData = response['page_meta'];
        _historyCurrentPage = pageMetaData["current_page"];
        _historyTotalPage = pageMetaData["total"];
      }
    } else if (response != null && response.containsKey('error')) {
      _hasHistoryError = true;
      if (response != null) {
        _historyError = response['error'];
      } else {
        _historyError = "Some error occured";
      }
    }
  }

  getMeditate({bool isRefreshRequest = false}) async {
    _hasMeditateError = false;
    if (_meditateCurrentPage == _meditateTotalPage) return;

    if (!isRefreshRequest && _meditates.isNotEmpty) return;

    Map<String, dynamic> response = await _apiLocator.getMeditate(
        isRefreshRequest: isRefreshRequest,
        page: _meditateCurrentPage + 1,
        perpage: 20);
    if (response == null || response.containsKey('error')) {
      _hasMeditateError = true;
      if (response != null) {
        _meditateError = response['error'];
      } else {
        _meditateError = "Some error occured";
      }
    } else if (response != null || response.containsKey('data')) {
      _meditateDescription = response["description"] ?? "";
      List<dynamic> rsp = response['data'] as List;
      var a = rsp
          .map<HomepageDynamicData>(
              (json) => HomepageDynamicData.fromJson(json))
          .toList();
      if (_meditateCurrentPage == 0) _meditates.clear();
      _meditates.addAll(a);
      if (response.containsKey("page_meta")) {
        Map<String, dynamic> pageMetaData = response['page_meta'];
        _meditateCurrentPage = pageMetaData["current_page"];
        _meditateTotalPage = pageMetaData["total"];
      }
    }
  }

  getPlayList(
      {String slug,
        bool isFetchMoreData = false,
        bool isRefreshRequest = false}) async {
    _hasPlaylistError = false;

    if (slug != null) _playlistSlug = slug;

    if (!isFetchMoreData) {
      _playlist.clear();
      _playlistCurrentPage = 0;
    }

    if (_playlistCurrentPage == _playlistTotalPage) {
      return;
    }

    Map response = await _apiLocator.getPlaylist(
      isRefreshRequest: isRefreshRequest,
      slug: _playlistSlug,
      page: _playlistCurrentPage + 1,
      perpage: 20,
    );

    // checking response
    if (response == null || response.containsKey('error')) {
      _hasPlaylistError = true;
      if (response != null) {
        _playListError = response['error'];
      } else {
        _playListError = "Some error occured";
      }
    } else if (response.containsKey('data')) {
      List<dynamic> rsp = response['data'] as List;
      rsp.forEach((Playable) {
        if (Playable['type'].toString().toLowerCase() == "track") {
          _playlist.add(Track.fromJson(Playable["type_object"]));
        }
      });

// getting meta data
      if (response.containsKey("page_meta")) {
        Map<String, dynamic> pageMetaData = response['page_meta'];
        _playlistCurrentPage = pageMetaData["current_page"];
        _playlistTotalPage = pageMetaData["total"];
      }
    }
  }

  getSleep({bool isRefreshRequest = false}) async {
    _hasSleepError = false;
    if (_sleepCurrentPage == _sleepTotalPage) return;

    if (!isRefreshRequest && _sleep.isNotEmpty) return;

    Map<String, dynamic> response = await _apiLocator.getSleep(
        isRefreshRequest: isRefreshRequest,
        page: _sleepCurrentPage + 1,
        perpage: 20);
    if (response == null || response.containsKey('error')) {
      _hasSleepError = true;
      if (response != null) {
        _sleepError = response['error'];
      } else {
        _sleepError = "Some error occured";
      }
    } else if (response != null || response.containsKey('data')) {
      _sleepDescription = response["description"] ?? "";
      List<dynamic> rsp = response['data'] as List;

      var a = rsp.map<HomepageDynamicData>(
              (json) => HomepageDynamicData.fromJson(json));

      if (_sleepCurrentPage == 0) _sleep.clear();
      _sleep.addAll(a);
      if (response.containsKey("page_meta")) {
        Map<String, dynamic> pageMetaData = response['page_meta'];
        _sleepCurrentPage = pageMetaData["current_page"];
        _sleepTotalPage = pageMetaData["total"];
      }
    }
  }

  getViewAll(String slug, {bool isRefreshRequest = false}) async {
    _hasViewAllError = false;
    if (_viewAllCurrentPage == _viewAllTotalPage) return;

    Map<String, dynamic> response = await _apiLocator.getViewAllOfSpecificItem(
        isRefreshRequest: isRefreshRequest,
        slug: slug,
        page: _viewAllCurrentPage + 1,
        perpage: 20);

    if (response == null) {
      _hasViewAllError = true;

      _viewAllError = "Some error occured";
    } else if (response != null && response.containsKey('data')) {
      List<dynamic> rsp = response['data'] as List;

      ///

      var a = rsp.map<Playable>((json) => Playable.fromJson(json));
      if (_viewAllCurrentPage == 0) _viewAllUpdatedTracks.clear();
      _viewAllUpdatedTracks.addAll(a);

      if (response.containsKey("page_meta")) {
        Map<String, dynamic> pageMetaData = response['page_meta'];
        _viewAllCurrentPage = pageMetaData["current_page"];
        _viewAllTotalPage = pageMetaData["total"];
      }
    } else if (response != null && response.containsKey('error')) {
      _hasViewAllError = true;
      if (response != null) {
        _viewAllError = response['error'];
      } else {
        _viewAllError = "Some error occured";
      }
    }
  }

  addItemsIntoEmptyViewAllList(List<Playable> items) {
    _viewAllUpdatedTracks.addAll(items);
  }

  clearViewAlItems() {
    _viewAllUpdatedTracks.clear();
  }

  getHomepageMeditatePlayable({bool isRefreshRequest = false}) async {
    _hasMeditateHomePlayableError = false;
    final response = await _apiLocator.getHomepageMeditatePlayable(
      isRefreshRequest: isRefreshRequest,
    );

    if (response == null) {
      _hasMeditateHomePlayableError = true;
      _meditateHomePlayableError = some_error_occured;
    } else if (response.containsKey("error")) {
      _hasMeditateHomePlayableError = true;
      if (response["error"] == error_msg_404) {
        _hasMeditateHomePlayableError = false;
      }
      _meditateHomePlayableError = response["error"];
    } else if (response.containsKey("data")) {
      var res = response["data"] as List;
      //    _meditateHomePlayableList.clear();
      _meditateHomePlayableList =
          res.map<Playable>((e) => Playable.fromJson(e)).toList();
    }
  }

  getHomepageDynamicLists({bool isRefreshRequest = false}) async {
    _hasDynamicHomepageListError = false;
    Map response = await _apiLocator.getHomepageDynamicLists(
      isRefreshRequest: isRefreshRequest,
    );

    if (response == null) {
      _hasDynamicHomepageListError = true;
      _meditateHomePlayableError = some_error_occured;
    } else if (response.containsKey("error")) {
      _hasDynamicHomepageListError = true;
      if (response["error"] == error_msg_404) {
        _hasDynamicHomepageListError = false;
      }
      _dynamicHomepageError = response["error"];
    } else if (response.containsKey("data")) {
      //    print(response["data"]);

      //  print(response["data"]["data"]);

      var res = response["data"] as List;

      _dynamicHomepageList = res
          .map<HomepageDynamicData>((e) => HomepageDynamicData.fromJson(e))
          .toList();
    }
  }

  resetHistoryPageCount() {
    _historyCurrentPage = 0;
    _historyTotalPage = null;
  }

  resetPlaylistPageCount() {
    _playlistCurrentPage = 0;
    _playlistTotalPage = null;
  }

  resetMediatePageCount() {
    _meditateCurrentPage = 0;
    _meditateTotalPage = null;
  }

  resetSleepPageCount() {
    _sleepCurrentPage = 0;
    _sleepTotalPage = null;
  }

  resetPopularPageCount() {
    _popularTracksCurrentPage = 0;
    _popularPageTotalPage = null;
  }

  resetViewAllPageCount() {
    _viewAllCurrentPage = 0;
    _viewAllTotalPage = null;
  }

  List<Track> get trendingTracks => _trendingTracks;
  List<Track> get latestTracks => _latestTracks;
  // List<Albums> get albums => _albums;
  List<Track> get albumTracks => _albumTracks;
  List<Track> get recentlyPlayedTracks => _recentlyPlayedTracks;
  List<HistoryTracks> get historyTracks => _historyTracks;
  List<HomepageDynamicData> get meditates => _meditates;
  List<Track> get playlist => _playlist;
  List<Track> get userRecomendTracks => _userRecomendTracks;
  List<HomepageDynamicData> get sleep => _sleep;
  List<Playable> get viewAllUpdatedTracks => _viewAllUpdatedTracks;

  List<Playable> get meditateHomePlayableList => _meditateHomePlayableList;
  List<HomepageDynamicData> get dynamicHomepageList => _dynamicHomepageList;

  bool get hasTrendingErrr => _hasTrendingError;
  bool get hasLatestError => _hasLatestError;
  // bool get hasAlbumError => _hasAlbumsError;
  // bool get hasAlbumSongsError => _hasAlbumSongsError;
  bool get hasRecentlyPlayedError => _hasRecentlyPlayedEror;
  bool get hasHistoryError => _hasHistoryError;
  bool get hasMeditateError => _hasMeditateError;
  bool get hasPlayListError => _hasPlaylistError;
  bool get hasUserRecomendError => _hasRecomendError;
  bool get hasSleepError => _hasSleepError;
  bool get hasViewAllError => _hasViewAllError;
  bool get hasMeditateHomePlayableError => _hasMeditateHomePlayableError;

  bool get hasDynamicHomepageListError => _hasDynamicHomepageListError;

  String get latestError => _latestError;
  String get trendingError => _trendingError;
  // String get albumsError => _albumsError;
  // String get albumSongsError => _albumSongsError;
  String get recentError => _recentlyPlayedError;
  String get historyError => _historyError;
  String get meditateError => _meditateError;
  String get playListError => _playListError;
  String get userRecomendError => _recomendError;
  String get sleepError => _sleepError;
  String get viewAllError => _viewAllError;
  String get meditateHomePlayableError => _meditateHomePlayableError;
  String get meditateDescription => _meditateDescription;
  String get sleepDescription => _sleepDescription;

  String get dynamicHomepageError => _dynamicHomepageError;
}
