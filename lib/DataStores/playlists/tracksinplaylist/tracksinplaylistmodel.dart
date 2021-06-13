class TracksinPlaylistModel {

  int _id;
  int _playlistid;
  String _trackid;
  String _trackname;
  String _trackdescription;
  String _trackduration;
  String _trackurl;
  String _trackdownloadurl;
  String _trackgenre;

  TracksinPlaylistModel(this._playlistid,this._trackid, this._trackname,this._trackdescription,this._trackduration,this._trackurl,
      this._trackdownloadurl,this._trackgenre);

  TracksinPlaylistModel.withId(this._id,this._playlistid,this._trackid, this._trackname,this._trackdescription,this._trackduration,this._trackurl,
      this._trackdownloadurl,this._trackgenre);

  int get id => _id;
  int get playlistid => _playlistid;

  String get trackid => _trackid;

  String get trackname => _trackname;

  String get trackdescription => _trackdescription;
  String get trackduration => _trackduration;
  String get trackurl => _trackurl;
  String get trackdownloadurl => _trackdownloadurl;
  String get trackgenre => _trackgenre;


  set playlistid(int newplaylistid) {
    this._playlistid = newplaylistid;
  }
  set trackid(String newid) {
    this._trackid = newid;
  }

  set trackname(String newtrackname) {
    this._trackname = newtrackname;
  }
  set trackdescription(String newdesc) {
    this._trackdescription = newdesc;
  }
  set trackduration(String newduration) {
    this._trackduration = newduration;
  }
  set trackurl(String newurl) {
    this._trackurl = newurl;
  }
  set trackdownloadurl(String newdownurl) {
    this._trackdownloadurl = newdownurl;
  }
  set trackgenre(String newgenre) {
    this._trackgenre = newgenre;
  }
  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['playlistid'] = _playlistid;
    map['trackid'] = _trackid;
    map['trackname'] = _trackname;
    map['trackdescription'] = _trackdescription;
    map['trackduration'] = _trackduration;
    map['trackurl'] = _trackurl;
    map['trackdownloadurl'] = _trackdownloadurl;
    map['trackgenre'] = _trackgenre;

    return map;
  }

  // Extract a Note object from a Map object
  TracksinPlaylistModel.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._playlistid = map['playlistid'];
    this._trackid = map['trackid'];
    this._trackname = map['trackname'];
    this._trackdescription = map['trackdescription'];
    this._trackduration = map['trackduration'];
    this._trackurl = map['trackurl'];
    this._trackdownloadurl = map['trackdownloadurl'];
    this._trackgenre = map['trackgenre'];

  }
}



