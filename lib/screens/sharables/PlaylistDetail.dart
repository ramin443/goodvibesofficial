
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goodvibesoffl/DataStores/playlists/PlaylistModel.dart';
import 'package:goodvibesoffl/DataStores/playlists/playlistdbhelper.dart';
import 'package:goodvibesoffl/DataStores/playlists/tracksinplaylist/tracksinplaylistdbhelper.dart';
import 'package:goodvibesoffl/DataStores/playlists/tracksinplaylist/tracksinplaylistmodel.dart';
import 'package:goodvibesoffl/constants/fontconstants.dart';
import 'package:sqflite/sqflite.dart';
class PlayListDetail extends StatefulWidget {
  int playlistindex;
  int playlistid;
  String playlisttitle;
  String playlistcreateddate;


  PlayListDetail({Key key,@required this.playlisttitle,
    @required this.playlistid,
    @required this.playlistindex,
    @required this.playlistcreateddate
  }) : super(key: key);

  @override
  _PlayListDetailState createState() => _PlayListDetailState();
}

class _PlayListDetailState extends State<PlayListDetail> {
  PlaylistDatabaseHelper playlistDatabaseHelper = PlaylistDatabaseHelper();
  List<PlaylistModel> playlists;
  int playlistcount = 0;
  TracksInPlaylistDatabaseHelper tracksInPlaylistDatabaseHelper = TracksInPlaylistDatabaseHelper();
  List<TracksinPlaylistModel> tracksinplaylists;
  int playlisttrackscount = 0;
  @override
  void initState() {
    super.initState();
    updateplaylistview();
    updatetracksinplaylistview(widget.playlistid);
//    updateListView();
  }
  @override
  Widget build(BuildContext context) {
    if (playlists == null) {
      playlists = List<PlaylistModel>();
      updateplaylistview();
    }
    if (tracksinplaylists == null) {
      tracksinplaylists = List<TracksinPlaylistModel>();
      updatetracksinplaylistview(widget.playlistid);
    }
    double screenwidth=MediaQuery.of(context).size.width;
    double screenheight=MediaQuery.of(context).size.height;
    double screenarea=screenwidth*screenheight;
    return Scaffold(
      backgroundColor: Color(0xfff5f5f5),
      appBar: AppBar(
        backgroundColor:Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(CupertinoIcons.arrow_left,
            color: Colors.black,
            size: screenwidth*0.0546,
          ),
        ),
        title: Text(
          playlists.length>0?
          this.playlists[widget.playlistindex].playlistname:"Playlist title",style: TextStyle(
          fontFamily: helveticaneuemedium,
          fontSize: screenwidth*0.04,
          color: Colors.black87,
        ),
        ),
        bottom: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions:[
            Container(
                margin: EdgeInsets.only(right: 10),
                child:
                Text(
                  playlists.length>0?
                  this.playlists[widget.playlistindex].datecreated.toString():"Playlist date",style: TextStyle(
                  fontFamily: helveticaneueregular,
                  fontSize: screenwidth*0.03,
                  color: Colors.black54,
                ),
                ))],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: screenwidth*0.05866),
          child: LimitedBox(
            maxHeight: screenheight*0.85,
            maxWidth: screenwidth,
            child: ListView.builder(
                itemCount:
                tracksinplaylists.length,
                itemBuilder: (context,index){
                  return Column(
                    children: [
                      Container(
                        child: Text(tracksinplaylists!=null?
                        this.tracksinplaylists[index].trackname+" "+
                            this.tracksinplaylists[index].playlistid.toString():"track",style: TextStyle(
                            fontFamily: helveticaneuemedium,
                            color: Colors.black87,
                            fontSize: 24
                        ),
                        ),
                      )
                    ],
                  );
                }),
          ),
        ),
      ),
    );
  }
  void updateplaylistview() {

    final Future<Database> dbFuture = playlistDatabaseHelper.initializeDatabase();
    dbFuture.then((database) {

      Future<List<PlaylistModel>> playListFuture = playlistDatabaseHelper.getPlaylistsList();
      playListFuture.then((pList) {
        setState(() {
          this.playlists = pList;
          this.playlistcount = pList.length;
        });
      });
    });
  }
  void updatetracksinplaylistview(int playlistid) {

    final Future<Database> dbFuture = tracksInPlaylistDatabaseHelper.initializeDatabase();
    dbFuture.then((database) {

      Future<List<TracksinPlaylistModel>> playListtracksFuture = tracksInPlaylistDatabaseHelper.gettracksinPlaylistsList(playlistid);
      playListtracksFuture.then((pList) {
        setState(() {
          this.tracksinplaylists = pList;
          this.playlisttrackscount = pList.length;
        });
      });
    });
  }
}


