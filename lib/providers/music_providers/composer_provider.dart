import 'dart:convert';
import 'package:goodvibesoffl/models/dynamic_homepage_model.dart';
import 'package:goodvibesoffl/services/api_service.dart';
import 'package:goodvibesoffl/services/composer_service.dart';
import 'package:goodvibesoffl/services/user_service.dart';
import 'package:goodvibesoffl/utils/strings/string_constants.dart';
import 'package:goodvibesoffl/widgets/common_widgets/common_widgets_methods.dart';
// import 'package:logger/logger.dart';
import 'package:sqflite/sqflite.dart';
import '../../locator.dart';
import '../../services/database_service.dart';
import '../../models/composer_audio_model.dart';
import '../../utils/common_functiona.dart';
import 'package:flutter/material.dart';
import '../../utils/strings/audio_constants.dart';

class ComposerProvider {
  final _apiService = locator<ApiService>();

  List<ComposerAudio> _composeItems = [];
  List<ComposerAudio> _filteredAudios = [];
  List<ComposerCategory> _composerCategoryList = <ComposerCategory>[];
  List<ComposerSavedMix> _savedComposerMixes = [];

  List<ComposerSavedMix> _popularMixes = [];
  List<ComposerSavedMix> _recentMixes = [];

  bool _hasCombinedCompositionFetchError = false;
  String _combinedCompositionFetchError = "";

  List<CombinedCompositions> _compositionsLists = [];

  bool _hasGetComposeError = false;
  String getComposeError = "";

  bool _hasComposerSavedMixesError = false;

  String composerSavedMixesError = '';

  bool _hasFetchedFromApi = false;

  /// function to get compser's items , either from db or from api
  getComposeItemx() async {
    /// 1. get and set the path to save composer files
    await locator<ComposerService>().getSaveDirectoryPath();

    /// get database instance to be used in all queries
    Database _db = await DatabaseService().db;
    _composeItems.clear();

    //// get file names of already downloaded composer audio files from db
    /// below db query returns list of map with key "fileName"
    List<String> downloadedFilesList =
    await getDownloadedComposerFileNamesList();

    //print("downloaded  files names lsit: $downloadedFilesList");

    //// get list of all composer audio files saved in database
    /// if empty or null fetch list from server

    List<Map<String, dynamic>> composerListFromDatabase =
    await DatabaseService().getComposerFiles(_db);

    bool _isOffline = await checkIfOffline();

//// if data from db is null or is list empty fetch from api
    /// else fetch from api
    ///  but after the completion of fetching data from api also (if not offline and , data has not already been fetched from api in this session),
    ///  fetch data from api to get the latest data

    if (composerListFromDatabase == null || composerListFromDatabase.isEmpty) {
      await _getComposerItemsFromApi(downloadedFilesList, _db,
          composerListFromDatabase: composerListFromDatabase);
    } else {
      /// getting from db
      await _getComposerItemsFromDb(
        composerListFromDatabase: composerListFromDatabase,
        downloadedFilesList: downloadedFilesList,
      );

      ////////if not offline and has not been fetched from api already in this session
      if (!_hasFetchedFromApi && !_isOffline) {
        ///made [_getComposerItemsFromApi] function not awaitable, so that state can be yielded
        /// by bloc with the data from db , without having to wait for data to fetch from api
        ///  data is fetched by api only once in a session, only if db is empty
        ///  and once after the completion of fetching from db

        _getComposerItemsFromApi(downloadedFilesList, _db,
            composerListFromDatabase: composerListFromDatabase);
      }
    }
  }

  _getComposerItemsFromApi(List<String> downloadedFilesList, Database db,
      {@required List<Map<String, dynamic>> composerListFromDatabase}) async {
    /// getting response from api
    Map response = await _apiService.getComposeItems();

    if (response == null) {
      _hasGetComposeError = true;

      getComposeError = some_error_occured;
    } else if (response.containsKey("error")) {
      _hasGetComposeError = true;
      getComposeError = response["error"];
    } else if (response.containsKey("data")) {
      List list = response["data"];

      /// data from api comes in the form of playablse
      /// the data is first mapped to `HompageDynamicData` and then to [ComposerAudio]
      var _composerList =
      list.map<HomepageDynamicData>((e) => HomepageDynamicData.fromJson(e));

      /// categories for composer audios are mapped from the `title` and `id` of `HomepageDynamicData`'s typeObehject
      _composerCategoryList.clear();

      _composerList.forEach((item) {
        _composerCategoryList.add(
            new ComposerCategory(id: item.id, name: item.typeObject.title));
      });

      //// inserting categories into datatbase for offline use
      await DatabaseService()
          .insertIntoComposerCategoryTable(_composerCategoryList, db);

      _composerCategoryList.insert(0, ComposerCategory(id: -1, name: "All"));

      /// getting temp composer items and adding into database before download starts
      List<ComposerAudio> _tempComposeItemsList = [];

      _composerList.forEach((dynamicData) {
        dynamicData.playables.forEach((playable) {
          _tempComposeItemsList.add(ComposerAudio.fromPlayableWithOutDownload(
              playable: playable,
              data: dynamicData,
              localFilesList: downloadedFilesList));
        });
      });

      //// now adding those temp items into databse all at once
      await DatabaseService()
          .insertAllComposerAudios(_tempComposeItemsList, db);

      /// mapping dynamic homepage data into ComposeAudio class
      _composeItems.clear();
      _composerList.forEach((dynamicData) {
        dynamicData.playables.forEach((playable) {
          _composeItems.add(ComposerAudio.fromPlayable(
              playable: playable,
              data: dynamicData,
              localFilesList: downloadedFilesList));
        });
      });
      _hasFetchedFromApi = true;
    }
  }

  _getComposerItemsFromDb(
      {@required List<String> downloadedFilesList,
        @required List<Map<String, dynamic>> composerListFromDatabase}) async {
    // Logger log = Logger();

    var _composeList = composerListFromDatabase
        .map((e) => ComposerAudio.fromDb(e, downloadedFilesList))
        .toList();

    List<Map<String, dynamic>> composeCategoriesDb =
    await DatabaseService().getComposerCategories();

    var _categoriesFromDb = composeCategoriesDb
        .map<ComposerCategory>(((item) => ComposerCategory.fromDb(item)))
        .toList();

    //  if (_categoriesFromDb.isNotEmpty)
    _composerCategoryList.clear();

    _composerCategoryList.addAll(_categoriesFromDb);
    _composerCategoryList.insert(0, ComposerCategory(id: -1, name: "All"));

    if (_composeList.isNotEmpty) _composeItems.clear();

    _composeItems.addAll(_composeList);

    _hasGetComposeError = false;
  }

  filterComposerTracks(int categoryId) {
    _filteredAudios.clear();

    _filteredAudios =
        _composeItems.where((item) => item.categoryId == categoryId).toList();
  }

// function made to save  only
  _save(title, List<ComposerAudio> audios) async {
    Map response =
    await _apiService.savecomposerMix(title: title, audios: audios);

    var resfromDb = await DatabaseService().insertIntoSavedComposerMixesTable(
        mapToInsert: _getSaveGropJsonFromAudiosList(audios, title, -1));

    var savedItemId = resfromDb.first['last_insert_rowid()'];

    //print('ave: $savedItemId');

    if (response == null) {
    } else if (response.containsKey("error")) {
    } else {
      var idFromApi = response['data']['id'];

      await DatabaseService().updateSavedItemsIdToApiId(
          idFromApi: idFromApi, savedItemId: savedItemId);

      showToastMessage(message: "Saved Mix Successfully");
    }
  }

  saveComposerMix(
      {String title,
        List<ComposerAudio> audios,
        BuildContext context,
        bool isUpdate,
        int mixId}) async {
    if (isUpdate) {
      ComposerSavedMix item = _savedComposerMixes.firstWhere(
            (element) => element.id == mixId,
        orElse: () => null,
      );

      if (item != null) {
        _savedComposerMixes.remove(item);

        _savedComposerMixes.add(item.copyWith(title: title));
      }

      // adding to api

      Map res = await _apiService.updateSavedMix(
          audios: audios, title: title, id: mixId);

      /// updating db item
      DatabaseService()
          .updateSavedComposerGroupName(title: title, mixId: mixId);

      if (res == null) {
        showToastMessage(message: "Could not update mix's name.");
      } else if (res.containsKey("error")) {
        showToastMessage(message: "Could not update mix's name.");
      } else if (res.containsKey('data')) {
        showToastMessage(message: "Mix name updated.");
      }
    }

    ///// else save the mix
    else {
      //// if audios are empty , cannot be saved
      if (audios.isEmpty) {
        showToastMessage(message: "No audios are selected!");
      } else {
        /// if audios are not empty saving the mix

        List<Map<String, dynamic>> mixesFromDb =
        await DatabaseService().getAllSavedGroups();

        var user = locator<UserService>().user.value;

        if (mixesFromDb == null) mixesFromDb = [];

        if (mixesFromDb.length >= 2) {
          //// free user can only save two mixes
          if (user.paid) {
            _save(title, audios);
          } else {
            showDialogBox(
              dialogType: cannotSaveMoreMix,
              context: context,
            );
          }
        } else if (mixesFromDb.length < 2) {
          _save(title, audios);
        }
      }
    }
  }

  updateMixPlayCount(int id) async {
    await _apiService.updateComposerMixPlayCount(id: id);
  }

  Map _getSaveGropJsonFromAudiosList(
      List<ComposerAudio> audios, String title, int mixId) {
    Map<String, dynamic> groupJson = {
      "composition": {
        "title": title,
        "audios": List.generate(
            audios.length,
                (index) => {
              "id": audios[index].id,
              "defaultVolume": audios[index].defaultVolume,
              "position": index,
              "url": audios[index].url,
              "downloadUrl": audios[index].downloadUrl,
              "fileName": audios[index].fileName,
              "audioPathType": audios[index].audioPathType,
              'audioTitle': audios[index].audioTitle,
              "category": audios[index].category,
              "categoryId": audios[index].categoryId,
              "image": audios[index].image,
              "paid": audios[index].isPaid
            })
      }
    };

    String encodedJson = json.encode(groupJson);

    Map<String, dynamic> mapToInsertInDb = {
      "group_json": encodedJson,
      "group_name": title,
      "group_id_api": mixId
    };

    return mapToInsertInDb;
  }

  deleteComposerMix({int id}) async {
    Map response = await locator<ApiService>().deleteSavedMix(id: id);
    await DatabaseService().deleteComposerSavedMix(id: id);

    if (response == null) {
    } else if (response.containsKey("error")) {
      return false;
    } else if (response.containsKey("data")) {
      var item = _savedComposerMixes.firstWhere((element) => element.id == id,
          orElse: () => null);
      if (item != null) _savedComposerMixes.remove(item);
    }
  }

  getAllSavedMixes({bool isRefreshRequest = false}) async {
    _savedComposerMixes.clear();
    _hasComposerSavedMixesError = false;

    var listOfDownloads = await getDownloadedComposerFileNamesList();

    List<Map<String, dynamic>> mixesFromDb =
    await DatabaseService().getAllSavedGroups();

    if (mixesFromDb == null || mixesFromDb.isEmpty) {
      Map response = await _apiService.getSavedComposerMixes();
      if (response == null) {
      } else if (response.containsKey("error")) {
        return false;
      } else if (response.containsKey("data")) {
        var data = response['data'];

        var _saveMixes = data
            .map<ComposerSavedMix>(
                (e) => ComposerSavedMix.fromJson(e, listOfDownloads))
            .toList();

        for (int i = 0; i < _saveMixes.length; i++) {
          var savedMix = _saveMixes[i];

          if (savedMix.audios.isEmpty) {
            _saveMixes.remove(savedMix);
          }
        }
        _savedComposerMixes.addAll(_saveMixes);

        await DatabaseService().insertAllSavedCompoerMixes(
            mixes: _savedComposerMixes
                .map<Map<String, dynamic>>(
                    (mix) => _getSaveGropJsonFromAudiosList(
                  mix.audios,
                  mix.title,
                  mix.id,
                ))
                .toList());
      }
    } else {
// process saved group from database

      var decoded = json.decode(mixesFromDb[0]['group_json']);

      var composerMixes = mixesFromDb.map<ComposerSavedMix>((e) {
        var groupJson = json.decode(e['group_json']);

        var id = e['group_id_api'];

        /// if the group_id_json is unchaged from -1, get the local groupId
        ///  which was saved in dataabse, which will prevent from
        /// having dupliate group id
        if (id == -1) id = e['groupId'];

        return ComposerSavedMix.fromDb(
            json: groupJson,
            groupId: id,
            localAudioFilesList: listOfDownloads,
            title: e['group_name']);
      }).toList();

      if (composerMixes.isNotEmpty) {
        for (int i = 0; i < composerMixes.length; i++) {
          var savedMix = composerMixes[i];

          if (savedMix.audios.isEmpty) {
            composerMixes.remove(savedMix);
          }
        }
      }

      if (composerMixes != null) _savedComposerMixes.addAll(composerMixes);
    }

    if (_savedComposerMixes.isNotEmpty) {
      for (int i = 0; i < _savedComposerMixes.length; i++) {
        var savedMix = _savedComposerMixes[i];

        if (savedMix.audios.isEmpty) {
          _savedComposerMixes.remove(savedMix);
        }
      }
    }
  }

  checkComposerDownloadedItemAndUpdateCurrentList(int trackId) {
    var item = _composeItems.firstWhere((track) => track.id == trackId,
        orElse: () => null);

    if (item != null) {
      var temp = item.copyWith(audioPathType: audio_file);

      //print(
      // "old filetype : ${item.audioPathType}  updated: ${temp.audioPathType}");
      int _index = _composeItems.indexOf(item);
      _composeItems.removeAt(_index);
      _composeItems.insert(_index, temp);
      // _composeItems.remove(item);
      // _composeItems.add(temp);ktmlab
    }
  }

  Future<List<String>> getDownloadedComposerFileNamesList() async {
    Database _db = await DatabaseService().db;
    List<Map<String, dynamic>> composerItemsFileNames = [];

    composerItemsFileNames =
    await DatabaseService().getDownloadedComposerFilenames();

    List<String> downloadedFilesList =
    composerItemsFileNames.map<String>((item) => item["fileName"]).toList();

    return downloadedFilesList;
  }

  clearCombinedCompositionsList() {
    _compositionsLists.clear();
  }

  getCombinedCompositions({bool isRefreshRequest = false}) async {
    _hasCombinedCompositionFetchError = false;
    if (_compositionsLists.isNotEmpty) return;

    Map response = await _apiService.getCombinedCompositions(
        isRefreshRequest: isRefreshRequest);
    if (response == null) {
      _hasCombinedCompositionFetchError = true;
      _combinedCompositionFetchError = response['error'];
    } else if (response.containsKey("error")) {
      _hasCombinedCompositionFetchError = true;
      _combinedCompositionFetchError = response['error'];
    } else if (response.containsKey("data")) {
      List<String> downloadedFilesList =
      await getDownloadedComposerFileNamesList();

      CombinedCompositions _published = CombinedCompositions.fromJson(
          response['data'], downloadedFilesList,
          key: "published");

      CombinedCompositions _popular = CombinedCompositions.fromJson(
          response['data'], downloadedFilesList,
          key: "popular");

      _compositionsLists.clear();

      var _tempPublished = _published;
      var tempPopular = _popular;

      /// removing empty audios
      if (_tempPublished != null && _tempPublished.mixes.isNotEmpty) {
        for (int i = 0; i < _tempPublished.mixes.length; i++) {
          if (_tempPublished.mixes[i].audios.isEmpty) {
            var removed = _tempPublished.mixes.remove(_tempPublished.mixes[i]);

            //print("removed: $removed");
          }
        }

        for (int i = 0; i < _tempPublished.mixes.length; i++) {
          if (_tempPublished.mixes[i].audios.isEmpty) {
            var removed = _tempPublished.mixes.remove(_tempPublished.mixes[i]);

            //print("removed: $removed");
          }
        }
      }

      /// removing empty audios

      if (tempPopular != null && tempPopular.mixes.isNotEmpty) {
        for (int i = 0; i < tempPopular.mixes.length; i++) {
          var item = tempPopular.mixes[i];
          if (item.audios.isEmpty) {
            tempPopular.mixes.remove(tempPopular.mixes[i]);
          }
        }
        for (int i = 0; i < tempPopular.mixes.length; i++) {
          var item = tempPopular.mixes[i];
          if (item.audios.isEmpty) {
            tempPopular.mixes.remove(tempPopular.mixes[i]);
          }
        }
      }

/////

      if (tempPopular != null) _compositionsLists.add(tempPopular);

      if (_tempPublished != null) _compositionsLists.add(_tempPublished);

      // //print(combined.mixes.length.toString());
    }
  }

  bool get hasGetComposeError => _hasGetComposeError;
  bool get hasFetchedFromApi => _hasFetchedFromApi;
  bool get hasComposerSavedMixesError => _hasComposerSavedMixesError;

  List<ComposerAudio> get composeItems => _composeItems;
  List<ComposerCategory> get composerCategoryList => _composerCategoryList;
  List<ComposerAudio> get filteredAudios => _filteredAudios;

  List<ComposerSavedMix> get savedComposerMixes => _savedComposerMixes;
  List<CombinedCompositions> get compositionsLists => _compositionsLists;

  List get recentMixes => _recentMixes;
  List get popularMixes => _popularMixes;

  bool get hasCombinedCompositionFetchError =>
      _hasCombinedCompositionFetchError;
  String get combinedCompositionFetchError => _combinedCompositionFetchError;
}
