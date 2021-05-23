import 'dart:io';
import 'dart:ui';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:goodvibesoffl/constants/fontconstants.dart';
import 'package:goodvibesoffl/constants/styleconstants.dart'as Styleconst;
import 'package:goodvibesoffl/favorites/favoritesdbhelper.dart';
import 'package:goodvibesoffl/favorites/favoritetrackmodel.dart';
import 'package:goodvibesoffl/models/player_status_enum.dart';
import 'package:goodvibesoffl/screens/sharables/Timer.dart';
import 'package:goodvibesoffl/screens/sharables/share_track.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:goodvibesoffl/musicplayerfunctions/eventrecords.dart'as MusicEventRecords;
import 'package:sqflite/sqflite.dart';
class MusicPlayer extends StatefulWidget {
  final String imageasset;
  final String title;
  String description;

  MusicPlayer({Key key, @required this.imageasset,@required this.title,@required this.description}) : super(key: key);

  @override
  _MusicPlayerState createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  FavoritesDatabaseHelper favoritesDatabaseHelper = FavoritesDatabaseHelper();
  List<FavoriteTrackModel> favoritesList;
  int count = 0;
  ScrollController scrollController=ScrollController();
  String message='';
  String time='0';
  // AnimationController controller =AnimationController(vsync: this);
  int timetapped=0;

  String imageasset;
  final FlutterFFprobe _flutterFFprobe = new FlutterFFprobe();
  int durationchanged=0;
  int totalduration=0;
  bool loop=false;
//  bool favorite=false;
bool playing=false;
double sheetheight=70;
  bool favoritespressed=false;
  bool first=false;
  bool second=false;
  bool third=false;
  bool playmorethanonce=false;
  bool upwardscroll=false;
  bool showsuggestedtracks=false;
  Map info=Map();
bool timer=false;
//  final assetsAudioPlayer = AssetsAudioPlayer();
int currentprogress=0;
PlayerState _playerState;
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
  emptycode(){}
  @override
  initState() {
    super.initState();
    addcurrentaudiolistener();
    updateListView();
 //   playinit();
  // print(favoritesList.length);
  }
  playinit()async{
    _playerState==PlayerState.stop?
    await Styleconst.constassetsAudioPlayer.open(
      Audio("assets/audio/2 Minute Timer - Calm and Relaxing Music.mp3",
        metas: Metas(
          title:  "Activate your higher mind",
          artist: "Breathing with your body",
          album: "Calm",
          image: MetasImage.asset("assets/images/anxiety.png"), //can be MetasImage.network
        ),

      ),
      loopMode:loop? LoopMode.single:LoopMode.none,
      volume: 80,
      showNotification: true,
      //   playInBackground: PlayInBackground.enabled,

    ):emptycode();
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
  playerstatelistener(){
    Styleconst.constassetsAudioPlayer.isPlaying.listen((currentplaystate) {
      setState(() {
        playing=currentplaystate;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    if (favoritesList == null) {
      favoritesList = List<FavoriteTrackModel>();
      updateListView();
    }
    bottomsheet(){
      showModalBottomSheet(context: context,
          isScrollControlled: true,

          builder: (BuildContext context){
            return DraggableScrollableSheet(
                initialChildSize: 0.5, // half screen on load
                maxChildSize: 1,       // full screen on scroll
                minChildSize: 0.25,
                builder: (BuildContext context, ScrollController scrollController){
                  return Container(

                  );
                });
          });
    }

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    double screenwidth=MediaQuery.of(context).size.width;
    double screenheight=MediaQuery.of(context).size.height;
    double screenarea=screenheight*screenwidth;
    AppBar initialappbar=AppBar(

      centerTitle: true,
      backgroundColor: Colors.transparent,elevation: 0,
      leading: IconButton(
        onPressed: (){
          Navigator.pop(context);
        },
        icon: Icon(CupertinoIcons.back,
          //    size: 24,
          size: screenwidth*0.064,
          color: Colors.black87,),
      ),
      actions: [
        GestureDetector(
            onTap:(){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>
              ShareTrack(imageasset: widget.imageasset,title: widget.title,
              description: widget.description,
              )));
            },
            child:Container(
            margin: EdgeInsets.only(
        //        right: 16
          right: screenwidth*0.0426
            ),
            child: Icon(FeatherIcons.share2,
          //            size: 30,
          size:screenwidth*0.064,
          color: Colors.black87,
        )),
            ) ,
        GestureDetector(
            onTap: (){
              setState(() {

                favoritesList.length>0?_delete(context, favoritesList[0]):
                _save(FavoriteTrackModel('Activate your higher mind',' Breathing with your body',
                'assets/images/orange_circle.png'
                ));
            //    favoritespressed=!favoritespressed;
updateListView();
//print(favoritesList.length);
             //   print(this.favoritesList[0].description);

              });
            },
            child:
            Container(margin: EdgeInsets.only(
              //    right: 15
                right: screenarea*0.0000599
            ),
              child: Icon(
                favoritesList.length>0?MdiIcons.heart:FeatherIcons.heart,
                color:   favoritesList.length>0? Colors.redAccent:Colors.black87,
                //     size: 24,
                size: screenwidth*0.064,

              ),
            ))
      ],
      title: GestureDetector(
          onVerticalDragStart: (v){
            Navigator.pop(context);
          },
          child:
          Text("Now Playing",style: TextStyle(
              fontFamily: helveticaneuemedium,
              //        fontSize: 17,
              fontSize: screenwidth*0.04533,
              color: Colors.black87
          ),)),
    );
    AppBar appbar=          AppBar(
      bottom:

      PreferredSize(
        preferredSize: Size(screenwidth,screenheight*0.09095),
        child:AnimatedSwitcher(
            duration: Duration(milliseconds: 350),
            child:

                Column(children:[
                  ProgressBar(
                    progress: Duration(milliseconds: currentprogress),
                    //  buffered: Duration(milliseconds: 2000),
                    total: Duration(milliseconds: totalduration),
                    thumbRadius: 1.8,
                    thumbColor:Colors.white,
                    timeLabelLocation: TimeLabelLocation.none,
                    progressBarColor: Color(0xff12c2e9),
                    baseBarColor:  Colors.black26,
                    barHeight: 1.8,


                  ),
            upwardscroll?
        ClipRect(child:BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 50,sigmaY: 50),
            child:
        Container(
          color: Colors.black.withOpacity(0.03),
          padding: EdgeInsets.symmetric(
       //       horizontal: 12,vertical: 9
         horizontal: screenwidth*0.032,vertical: screenwidth*0.024
          ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(child:Row(children:[
            Container(child:
            ClipRRect(                borderRadius: BorderRadius.all(Radius.circular(6)),
                child:
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(6))
                  ),
                  //     height: 54,width: 54,
                  height:  screenwidth*0.144,width:  screenwidth*0.144,
                  child: Image.asset(widget.imageasset,fit: BoxFit.cover,),
                ))),
              Container(
                margin: EdgeInsets.only(
                  //   left: 16
                    left: screenarea*0.0000639
                ),
                //   height: 54,
                height:  screenheight*0.08095,
                child: Column(crossAxisAlignment:CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(child: Text("Get Motivated",style: TextStyle(
                        fontFamily: helveticaneuebold,color: Colors.black87,
                        //  fontSize: 13.5
                        fontSize: screenwidth*0.036
                    ),),),
                    Container(
                      margin: EdgeInsets.only(
                        //     top: 5
                          top: screenarea*0.00001999
                      ),
                      child: Text("Reach your goals with this advice",style: TextStyle(
                          fontFamily: helveticaneueregular,color: Colors.black54,
                          //fontSize: 10
                          fontSize:screenwidth*0.0266
                      ),),),
                  ],),),
            ])),
            Container(child:
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(onTap:(){},child: Container(child: Icon(Icons.skip_previous,
                  //    size: 26,
                  size: screenwidth*0.0693,
                  color: Colors.black87,),)),
                GestureDetector(onTap:()async{
                  playmorethanonce?pauseorplay():
                  await Styleconst.constassetsAudioPlayer.open(
                    Audio.network("https://d14nt81hc5bide.cloudfront.net/tracks/1000-1999/300-399/1317_ysRCzwwfTnwZ5tch17VhucLE.wav",
                      metas: Metas(
                        title:  "Activate your higher mind",
                        artist: "Breathing with your body",
                        album: "Calm",
                        image: MetasImage.asset("assets/images/anxiety.png"), //can be MetasImage.network
                      ),

                    ),
                    loopMode:loop? LoopMode.single:LoopMode.none,
                    volume: 80,
                    showNotification: true,
                    //   playInBackground: PlayInBackground.enabled,

                  );

                  setState(() {
             //       assetsAudioPlayer.current.value.audio.
                 totalduration=Styleconst.constassetsAudioPlayer.current.value.audio.duration.inMilliseconds;
//                    totalduration=
                    playing=!playing;
                    playmorethanonce=true;
                  });
                },child: Container(child: Icon(
                  _playerState==PlayerState.play?
                  CupertinoIcons.pause_solid:CupertinoIcons.play_arrow_solid,
                  //      size: 26,
                  size: screenwidth*0.0693,
                  color: Colors.black87,),)),
                GestureDetector(onTap:(){},child: Container(child: Icon(Icons.skip_next,
                  //        size: 26,
                  size: screenwidth*0.0693,
                  color: Colors.black87,),)),

              ],))
        ],),
      ))):SizedBox(height: 0,)])),),

      centerTitle: true,
      backgroundColor: Colors.transparent,elevation: 0,
      leading: IconButton(
        onPressed: (){
          Navigator.pop(context);
        },
        icon: Icon(CupertinoIcons.back,
          //    size: 24,
          size: screenwidth*0.064,
          color: Colors.black87,),
      ),
      actions: [
        GestureDetector(
            onTap: (){
              setState(() {
                favoritesList.length>0?_delete(context, favoritesList[0]):
                _save(FavoriteTrackModel('Activate your higher mind',' Breathing with your body',
                    'assets/images/orange_circle.png'
                ));
                //    favoritespressed=!favoritespressed;
                updateListView();              });
            },
            child:
            Container(margin: EdgeInsets.only(
              //    right: 15
                right: screenarea*0.0000599
            ),
              child: Icon(
                favoritesList.length>0?MdiIcons.heart:FeatherIcons.heart,
                color:   favoritesList.length>0? Colors.redAccent:Colors.black87,
                //     size: 24,
                size: screenwidth*0.064,

              ),
            ))
      ],
      title: GestureDetector(
          onVerticalDragStart: (v){
            Navigator.pop(context);
          },
          child:
          Text("Now Playing",style: TextStyle(
              fontFamily: helveticaneuemedium,
              //        fontSize: 17,
              fontSize: screenwidth*0.04533,
              color: Colors.black87
          ),)),
    );
    double remaining=screenheight-initialappbar.preferredSize.height-screenwidth*0.208-1.8;
    double otherheight=screenwidth*0.048+screenwidth*0.0106+screenwidth*0.0533+screenwidth*0.05+screenwidth*0.0213+1;
double rem=remaining-otherheight;
    return

      Stack(
      children: [
      Image.asset('assets/images/X - 1@2x.png',fit: BoxFit.cover,width: screenheight,),


        Scaffold(


          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          backgroundColor: Colors.transparent,
          appBar:

              upwardscroll?
appbar:initialappbar,
          body:

          Stack(children:[
          Container(
            child: Column(mainAxisAlignment:MainAxisAlignment.start,
              crossAxisAlignment:CrossAxisAlignment.center,children: [
              Container(margin:EdgeInsets.only(
          //        top: 15
                  top: screenarea*0.0000599
              ),
            //    padding: EdgeInsets.all(43),
                child: Center(child:ClipOval(
                  child:BackdropFilter(
                      filter: ImageFilter.blur(sigmaY: 50,sigmaX: 50),
                      child:
                  Container(
             //       height: 246,width: 246,
        height: screenheight*0.3688,width: screenheight*0.3688,
                    //            padding: EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: Color(0xff12c2e9).withOpacity(0.12),
                      shape: BoxShape.circle
                    ),
                    child:Center(child:
                        Stack(children:[
                        Center(child:
                    Stack(children:[
                      Center(
                        //    top: 4,
                        child:  Container(
                            margin: EdgeInsets.only(
                     //           top: 20,
                                top: screenwidth*0.0533
                                ,left: 0),
                            child: ClipOval(
                          child:
                          Container(
                           //   height: 175,width: 175,
                             height: screenheight*0.262,width: screenheight*0.262,
                              decoration: BoxDecoration(shape: BoxShape.circle),
                              child:
                              Image.asset(widget.imageasset,fit: BoxFit.fitWidth)),
                        )),),
                    Container(
                  //      margin: EdgeInsets.only(top: 4,left: 4),
                        child:
                    ClipOval(child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaY: 10,sigmaX: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle
                              ,
                            color: Colors.white.withOpacity(0.0)
                        ),
                //        height: 246,width: 246,
                        height: screenheight*0.3688,width: screenheight*0.3688,
                      ),),)),
                    Center(child:
                    ClipOval(
                      child:
                          Container(

                    //        height:175,width: 175,
                              height: screenheight*0.262,width: screenheight*0.262,
                              decoration: BoxDecoration(shape: BoxShape.circle),
                              child:
                                  Hero(
                                      tag: 'player',
                                      child:
                    Image.asset(widget.imageasset,fit: BoxFit.fitWidth,))),
                        )),
                      Center(child:
                      SleekCircularSlider(
                        appearance: CircularSliderAppearance(
                            startAngle: 270,
                            infoProperties: InfoProperties(
                                mainLabelStyle: TextStyle(
                                    fontFamily: helveticaneueregular,
                                    color: Colors.transparent,
                                    //         fontSize: 26
                                    fontSize: screenwidth*0.0693
                                )
                            ),
                            customWidths: CustomSliderWidths(
                                handlerSize: 8,
                                trackWidth: 0,
                                progressBarWidth: 3
                            ),
                            customColors: CustomSliderColors(
                                dotColor: Colors.white,
                                trackColor: Colors.transparent,
                                progressBarColor: Colors.white.withOpacity(0.9)
                            ),
                            counterClockwise: false,
                            animationEnabled: true,
                            //       size: 100,
                            size: screenheight*0.262,
                            spinnerMode: false,
                            angleRange: 360
                        ),
                        min: 0,
                        max: 100,
                        initialValue: 69,
                        onChange: (double value) {
                          // callback providing a value while its being changed (with a pan gesture)
                        },
                        onChangeStart: (double startValue) {
                          // callback providing a starting value (when a pan gesture starts)
                        },
                        onChangeEnd: (double endValue) {
                          // ucallback providing an ending value (when a pan gesture ends)
                        },

                      ))

                    ])),

                        ]))
                  ) ),
                ),)),
                Container(margin: EdgeInsets.only(
         //           top: 34
           top: screenarea*0.000135
                ),
                  child: Center(
                    child: Column(children: [
                      Container(child: Text(widget.title,style: TextStyle(fontFamily: helveticaneuebold,
                      color: Colors.black87,
                      //    fontSize: 22
                      fontSize: screenwidth*0.0586
                      ),),),
                      Container(margin: EdgeInsets.only(
                  //        top: 8
                    top: screenarea*0.0000319
                      ),
                        child: Text(widget.description,style: TextStyle(fontFamily: helveticaneueregular,
                          color: Colors.black45,
                      //      fontSize: 13.5
                        fontSize: screenwidth*0.036
                        ),),)
                    ],),
                  ),),
                Container(margin: EdgeInsets.only(
                //    top: 32,
                  top: screenarea*0.000127,
              //      left: 34,right: 34
                    left: screenwidth*0.0586,right: screenwidth*0.0586

                ),
                  child: Column(
                    children: [
                      ProgressBar(
                        progress: Duration(milliseconds: currentprogress),
                      //  buffered: Duration(milliseconds: 2000),
                        total: Duration(milliseconds: totalduration),
                        thumbRadius: 10.5,
                        thumbColor:Color(0xff9797de),
                        timeLabelLocation: TimeLabelLocation.below,
                        timeLabelTextStyle: TextStyle(
                          fontFamily: helveticaneueregular,
                          color:Colors.black54,
                          fontSize: 12.5
                        ),
                        progressBarColor: Colors.deepPurple,
                        baseBarColor: Colors.white,
                   //     thumbGlowRadius: 4,
                        timeLabelType: TimeLabelType.totalTime,
                        onSeek: (duration) {
                          setState(() {
                            durationchanged=duration.inMilliseconds;
                            Styleconst.constassetsAudioPlayer.seek(Duration(milliseconds: duration.inMilliseconds));
                          });
                        //  print('User selected a new time: $duration');
                        },
                      ),
                      Container(
                        margin: EdgeInsets.only(
                        //    top: 14
                        top: screenarea*0.0000559
                        ),
                       width: screenwidth,
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
    GestureDetector(
    onTap: (){
    setState(() {
      loop?
      Styleconst.constassetsAudioPlayer.setLoopMode(LoopMode.none):
      Styleconst.constassetsAudioPlayer.setLoopMode(LoopMode.single)
      ;
    loop=!loop;

    });
    },
    child:
    loop?
    ShaderMask(
        blendMode: BlendMode.srcATop,
        shaderCallback: (Rect bounds){
          return LinearGradient(colors: [Color(0xff9797de),Color(0xff32386A)],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
//                   stops: [0.0,0.5]
          ).createShader(bounds);
        },child:
    SvgPicture.asset("assets/images/repeat.svg",width: 20,)):
                          ShaderMask(
                          blendMode: BlendMode.srcATop,
                          shaderCallback: (Rect bounds){
                            return LinearGradient(colors: [Color(0xff9797de),Color(0xff32386A)],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
//                   stops: [0.0,0.5]
                            ).createShader(bounds);
                          },child:

SvgPicture.asset("assets/images/shuffle.svg",width: 20,))),

                           IconButton(icon: Icon(Icons.skip_previous,
                             color: Colors.black87,
            //                 size: 30,
                             size:screenwidth*0.08,
                           ),
                               onPressed: (){

                           }),
                            Container(
              //                height: 65,
                //              width: 65,
                  height: screenheight*0.0974,width: screenheight*0.0974,
                            decoration: BoxDecoration(
                              color: Colors.white60,shape: BoxShape.circle,
                            ),
                              child: Center(
                                child: IconButton(
                                  icon: Icon(
                                   _playerState==PlayerState.play?
                                    CupertinoIcons.pause_solid:CupertinoIcons.play_arrow_solid,
                                    color: Colors.black87,
                       //             size: 30,
                                     size:screenwidth*0.08,

                                  ),onPressed: ()async{
                               _playerState==PlayerState.stop?
                                  await Styleconst.constassetsAudioPlayer.open(
                                    Audio("assets/audio/2 Minute Timer - Calm and Relaxing Music.mp3",
                                      metas: Metas(
                                        title:  "Activate your higher mind",
                                        artist: "Breathing with your body",
                                        album: "Calm",
                                        image: MetasImage.asset("assets/images/anxiety.png"), //can be MetasImage.network
                                      ),

                                    ),
                                      loopMode:loop? LoopMode.single:LoopMode.none,
volume: 80,
                                      notificationSettings: NotificationSettings(

                                      ),
                                      showNotification: true,
                                   //   playInBackground: PlayInBackground.enabled,

                                  ):pauseorplay();

setState(() {
  playing=!playing;
    playmorethanonce=true;
});

                                },
                                ),
                              ),
                            ),
                            IconButton(icon: Icon(Icons.skip_next,
                              color: Colors.black87,
                      //        size: 30,
                              size:screenwidth*0.08,

                            ),
                                onPressed: (){

                                }),
                        ShaderMask(
                          blendMode: BlendMode.srcATop,
                          shaderCallback: (Rect bounds){
                            return LinearGradient(colors: [Color(0xff9797de),Color(0xff32386A)],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
//                   stops: [0.0,0.5]
                            ).createShader(bounds);
                          },child:
                            GestureDetector(
                                onTap: (){
                              setState(() {
//                                timer=true;
  Navigator.push(context, MaterialPageRoute(builder: (context)=>
  Timer()));
                              });
                                },
                                child:
                            SvgPicture.asset("assets/images/timer.svg"))),

                          ],
                        ),
                      ),
                  ],),
                )
            ],),
          )]),
    ),
       // timer?SizedBox(height: 0,):
        Positioned.fill(child:

        Material(

type: MaterialType.transparency,
            child:
SlidingUpPanel(
  boxShadow: [BoxShadow(color: Colors.transparent)],
  color: Colors.transparent,
  backdropEnabled: false,
  backdropColor: Colors.transparent,
  borderRadius: BorderRadius.only(topLeft: Radius.circular(16),topRight:  Radius.circular(16)),
  minHeight: screenheight*0.135,
  maxHeight: remaining,
  panel:panel(context,rem),
onPanelClosed: (){
    setState(() {
      upwardscroll=false;
      Future.delayed(Duration(milliseconds: 0),dontshowtracks);

    });
},
  onPanelOpened: (){
    setState(() {
      upwardscroll=true;
      Future.delayed(Duration(milliseconds: 0),showtracks);
    });
  },
//body: suggestedtracks(context),



),
      ),),


      ],
    );

  }

  pauseorplay()async{
    Styleconst.constassetsAudioPlayer.isPlaying.value?Styleconst.constassetsAudioPlayer.pause():Styleconst.constassetsAudioPlayer.play();
  }
  showtracks()async{
    setState(() {
      showsuggestedtracks=true;
    });
  }
  dontshowtracks()async{
    setState(() {
      showsuggestedtracks=false;
    });
  }


  Widget suggestedtracks(BuildContext context,double rem){
    double screenwidth=MediaQuery.of(context).size.width;
    return Container(
      height: rem,
child: ListView(
  scrollDirection: Axis.vertical,
  physics: BouncingScrollPhysics(),
  children: [

    trackslist(),
    Container(
        margin: EdgeInsets.only(bottom: screenwidth*0.048),
        child:
        trackslist())

  ],),
    );
  }
  Widget panel(BuildContext context,double rem){
    double screenwidth=MediaQuery.of(context).size.width;
    return   ClipRRect(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(16),topRight:  Radius.circular(16)),
        child:BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 50,sigmaY: 50),
            child:
            GestureDetector(

                child:
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(16),topRight:  Radius.circular(16)),
                    color: Colors.black.withOpacity(0.03),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin:EdgeInsets.only(
                          //         top: 18
                            top: screenwidth*0.048
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 0),
                              //    height: 4,width: 75,
                              height: screenwidth*0.0106,width: screenwidth*0.2,
                              decoration: BoxDecoration(
                                  color: Colors.black54,
                                  borderRadius: BorderRadius.all(Radius.circular(4))
                              ),

                            )
                          ],
                        ),),

                      Container(
                        padding:EdgeInsets.symmetric(horizontal: screenwidth*0.0586),
                        margin:EdgeInsets.only(
                          //        top: 20
                            top: screenwidth*0.0533
                        ),
                        child: Text("More Tracks For You",style: TextStyle(
                            fontFamily: helveticaneuemedium,
                            color: Colors.black87,
                            //    fontSize: 15,
                            fontSize: screenwidth*0.04
                        ),),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Container(
                          margin: EdgeInsets.only(
                            //      vertical: 6
                    //          top: 8
                      top: screenwidth*0.0213
                          ),
                          height: 1,
                          //width: 330,
                          width: screenwidth*0.88,
                          color: Colors.black26,

                        ),],
                      ),

suggestedtracks(context,rem)

                    ],),))));
  }
  Widget trackslist(){
    double screenheight=MediaQuery.of(context).size.height;
    double screenwidth=MediaQuery.of(context).size.width;
    double screenarea=screenheight*screenwidth;
    return Column(

        key: UniqueKey(),
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              width: MediaQuery.of(context).size.width*0.85,
            //  margin: EdgeInsets.only(top:  screenarea*0.000065),

              child:
              Column(children:[
                Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    actionExtentRatio: 0.24,
                    secondaryActions: <Widget>[
                      Column(
                          mainAxisAlignment:MainAxisAlignment.start,children:[
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
                        ),
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
                                        image: AssetImage("assets/images/medi.png"),
                                        fit: BoxFit.cover
                                    )
                                ),
                                child: GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      first=!first;
                                    });
                                  },
                                  child: Icon(first?MdiIcons.heart:FeatherIcons.heart,size: screenwidth*0.044,
                                    color:first?Colors.redAccent: Colors.white54,),
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
                                    child: Text("Get motivated",style: TextStyle(
                                        fontFamily: helveticaneuemedium,color: Colors.black87,
                                        //fontSize: 12.5
                                        fontSize: screenwidth*0.0333
                                    ),),),
                                  Container(child: Text("Reach your goals with this advice",style: TextStyle(
                                      fontFamily: helveticaneueregular,color: Colors.black87,
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
                                      // fontSize: 12.5
                                      fontSize: screenwidth*0.0333
                                  ),
                                  ),
                                Container(
                                    margin: EdgeInsets.only(
                              //          left: 9
                                        left: screenwidth*0.024
                                    ),
                                    child:
                                FaIcon(FontAwesomeIcons.play,
                                color: Colors.black87,
                         //       size: 13.5,
                                  size: screenwidth*0.036,

                                ))
                                ]))
                          ],
                        ))),
                Divider(thickness: 1,color: Colors.grey[400],)
              ])
          ),

          Container(
              width: MediaQuery.of(context).size.width*0.85,
              margin: EdgeInsets.only(
                //     top: 26,left: 26,right: 26
                //          top: 18,
                  top: screenarea*0.0000719
              ),
              child:
              Column(children:[
                Container(
                    margin:EdgeInsets.only(
                      //        bottom: 8
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
                                    image: AssetImage("assets/images/pexels-karolina-grabowska-4203102.jpg"),
                                    fit: BoxFit.cover
                                )
                            ),
                            child: GestureDetector(
                              onTap: (){
                                setState(() {
                                  second=!second;
                                });
                              },
                              child: Icon(second?MdiIcons.heart:FeatherIcons.heart,size: screenwidth*0.044,
                                color:second?Colors.redAccent: Colors.white54,),
                            ),
                          ),
                        ),
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
                                child: Text("Remove negative blockage",style: TextStyle(
                                    fontFamily: helveticaneuemedium,color: Colors.black87,
                                    //fontSize: 12.5
                                    fontSize: screenwidth*0.0333
                                ),),),
                              Container(child: Text("Erase Subconscious negative patterns",style: TextStyle(
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
                              ),
                              Container(
                                  margin: EdgeInsets.only(
                                  //    left: 9
                                      left: screenwidth*0.024
                                  ),
                                  child:
                                  FaIcon(FontAwesomeIcons.play,
                                    color: Colors.black87,
                            //        size: 13.5,
                                    size: screenwidth*0.036,

                                  ))
                            ]))
                      ],
                    )),
                Divider(thickness: 1,color: Colors.grey[400],)
              ])
          ),
          Container(
              width: MediaQuery.of(context).size.width*0.85,
              margin: EdgeInsets.only(
                //     top: 26,left: 26,right: 26
                //        top: 18,
                  top: screenarea*0.0000719
              ),
              child:
              Column(children:[
                Container(
                    margin:EdgeInsets.only(
                      //      bottom: 8
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
                                    image: AssetImage("assets/images/pexels-pixabay-355209.jpg"),
                                    fit: BoxFit.cover
                                )
                            ),
                            child: GestureDetector(
                              onTap: (){
                                setState(() {
                                  third=!third;
                                });
                              },
                              child: Icon(third?MdiIcons.heart:FeatherIcons.heart,size: screenwidth*0.044,
                                color:third?Colors.redAccent: Colors.white54,),
                            ),
                          ),
                        ),
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
                                child: Text("Happiness frequency",style: TextStyle(
                                    fontFamily: helveticaneuemedium,color: Colors.black87,
                                    //fontSize: 12.5
                                    fontSize: screenwidth*0.0333
                                ),),),
                              Container(child: Text("Reach your goals with this advice",style: TextStyle(
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
                              ),
                              Container(
                                  margin: EdgeInsets.only(
                              //        left: 9
                                left: screenwidth*0.024
                                  ),
                                  child:
                                  FaIcon(FontAwesomeIcons.play,
                                    color: Colors.black87,
                            //        size: 13.5,
                              size: screenwidth*0.036,
                                  ))
                            ]))
                      ],
                    )),
                Divider(thickness: 1,color: Colors.grey[400],),
              ])
          ),

        ]);
  }
}
class SwipeDetectorExample extends StatefulWidget {
  final Function() onSwipeUp;
  final Function() onSwipeDown;
  final Widget child;

  SwipeDetectorExample({this.onSwipeUp, this.onSwipeDown, this.child});

  @override
  _SwipeDetectorExampleState createState() => _SwipeDetectorExampleState();
}

class _SwipeDetectorExampleState extends State<SwipeDetectorExample> {
  //Vertical drag details
  DragStartDetails startVerticalDragDetails;
  DragUpdateDetails updateVerticalDragDetails;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onVerticalDragStart: (dragDetails) {
          startVerticalDragDetails = dragDetails;
        },
        onVerticalDragUpdate: (dragDetails) {
          updateVerticalDragDetails = dragDetails;
        },
        onVerticalDragEnd: (endDetails) {
          double dx = updateVerticalDragDetails.globalPosition.dx -
              startVerticalDragDetails.globalPosition.dx;
          double dy = updateVerticalDragDetails.globalPosition.dy -
              startVerticalDragDetails.globalPosition.dy;
          double velocity = endDetails.primaryVelocity;

          //Convert values to be positive
          if (dx < 0) dx = -dx;
          if (dy < 0) dy = -dy;

          if (velocity < 0) {
            widget.onSwipeUp();
          } else {
            widget.onSwipeDown();
          }
        },
        child: widget.child);
  }
}