import 'dart:convert';
import 'dart:io';

//import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:goodvibesoffl/models/composer_download_task_model.dart';
import 'package:goodvibesoffl/models/music_model.dart';
import 'package:goodvibesoffl/models/playlist_model.dart';
import 'package:goodvibesoffl/models/settings_model.dart';
import 'package:goodvibesoffl/models/user_model.dart';
import 'package:goodvibesoffl/utils/common_functiona.dart';
import 'package:goodvibesoffl/utils/date_format.dart';
import 'package:goodvibesoffl/utils/strings/audio_constants.dart';
// import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/composer_audio_model.dart';
import 'database/migration_scripts.dart';

class DatabaseService {
  /// databse  table names

  static const download_table = 'download';
  static const history_table = 'history';
  static const favourite_table = 'favourite';
  static const reminder_table = 'reminder';
  static const settings_table = "settings";
  static const user_table = "user";

  static const saved_group_audios_table = "saved_group_audios_table";

  static const composer_audio_files = "composer_audio_files";
  static const composer_category_table = "composer_category_table";
  static const composer_downloaded_files = "composer_downloaded_files";
  static const playlist_table = "playlist_table";
  static const rituals_table = "rituals_table";

  static const Column_completion_status = "completion_status";
  static const Column_completed_duration = "played_duration";
  static const Column_duration = "total_duration";

// FOREIGN KEYS
  static const groupId_fKey = "groupId";

  static DatabaseService dbService;
  static Database _db;
  static const database_name = 'data.db';

  // increased database version to add composer tables, should be 3
  static const db_version = 3;
  DatabaseService._private();

  factory DatabaseService() {
    if (dbService == null) {
      dbService = DatabaseService._private();
    }

    return dbService;
  }

  Future<Database> get db async {
    if (_db == null) {
      _db = await initDb();
    }

    return _db;
  }

  Future<Database> initDb() async {
    final _db_version = databaseMigrations.length;
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, database_name);

    _db = await openDatabase(path, version: _db_version,
        onCreate: (db, version) async {
          dPrint("create database ::");

          for (int i = 1; i <= _db_version; i++) {
            dPrint(databaseMigrations[i]);
            _runDatabaseQueryWithTryCatch(db, databaseMigrations[i]);
            dPrint("\n");
          }
        }, onUpgrade: (db, oldVersion, newVersion) async {
          dPrint('database new version : $newVersion');
          dPrint("upgrade database::::");
          for (int i = oldVersion + 1; i <= _db_version; i++) {
            dPrint("migration\n");

            dPrint(databaseMigrations[i]);
            _runDatabaseQueryWithTryCatch(db, databaseMigrations[i]);
          }
        });

    return _db;
  }

  _runDatabaseQueryWithTryCatch(Database db, String query) async {
    try {
      await db.rawQuery(query);
    } catch (e) {
      //dPrint(e);
    }
  }

  clearSavedComposerMixesTable() async {
    var _db = await db;
    _db.delete(saved_group_audios_table);
  }

  insertIntoSavedComposerMixesTable(
      {String groupName,
        String groupJson,
        Map<String, dynamic> mapToInsert}) async {
    var _db = await db;

    try {
      await _db.insert(saved_group_audios_table, mapToInsert);

      var lastId = _db.rawQuery("SELECT last_insert_rowid()");

      return lastId;
    } catch (e) {
      //dPrint(e);
    }
  }

  insertAllSavedCompoerMixes(
      {@required List<Map<String, dynamic>> mixes}) async {
    var _db = await db;

    _db.delete(saved_group_audios_table);

    var _batch = _db.batch();
    mixes.forEach((element) {
      _batch.insert(saved_group_audios_table, element);
    });

    try {
      var res = await _batch.commit(noResult: true, continueOnError: true);
    } catch (e) {
      //dPrint(e);
    }
  }

  getAllSavedGroups() async {
    var _db = await db;
    var res = _db.query(saved_group_audios_table);
    return res;
  }

  updateSavedComposerGroupName({String title, int mixId}) async {
    Database _db = await db;

    try {
      var dbRes = await _db.rawQuery(
          '''UPDATE saved_group_audios_table SET group_name="$title" WHERE group_id_api=$mixId  ''');
    } catch (e) {
      //dPrint(e);
    }
  }

  deleteComposerSavedMix({@required int id}) async {
    Database _db = await db;

    try {
      var res = _db.rawQuery(
          ''' DELETE FROM saved_group_audios_table WHERE group_id_api =$id''');
    } catch (e) {
      //dPrint(e);
    }
  }

  updateSavedItemsIdToApiId({@required int idFromApi, int savedItemId}) async {
    Database _db = await db;
    try {
      await _db.rawQuery(
          ''' UPDATE  saved_group_audios_table SET group_id_api=$idFromApi where "groupId"=$savedItemId ''');
    } catch (e) {
      //dPrint(e);
    }
  }

  getAllDownloadedCFilesList() async {
    _db = await db;

    var res =
    await _db.rawQuery(''' SELECT * FROM "$composer_downloaded_files"''');

    return res;
  }

  getAllDownloadedComposerFileNamesList(Database db) async {
    var res = await _db
        .rawQuery(''' SELECT audioTitle FROM "$composer_downloaded_files"''');

    return res;
  }

  getAllDownloadTasksFromDownloaderPlugin() async {
    _db = await db;

    var res = await _db.rawQuery('''SELECT * FROM task WHERE  status=3 ''');
    return res;
  }

  insertIntoDownloadedCFilesTable(
      DownloadTaskModel taskModel,
      Database db,
      ) async {
    _db = db;
    try {
      var exists = await _db.rawQuery(
          ''' SELECT * FROM "$composer_downloaded_files" where id==${taskModel.audioId}''');

      if (exists.isEmpty)
        _db.insert(composer_downloaded_files, {
          "id": taskModel.audioId,
          "audioTitle": taskModel.audioTitle,
          "fileName": taskModel.fileName,
          "taskID": taskModel.taskId
        });
    } catch (e) {
      //dPrint("error in inserting download task model in db is : $e");
    }
  }

  updateComposerAudioFileAfterDownload(
      {DownloadTaskModel item, Database db}) async {
    try {
      var updateRes = await db.rawQuery(''' UPDATE "${composer_audio_files}"
           SET audioPathType="$audio_file"
           WHERE id=${item.audioId} ''');
    } catch (e) {
      //dPrint(e);
    }
  }

  insertAllIntoDownloadedCFilesTable() async {}

  getDownloadedComposerFilenames() async {
    var db = _db;
    try {
      var res = await db
          .rawQuery('''SELECT fileName  FROM "${composer_downloaded_files}"''');
      return res;
    } catch (e) {
      return [];
    }
  }

  insertIntoComposerCategoryTable(
      List<ComposerCategory> categories, Database db) async {
    await _db.delete(composer_category_table);

    var batch = db.batch();

    categories.forEach((item) {
      try {
        batch.insert(
            composer_category_table, {"id": item.id, "name": item.name});
      } catch (e) {
        //dPrint(e);
      }
    });

    await batch.commit(continueOnError: true, noResult: true);

    // var res = await Future.wait(categories.map((item) {
    //   try {
    //     return _db.insert(
    //         composer_category_table, {"id": item.id, "name": item.name});
    //   } catch (e) {}
    // }));

//    return res;
  }

  getComposerCategories() async {
    _db = await db;

    var res =
    await _db.rawQuery('''SELECT * FROM "$composer_category_table" ''');
    return res;
  }

  insertAllComposerAudios(List<ComposerAudio> audios, Database db) async {
    try {
      await db.delete(composer_audio_files);
    } catch (e) {
      //dPrint(e);
    }

    try {
      var batch = db.batch();

      audios
          .forEach((ComposerAudio audio) => batch.insert(composer_audio_files, {
        "id": audio.id,
        "fileName": audio.fileName,
        "dateAdded": DateTime.now().toString(),
        "audioPathType": audio.audioPathType,
        "audioTitle": audio.audioTitle,
        "defaultVolume": audio.defaultVolume,
        "paid": audio.isPaid,
        "image": audio.image,
        "category": audio.category,
        "categoryId": audio.categoryId,
        "url": audio.url,
        "downloadUrl": audio.downloadUrl
      }));

      await batch.commit(noResult: true, continueOnError: true);
    } catch (e) {
      //dPrint(e);
    }
  }

  insertAudioIntocomposerAudioFilesTable(
      {ComposerAudio audio, Database db}) async {
    await _db.insert(composer_audio_files, {
      "id": audio.id,
      "fileName": audio.fileName,
      "dateAdded": DateTime.now().toString(),
      "audioPathType": audio.audioPathType,
      "audioTitle": audio.audioTitle,
      "defaultVolume": audio.defaultVolume,
      "paid": audio.isPaid,
      "image": audio.image,
      "category": audio.category,
      "categoryId": audio.categoryId,
      "url": audio.url,
      "downloadUrl": audio.downloadUrl
    });
  }

  getComposerFiles(Database db) async {
    try {
      var res = await _db.query(composer_audio_files);
      return res;
    } catch (e) {
      //dPrint(e);
    }
  }

  getLocalComposerFileNamesList() async {
    _db = await db;

    try {
      var res = await _db.rawQuery(
          '''SELECT fileName from "$composer_audio_files" WHERE "$composer_audio_files.audioPathType"="$audio_file" ''');

      if (res.isEmpty) {
        //dPrint("empty");
        return [];
      } else {
        //dPrint(res);

        return res[0]['some'];
      }
    } catch (e) {
      //dPrint(e);
    }
  }

  insertIntoSettingsTable(SettingsModel settings) async {
    _db = await db;

    _db.delete(settings_table);

    var result = _db.insert(
      settings_table,
      {
        "id": settings.id,
        "email": settings.email,
        "full_name": settings.fullName,
        "country": settings.country,
        "city": settings.city,
        "state": settings.state,
        "address": settings.address,
        "key": settings.key,
        "device": settings.device,
        "paid": settings.paid,
        "free_trail": settings.freeTrail,
        "login_type": settings.loginType,
        "admin": settings.admin,
        "user_image": settings.userImage,
        "user_image_standard": settings.userImageStandard,
        "active": settings.active,
        "created_at": settings.createdAt,
        "plan": settings.plan,
        "status": settings.status,
        "disabled": settings.disabled,
        "daily_updates_push": settings.settings.dailyUpdatesPush,
        "offers_push": settings.settings.offersPush,
        "others_push": settings.settings.dailyUpdatesPush
      },
    );
    return result;
  }

  updateSettings(SettingsModel settings) async {
    _db = await db;
    try {
      var result = _db.update(
        settings_table,
        {
          "id": settings.id,
          "email": settings.email,
          "full_name": settings.fullName,
          "country": settings.country,
          "city": settings.city,
          "state": settings.state,
          "address": settings.address,
          "key": settings.key,
          "device": settings.device,
          "paid": settings.paid,
          "free_trail": settings.freeTrail,
          "login_type": settings.loginType,
          "admin": settings.admin,
          "user_image": settings.userImage,
          "user_image_standard": settings.userImageStandard,
          "active": settings.active,
          "created_at": settings.createdAt,
          "plan": settings.plan,
          "status": settings.status,
          "disabled": settings.disabled,
          "daily_updates_push": settings.settings.dailyUpdatesPush,
          "offers_push": settings.settings.offersPush,
          "others_push": settings.settings.othersPush,
          "gender": settings.gender
        },
      );
      return result;
    } catch (e) {
      //dPrint("settings table update ");
    }
  }

  clearHistory() async {
    _db = await db;
    await _db.delete(history_table);
  }

  Future<List<Map<String, dynamic>>> getDownloads() async {
    _db = await db;
    var fb = await _db.rawQuery(
        'select DISTINCT id,title,filename,duration,cid,description,url,cname,composer,image,download_id,datetime,track_download_url,downloaded from "$download_table"');

    if (fb != null) return fb;
  }

  Future getSingleDownload(int id) async {
    _db = await db;

    // var data = await _db.rawQuery("SELECT * from $download_table where id=$id");
    var data = await _db.rawQuery("select * from $download_table");

    if (data != null) {
      // //dPrint(data[0]["download_id"]);
      return Track.fromDb(data[0]);
    }
  }

  Future<Track> getSingleDownloadedTrack({@required int trackId}) async {
    _db = await db;

    var data =
    await _db.rawQuery("SELECT * from $download_table where id=$trackId");

    if (data != null) {
      if (data.isNotEmpty) return Track.fromDb(data[0]);
    }
    return null;
  }

  clearDownloadsTable() async {
    _db = await db;

    try {
      await _db.delete(download_table);
    } catch (e) {
      //
    }
  }

  setDownloadComplete({@required int trackID}) async {
    _db = await db;
    await _db.rawUpdate(
        'UPDATE $download_table SET downloaded= 1 WHERE id=$trackID');
  }

  addIntoFavourite(var t) async {
    _db = await db;
    await _db.rawInsert('''insert into  "$favourite_table"
       (id ,title,filename,duration,cid,description,url,cname,composer,image) 
       values
        ("${t.id}" , "${t.title}", "filename", "${t.duration}", "${t.cid}", "${t.description}", "${t.url}", "${t.cname}", "${t.composer}","${t.image}")''');
  }

  addDownloadedItemIntoDownloadList(
      {Track track, String downloadPath, int downloadId}) async {
    var row = {
      'id': track.id,
      'title': track.title,
      'filename': track.filename,
      'duration': track.duration,
      'cid': track.cid,
      'description': track.description,
      'url': track.url,
      'cname': track.cname,
      'composer': track.composer,
      'image': track.image,
      'download_id': downloadId,
      'datetime': track.dateTime,
      'track_download_url': track.trackDownloadUrl,
      'downloaded': 0,
    };

    _db = await db;

    await _db.insert(download_table, row);
  }

  deleteDownloadItem({int trackId}) async {
    var _db = await db;

    var d = await _db
        .rawQuery('select * from  "$download_table" where id=$trackId');
    d = d.toList();
    if (d.isNotEmpty) {
      Directory directory = await getApplicationDocumentsDirectory();

      String initialPath =
      Platform.isAndroid ? directory.parent.path : directory.path;

      var path = join(initialPath, 'files', 'sounds',
          trimDownloadFilename(d[0]['filename']));

      File file = File(path);

      try {
        bool fileStatus = await file.exists();
        if (fileStatus) {
          file.deleteSync();
        }
      } catch (e) {
        // file delete exception
      }
      await _runDatabaseQueryWithTryCatch(
          _db, 'delete from  "$download_table" where id=$trackId');
    }
  }

  addTrackInHistory({Track track}) async {
    int playCount = 1;

    _db = await db;

    /// checking if the track exists in the database
    ///
    var currentDate = dateFormat.format(DateTime.now()).toString();

    /// checking if the song is played already or not
    try {
      var songPlayed = await _db.rawQuery(
          'select * from  "$history_table" where id=${track.id} AND datetime="$currentDate"');

      if (songPlayed.length == 0) {
        track.paid = track.paid ?? false;
        var insert = await _db.insert(history_table, {
          "id": track.id,
          "title": track.title,
          "filename": track.filename,
          "cid": track.cid,
          "url": track.url,
          "cname": track.cname,
          'description': track.description,
          "composer": track.composer,
          "image": track.image,
          "datetime": dateFormat.format(DateTime.now()).toString(),
          "play_count": playCount,
          "paid": track.paid != null ? 1 : 0
        });
      } else {
        var exists = await _db.rawQuery(
            'SELECT * FROM "$history_table" where  datetime="$currentDate"');

        playCount = exists[0]['play_count'] + 1;

        await _db.rawUpdate(
            'UPDATE "$history_table" SET play_count=$playCount  WHERE id=${track.id} AND datetime="$currentDate"');
      }
    } catch (e) {
      reportDatabaseTableAddErrorToCrashlytics();
    }
  }

  Future<bool> checkFavourite(int id) async {
    _db = await db;

    var a = await _db.rawQuery('select * from "$favourite_table" where id=$id');

    if (a.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  deleteAllRowsFromFavourite() async {
    _db = await db;
    _db.delete(favourite_table);
  }

  deleteFromFavourite(int id) async {
    _db = await db;
    await _db.rawDelete('delete from  "$favourite_table" where id=$id');
  }

  insertIntoFavourite(map) async {
    _db = await db;
    await _db.insert(favourite_table, map);
  }

  getAllFavourites() async {
    _db = await db;
    return _db.rawQuery('select * from "$favourite_table"');
  }

//// reminder related methods
  deleteSingleReminder(int id) async {
    _db = await db;
    await _db.rawDelete('delete from  "$reminder_table" where reminderID=$id');
  }

  deleteMultipleRemidners(List<int> ids) async {
    _db = await db;
    await Future.forEach(ids, (id) {
      _db.rawDelete('delete from  "$reminder_table" where reminderID=$id');
    });
  }

  deleteReminderTable() async {
    _db = await db;
    await _db.rawDelete('delete from reminder');
  }

  addReminder(row) async {
    _db = await db;
    await _db.insert('reminder', row);
  }

  updateReminder({int status, int id}) async {
    _db = await db;
    await _db
        .rawUpdate('UPDATE reminder SET status= $status WHERE reminderID=$id');
  }

  getCombinedRemider() async {
    _db = await db;
    return _db.rawQuery(
        'SELECT time,group_concat(id || ": " || day,", ") as individualModel,group_concat(day,", ") as days,status,reminderID FROM reminder Group By reminderID');
  }

  getReminders() async {
    _db = await db;
    return _db.query(reminder_table);
  }

  Future<int> getNextReminderID() async {
    _db = await db;
    List<Map<String, dynamic>> result =
    await _db.rawQuery('SELECT MAX(reminderID) FROM $reminder_table');
    int reminderID = result.first["MAX(reminderID)"];
    if (reminderID == null) {
      return 1;
    } else {
      return reminderID + 1;
    }
  }

  getMusicFileLocalUrl(int id) async {
    _db = await db;

    var some = await _db
        .rawQuery('''select url from "$download_table" where id=$id''');

    return some;
  }

  Future<bool> checkIfDownloadExistInTable(int id) async {
    _db = await db;
    List<Map> result =
    await _db.rawQuery('select * from "$download_table" where id=$id');
    if (result.length == 0) {
      return false;
    }
    return true;
  }

  getSettings() async {
    _db = await db;
    var settings = await _db.rawQuery('select * from "$settings_table"');
    if (settings.isNotEmpty) {
      //dPrint("settings table length: ${settings.length}");
      //dPrint(settings);

      return settings[settings.length - 1];
    } else
      return {};
  }

  reportDatabaseTableAddErrorToCrashlytics(
      {String tableName, String exception, var stackTrace}) {
   // Crashlytics.instance.recordError(
    //  exception,
   //   stackTrace,
 //   );
  }

  /// history tracks

  Future<List<Map<String, dynamic>>> getHistoryTracks() async {
    _db = await db;
    var result = await _db.rawQuery('SELECT * from history');
    return result;
  }

  Future<List<Map<String, dynamic>>> getDistinctItemFromHistory() async {
    _db = await db;
    var result = await _db
        .rawQuery('SELECT DISTINCT *  from "$history_table" GROUP BY "id"');
    return result;
  }

  insertIntoUserTable(User user) async {
    try {
      _db = await db;

      var result = _db.insert(
        user_table,
        {
          "uid": user.uid,
          "email": user.email,
          "name": user.name,
          "image": user.image,
          "type": user.type,
          "authToken": user.authToken,
          "isLoggedIn": user.isLoggedIn ? 1 : 0,
          "paid": user.paid ? 1 : 0,
          "passwordSet": user.passwordSet ? 1 : 0,
          "meditationDay": user.meditationDay,
          "minToday": user.minToday,
          "badgeLevel": user.badgeLevel,
          "tags": json.encode(user.tags?.map((e) => e.toDBJson())?.toList()),
          "freeTrial": user.freeTrial ? 1 : 0,
          "country": user.country,
          "city": user.city,
          "state": user.state,
          "address": user.address,
          "dob": user.dob?.toString(),
          'plan': user.plan,
          'gender': user.gender
        },
      );
      return result;
    } catch (e) {
      return null;
    }
  }

  updateUserTable(User user) async {
    _db = await db;

    try {
      var result = _db.update(
        user_table,
        {
          "uid": user.uid,
          "email": user.email,
          "name": user.name,
          "image": user.image,
          "type": user.type,
          "authToken": user.authToken,
          "isLoggedIn": user.isLoggedIn ? 1 : 0,
          "paid": user.paid ? 1 : 0,
          "passwordSet": user.passwordSet ? 1 : 0,
          "meditationDay": user.meditationDay,
          "minToday": user.minToday,
          "badgeLevel": user.badgeLevel,
          "tags": json.encode(user.tags?.map((e) => e.toDBJson())?.toList()),
          "freeTrial": user.freeTrial,
          "country": user.country,
          "city": user.city,
          "state": user.state,
          "address": user.address,
          "dob": user.dob?.toString(),
          "gender": user.gender,
          'plan': user.plan
        },
        where: 'uid = ?',
        whereArgs: [user.uid],
      );
      return result;
    } catch (e) {
      //dPrint("profile table update catch error");
    }
  }

  getUser() async {
    _db = await db;
    return _db.query(user_table);
  }

  deleteUserFromUserTable() async {
    _db = await db;
    await _db.rawDelete('delete from $user_table');
  }

  removedAndInsertTrackInDownloadTable({Track track}) async {
    try {
      _db = await db;
      await _db.rawDelete('delete from "$download_table" where id=${track.id}');
      var row = {
        'id': track.id,
        'title': track.title,
        'filename': track.filename,
        'duration': track.duration,
        'cid': track.cid,
        'description': track.description,
        'url': track.url,
        'cname': track.cname,
        'composer': track.composer,
        'image': track.image,
        'download_id': track.downloadId,
        'datetime': track.dateTime,
        'downloaded': 1,
        'track_download_url': track.trackDownloadUrl,
      };
      _db.insert(download_table, row);
    } catch (e) {
      return;
    }
  }

  insertIntoRitualsTable({Track track}) async {
    var _db = await db;

    try {
      var _res = await _db.rawQuery(
          ''' SELECT id FROM "$rituals_table" WHERE id=${track.id} AND playlist_id==${track.playlistId} ''');

      if (_res.isEmpty) {
        // dPrint("track does not exist");

        try {
          await _db.insert(rituals_table, {
            "id": track.id,
            "title": track.title,
            "filename": track.filename,
            "duration": getSecondsFromDurationString(track.duration),
            "played_duration": 0.0,
            "completion_status": CompletionStatus.Started.toString(),
            "cid": track.cid,
            "description": track.description,
            "url": track.url,
            "download_url": track.trackDownloadUrl,
            "cname": track.cname,
            "composer": track.composer,
            "image": track.image,
            "download_id": -1,
            "datetime": track.dateTime,
            "track_download_url": track.trackDownloadUrl,
            "downloaded": false,
            "track_paid_type": track.trackPaidType.toString(),
            "playlist_id": track.playlistId
          });
        } catch (e) {
          // dPrint("error in insrting track");
        }
      }
    } catch (e) {
      // dPrint("error in getting track");
    }
  }

  Future<Map<String, dynamic>> getTrackFromRitualTable(
      int trackId, int playlistId) async {
    var _db = await db;
    try {
      var res = await _db.rawQuery(
          '''SELECT * FROM "$rituals_table" WHERE id=$trackId AND playlist_id=$playlistId''');
      if (res.isNotEmpty) {
        return res.first;
      }
      return {};
    } catch (e) {
      return {};
    }
  }

  getRituals() async {
    var _db = await db;

    try {
      var res = await _db.query(rituals_table);
      return res;
    } catch (e) {
      // dPrint(e);

      return [];
    }
  }

  Future<void> updateRitualTrackCompletionStatus(Track track) async {
    var _db = await db;

    try {
      var res = _db.rawQuery(
          '''UPDATE "$rituals_table" SET "completion_status"="CompletionStatus.Complete" WHERE id=${track.id} ''');
    } catch (e) {
      dPrint(e);
    }
  }

  updateRitualTrackDuration(var position, Track track) async {
    var _db = await db;

    try {
      await _db.rawQuery(
          '''UPDATE "$rituals_table" SET  "played_duration"="$position" where id=${track.id} AND playlist_id=${track.playlistId} ''');
    } catch (e) {
      dPrint(e);
    }
  }

  insertIntoPlaylistTable({@required PlayList playlist}) async {
    var _db = await DatabaseService().db;

    try {
      var exists = await _db.rawQuery(
          '''SELECT id FROM "$playlist_table" WHERE id=${playlist.id} ''');

      if (exists.isEmpty) {
        try {
          await _db.insert(playlist_table, {
            "id": playlist.id,
            "title": playlist.title,
            "description": playlist.description,
            "length": 0,
            "image": playlist.image,
            "slug": playlist.slug,
            "playables_count": playlist.playablesCount,
            "total_progress": 0.0,
            "completion_status": CompletionStatus.Started.toString(),
            "total_duration": playlist.playableStat.totalDuration,
            'played_duration': playlist.playableStat.playedDuration
          });
        } catch (e) {
          dPrint(e);
        }
      }
    } catch (e) {
      dPrint(e);
    }
  }

  getAllFromRitualsTableWithFromPlaylist(int playlistId) async {
    var _db = await db;

    try {
      var res = await _db.rawQuery(
          '''SELECT * FROM rituals_table WHERE playlist_id=${playlistId} ''');

      return res;
    } catch (e) {
      return [];
    }
  }

  getPlayedRitualPlaylists() async {
    try {
      var _db = await db;
      var res = await _db.query(playlist_table);

      return res.toList();
    } catch (e) {
      return [];
    }
  }

  updateRituaslPlaylistTable(
      {@required totalProgress, @required playlistId}) async {
    var _db = await db;

    try {
      await _db.rawQuery(
          '''UPDATE "$playlist_table" SET "total_progress"=$totalProgress WHERE id=$playlistId ''');
    } catch (e) {
      dPrint(e);
    }
  }
}
