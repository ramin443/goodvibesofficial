import 'package:goodvibesoffl/favorites/favoritetrackmodel.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FavoritesDatabaseHelper {

  static FavoritesDatabaseHelper _databaseHelper;    // Singleton DatabaseHelper
  static Database _database;                // Singleton Database

  String favoritestable = 'note_table';
  String colId = 'id';
  String colTitle = 'title';
  String colDescription = 'description';
  String colimageasset = 'imageasset';
//  String colDate = 'date';

  FavoritesDatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

  factory FavoritesDatabaseHelper() {

    if (_databaseHelper == null) {
      _databaseHelper = FavoritesDatabaseHelper._createInstance(); // This is executed only once, singleton object
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
    String path = directory.path + 'fav.db';

    // Open/create the database at a given path
    var favoritesDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    return favoritesDatabase;
  }

  void _createDb(Database db, int newVersion) async {

    await db.execute('CREATE TABLE $favoritestable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, '
        '$colDescription TEXT, $colimageasset TEXT)');
  }

  // Fetch Operation: Get all note objects from database
  Future<List<Map<String, dynamic>>> getFavoritesMapList() async {
    Database db = await this.database;

//		var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result = await db.query(favoritestable, orderBy: '$colId DESC');
    return result;
  }

  // Insert Operation: Insert a Note object to database
  Future<int> insertFavorites(FavoriteTrackModel favoriteTrackModel) async {
    Database db = await this.database;
    var result = await db.insert(favoritestable, favoriteTrackModel.toMap());
    return result;
  }

  // Update Operation: Update a Note object and save it to database
  Future<int> updateFavorites(FavoriteTrackModel favoriteTrackModel) async {
    var db = await this.database;
    var result = await db.update(favoritestable, favoriteTrackModel.toMap(), where: '$colId = ?', whereArgs: [favoriteTrackModel.id]);
    return result;
  }

  // Delete Operation: Delete a Note object from database
  Future<int> deleteFavorites(int id) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $favoritestable WHERE $colId = $id');
    return result;
  }

  // Get number of Note objects in database
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $favoritestable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'Note List' [ List<Note> ]
  Future<List<FavoriteTrackModel>> getFavoritesList() async {

    var favMapList = await getFavoritesMapList(); // Get 'Map List' from database
    int count = favMapList.length;         // Count the number of map entries in db table

    List<FavoriteTrackModel> favList = List<FavoriteTrackModel>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      favList.add(FavoriteTrackModel.fromMapObject(favMapList[i]));
    }

    return favList;
  }

}
