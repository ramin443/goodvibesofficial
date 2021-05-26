import 'dart:ui';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:goodvibesoffl/bloc/musicPlayer/musicplayer_bloc.dart';
import 'package:goodvibesoffl/constants/fontconstants.dart';
import 'package:goodvibesoffl/models/music_model.dart';
import 'package:goodvibesoffl/screens/sharables/MusicPlayer.dart';
import 'package:goodvibesoffl/screens/sharables/music_player.dart';
import 'package:goodvibesoffl/services/api_service.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:goodvibesoffl/constants/styleconstants.dart'as Styleconst;
import 'package:provider/provider.dart';

import '../../locator.dart';

class SinglePlaylist extends StatefulWidget {
  final int categoryid;
  final String categoryname;
  final String categoryduration;
  final String imageasset;
  final String title;
  String description;

  SinglePlaylist({Key key,@required this.categoryid,
    @required this.categoryname,
    @required this.categoryduration
  ,@required this.imageasset,@required this.title,@required this.description}) : super(key: key);

  @override
  _SinglePlaylistState createState() => _SinglePlaylistState();
}

class _SinglePlaylistState extends State<SinglePlaylist> with SingleTickerProviderStateMixin{
  final mpla = MusicPlays();
  AnimationController _scaleanimationcontroller;
  bool playing=false;
  bool playmorethanonce=false;
  int totalduration=0;
  PlayerState _playerState;
  List<Track> _tracks=[];
  int currentprogress=0;
  bool loop=false;
  bool pressed=false;
  @override
  void initState() {
    super.initState();
    addcurrentaudiolistener();
    _scaleanimationcontroller=AnimationController(vsync: this,duration: Duration(milliseconds: 100));
    _scaleanimationcontroller.addListener(() {
      if(_scaleanimationcontroller.status==AnimationStatus.forward){
//_scaleanimationcontroller.reverse();
      }
    });
    fetchcategorytracks();
setState(() {

});
Future.delayed(Duration(milliseconds: 700),setstatefun);
  }
  setstatefun(){
    setState(() {

    });
  }
fetchcategorytracks()async{
  Map tracksfromcategoryresponse= await locator<ApiService>().getCategoryTracks(id: widget.categoryid,page: 1,perpage: 15);
  List<dynamic> tracklist = tracksfromcategoryresponse['data'] as List;
  var t = tracklist.map<Track>((json) => Track.fromJson(json));
  setState(() {
    _tracks.addAll(t);
  });
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
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    double screenheight=MediaQuery.of(context).size.height;
    double screenwidth=MediaQuery.of(context).size.width;
    double screenarea=screenheight*screenwidth;
    final animation=Tween<double>(begin: 24,end: 30).animate(_scaleanimationcontroller);
    return
      Provider<MusicPlays>(
      create:(_)=>MusicPlays(),
      child:
      Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton:                                _playerState==PlayerState.stop?
        SizedBox(height: 0,):
        Container(
            height: screenwidth*0.2026,
            width: screenwidth,
            child:  Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children:[
                  ProgressBar(
                    progress: Duration(milliseconds: currentprogress),
                    //  buffered: Duration(milliseconds: 2000),
                    total: Duration(milliseconds: totalduration),
                    thumbRadius: 1.8,
                    thumbColor:Colors.white,
                    timeLabelLocation: TimeLabelLocation.none,
                    progressBarColor: Color(0xff12c2e9),
                    baseBarColor:  Colors.transparent,
                    barHeight: 1.8,


                  ),

                  GestureDetector(
                      onVerticalDragStart: (v){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>
                            MusicPlayer(imageasset: "assets/images/medi.png",
                                title: "Get Motivated",
                                description: "Reach your goals with this advice")));
                      },
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>
                            MusicPlayer(imageasset: "assets/images/medi.png",
                                title: "Get Motivated",
                                description: "Reach your goals with this advice")));
                      },
                      child:
                      ClipRect(child:
                      BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10,sigmaY:10),
                          child:Container(
                            color: Colors.white.withOpacity(0.1),
                            //  margin: EdgeInsets.only(left: 40),
                            padding: EdgeInsets.symmetric(
                              //         vertical: 8
                                vertical: screenwidth*0.02133
                                ,horizontal: 17.5
                            ),
                            width: screenwidth,

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
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
                                        height:  screenwidth*0.124,width:  screenwidth*0.124,
                                        child: Image.asset("assets/images/orange_circle.png",fit: BoxFit.cover,),
                                      ))),
                                  Container(
                                    margin: EdgeInsets.only(
                                      //           left: 16
                                        left: screenwidth*0.0426     ),
                                    //  height: 54,
                                    height: screenwidth*0.144,
                                    child: Column(crossAxisAlignment:CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(child: Text("Get Motivated",style: TextStyle(
                                            fontFamily: helveticaneuebold,color: Colors.black87,fontSize: screenwidth*0.036
                                        ),),),
                                        Container(
                                          margin: EdgeInsets.only(top: 5),
                                          child: Text("Reach your goals with this advice",style: TextStyle(
                                              fontFamily: helveticaneueregular,color: Colors.black54,fontSize: screenwidth*0.0266
                                          ),),),
                                      ],),)])),
                                Container(child:
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(onTap:(){},child: Container(child: Icon(Icons.skip_previous,
                                      //    size: 26,
                                      size: screenwidth*0.0693,
                                      color: Colors.black87,),)),
                                    GestureDetector(onTap:()async{
                                      _playerState==PlayerState.stop?
                                      await Styleconst.constassetsAudioPlayer.open(
                                        Audio("assets/audio/2 Minute Timer - Calm and Relaxing Music.mp3",
                                          metas: Metas(
                                            title:  "test1",
                                            artist: "Florent Champigny",
                                            album: "CountryAlbum",
                                            image: MetasImage.asset("assets/images/orange_circle.png"), //can be MetasImage.network
                                          ),

                                        ),
                                        loopMode:loop? LoopMode.single:LoopMode.none,
                                        volume: 80,
                                        showNotification: true,
                                        //   playInBackground: PlayInBackground.enabled,

                                      ):pauseorplay();

                                      setState(() {
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
                              ],
                            ),
                          ))))])),
        body:
        SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child:
                Container(
                    padding: EdgeInsets.only(
                  ),
                    child:
            Column(mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children:[
                  Stack(children:[
                    Container(
                        child:
                            Stack(children:[
                        Hero(
                          tag: "tagg",
                          child:
                              ShaderMask(
                                  blendMode: BlendMode.srcATop,
                                  shaderCallback: (Rect bounds){
                                    return LinearGradient(colors: [Colors.transparent,Color(0xff0a3741).withOpacity(0.4)],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
//                   stops: [0.0,0.5]
                                    ).createShader(bounds);
                                  },
                                  child:
                          Image.asset(widget.imageasset,fit: BoxFit.cover,)),)
                            ,
                              Container(
                                width: screenwidth,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [Colors.transparent,Color(0xff0a3741).withOpacity(0.4)]
                                  )
                                ),
                              )
                            ])
                    ),
                    Container(
                      child:

                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppBar(
                            backgroundColor: Colors.transparent,elevation: 0,
                            leading: IconButton(
                              onPressed: (){Navigator.pop(context);},
                              icon: Icon(CupertinoIcons.back,
                                //       size: 24,
                                size: screenwidth* 0.064,
                                color: Colors.white,),
                            ),
                            actions: [
                              GestureDetector(child:
                              Container(
                                  margin: EdgeInsets.only(
                                    //    right: 10
                                      right: screenarea*0.0000399
                                  ),
                                  child:
                                  AnimatedBuilder(
                                      animation: animation,
                                      builder:(context,child){ return              Icon(pressed?MdiIcons.heart:FeatherIcons.heart,

                                          size:animation.value);})),onTap: (){
                                _scaleanimationcontroller.forward();
                                setState(() {
                                  pressed?pressed=false:
                                  pressed=true;
                                });
                              }, )
                            ],
                          ),

                        ],
                      ),),Positioned(
                        bottom: 0,
                        child:
                        Container(
                       //   width:320,
                         width: screenwidth*0.853,
                          margin: EdgeInsets.only(
                              bottom:screenarea*0.000151
                              ,  left:screenarea*0.0001039,right: screenarea*0.0001039
                          ),
                          child:
                          Column(children:[
                          Row(mainAxisAlignment:MainAxisAlignment.start,children: [ Container(
child: Column(crossAxisAlignment:CrossAxisAlignment.start,children: [
  Container(

    child: Text(widget.title,style: TextStyle(
    fontFamily: helveticaneuebold,
    color: Colors.white,
        //fontSize: 24
  fontSize: screenwidth*0.064
    ),),),
  Container(
    margin: EdgeInsets.only(
 //       top: 12,bottom: 28
   top: screenwidth*0.028,bottom: screenwidth*0.07466
    ),
    child: Text(widget.description,style: TextStyle(
      fontFamily: helveticaneueregular,
      color: Colors.white70,
        //fontSize: 14.5
 fontSize: screenwidth*0.03866
  ),),),
],),
                            )]),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context)=>
                                          MultiProvider(
                                              providers: [
                                                ChangeNotifierProvider<MusicPlays>(
                                                  create: (_)=>MusicPlays(),
//  builder: (_,child)
                                                  //  => DataProvider(),
                                                ),
                                              ],
                                              child:
                                              MusicPlayer(
                                                  index: 0,
                                                  navigatedfromminiplayer: false,
                                                  imageasset: "assets/images/orange_circle.png",
                                                  downloadurl:  _tracks[0].trackDownloadUrl,
                                                  trackurl:  _tracks[0].url,
                                                  trackduration:  _tracks[0].duration,
                                                  trackid:  _tracks[0].id.toString(),
                                                  title:  _tracks[0].title!=null?
                                                  _tracks[0].title.length>28?
                                                  _tracks[0].title.substring(0,28):
                                                  _tracks[0].title:"",
                                                  description: _tracks[0].description!=null?
                                                  _tracks[0].description.length>80?
                                                  _tracks[0].description.substring(0,80):
                                                  _tracks[0].description:'',
                                                  trackslist: _tracks))
                                  ));
                                },
                                child:
                              ClipRRect(
                                  borderRadius: BorderRadius.all(Radius.circular(6)),
                                  child:BackdropFilter(
                                      filter: ImageFilter.blur(sigmaY: 10,sigmaX: 10),
                                      child:
                                      Container(
                                        color: Colors.white.withOpacity(0.2),
                                        //   height: 32,
                                        //    width: 78,
                                        width: screenwidth*0.208,
                                        height:screenwidth*0.085 ,
                                        child: Row(mainAxisAlignment:MainAxisAlignment.spaceEvenly,children: [
                                          Icon(Icons.play_arrow,color: Colors.white,
                                            //     size: 16
                                            size: screenwidth*0.0426
                                            ,),
                                          Container(child: Text("Play",style: TextStyle(fontFamily: helveticaneueregular,
                                              // fontSize: 14,
                                              fontSize: screenwidth*0.03733,
                                              color: Colors.white),),)

                                        ],),
                                      )))),
                              Container(
                                child: Text("00:10:00",
                                  style: TextStyle(
                                      fontFamily: helveticaneueregular,
                                      color: Colors.white,
                                      //   fontSize: 17
                                      fontSize: screenwidth*0.0453
                                  ),),)

                            ],),

                          ])))
                  ]),
                  Container(
                    margin: EdgeInsets.only(
                      //      top: 10
                        top: screenarea*0.0000399
                    ),
                    //          height: 4,
                    height: screenheight*0.00599,
                    width: screenwidth*0.2,
                    //  width: 75,

                    decoration: BoxDecoration(
                      color: Colors.grey[700],borderRadius: BorderRadius.all(Radius.circular(18)),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(
                        //   left: 26,top: 31
                          left: screenwidth*0.0586,top:screenwidth*0.0693
                      ),
                      child:
                      Row(mainAxisAlignment:MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Tracks",style: TextStyle(fontFamily: helveticaneuebold,
                              color: Colors.black87,
                              //    fontSize: 19
                              fontSize: screenwidth*0.0506
                          ),)
                        ],)),
                  LimitedBox(
                    maxHeight: screenheight*0.8,
                    maxWidth: screenwidth,
                    child: ListView.builder(
                        itemCount: _tracks.length,
                        scrollDirection: Axis.vertical,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context,index){
                     return      Container(
                         width: MediaQuery.of(context).size.width,
                         margin: EdgeInsets.only(
                             top: screenwidth*0.0373,
                             // top: 29,
                             //  left: 26, right: 26
                             left: screenwidth*0.0586,right:screenwidth*0.0586
                         ),
                         child:
                         Column(children:[
                           Container(
                               margin:EdgeInsets.only(
                                 //  bottom: 9
                                   bottom: screenarea*0.0000359
                               ),
                               child:
                               Row(

                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   GestureDetector(
                                       onTap:()async{
                                         print( _tracks[index].url);
                                         Navigator.push(context, MaterialPageRoute(
                                           builder: (context)=>
                                             MultiProvider(
                                                 providers: [
                                                   ChangeNotifierProvider<MusicPlays>(
                                                     create: (_)=>MusicPlays(),
//  builder: (_,child)
                                                     //  => DataProvider(),
                                                   ),
                                                 ],
                                                 child:
                                               MusicPlayer(
                                             index: index,
                                             navigatedfromminiplayer: false,
                                               imageasset: "assets/images/orange_circle.png",
                                               downloadurl:  _tracks[index].trackDownloadUrl,
                                               trackurl:  _tracks[index].url,
                                               trackduration:  _tracks[index].duration,
                                               trackid:  _tracks[index].id.toString(),
                                               title:  _tracks[index].title!=null?
                                               _tracks[index].title.length>28?
                                               _tracks[index].title.substring(0,28):
                                               _tracks[index].title:"",
                                               description: _tracks[index].description!=null?
                                               _tracks[index].description.length>80?
                                               _tracks[index].description.substring(0,80):
                                               _tracks[index].description:'',
                                               trackslist: _tracks))
                                         ));
                       //             await     mpla.playtrack(
                         //                    _tracks[index].id.toString(),
                           //                  _tracks[index].title,
                             //                _tracks[index].description,
                               //              _tracks[index].duration,
                                 //            _tracks[index].url,
                                   //          _tracks[index].trackDownloadUrl);

                                       },
                                       child:
                                   ClipOval(child: Container(
                                     //           height: 35,width: 35,
                                     height: screenwidth*0.093,width: screenwidth*0.093,
                                     decoration: BoxDecoration(
                                         shape: BoxShape.circle,
                                         border:Border.all(color: Colors.black.withOpacity(0.87),width: 1,style: BorderStyle.solid)
                                       //  color: Color(0xff12c2e9),
                                     ),
                                     child: Center(child: Icon(Icons.play_arrow,
                                       color:Colors.black.withOpacity(0.87),
                                       //     size: 26.5 ,
                                       size: screenwidth*0.0706,
                                     ),),
                                   ),)),
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
                                           child: Text(
                                             _tracks[index].title.length>29?
                         _tracks[index].title.substring(0,29):_tracks[index].title
                                            ,style: TextStyle(
                                               fontFamily: helveticaneuemedium,color: Colors.black.withOpacity(0.75),
                                               //fontSize: 12.5
                                               fontSize: screenwidth*0.0333
                                           ),),),
                                         Container(child: Text(
                          _tracks[index].description.length>29?
                                           _tracks[index].description.substring(0,30):_tracks[index].description,style: TextStyle(
                                             fontFamily: helveticaneueregular,color: Colors.black.withOpacity(0.5),
                                             //fontSize: 10.5
                                             fontSize: screenwidth*0.028
                                         ),),),
                                       ],),),
                                   Expanded(child:
                                   Row(
                                       mainAxisAlignment: MainAxisAlignment.end,
                                       children:[
                                         Text(
                                           _tracks[index].duration,
                                           textAlign:TextAlign.end,style: TextStyle(
                                             fontFamily: helveticaneuemedium,color: Colors.black.withOpacity(0.45),
                                             // fontSize: 12.5
                                             fontSize: screenwidth*0.0333
                                         ),
                                         ),]))
                                 ],
                               )),
                           Divider(thickness: 1,color: Colors.grey[400],)
                         ])
                     );
                    }),
                  ),




                ])))
    ));
  }
  pauseorplay()async{
    Styleconst.constassetsAudioPlayer.isPlaying.value?Styleconst.constassetsAudioPlayer.pause():Styleconst.constassetsAudioPlayer.play();
  }
}
