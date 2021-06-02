import 'package:goodvibesoffl/DataStores/playlists/PlaylistModel.dart';
import 'package:goodvibesoffl/DataStores/playlists/tracksinplaylist/tracksinplaylistmodel.dart';
import 'package:goodvibesoffl/favorites/favoritetrackmodel.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class TracksInPlaylistDatabaseHelper {

  static TracksInPlaylistDatabaseHelper _databaseHelper;    // Singleton DatabaseHelper
  static Database _database;                // Singleton Database

  String tracksinplaylisttable = 'playlist_table';
  String colId = 'id';
  String colplaylistid = 'playlistid';
  String coltrackid = 'trackid';
  String coltrackname = 'trackname';
  String coltrackdescription = 'trackdescription';
  String coltrackduration = 'trackduration';
  String coltrackurl = 'trackurl';
  String coltrackdownloadurl = 'trackdownloadurl';
  String coltrackgenre = 'trackgenre';

  //  String colDate = 'date';
  TracksInPlaylistDatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

  factory TracksInPlaylistDatabaseHelper() {

    if (_databaseHelper == null) {
      _databaseHelper = TracksInPlaylistDatabaseHelper._createInstance(); // This is executed only once, singleton object
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
    String path = directory.path + 'tracksinplaylists.db';

    // Open/create the database at a given path
    var playlistsDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    return playlistsDatabase;
  }

  void _createDb(Database db, int newVersion) async {

    await db.execute('CREATE TABLE $tracksinplaylisttable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colplaylistid INTEGER, '
        '$coltrackid TEXT, $coltrackname TEXT, $coltrackdescription TEXT, $coltrackduration TEXT, $coltrackurl TEXT'
        ', $coltrackdownloadurl TEXT, $coltrackgenre TEXT)');
  }

  // Fetch Operation: Get all note objects from database
  Future<List<Map<String, dynamic>>> gettracksinPlaylistsMapList(int playlistid) async {
    Database db = await this.database;

//  var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result = await db.query(tracksinplaylisttable, orderBy: '$colId DESC',where: '$colplaylistid = $playlistid');
    return result;
  }

  // Insert Operation: Insert a Note object to database
  Future<int> inserttrackinPlaylist(TracksinPlaylistModel tracksinPlaylistModel) async {
    Database db = await this.database;
    var result = await db.insert(tracksinplaylisttable, tracksinPlaylistModel.toMap());
    return result;
  }

  // Update Operation: Update a Note object and save it to database
  Future<int> updatetrackinPlaylist(TracksinPlaylistModel tracksinPlaylistModel) async {
    var db = await this.database;
    var result = await db.update(tracksinplaylisttable, tracksinPlaylistModel.toMap(), where: '$colId = ?',
        whereArgs: [tracksinPlaylistModel.id]);
    return result;
  }

  // Delete Operation: Delete a Note object from database
  Future<int> deletetrackinlaylist(int id) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $tracksinplaylisttable WHERE $colId = $id');
    return result;
  }

  // Get number of Note objects in database
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $tracksinplaylisttable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'Note List' [ List<Note> ]
  Future<List<TracksinPlaylistModel>> gettracksinPlaylistsList(int playlistid) async {

    var tracksinplaylisMapList = await gettracksinPlaylistsMapList(playlistid); // Get 'Map List' from database
    int count = tracksinplaylisMapList.length;         // Count the number of map entries in db table

    List<TracksinPlaylistModel> tracksinplaylisttList = List<TracksinPlaylistModel>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      tracksinplaylisttList.add(TracksinPlaylistModel.fromMapObject(tracksinplaylisMapList[i]));
    }

    return tracksinplaylisttList;
  }

}

