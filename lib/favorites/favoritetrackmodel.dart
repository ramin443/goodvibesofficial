class FavoriteTrackModel {

  int _id;
  String _title;
  String _description;
  String _imageasset;
 // int _priority;

  FavoriteTrackModel(this._title, this._description,this._imageasset );

  FavoriteTrackModel.withId(this._id, this._title, this._description, this._imageasset);

  int get id => _id;

  String get title => _title;

  String get description => _description;

  String get imageasset => _imageasset;


  set title(String newTitle) {
    if (newTitle.length <= 255) {
      this._title = newTitle;
    }
  }

  set description(String newDescription) {
    if (newDescription.length <= 255) {
      this._description = newDescription;
    }
  }

  set imageasset(String newimageasset) {

      this._imageasset = newimageasset;

  }
  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['description'] = _description;
    map['imageasset'] = _imageasset;

    return map;
  }

  // Extract a Note object from a Map object
  FavoriteTrackModel.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._description = map['description'];
    this._imageasset = map['imageasset'];
  }
}


