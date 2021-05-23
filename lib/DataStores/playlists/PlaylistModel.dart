class PlaylistModel {

  int _id;
  int _playlistid;
  String _playlistname;
  String _datecreated;

  // int _priority;

  PlaylistModel(this._playlistid, this._playlistname,this._datecreated );

  PlaylistModel.withId(this._id, this._playlistid, this._playlistname, this._datecreated);

  int get id => _id;

  int get playlistid => _playlistid;

  String get playlistname => _playlistname;

  String get datecreated => _datecreated;


  set playlistid(int newplaylistid) {
      this._playlistid = newplaylistid;
  }

  set playlistname(String newplaylistname) {
    if (newplaylistname.length <= 20) {
      this._playlistname = newplaylistname;
    }
  }

  set datecreated(String newdatecreated) {

    this._datecreated = newdatecreated;

  }
  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['playlistid'] = _playlistid;
    map['playlistname'] = _playlistname;
    map['datecreated'] = _datecreated;

    return map;
  }

  // Extract a Note object from a Map object
  PlaylistModel.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._playlistid = map['playlistid'];
    this._playlistname = map['playlistname'];
    this._datecreated = map['datecreated'];
  }
}


