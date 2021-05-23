import 'package:goodvibesoffl/Goal/goalmodel.dart';
import 'package:goodvibesoffl/favorites/favoritetrackmodel.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class GoalsDatabaseHelper {

  static GoalsDatabaseHelper _databaseHelper;    // Singleton DatabaseHelper
  static Database _database;                // Singleton Database
  String goalstable = 'goals_table';
  String colId = 'id';
  String colGoalPreferences = 'goalpreferences';
  String colGoalsCount = 'goalcount';
//  String colDate = 'date';

  GoalsDatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

  factory GoalsDatabaseHelper() {

    if (_databaseHelper == null) {
      _databaseHelper = GoalsDatabaseHelper._createInstance(); // This is executed only once, singleton object
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
    String path = directory.path + 'goals.db';

    // Open/create the database at a given path
    var favoritesDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    return favoritesDatabase;
  }

  void _createDb(Database db, int newVersion) async {

    await db.execute('CREATE TABLE $goalstable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colGoalPreferences TEXT, '
        '$colGoalsCount INTEGER)');
  }

  // Fetch Operation: Get all note objects from database
  Future<List<Map<String, dynamic>>> getGoalsMapList() async {
    Database db = await this.database;

//		var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result = await db.query(goalstable, orderBy: '$colId DESC');
    return result;
  }

  // Insert Operation: Insert a Note object to database
  Future<int> insertGoals(GoalsModel goalsModel) async {
    Database db = await this.database;
    var result = await db.insert(goalstable, goalsModel.toMap());
    return result;
  }

  // Update Operation: Update a Note object and save it to database
  Future<int> updateGoals(GoalsModel goalsModel) async {
    var db = await this.database;
    var result = await db.update(goalstable, goalsModel.toMap(), where: '$colId = ?', whereArgs: [goalsModel.id]);
    return result;
  }

  // Delete Operation: Delete a Note object from database
  Future<int> deleteGoals(int id) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $goalstable WHERE $colId = $id');
    return result;
  }

  // Get number of Note objects in database
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $goalstable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'Note List' [ List<Note> ]
  Future<List<GoalsModel>> getGoalsList() async {

    var gMapList = await getGoalsMapList(); // Get 'Map List' from database
    int count = gMapList.length;         // Count the number of map entries in db table

    List<GoalsModel> gList = List<GoalsModel>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      gList.add(GoalsModel.fromMapObject(gMapList[i]));
    }

    return gList;
  }

}
