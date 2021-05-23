class RecentlyPlayedTrackModel {

  int _id;
  String _trackid;
  String _trackname;
  String _trackdescription;
  String _trackduration;
  String _trackurl;
  String _trackdownloadurl;
  String _trackgenre;
String _dateplayed;

  RecentlyPlayedTrackModel(this._trackid, this._trackname,this._trackdescription,this._trackduration,this._trackurl,
      this._trackdownloadurl,this._trackgenre,this._dateplayed);

  RecentlyPlayedTrackModel.withId(this._id,this._trackid, this._trackname,this._trackdescription,this._trackduration,this._trackurl,
      this._trackdownloadurl,this._trackgenre,this._dateplayed);

  int get id => _id;

  String get trackid => _trackid;

  String get trackname => _trackname;

  String get trackdescription => _trackdescription;
  String get trackduration => _trackduration;
  String get trackurl => _trackurl;
  String get trackdownloadurl => _trackdownloadurl;
  String get trackgenre => _trackgenre;
  String get dateplayed => _dateplayed;


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
  set dateplayed(String newdateplayed) {
    this._dateplayed = newdateplayed;
  }
  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['trackid'] = _trackid;
    map['trackname'] = _trackname;
    map['trackdescription'] = _trackdescription;
    map['trackduration'] = _trackduration;
    map['trackurl'] = _trackurl;
    map['trackdownloadurl'] = _trackdownloadurl;
    map['trackgenre'] = _trackgenre;
    map['dateplayed'] = _dateplayed;

    return map;
  }

  // Extract a Note object from a Map object
  RecentlyPlayedTrackModel.fromMapObject(Map<String, dynamic> map) {
    this._id = map['trackid'];
    this._trackid = map['trackid'];
    this._trackname = map['trackname'];
    this._trackdescription = map['trackdescription'];
    this._trackduration = map['trackduration'];
    this._trackurl = map['trackurl'];
    this._trackdownloadurl = map['trackdownloadurl'];
    this._trackgenre = map['trackgenre'];
    this._dateplayed = map['dateplayed'];

  }
}


