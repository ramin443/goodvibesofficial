import 'package:goodvibesoffl/DataStores/recentlyplayedtracks/RecentlyPlayedTrackModel.dart';
import 'package:goodvibesoffl/favorites/favoritetrackmodel.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class RecentlyPlayedDatabaseHelper {

  static RecentlyPlayedDatabaseHelper _databaseHelper;    // Singleton DatabaseHelper
  static Database _database;                // Singleton Database

  String recentlyplayedtable = 'recently_played_table';
  String colId = 'id';
  String colTrackId = 'trackid';
  String colTrackName = 'trackname';
  String colTrackDescription = 'trackdescription';
  String colTrackDuration = 'trackdescription';
  String colTrackUrl = 'trackurl';
  String colTrackDownloadUrl = 'trackdownloadurl';
  String colTrackGenre = 'trackgenre';
  String colDatePlayed = 'dateplayed';


  //  String colDate = 'date';

  RecentlyPlayedDatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

  factory RecentlyPlayedDatabaseHelper() {

    if (_databaseHelper == null) {
      _databaseHelper = RecentlyPlayedDatabaseHelper._createInstance(); // This is executed only once, singleton object
    }
    return _databaseHelper;
  }

  Future<Database> get database async {

    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'recentlyplayed.db';

    // Open/create the database at a given path
    var favoritesDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    return favoritesDatabase;
  }

  void _createDb(Database db, int newVersion) async {

    await db.execute('CREATE TABLE $recentlyplayedtable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTrackId TEXT, '
        '$colTrackName TEXT, $colTrackDescription TEXT, $colTrackDuration TEXT, $colTrackUrl TEXT'
        ', $colTrackDownloadUrl TEXT, $colTrackGenre TEXT, $colDatePlayed TEXT)');
  }

  // Fetch Operation: Get all note objects from database
  Future<List<Map<String, dynamic>>> getRecentlyPlayedtracksMapList() async {
    Database db = await this.database;

//		var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result = await db.query(recentlyplayedtable, orderBy: '$colId DESC');
    return result;
  }

  // Insert Operation: Insert a Note object to database
  Future<int> insertRecentlyPlayedTrack(RecentlyPlayedTrackModel recentlyPlayedTrackModel) async {
    Database db = await this.database;
    var result = await db.insert(recentlyplayedtable, recentlyPlayedTrackModel.toMap());
    return result;
  }

  // Update Operation: Update a Note object and save it to database
  Future<int> updateRecentlyPlayedTrack(RecentlyPlayedTrackModel recentlyPlayedTrackModel) async {
    var db = await this.database;
    var result = await db.update(recentlyplayedtable, recentlyPlayedTrackModel.toMap(), where: '$colId = ?',
        whereArgs: [recentlyPlayedTrackModel.id]);
    return result;
  }

  // Delete Operation: Delete a Note object from database
  Future<int> deleteRecentlyPlayedTrack(int id) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $recentlyplayedtable WHERE $colId = $id');
    return result;
  }

  // Get number of Note objects in database
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $recentlyplayedtable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'Note List' [ List<Note> ]
  Future<List<RecentlyPlayedTrackModel>> getRecentlyPlayedTracksList() async {

    var recplaytrMapList = await getRecentlyPlayedtracksMapList(); // Get 'Map List' from database
    int count = recplaytrMapList.length;         // Count the number of map entries in db table

    List<RecentlyPlayedTrackModel> rptList = List<RecentlyPlayedTrackModel>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      rptList.add(RecentlyPlayedTrackModel.fromMapObject(recplaytrMapList[i]));
    }

    return rptList;
  }

}
