import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:goodvibesoffl/models/music_model.dart';
import 'package:goodvibesoffl/services/api_service.dart';
import 'package:goodvibesoffl/services/database_service.dart';
import 'package:goodvibesoffl/services/player_service.dart';
import 'package:goodvibesoffl/utils/strings/string_constants.dart';
import 'package:sqflite/sqlite_api.dart';
import '../locator.dart';

class FavoritesProvider with ChangeNotifier {
  List<Track> _favList = [];

  String _favError = "";
  bool _hasFavError = false;

  Future getFavsFromApi({bool isRefreshRequest = false}) async {
    _hasFavError = false;
    _favList.clear();

    Map response = await locator<ApiService>()
        .getAllFavorites(isRefreshRequest: isRefreshRequest ?? false);

    if (response == null) {
      _hasFavError = true;
      _favError = some_error_occured;
      return;
    } else if (response.containsKey("error")) {
      _hasFavError = true;
      _favError = response["error"];
      return;
    } else if (response != null && response.containsKey("data")) {
      var favsData = response['data'];
      var a = favsData.map<Track>((data) => Track.fromJson(data)).toList();

      if (a.length != 0) {
        _favList.addAll(a);
      }

      /// deleting old rows from the favourite table
      await DatabaseService().deleteAllRowsFromFavourite();

      try {
        a.forEach((Track track) {
          Map newMap = track.toJson(track);
          DatabaseService().insertIntoFavourite(newMap);
        });
      } catch (e) {
        //handle error adding into database\
        // print(e);
      }
    }
  }

  List<Track> get favList => _favList;
  String get favError => _favError;
  bool get hasFavError => _hasFavError;
}

class FavoriteIconProvider with ChangeNotifier {
  Database db;
  bool _isFav;
  bool _isBusy = false;

  FavoriteIconProvider(bool isFromPlayerPage) {
    if (isFromPlayerPage) {
      _isFav = locator<MusicService>().isFav.value;
    } else {
      _isFav = true;
    }
  }

  bool get isFav => _isFav;
  bool get isBusy => _isBusy;

  setBusy(bool busyStatus) {
    _isBusy = busyStatus;
    notifyListeners();
  }

  setFavStatus(bool status) {
    _isFav = status;
    notifyListeners();
  }

  onIconPressed({var track}) async {
    setBusy(true);
    if (!_isFav) {
      // adding in fav
      await locator<MusicService>().implementFavourite(track);
      setFavStatus(true);
      // showToastMessage(message: 'Added into favorites!');
    } else {
      /// deleting
      await locator<MusicService>().deletFav(track);
      setFavStatus(false);
      //  showToastMessage(message: 'Removed from favorites!');
    }

    setBusy(false);
  }
}
