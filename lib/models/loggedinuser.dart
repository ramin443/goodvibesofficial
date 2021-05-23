
class CurrentUser{
  int _id;
  String _uid;
  String _email;
  String _fullname;
 String _country;
  String _key;
  String _device;
  String _paid;
  String _freetrial;
  String _logintype;
  String _admin;
  String _createdate;
String _status;
  CurrentUser(this._uid,this._email,this._fullname,this._country,this._key,this._device
      ,this._paid,this._freetrial,this._logintype,this._admin,this._createdate);
  CurrentUser.withid(this._id,this._uid,this._email,this._fullname,this._country,this._key,this._device
      ,this._paid,this._freetrial,this._logintype,this._admin,this._createdate);
  int get id=>_id;
  String get uid=>_uid;
  String get email=>_email;
  String get fullname=>_fullname;
  String get country=>_country;
  String get key=>_key;
  String get device=>_device;
  String get paid=>_paid;
  String get freetrial=>_freetrial;
  String get logintype=>_logintype;
  String get admin=>_admin;
  String get createdate=>_createdate;
  String get status=>_status;

  set uid(String newuid){
    this._uid=newuid;
  }
  set email(String newemail){
    this._email=newemail;
  }
  set fullname(String newfullname){
    this._fullname=newfullname;
  }
  set country(String newcountry){
    this._country=newcountry;

  }
  set key(String newkey){
    this._key=newkey;
  }
  set device(String newdevice){
    this._device=newdevice;
  }
  set paid(String newpaid){
    this._paid=newpaid;
  }
  set freetrial(String newfreetrial){
    this._freetrial=newfreetrial;
  }
  set logintype(String newlogintype){
    this._logintype=newlogintype;
  }
  set admin(String newadmin){
    this._admin=newadmin;
  }
  set createddate(String newcreateddate){
    this._createdate=newcreateddate;
  }
  set status(String newstatus){
    this.status=newstatus;
  }
  Map<String, dynamic> toMap(){
    var map=Map<String, dynamic>();
    if(id!=null){
      map["id"]=_id;
    }
    map["uid"]=_uid;
    map["email"]=_email;
    map["fullname"]=_fullname;
    map["country"]=_country;
    map["key"]=_key;
    map["device"]=_device;
    map["paid"]=_paid;
    map["freetrial"]=_freetrial;
    map["logintype"]=_logintype;
    map["admin"]=_admin;
    map["createddate"]=_createdate;
    map["status"]=_status;

  }
  CurrentUser.fromMapObject(Map<String,dynamic> map){
    this._id=map["id"];
    this._uid =map["uid"];
    this._email=map["email"];
    this._fullname=map["fullname"];
    this._country=map["country"];
    this._key=map["key"];
    this._device=map["device"];
    this._paid=map["paid"];
    this._freetrial=map["freetrial"];
    this._logintype=map["logintype"];
    this._admin=map["admin"];
    this._createdate=map["createddate"];
    this._status=map["status"];

  }
}