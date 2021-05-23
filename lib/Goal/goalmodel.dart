class GoalsModel {

  int _id;
  String _goalpreferences;
  int _goalcount;
  // int _priority;

  GoalsModel(this._goalpreferences, this._goalcount );

  GoalsModel.withId(this._id, this._goalpreferences, this._goalcount);

  int get id => _id;

  String get goalpreferences => _goalpreferences;

  int get goalcount => _goalcount;


  set goalpreferences(String newgoalpref) {
      this._goalpreferences = newgoalpref;
  }

  set goalcount(int newgoalcount) {
      this._goalcount = newgoalcount;
  }

  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['goalpreferences'] = _goalpreferences;
    map['goalcount'] = _goalcount;

    return map;
  }

  // Extract a Note object from a Map object
  GoalsModel.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._goalpreferences = map['goalpreferences'];
    this._goalcount = map['goalcount'];
  }
}


