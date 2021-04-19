
import 'package:goodvibesofficial/models/usergoalmodel.dart';
import 'package:sqflite/sqflite.dart';

import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';


class UserGoalsDatabaseHelper {



  static UserGoalsDatabaseHelper _userGoalsDatabaseHelper;    // Singleton DatabaseHelper
  static Database _database;                // Singleton Database



  String usergoalsTable = 'note_table';
  String colId = 'id';
  String colGoaltype = 'goaltype';
  String colDuration = 'duration';
  String colSetdate = 'setdate';


  UserGoalsDatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper



  factory UserGoalsDatabaseHelper() {



    if (_userGoalsDatabaseHelper == null) {
      _userGoalsDatabaseHelper = UserGoalsDatabaseHelper._createInstance(); // This is executed only once, singleton object
    }
    return _userGoalsDatabaseHelper;
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
    String path = directory.path + 'usergoals.db';



    // Open/create the database at a given path
    var notesDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    return notesDatabase;
  }



  void _createDb(Database db, int newVersion) async {



    await db.execute('CREATE TABLE $usergoalsTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colGoaltype TEXT, '
        '$colDuration TEXT, $colSetdate TEXT)');
  }



  // Fetch Operation: Get all note objects from database
  Future<List<Map<String, dynamic>>> getUserGoalsMapList() async {
    Database db = await this.database;



//		var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result = await db.query(usergoalsTable, orderBy: '$colId DESC');
    return result;
  }



  // Insert Operation: Insert a Note object to database
  Future<int> insertUserGoal(UserGoalModel userGoalModel) async {
    Database db = await this.database;
    var result = await db.insert(usergoalsTable, userGoalModel.toMap());
    return result;
  }



  // Update Operation: Update a Note object and save it to database
  Future<int> updateUserGoal(UserGoalModel userGoalModel) async {
    var db = await this.database;
    var result = await db.update(usergoalsTable, userGoalModel.toMap(), where: '$colId = ?', whereArgs: [userGoalModel.id]);
    return result;
  }



  // Delete Operation: Delete a Note object from database
  Future<int> deleteuserGoalModel(int id) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $usergoalsTable WHERE $colId = $id');
    return result;
  }



  // Get number of Note objects in database
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $usergoalsTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }



  // Get the 'Map List' [ List<Map> ] and convert it to 'Note List' [ List<Note> ]
  Future<List<UserGoalModel>> getUserGoalslist() async {



    var usergMapList = await getUserGoalsMapList(); // Get 'Map List' from database
    int count = usergMapList.length;         // Count the number of map entries in db table



    List<UserGoalModel> usergoalsList = List<UserGoalModel>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      usergoalsList.add(UserGoalModel.fromMapObject(usergMapList[i]));
    }



    return usergoalsList;
  }



}

