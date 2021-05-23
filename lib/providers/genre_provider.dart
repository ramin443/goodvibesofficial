import 'package:goodvibesoffl/models/music_model.dart';
import 'package:goodvibesoffl/providers/base_provider.dart';
import 'package:goodvibesoffl/services/api_service.dart';
import '../locator.dart';

class GenreProvider extends BaseProvider {
  bool hasGenreError = false;
  String genreError = ' ';
  final _apiLocator = ApiService();
  List<Track> _genreTracks = [];
  List<Track> _genreTracksFiltered = [];
  List<Genre> _genre = [];

  List<Track> get genreTracks => _genreTracks;
  List<Track> get genreTracksFiltered => _genreTracksFiltered;
  List<Genre> get genre => _genre;

  List<Track> _categoryTracks = [];

  List<Categories> _gCategory = [];
  List<Categories> get gCategory => _gCategory;
  List<Track> get categoryTracks => _categoryTracks;

  bool _hasError = false;

  bool get hasError => _hasError;
  String error = '';

  getGenre({bool isRefreshRequest = false}) async {
    setBusy(true);
    _genre.clear();
    Map response =
        await _apiLocator.getGenre(isRefreshRequest: isRefreshRequest);

    if (response.containsKey('data')) {
      List<dynamic> rsp = response['data'] as List;
      var a = rsp.map<Genre>((json) => Genre.fromJson(json));
      _genre.addAll(a);
      setBusy(false);
    } else {
      hasGenreError = true;

      if (response != null) {
        if (response.containsKey('error')) genreError = response['error'];
      } else {
        genreError = 'Some Error Ocurred';
      }
      setBusy(false);
    }
    notifyListeners();
  }

  int genreSelectedIndex = 0;

  getGenereCategory(int id) async {
    _gCategory.clear();

    var response =
        await _apiLocator.getGenreCategory(id: id, perpage: 20, page: 1);

    if (response != null && response.containsKey('data')) {
      List<dynamic> rsp = response['data'] as List;
      var a = rsp.map<Categories>((json) => Categories.fromJson(json));

      _gCategory.addAll(a);
    }
    notifyListeners();
  }

  getGenreTracks({int id, int page = 1, int perpage = 20}) async {
    _categoryTracks.clear();
    _genreTracks.clear();
    Map response =
        await _apiLocator.getGenreTracks(id: id, page: page, perpage: perpage);

    if (response.containsKey('data')) {
      List<dynamic> rsp = response['data'] as List;
      var a = rsp.map<Track>((json) => Track.fromJson(json));
      if (page == 1) _genreTracks.clear();
      _genreTracks.addAll(a);
    } else {
      hasGenreError = true;
      if (response.containsKey("error"))
        genreError = response["error"];
      else
        genreError = "An error occured";
    }
    notifyListeners();
  }

  filterGenereTracks(int id) {
    _genreTracksFiltered.clear();

    _genreTracks.forEach((Track track) {
      if (track.cid == id) _genreTracksFiltered.add(track);
    });

    notifyListeners();
  }

  clearGenreTracksFilter() {
    _genreTracksFiltered.clear();
    notifyListeners();
  }
}
