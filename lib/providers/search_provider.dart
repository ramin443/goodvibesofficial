//import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:goodvibesoffl/models/music_model.dart';
import 'package:goodvibesoffl/services/api_service.dart';

class SearchProvider with ChangeNotifier {
  bool _busy = false;
  bool _hasError = false;

  String _searchTerm;

  String searchError = "";
  List<Track> _tracks = [];

  //static FirebaseAnalytics analytics = FirebaseAnalytics();
  final _apiLocator = ApiService();

  int _popularSearchCurrentPage = 0;
  int _popularSearchTotalPage;

  void setBusy(bool value) {
    _busy = value;
  }

  void setError(bool value) {
    _hasError = value;
  }

  getSearchDetails({String text, bool isNewSearch = true}) async {
    _hasError = false;
    if (isNewSearch) {
      _tracks.clear();
      _popularSearchCurrentPage = 0;
    }

    if (text != null) {
      _searchTerm = text;
      await sendSearchInfo(searchText: text);
    }

    if (_popularSearchCurrentPage == _popularSearchTotalPage) return;

    Map<String, dynamic> response = await _apiLocator.getSearchDetails(
        text: _searchTerm, page: _popularSearchCurrentPage + 1, perPage: 12);

    // print(response);
    if (response.containsKey('data')) {
      List<dynamic> rsp = response['data'] as List;

      var a = rsp.map<Track>((json) => Track.fromJson(json));
      _tracks.addAll(a);

      if (response.containsKey("page_meta")) {
        Map<String, dynamic> pageMetaData = response['page_meta'];
        _popularSearchCurrentPage = pageMetaData["current_page"];
        _popularSearchTotalPage = pageMetaData["total"];

        if (_tracks.isEmpty) _popularSearchTotalPage = 2;
      }
    } else if (response == null || response.containsKey("error")) {
      setError(true);
      searchError = response['error'] ?? "Some Error occured";
    }
  }

  sendSearchInfo({String searchText}) async {
   // await analytics.logEvent(name: 'search', parameters: {
   //   'search_term': searchText,
 //   });
  }

  List<Track> get tracks => _tracks;
  bool get busy => _busy;
  bool get hasError => _hasError;
}
