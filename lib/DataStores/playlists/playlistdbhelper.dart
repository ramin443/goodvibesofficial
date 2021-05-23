import 'package:goodvibesoffl/DataStores/playlists/PlaylistModel.dart';
import 'package:goodvibesoffl/favorites/favoritetrackmodel.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class PlaylistDatabaseHelper {

  static PlaylistDatabaseHelper _databaseHelper;    // Singleton DatabaseHelper
  static Database _database;                // Singleton Database

  String playlisttable = 'playlist_table';
  String colId = 'id';
  String colPlaylistID = 'playlistid';
  String colPlaylistname = 'playlistname';
  String colPlaylistcreateddate = 'datecreated';
//  String colDate = 'date';

  PlaylistDatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

  factory PlaylistDatabaseHelper() {

    if (_databaseHelper == null) {
      _databaseHelper = PlaylistDatabaseHelper._createInstance(); // This is executed only once, singleton object
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
    String path = directory.path + 'playlists.db';

    // Open/create the database at a given path
    var playlistsDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    return playlistsDatabase;
  }

  void _createDb(Database db, int newVersion) async {

    await db.execute('CREATE TABLE $playlisttable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colPlaylistID INTEGER, '
        '$colPlaylistname TEXT, $colPlaylistcreateddate TEXT)');
  }

  // Fetch Operation: Get all note objects from database
  Future<List<Map<String, dynamic>>> getPlaylistsMapList() async {
    Database db = await this.database;

//		var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result = await db.query(playlisttable, orderBy: '$colId DESC');
    return result;
  }

  // Insert Operation: Insert a Note object to database
  Future<int> insertPlaylist(PlaylistModel playlistModel) async {
    Database db = await this.database;
    var result = await db.insert(playlisttable, playlistModel.toMap());
    return result;
  }

  // Update Operation: Update a Note object and save it to database
  Future<int> updatePlaylist(PlaylistModel playlistModel) async {
    var db = await this.database;
    var result = await db.update(playlisttable, playlistModel.toMap(), where: '$colId = ?', whereArgs: [playlistModel.id]);
    return result;
  }

  // Delete Operation: Delete a Note object from database
  Future<int> deletePlaylist(int id) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $playlisttable WHERE $colId = $id');
    return result;
  }

  // Get number of Note objects in database
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $playlisttable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'Note List' [ List<Note> ]
  Future<List<PlaylistModel>> getPlaylistsList() async {

    var playlisMapList = await getPlaylistsMapList(); // Get 'Map List' from database
    int count = playlisMapList.length;         // Count the number of map entries in db table

    List<PlaylistModel> playlisttList = List<PlaylistModel>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      playlisttList.add(PlaylistModel.fromMapObject(playlisMapList[i]));
    }

    return playlisttList;
  }

}
