class UserGoalModel{
int _id;
String _goaltype;
String _duration;
String _setdate;
UserGoalModel(this._goaltype,this._duration, this._setdate);
UserGoalModel.withId(this._id,this._goaltype,this._duration, this._setdate);

int get id=>_id;
String get goaltype=>_goaltype;
String get duration=>_duration;
String get setdate=>_setdate;


set goaltype(String newgoaltype){
  this._goaltype=newgoaltype;
}
set duration(String newduration){
  this._duration=newduration;
}
set setdate(String newsetdate) {
  this._setdate = newsetdate;
}

Map<String, dynamic> toMap(){
  var map=Map<String, dynamic>();
  if(id!=null){
    map["id"]=_id;
  }
  map["goaltype"]=_goaltype;
  map["duration"]=_duration;
  map["setdate"]=_setdate;
  }
UserGoalModel.fromMapObject(Map<String,dynamic> map){
this._id=map["id"];
this._goaltype=map["goaltype"];
this._duration=map["duration"];
this._setdate=map["setdate"];

}

}
