
import 'dart:ui';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goodvibesoffl/constants/fontconstants.dart';
import 'package:goodvibesoffl/favorites/favoritesdbhelper.dart';
import 'package:goodvibesoffl/favorites/favoritetrackmodel.dart';
import 'package:goodvibesoffl/screens/premium/getpremium.dart';
import 'package:goodvibesoffl/screens/sharables/MusicPlayer.dart';
import 'package:goodvibesoffl/screens/sharables/music_player.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:goodvibesoffl/constants/styleconstants.dart'as Styleconst;
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

class Library extends StatefulWidget {
  @override
  _LibraryState createState() => _LibraryState();
}

class _LibraryState extends State<Library>with TickerProviderStateMixin {
  FavoritesDatabaseHelper favoritesDatabaseHelper = FavoritesDatabaseHelper();
  List<FavoriteTrackModel> favoritesList;
  int count = 0;
  TabController tabController;
  bool favorites=true;
  bool downloadedtracks=true;
bool tracks=true;
bool first=false;
bool second=false;
bool third=false;
  int totalduration=0;
  PlayerState _playerState;
  int currentprogress=0;
  bool loop=false;
  bool playing=false;
  bool playmorethanonce=false;

  @override
  void initState() {
    super.initState();
    tabController=TabController(length: 2, vsync: this);
    addcurrentaudiolistener();
updateListView();
  }

  addcurrentaudiolistener()async{

    Styleconst.constassetsAudioPlayer.currentPosition.listen((audioposition) {
      setState(() {
        currentprogress=audioposition.inMilliseconds;
      });
    });
    Styleconst.constassetsAudioPlayer.playerState.listen((event) {
      _playerState=event;
    });
    Styleconst.constassetsAudioPlayer.current.listen((event) {
      setState(() {
        totalduration= event.audio.duration.inMilliseconds;
      });
    });
  }
  pauseorplay()async{
    Styleconst.constassetsAudioPlayer.isPlaying.value?Styleconst.constassetsAudioPlayer.pause():Styleconst.constassetsAudioPlayer.play();
  }
  void _delete(BuildContext context, FavoriteTrackModel favoriteTrackModel) async {

    int result = await favoritesDatabaseHelper.deleteFavorites(favoriteTrackModel.id);
    if (result != 0) {
      print( 'Note Deleted Successfully');
      updateListView();
    }
  }



  void updateListView() {

    final Future<Database> dbFuture = favoritesDatabaseHelper.initializeDatabase();
    dbFuture.then((database) {

      Future<List<FavoriteTrackModel>> noteListFuture = favoritesDatabaseHelper.getFavoritesList();
      noteListFuture.then((favList) {
        setState(() {
          this.favoritesList = favList;
          this.count = favList.length;
        });
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    final musicplays=Provider.of<MusicPlays>(context);

    if (favoritesList == null) {
      favoritesList = List<FavoriteTrackModel>();
      updateListView();
    }
    double screenheight=MediaQuery.of(context).size.height;
    double screenwidth=MediaQuery.of(context).size.width;
    double screenarea=screenheight*screenwidth;

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return
      Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton:   musicplays.getminiplayer(context),
        backgroundColor: Colors.transparent,
        appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: Color(0xfff5f5f5),
            centerTitle: false,
            title: Container(
              margin: EdgeInsets.only(
     //             left: 14
       left: screenarea*0.0000559
              ),
              //        padding: EdgeInsets.all(8),
              child: SvgPicture.asset('assets/images/logo 2.svg',
                color: Color(0xff9797de),
                //      fit: BoxFit.cover,
                //          width: 35,
              ),
            ),
        ),
        body: SingleChildScrollView(child:
        Container(
          width: screenwidth,

          margin: EdgeInsets.only(
        //      left: 22,right: 22
left: screenwidth*0.0586,right:screenwidth*0.0586
          ),
          child: Column(mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                child:
          Row(mainAxisAlignment:MainAxisAlignment.start,children: [
            GestureDetector(
                onTap: (){
setState(() {
  favorites==false?favorites=true:emptycode();
});
                },
                child:
            Container(child: Text("Favorites",style: TextStyle(
              fontFamily: helveticaneuemedium,color:favorites?Colors.black87:Colors.black38,
        //        fontSize: 22
          fontSize: screenwidth*0.0586
            ),),)),
            GestureDetector(
                onTap: (){
                  setState(() {
                    favorites==true?favorites=false:emptycode();
                  });
                },
                child:
                    favorites?
                Container(margin:EdgeInsets.only(
           //         left: 21
left: screenarea*0.0000839
                ),child: Text("Downloads",style: TextStyle(
                    fontFamily: helveticaneuemedium,color:Colors.black38,
             //       fontSize: 22
                    fontSize: screenwidth*0.0586
                ),),):  Container(margin:EdgeInsets.only(
                    //    left: 21
                        left: screenarea*0.0000839
                    ),child: Text("Downloads",style: TextStyle(
                        fontFamily: helveticaneuemedium,color: Colors.black87,
               //         fontSize: 22
                        fontSize: screenwidth*0.0586
                    ),),)),

          ],)),
          Container(
child:
Row(mainAxisAlignment: MainAxisAlignment.start,
    children:[
      Container(child: AnimatedSwitcher(
        duration: Duration(milliseconds: 1000,
        ),
        child: favorites?
        favoritestab():downloadstab(),
      ),),

            ])),

        ],),
        ))
      );
  }
  Widget favoritestab(){
    double screenheight=MediaQuery.of(context).size.height;
    double screenwidth=MediaQuery.of(context).size.width;
    double screenarea=screenheight*screenwidth;
    return Container(
      key: Key("swit"),
      margin: EdgeInsets.only(
    //      top: 12
      top: screenarea*0.0000479
      ),
      child: Column(mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: screenwidth*0.42,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: (){
                          setState(() {
                            tracks?emptycode():tracks=true;
                      //      trackslist()=favplaylist();
                          });
                        },
                        child:
                    Container(child: Text("Tracks",style: TextStyle(
                        fontFamily: helveticaneuemedium,color:tracks? Colors.black87:Colors.black38,
                        //fontSize: 13
                        fontSize: screenwidth*0.0346
                    ),),)),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          tracks?tracks=false:emptycode();
                        });
                      },
                      child:
                    Container(
                      child: Text("Favorite Playlist",style: TextStyle(
                          fontFamily: helveticaneuemedium,color:tracks?Colors.black38: Colors.black87,
        //                  fontSize: 13
          fontSize: screenwidth*0.0346
                      ),),)),
                  ],)
              ],),),
          AnimatedContainer(
       //     height: 3,
         height: screenheight*0.00449,
            margin: EdgeInsets.only(
    //            top: 4.5
                top: screenarea*0.0000179
            ),
            duration: Duration(milliseconds: 250),
width: screenwidth*0.42,
alignment: tracks?Alignment.centerLeft:Alignment.centerRight,
            child:

            AnimatedContainer(
              duration: Duration(milliseconds: 250),
 //             height: 3,
              height: screenheight*0.00449,

              width: tracks?
             // 45:96
screenwidth*0.12:screenwidth*0.256
              ,
              decoration: BoxDecoration(color: Color(0xff9797de)),
            ),
          ),
      Container(child: AnimatedSwitcher(
      //  key: UniqueKey(),
        duration: Duration(milliseconds: 350),
        child: tracks?trackslist():favplaylist(),
      ),),

              ])


        );
  }
  Widget favplaylist(){
    double screenheight=MediaQuery.of(context).size.height;
    double screenwidth=MediaQuery.of(context).size.width;
    double screenarea=screenheight*screenwidth;
    return Column(
      key: UniqueKey(),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
              onTap: (){
                showDialog(context: context, builder: (context)=>
                  new CupertinoAlertDialog(
                title: new Text("Create Playlist", style: TextStyle(
color: Colors.black87,
fontFamily: helveticaneueregular,
                      letterSpacing: 0.2,
                      fontSize: screenwidth*0.0453
                  ),),
                content: new Material(
                    color: Colors.transparent,
                    child:Column(children:[
               Container(
                   margin:EdgeInsets.only(top: 2),
                   child:   Text("Now You Can Add Your Tracks\nTo Your Own Custom Playlist",
                    textAlign:TextAlign.center,style: TextStyle(
                      letterSpacing: -0.2,
                    color: Colors.black87,
                    fontFamily: helveticaneueregular,
                    fontSize: screenwidth*0.0346
                ),)),
                  Container(
                    margin: EdgeInsets.only(top: 16,
                    bottom: 0),
                    //     height:35 ,
                    //     height: screeheight*0.05247,
                      height: screenwidth*0.086,
                      //    width: 244,
                      width: screenwidth*0.65,
                      padding: EdgeInsets.only(
                        //    left: 10,
                        top: 4,
                          left: screenarea*0.00003998,
                         ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                      ),child:Center(
                    child: TextField(

                    style: TextStyle(
                        fontFamily: helveticaneueregular,
                        color: Colors.grey[800],
                        //  fontSize: 14
                        fontSize: screenwidth*0.0373
                    ),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                            fontFamily: helveticaneueregular,
                            color: Colors.grey[300],
                            //        fontSize: 14
                            fontSize: screenwidth*0.0373
                        ),
                        hintText: 'My Playlist #2'
                    ),
                  ),)
                  ),
                ])),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Cancel',
                      style: TextStyle(
                          color: Color(0xff007aff),
                          fontFamily: helveticaneueregular,
                          fontSize: screenwidth*0.0453
                      ),),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  FlatButton(
                    child: Text('Create',
                    style: TextStyle(
                      color: Color(0xff007aff),
                      fontFamily: helveticaneuemedium,
                      fontSize: screenwidth*0.0453
                    ),),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
                )
                );
              },
              child:
    Container(
    margin: EdgeInsets.only(
 //       top: 20
   top: screenarea*0.0000799
    ),
    child: Row(mainAxisAlignment: MainAxisAlignment.start,
    children: [
    Container(
 //   height:30,width: 30,
   height: screenheight*0.0449,width: screenheight*0.0449,
    alignment: Alignment.center,
    decoration: BoxDecoration(
    shape: BoxShape.circle,
    border:Border.all(color: Colors.grey[600],width: 1)
    ),
    child: Center(child:
    Icon(CupertinoIcons.plus,
    //  size: 25,
      size: screenwidth*0.0666,
      color: Colors.black54.withOpacity(0.72),),)),
    Container(
    margin: EdgeInsets.only(
  //      left: 11
    left: screenarea*0.0000439
    ),
    child: Text("Create playlist",style: TextStyle(
    fontFamily: helveticaneuemedium,color: Colors.black87,
    ),),)
    ],),)),
    Container(
    width: MediaQuery.of(context).size.width*0.85,
    margin: EdgeInsets.only(
//    top: 20,
        top: screenarea*0.0000799
    //  left: 26, right: 26
    //     right: screenarea*0.000103
    ),
    child:
    Column(children:[
    Container(
    margin:EdgeInsets.only(
    //  bottom: 9
//    bottom: 8
  bottom: screenarea*0.0000319
    ),
    child:
    Row(

    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    ClipOval(child: Container(
    //           height: 35,width: 35,
    height: screenwidth*0.093,width: screenwidth*0.093,
    decoration: BoxDecoration(
    shape: BoxShape.circle,
    border:Border.all(color: Color(0xff12c2e9),width: 1,style: BorderStyle.solid)
    //  color: Color(0xff12c2e9),
    ),
    child: Center(child: Icon(Icons.play_arrow,
    color: Color(0xff12c2e9),
    //     size: 26.5,
    size: screenwidth*0.0706,
    ),),
    ),),
    Container(margin: EdgeInsets.only(
    //   left: 11
    left: screenarea*0.0000439
    ),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment:
    MainAxisAlignment.start,
    children: [
    Container(
    margin:EdgeInsets.only(
    //   bottom: 4
    bottom: screenarea*0.0000159
    ),
    child: Text("My Playlist #1",style: TextStyle(
    fontFamily: helveticaneuemedium,color: Color(0xff12c2e9),
    //fontSize: 12.5
    fontSize: screenwidth*0.0333
    ),),),
    Container(child: Text("By Sebastian",style: TextStyle(
    fontFamily: helveticaneueregular,color: Color(0xff12c2e9).withOpacity(0.5),
    //fontSize: 10.5
    fontSize: screenwidth*0.028
    ),),),
    ],),),
    Expanded(child:
    Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children:[
    Text(
    "17:24",
    textAlign:TextAlign.end,style: TextStyle(
    fontFamily: helveticaneuemedium,color: Color(0xff12c2e9),
    // fontSize: 12.5
    fontSize: screenwidth*0.0333
    ),
    ),]))
    ],
    )),
    Divider(thickness: 1,color: Colors.grey[400],)
    ])
    ),

    Container(
    width: MediaQuery.of(context).size.width*0.85,
    margin: EdgeInsets.only(
    //     top: 26,left: 26,right: 26
 //   top: 18,
   top: screenarea*0.0000719
    ),
    child:
    Column(children:[
    Container(
    margin:EdgeInsets.only(
 //   bottom: 8
        bottom: screenarea*0.0000319
    ),
    child:
    Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    ClipOval(child: Container(
    //      height: 35,width: 35,
    height: screenwidth*0.093,width: screenwidth*0.093,
    decoration: BoxDecoration(
    shape: BoxShape.circle,
    border:Border.all(color: Colors.grey[700],width: 1,style: BorderStyle.solid)
    //  color: Color(0xff12c2e9),
    ),
    child: Center(child: Icon(Icons.play_arrow,
    color: Colors.black87,
    //  size: 26.5,
    size: screenwidth*0.0706,
    ),),
    ),),
    Container(margin: EdgeInsets.only(
    //         left: 11
    left: screenarea*0.0000439
    ),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment:
    MainAxisAlignment.start,
    children: [
    Container(
    margin:EdgeInsets.only(
    //  bottom: 4
    bottom: screenarea*0.0000159
    ),
    child: Text("Sleep Playlist",style: TextStyle(
    fontFamily: helveticaneuemedium,color: Colors.black87,
    //fontSize: 12.5
    fontSize: screenwidth*0.0333
    ),),),
    Container(child: Text("By Sebastian",style: TextStyle(
    fontFamily: helveticaneueregular,color: Colors.black54
        .withOpacity(0.5),
    //fontSize: 10.5
    fontSize: screenwidth*0.028
    ),),),
    ],),),
    Expanded(child:
    Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children:[
    Text(
    "17:24",
    textAlign:TextAlign.end,style: TextStyle(
    fontFamily: helveticaneuemedium,color: Colors.black87,
    //fontSize: 12.5
    fontSize: screenwidth*0.0333

    ),
    ),]))
    ],
    )),
    Divider(thickness: 1,color: Colors.grey[400],)
    ])
    ),

    ]);
  }
  Widget trackslist(){
    double screenheight=MediaQuery.of(context).size.height;
    double screenwidth=MediaQuery.of(context).size.width;
    double screenarea=screenheight*screenwidth;
    return Column(
        key: UniqueKey(),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          favoritesList.length>0?
          Container(
              width: MediaQuery.of(context).size.width*0.85,
              margin: EdgeInsets.only(top:  screenarea*0.000115),

              child:
              Column(children:[
                Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    actionExtentRatio: 0.24,
                    secondaryActions: <Widget>[
                      Column(
                          mainAxisAlignment:MainAxisAlignment.start,children:[
                            GestureDetector(
                              onTap: (){
                                _delete(context, favoritesList[0]);
                                updateListView();
                              },
                                child:
                        Container(
                          //       height: 40,width: 40,
                            height: screenwidth*0.1066,width: screenwidth*0.1066,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.red,
                            ),
                            child: Center(child:Container(
                              //   height: 4.5,
                              height: screenwidth*0.012,
                              width: screenwidth*0.048,
                              //    width: 18,
                              color: Colors.white,
                            ),)
                        )),
                      ])
                    ],
                    child:
                    Container(
                        margin:EdgeInsets.only(
                          //  bottom: 9
                          //             bottom: 8
                            bottom: screenarea*0.0000319
                        ),
                        child:
                        Row(

                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(3)),
                              child: Container(
                                height: screenwidth*0.09,width: screenwidth*0.09,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(3)),
                                    image: DecorationImage(
                                        image: AssetImage(this.favoritesList[0].imageasset),
                                        fit: BoxFit.cover
                                    )
                                ),

                              ),
                            ),
                            Container(margin: EdgeInsets.only(
                              //   left: 11
                                left: screenarea*0.0000439
                            ),
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment:
                              MainAxisAlignment.start,
                                children: [
                                  Container(
                                    margin:EdgeInsets.only(
                                      //   bottom: 4
                                        bottom: screenarea*0.0000159
                                    ),
                                    child: Text(this.favoritesList[0].title,style: TextStyle(
                                        fontFamily: helveticaneuemedium,color: Color(0xff12c2e9),
                                        //fontSize: 12.5
                                        fontSize: screenwidth*0.0333
                                    ),),),
                                  Container(child: Text(this.favoritesList[0].description,style: TextStyle(
                                      fontFamily: helveticaneueregular,color: Color(0xff12c2e9).withOpacity(0.5),
                                      //fontSize: 10.5
                                      fontSize: screenwidth*0.028
                                  ),),),
                                ],),),
                            Expanded(child:
                            Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children:[
                                  Text(
                                    "02:04",
                                    textAlign:TextAlign.end,style: TextStyle(
                                      fontFamily: helveticaneuemedium,color: Color(0xff12c2e9),
                                      // fontSize: 12.5
                                      fontSize: screenwidth*0.0333
                                  ),
                                  ),]))
                          ],
                        ))),
                Divider(thickness: 1,color: Colors.grey[400],)
              ])
          ):Container(
            margin: EdgeInsets.only(top:screenwidth*0.0373),
            width: screenwidth*0.85,
            child: Row(mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(child: Text("No tracks added to favorites yet",style: TextStyle(
                  fontFamily: helveticaneuemedium,
                  color: Colors.black87,
          //        fontSize: 14.5
            fontSize: screenwidth*0.0333
                ),),)
              ],
            ),
          ),


        ]);
  }
  void _save(FavoriteTrackModel favoriteTrackModel) async {

    int result;
    if (favoritesList.length>0) {  // Case 1: Update operation
      result = await favoritesDatabaseHelper.updateFavorites(favoriteTrackModel);
    } else { // Case 2: Insert Operation
      result = await favoritesDatabaseHelper.insertFavorites(favoriteTrackModel);
    }

    if (result != 0) {  // Success
      print( 'Track Added to Favorites');
    } else {  // Failure
      print('Problem Saving to Favorites');
    }

  }
  Widget downloadstab(){
    double screenheight=MediaQuery.of(context).size.height;
    double screenwidth=MediaQuery.of(context).size.width;
    double screenarea=screenheight*screenwidth;
    return Container(
        key: Key("swit"),
        margin: EdgeInsets.only(
        //    top: 12
            top: screenarea*0.0000479
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: screenwidth*0.60,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment:MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: (){
                              setState(() {
                                downloadedtracks?emptycode():downloadedtracks=true;
                                //      trackslist()=favplaylist();
                              });
                            },
                            child:
                            Container(child: Text("Downloaded Tracks",style: TextStyle(
                                fontFamily: helveticaneuemedium,color:downloadedtracks? Colors.black87:Colors.black38,
                                //fontSize: 13
                                fontSize: screenwidth*0.0346
                            ),),)),
                        GestureDetector(
                            onTap: (){
                              setState(() {
                                downloadedtracks?downloadedtracks=false:emptycode();
                              });
                            },
                            child:
                            Container(
                              child: Text("Offline Playlists",style: TextStyle(
                                  fontFamily: helveticaneuemedium,color:downloadedtracks?Colors.black38: Colors.black87,
                                  //                  fontSize: 13
                                  fontSize: screenwidth*0.0346
                              ),),)),
                      ],),

                  ],),),
              AnimatedContainer(
              //  height: 3,

                height: screenheight*0.00449,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 250),
                  height: screenheight*0.00449,
width:downloadedtracks? screenwidth*0.34:screenwidth*0.25,
                  decoration: BoxDecoration(color: Color(0xff9797de)),
                ),
                margin: EdgeInsets.only(
                //    top: 4.5
                top: screenarea*0.0000179
                ),
                duration: Duration(milliseconds: 250),
                width: screenwidth*0.60,
                alignment: downloadedtracks?Alignment.centerLeft:Alignment.centerRight,

              ),
              Container(child: AnimatedSwitcher(
                //  key: UniqueKey(),
                duration: Duration(milliseconds: 350),
                child: downloadedtracks?premiumpage():favplaylist(),
              ),),
            //  Container(child: premiumpage()),

            ])


    );
  }
Widget premiumpage(){
    double screenheight=MediaQuery.of(context).size.height;
    double screenwidth=MediaQuery.of(context).size.width;
    double screenarea=screenheight*screenwidth;
    return Column(mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            child:
            Container(
//          color: Colors.black87,
              margin: EdgeInsets.only(
                //         top: 22
                  top: screenarea*0.0000879   ),
              width: screenwidth*0.86,
              decoration: BoxDecoration(

                //   color: Colors.black87,
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              //     height: 164,
              height: screenwidth*0.4373,
              child:
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  image: DecorationImage(
                    image: AssetImage("assets/images/premcont.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child:
                Stack(children:[
                  Container(
                      margin: EdgeInsets.only(
                        //     left: 12,top: 16
                          left: screenwidth*0.032,top: screenwidth*0.0426
                      ),
                      child:
                      Column(children:[
                        Row(mainAxisAlignment:MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipOval(child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 10,sigmaY: 10),
                                child:
                                Container(
                                  //      height: 68,width: 68,
                                  height: screenheight*0.1019,width: screenheight*0.1019,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white24
                                  ),
                                  child: Center(
                                    child: Icon(MdiIcons.crownOutline,
                                      color: Color(0xff9797de),
                                      //           size: 30,
                                      size: screenwidth*0.1,
                                    ),
                                  ),
                                )),),
                            Container(
                              margin: EdgeInsets.only(
                                //    left:22
                                  left: screenarea*0.0000879
                              ),
                              child: Column(mainAxisAlignment:MainAxisAlignment.start,crossAxisAlignment:
                              CrossAxisAlignment.start,children: [
                                Container(child: Text("Try Premium?",style: TextStyle(
                                    fontFamily: helveticaneuemedium,
                                    color: Colors.black87,
                                    //              fontSize: 17
                                    fontSize: screenwidth*0.0453
                                ),),),
                                Container(margin: EdgeInsets.only(
                                  //       top: 12
                                    top: screenarea*0.0000479
                                ),
                                  child: Text("Switch to premium for unlimited\ndownloads and uninterrupted\nmusic streaming",
                                    style: TextStyle(
                                        fontFamily: helveticaneueregular,
                                        color: Colors.black38,
                                        //             fontSize: 12.5
                                        fontSize: screenwidth*0.0333
                                    ),),),
                              ],),
                            )

                          ],),
                      ])
                  ),
                  Positioned(
                      right: 12,
                      bottom: 15,
                      child:
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:[
                            SvgPicture.asset('assets/images/white_logo.svg',
//                        height: 350,
                              //        height: 130,
                              height: screenwidth*0.3573,
//                    width: 350*327/426.7,
                              //            fit: BoxFit.scaleDown,
                              //                       alignment: new Alignment(-200,0),
                              //    width: 426*372/426.7,
                              color:Color(0xff9797de).withOpacity(0.45),
                            )])),
                  Positioned(
                      right: 10,
                      bottom: 20,
                      child:
                      GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context)=>GetPremium()
                            ));
                          },
                          child:
                      Container(
                        //     height: 24,
                        height: screenheight*0.0359,
                        width: screenwidth*0.2026,
                        //      width: 76,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(3)),
                          color: Colors.white,
                        ),
                        child:Center(child:Text("Learn more",style:TextStyle(
                            fontFamily: helveticaneueregular,
                            color: Colors.grey,
                            //       fontSize: 10.5
                            fontSize: screenwidth*0.028
                        ),)),
                      )))
                ]),
              ),




            )),

        Container(
          margin:EdgeInsets.only(
        //      top: 45
         top: screenarea*0.000179
          ),child: Center(
child: Column(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.start,
children: [
  Container(child:

  Text("No downloads yet",style: TextStyle(
    fontFamily: helveticaneuemedium,
    color: Colors.black87,
  //  fontSize: 18
 fontSize: screenwidth*0.048
  ),)),
  Container(margin:EdgeInsets.only(
 //     top: 5
  top: screenarea*0.0000199
  ),child:
      Row(children:[
        Text("Tap ",style: TextStyle(
            fontFamily: helveticaneueregular,
            color: Colors.black38,
      //      fontSize: 10
        fontSize: screenwidth*0.0266
        ),),
  Icon(FeatherIcons.download,
  //  size: 10,
    size: screenwidth*0.0266,
    color: Colors.black38
    ,),
  Text(" on track to listen without connection",style: TextStyle(
      fontFamily: helveticaneueregular,
      color: Colors.black38,
   //   fontSize: 10
      fontSize: screenwidth*0.0266

  ),)])),
],),
        ),)
      ],
    );
}
  emptycode(){}
}
