import 'dart:ui';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goodvibesoffl/constants/fontconstants.dart';
import 'package:goodvibesoffl/models/music_model.dart';
import 'package:goodvibesoffl/screens/home/home.dart';
import 'package:goodvibesoffl/screens/home/library.dart';
import 'package:goodvibesoffl/screens/home/profile.dart';
import 'package:goodvibesoffl/screens/sharables/music_player.dart';
import 'package:goodvibesoffl/services/api_service.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:goodvibesoffl/constants/styleconstants.dart'as Styleconst;

import '../../locator.dart';

class Recommended extends StatefulWidget {
  @override
  _RecommendedState createState() => _RecommendedState();
}

class _RecommendedState extends State<Recommended> {
  bool listview=false;
  bool first=false;
  bool second=false;
  bool third=false;

  bool iszero=true;
  bool affirmation=false;
  bool relax=false;
  bool anxiety=false;
  bool whitenoise=false;
  bool stress=false;
  bool binaurial=false;
  bool calm=false;
  bool nature=false;
  bool instruments=false;
  bool rain=false;
  bool tabtap=false;
  TextEditingController searchcontroller=TextEditingController();
  int currentindex=0;
  List<Track> _searchtracks = [];
  List _children=[
    Home(),
    Library(),
    Profile()
  ];
  int totalduration=0;
  PlayerState _playerState;
  int currentprogress=0;
  bool loop=false;
  bool playing=false;
  bool playmorethanonce=false;

  @override
  void initState() {
    super.initState();
    //  tabController=TabController(length: 2, vsync: this);
    addcurrentaudiolistener();
    _searchtracks=[];
  }
  void onTabTapped(int index) {
    setState(() {
      currentindex = index;
      tabtap=true;
    });
  }
  getsearchedtracks(String searchtext)async{
    _searchtracks=[];
    Map searchresponse=await locator<ApiService>().getSearchDetails(text:searchtext,page: 1,perPage: 16,);
    List<dynamic> searchtrackslist=searchresponse['data'] as List;
    var searchtra = searchtrackslist.map<Track>((json) => Track.fromJson(json));
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    setState(() {
      _searchtracks.addAll(searchtra);
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
  pauseorplay()async{
    Styleconst.constassetsAudioPlayer.isPlaying.value?Styleconst.constassetsAudioPlayer.pause():Styleconst.constassetsAudioPlayer.play();
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
    return Scaffold(
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
      backgroundColor: Color(0xfff5f5f5),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,

        centerTitle: false,
        title:
        GestureDetector(
            onTap: (){
              //           Navigator.pop(context);
            },
            child:
            Row(
              //  mainAxisAlignment: MainAxisAlignment.start,
                children:[
                  Container(
                    margin: EdgeInsets.only(
                      //   right: 7
                        right: screenarea*0.0000279
                    ),
                    child:  SvgPicture.asset('assets/images/white_logo.svg',fit: BoxFit.cover,
                      color: Color(0xff9797de),
                      //        width: 30,
                      width: screenwidth*0.08,
//  width: screenwidth*0.128,
                    ),
                  ),
                  SvgPicture.asset('assets/images/logo 2.svg',fit: BoxFit.cover,
                    //        height: double.infinity,
                    width:screenheight*screenwidth*0.000435,
                    //     width: screenheight*screenwidth*0.000439,
                    color: Color(0xff9797de),
                    //         alignment: Alignment.center,
                  ),])),
        actions: [
          Container(
              margin: EdgeInsets.only(
                //        right: 3
                  right: screenwidth*0.008
              ),
              child:
              IconButton(onPressed: (){
                setState(() {
                  listview=!listview;
                });
              }, icon: Icon(
                listview?CupertinoIcons.rectangle_grid_1x2_fill:
                CupertinoIcons.square_grid_2x2_fill,
                color: Color(0xff9797de),
                //    size: 26,
                size: screenwidth*0.0693,
              )))
        ],
      ),
      body:
      tabtap?_children[currentindex]:
      SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child:
          Container(
            margin: EdgeInsets.only(
              //  left: 18,right: 18
                left: screenarea*0.0000719, right: screenarea*0.0000719

            ),
            child: Column(mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(mainAxisAlignment:MainAxisAlignment.start,children: [
                  Container(child: Text("Explore",style: TextStyle(fontFamily: helveticaneuemedium,
                      color: Colors.black87,
//     fontSize: 22
                      fontSize: screenwidth*0.0586
                  ),),)
                ],),Row(children:[
                  Container(
                    margin: EdgeInsets.only(
                      //          top: 9
                        top: screenarea*0.0000359
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(child: Text("All tracks",style: TextStyle(
                            fontFamily: helveticaneuemedium,color: Colors.black87,
//    fontSize: 12.5
                            fontSize: screenwidth*0.0333
                        ),),),
                        Container(
                          margin: EdgeInsets.only(
                            //        top: 2
                              top: screenarea*0.0000079
                          ),
                          //    height: 3,
                          //   width: 53,
                          height:screenheight*0.004497,width: screenwidth*0.14133,
                          decoration: BoxDecoration(
                              color: Color(0xff9797de)
                          ),
                        )
                      ],),
                  )]),
                Container(margin: EdgeInsets.only(
                  //   top: 16
                    top: screenarea*0.0000639
                ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        //     height:35 ,
                          height: screenheight*0.05247,
                          //    width: 244,
                          width:screenwidth*0.65,
                          padding: EdgeInsets.only(
                            //    left: 10,
                              left: screenarea*0.00003998,
                              bottom: 0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                          ),child:Center(child: TextField(
                        style: TextStyle(
                            fontFamily: helveticaneueregular,
                            color: Colors.grey[800],
                            //  fontSize: 14
                            fontSize: screenwidth*0.0373
                        ),
                        onChanged: (v){
                        },
                        cursorColor: Colors.grey[800],
                        controller: searchcontroller,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            suffixIcon: GestureDetector(
                              onTap: (){
                                searchcontroller.text==""?
                                deselecttextfield():settextfieldempty()
                                ;
                              },
                              child: Icon(CupertinoIcons.xmark,
                                //  size: 16,
                                size: screenwidth*0.0426,
                                color: Colors.black87,),),
                            hintStyle: TextStyle(
                                fontFamily: helveticaneueregular,
                                color: Colors.grey[300],
                                //        fontSize: 14
                                fontSize: screenwidth*0.0373
                            ),
                            hintText: 'Search'
                        ),
                      ),)
                      ),
                      GestureDetector(
                          onTap: (){
                            searchcontroller.text==""?emptycode():
                            getsearchedtracks(searchcontroller.text);
                          },
                          child:
                          Container(
                            // width: 60,
                            //      height: 35,
                            width: screenwidth*0.16,
                            height: screenheight*0.05247,
                            margin: EdgeInsets.only(
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(6)),
                            ),
                            child: Center(child: Icon(Icons.search,
                              //             size:20,
                              size: screenwidth*0.0533,
                              color: Colors.grey[600],),),
                          ))
                    ],),),
                Container(
                    margin: EdgeInsets.only(
                      //       top: 16
                        top: screenarea*0.0000639
                    ),
                    child:
                    Row(children:[
                      Container(child: Text("Category",style: TextStyle(
                          fontFamily: helveticaneuemedium,color: Colors.black87,
                          //fontSize: 12.5
                          fontSize: screenwidth*0.0333
                      ),),),])
                ),
                Container(
                  margin: EdgeInsets.only(
                    //      top: 9
                      top: screenarea*0.0000359
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment:MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                              onTap: (){
                                affirmation?       removegenretrack(25)
                                    :getgenretracks(25);
                                setState(() {
                                  affirmation=!affirmation;
                                });

                              },
                              child:
                              AnimatedContainer(
                                //  width: 87,
                                //      height: 29,
//      height: screenheight*0.0434, width: screenwidth*0.2,
                                  padding: EdgeInsets.symmetric(
                                    //        vertical: 7.5,horizontal: 12.5
                                      vertical: screenwidth*0.018,horizontal: screenwidth*0.0313
                                  ),
                                  duration: Duration(milliseconds: 150),
                                  decoration: BoxDecoration(
                                    color: affirmation?Color(0xff9797de):Colors.black.withOpacity(0.3),
                                    borderRadius: BorderRadius.all(Radius.circular(24)),
                                  ),
                                  child:     Center(child:
                                  Text("Affirmation",style: TextStyle(
                                      fontFamily: helveticaneueregular,
                                      color: Colors.white,
                                      //         fontSize: 13
                                      fontSize: screenwidth*0.03466
                                  ),),)
                              )),
                          GestureDetector(
                              onTap: (){
                                binaurial?       removegenretrack(22)
                                    :getgenretracks(22);
                                setState(() {
                                  binaurial=!binaurial;
                                });
                              },
                              child:
                              AnimatedContainer(
                                //  width: 87,
//          height: 29,
                                //        height: screenheight*0.0434, width: screenwidth*0.2,
                                  padding: EdgeInsets.symmetric(
                                    //        vertical: 7.5,horizontal: 12.5
                                      vertical: screenwidth*0.018,horizontal: screenwidth*0.0313
                                  ),          duration: Duration(milliseconds: 150),
                                  decoration: BoxDecoration(
                                    color: binaurial?Color(0xff9797de):Colors.black.withOpacity(0.3),
                                    borderRadius: BorderRadius.all(Radius.circular(24)),
                                  ),
                                  child:     Center(child:
                                  Text("Binaural Beats",style: TextStyle(
                                      fontFamily: helveticaneueregular,
                                      color: Colors.white,
                                      //            fontSize: 13
                                      fontSize: screenwidth*0.03466
                                  ),),)
                              )),
                          GestureDetector(
                              onTap: (){
                                nature?       removegenretrack(26)
                                    :getgenretracks(26);
                                setState(() {
                                  nature=!nature;
                                });
                              },
                              child:
                              AnimatedContainer(
                                //  width: 87,
                                //       height: 29,
                                  padding: EdgeInsets.symmetric(
                                    //        vertical: 7.5,horizontal: 12.5
                                      vertical: screenwidth*0.018,horizontal: screenwidth*0.0313
                                  ),
                                  duration: Duration(milliseconds: 150),
                                  decoration: BoxDecoration(
                                    color: nature?Color(0xff9797de):Colors.black.withOpacity(0.3),
                                    borderRadius: BorderRadius.all(Radius.circular(24)),
                                  ),
                                  child:     Center(child:
                                  Text("Nature Sounds",style: TextStyle(
                                      fontFamily: helveticaneueregular,
                                      color: Colors.white,
                                      //         fontSize: 13
                                      fontSize: screenwidth*0.03466
                                  ),),)
                              )),

                        ],)
                      ,
                      Container(
                          margin: EdgeInsets.only(
                            //         top: 9
                              top: screenarea*0.0000359
                          ),
                          child:
                          Row(
                            mainAxisAlignment:MainAxisAlignment.start,
                            children: [
                              GestureDetector(
                                  onTap: (){
                                    whitenoise?       removegenretrack(27)
                                        :getgenretracks(27);
                                    setState(() {
                                      whitenoise=!whitenoise;
                                    });
                                  },
                                  child:
                                  AnimatedContainer(
                                    //  width: 87,
                                    //               height: 29,
                                      padding: EdgeInsets.symmetric(
                                        //        vertical: 7.5,horizontal: 12.5
                                          vertical: screenwidth*0.018,horizontal: screenwidth*0.0313
                                      ),
                                      duration: Duration(milliseconds: 150),
                                      decoration: BoxDecoration(
                                        color: whitenoise?Color(0xff9797de):Colors.black.withOpacity(0.3),
                                        borderRadius: BorderRadius.all(Radius.circular(24)),
                                      ),
                                      child:     Center(child:
                                      Text("White Noise",style: TextStyle(
                                          fontFamily: helveticaneueregular,
                                          color: Colors.white,
                                          //                   fontSize: 13
                                          fontSize: screenwidth*0.03466
                                      ),),)
                                  )),
                              GestureDetector(
                                  onTap: (){
                                    instruments?       removegenretrack(24)
                                        :getgenretracks(24);
                                    setState(() {
                                      instruments=!instruments;
                                    });
                                  },
                                  child:
                                  AnimatedContainer(
                                      margin: EdgeInsets.only(left: 14),
                                      //  width: 87,
                                      //             height: 29,
                                      padding: EdgeInsets.symmetric(
                                        //        vertical: 7.5,horizontal: 12.5
                                          vertical: screenwidth*0.018,horizontal: screenwidth*0.0313
                                      ),
                                      duration: Duration(milliseconds: 150),
                                      decoration: BoxDecoration(
                                        color: instruments?Color(0xff9797de):Colors.black.withOpacity(0.3),
                                        borderRadius: BorderRadius.all(Radius.circular(24)),
                                      ),
                                      child:     Center(child:
                                      Text("Instrumental Music",style: TextStyle(
                                          fontFamily: helveticaneueregular,
                                          color: Colors.white,
                                          //               fontSize: 13
                                          fontSize: screenwidth*0.03466
                                      ),),)
                                  )),
                            ],)),
                      Container(
                        margin: EdgeInsets.only(
                          //     top: 29,
                            top: screenwidth*0.0773,
                            left: 0,right: 0),
                        child: AnimatedSwitcher(
                          duration: Duration(milliseconds: 250),
                          child: listview?listingview(context):staggeredgridview(context),
                        ),
                      ),


                    ],),
                ),

              ],),
          )),
    );
  }

  Widget listingview(BuildContext context){
    double screenwidth=MediaQuery.of(context).size.width;
    double screenheight=MediaQuery.of(context).size.height;
    double screenarea=screenwidth*screenheight;

    return                   LimitedBox(
      key: UniqueKey(),
      maxHeight: screenheight*0.8,
      maxWidth: screenwidth,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: _searchtracks.length,
        itemBuilder: (context,index){
          return
            GestureDetector(
                onLongPress: (){
                  showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      isDismissible: true,
                      context: context,
                      builder: (context){
                        return individualtrackbottomsheet(context);
                      }
                  );
                },
                child:
                Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(
                      //   top: 18,
                        top: screenarea*0.0000719,

                        left: 0,right: 0),
                    child:
                    Column(children:[
                      Container(
                          margin:EdgeInsets.only(
                            //       bottom: 9
                              bottom: screenarea*0.0000359
                          ),
                          child:
                          Row(

                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(children:[
                                LimitedBox(
                                    child:
                                    ClipRRect(
                                      borderRadius: BorderRadius.all(Radius.circular(3)),
                                      child:CachedNetworkImage(
                                        imageUrl: _searchtracks[index].image,
                                        width: screenwidth*0.1,
                                      ),

                                    )),
                                Container(
                                  width: screenwidth*0.1,
                                  height: screenwidth*0.1,
                                  child: Center(
                                    child: GestureDetector(
                                      onTap: (){},
                                      child: Icon(FeatherIcons.heart,
                                        // size: 19,
                                        size: screenwidth*0.0506,
                                        color: Colors.white,),
                                    ),
                                  ),
                                )
                              ]),
                              Container(margin: EdgeInsets.only(
                                //      f    left: 11
                                  left: screenarea*0.0000439
                              ),
                                child: Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment:
                                MainAxisAlignment.start,
                                  children: [

                                    Row(children:[
                                      Container(
                                        margin:EdgeInsets.only(
                                          //    bottom: 4
                                            bottom: screenarea*0.0000159  ),
                                        child:

                                        Text(
                                          _searchtracks[index].title!=null?
                                          _searchtracks[index].title.length>30?
                                          _searchtracks[index].title.substring(0,30):
                                          _searchtracks[index].title:"",style: TextStyle(
                                            fontFamily: helveticaneuemedium,color: Colors.black87,
                                            //      fontSize: 12.5
                                            fontSize: screenwidth*0.0333
                                        ),),),
                                    ]),


                                    Container(child: Text( _searchtracks[index].description!=null?
                                    _searchtracks[index].description.length>32?
                                    _searchtracks[index].description.substring(0,32):
                                    _searchtracks[index].description:"",style: TextStyle(
                                        fontFamily: helveticaneueregular,color: Colors.black87.withOpacity(0.5),
                                        //fontSize: 10.5
                                        fontSize: screenwidth*0.028
                                    ),),),
                                  ],),),
                              Expanded(child:
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children:[
                                    Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children:[
                                          Text(
                                            _searchtracks[index].duration,
                                            textAlign:TextAlign.end,style: TextStyle(
                                              fontFamily: helveticaneuemedium,color: Colors.black54,
                                              //fontSize: 12.5
                                              fontSize: screenwidth*0.0333

                                          ),
                                          ),
                                          GestureDetector(
                                              child:       Icon(Icons.more_vert,
                                                color: Colors.black54,
                                                // size: 20,
                                                size: screenwidth*0.0533,
                                              ),
                                              onTap: (){
                                                showModalBottomSheet(
                                                    backgroundColor: Colors.transparent,
                                                    isDismissible: true,
                                                    context: context,
                                                    builder: (context){
                                                      return Container(
                                                        height: screenwidth*0.761,
                                                        decoration: BoxDecoration(
                                                            color: Color(0xff757575),
                                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(12),topRight:Radius.circular(12) )
                                                        ),
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            Container(
                                                              //        height:4,width: 75,
                                                              height:screenwidth*0.0106,width: screenwidth*0.2,
                                                              margin: EdgeInsets.only(
                                                                //      top: 8
                                                                  top: screenwidth*0.0213
                                                              ),
                                                              decoration: BoxDecoration(
                                                                color: Colors.white,
                                                                borderRadius: BorderRadius.all(Radius.circular(16)),
                                                              ),
                                                            ),
                                                            Container(
                                                              margin: EdgeInsets.only(
                                                                //         top: 40
                                                                  top: screenwidth*0.086
                                                              ),
                                                              child: LimitedBox(
                                                                maxHeight: screenwidth*0.561,
                                                                child: ListView(
                                                                  physics: BouncingScrollPhysics(),
                                                                  scrollDirection: Axis.vertical,
                                                                  children: [
                                                                    Container(child: Row(children: [
                                                                      Container(
                                                                          margin:EdgeInsets.only(
                                                                            //          left: 6
                                                                              left: screenwidth*0.016
                                                                          ),
                                                                          child:
                                                                          IconButton(icon: Icon(CupertinoIcons.plus,
                                                                            color: Colors.white,
                                                                            //   size: 27,
                                                                            size: screenwidth*0.072
                                                                            , ), onPressed: (){

                                                                          })),
                                                                      Container(
                                                                        margin: EdgeInsets.only(
                                                                          //      left: 10
                                                                            left: screenwidth*0.0266
                                                                        ),
                                                                        child: Text("Add to Existing Playlist",style: TextStyle(
                                                                            fontFamily: helveticaneuemedium,
                                                                            color: Colors.white,
                                                                            //         fontSize: 15
                                                                            fontSize: screenwidth*0.04
                                                                        ),),
                                                                      )
                                                                    ],),),
                                                                    Container(
                                                                      margin:EdgeInsets.only(
                                                                        //           top: 8
                                                                          top: screenwidth*0.0213
                                                                      ),
                                                                      child: Row(children: [
                                                                        Container(
                                                                            margin:EdgeInsets.only(
                                                                              //      left: 6
                                                                                left: screenwidth*0.016
                                                                            ),
                                                                            child:
                                                                            IconButton(icon: Icon(CupertinoIcons.plus_circled,
                                                                                color: Colors.white,
                                                                                //           size: 27,
                                                                                size: screenwidth*0.072
                                                                            ), onPressed: (){

                                                                            })),
                                                                        Container(
                                                                          margin: EdgeInsets.only(
                                                                            //      left: 10
                                                                              left: screenwidth*0.0266
                                                                          ),
                                                                          child: Text("Create Playlist",style: TextStyle(
                                                                              fontFamily: helveticaneuemedium,
                                                                              color: Colors.white,
                                                                              //         fontSize: 15
                                                                              fontSize: screenwidth*0.04
                                                                          ),),
                                                                        )
                                                                      ],),),
                                                                    Container(                  margin:EdgeInsets.only(
                                                                      //      top: 8
                                                                        top: screenwidth*0.0213
                                                                    ),
                                                                      child: Row(children: [
                                                                        Container(
                                                                            margin:EdgeInsets.only(
                                                                              //        left: 6
                                                                                left: screenwidth*0.016
                                                                            ),
                                                                            child:
                                                                            IconButton(icon: Icon(FeatherIcons.heart,
                                                                                color: Colors.white,
                                                                                //      size: 27,
                                                                                size: screenwidth*0.072
                                                                            ), onPressed: (){

                                                                            })),
                                                                        Container(
                                                                          margin: EdgeInsets.only(
                                                                            //          left: 10
                                                                              left: screenwidth*0.0266
                                                                          ),
                                                                          child: Text("Add to Favorites",style: TextStyle(
                                                                              fontFamily: helveticaneuemedium,
                                                                              color: Colors.white,
                                                                              //          fontSize: 15
                                                                              fontSize: screenwidth*0.04
                                                                          ),),
                                                                        )
                                                                      ],),),
                                                                    Container(                  margin:EdgeInsets.only(
                                                                      //       top: 8
                                                                        top: screenwidth*0.0213
                                                                    ),
                                                                      child: Row(children: [
                                                                        Container(
                                                                            margin:EdgeInsets.only(
                                                                              //          left: 6
                                                                                left: screenwidth*0.016
                                                                            ),
                                                                            child:
                                                                            IconButton(icon: Icon(FeatherIcons.download,
                                                                                color: Colors.white,
                                                                                //      size: 27,
                                                                                size: screenwidth*0.072
                                                                            ), onPressed: (){

                                                                            })),
                                                                        Container(
                                                                          margin: EdgeInsets.only(
                                                                            //      left: 10
                                                                              left: screenwidth*0.0266
                                                                          ),
                                                                          child: Text("Download",style: TextStyle(
                                                                              fontFamily: helveticaneuemedium,
                                                                              color: Colors.white,
                                                                              //     fontSize: 15
                                                                              fontSize: screenwidth*0.04
                                                                          ),),
                                                                        )
                                                                      ],),),
                                                                  ],
                                                                ),),
                                                            )
                                                          ],),
                                                      );
                                                    }
                                                );
                                              })
                                        ]),
                                  ])),
                            ],
                          )),
                      Divider(thickness: 1,color: Colors.grey[400],)
                    ])
                ));
        },
      ),
    );
  }
  Widget individualtrackbottomsheet(BuildContext context){
    double screenwidth=MediaQuery.of(context).size.width;
    double screenheight=MediaQuery.of(context).size.height;
    double screenarea=screenwidth*screenheight;

    return Container(
      height: screenwidth*0.761,
      decoration: BoxDecoration(
          color: Color(0xff757575),
          borderRadius: BorderRadius.only(topLeft: Radius.circular(12),topRight:Radius.circular(12) )
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            //        height:4,width: 75,
            height:screenwidth*0.0106,width: screenwidth*0.2,
            margin: EdgeInsets.only(
              //      top: 8
                top: screenwidth*0.0213
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              //         top: 40
                top: screenwidth*0.086
            ),
            child: LimitedBox(
              maxHeight: screenwidth*0.561,
              child: ListView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                children: [
                  Container(child: Row(children: [
                    Container(
                        margin:EdgeInsets.only(
                          //          left: 6
                            left: screenwidth*0.016
                        ),
                        child:
                        IconButton(icon: Icon(CupertinoIcons.plus,
                          color: Colors.white,
                          //   size: 27,
                          size: screenwidth*0.072
                          , ), onPressed: (){

                        })),
                    Container(
                      margin: EdgeInsets.only(
                        //      left: 10
                          left: screenwidth*0.0266
                      ),
                      child: Text("Add to Existing Playlist",style: TextStyle(
                          fontFamily: helveticaneuemedium,
                          color: Colors.white,
                          //         fontSize: 15
                          fontSize: screenwidth*0.04
                      ),),
                    )
                  ],),),
                  Container(
                    margin:EdgeInsets.only(
                      //           top: 8
                        top: screenwidth*0.0213
                    ),
                    child: Row(children: [
                      Container(
                          margin:EdgeInsets.only(
                            //      left: 6
                              left: screenwidth*0.016
                          ),
                          child:
                          IconButton(icon: Icon(CupertinoIcons.plus_circled,
                              color: Colors.white,
                              //           size: 27,
                              size: screenwidth*0.072
                          ), onPressed: (){

                          })),
                      Container(
                        margin: EdgeInsets.only(
                          //      left: 10
                            left: screenwidth*0.0266
                        ),
                        child: Text("Create Playlist",style: TextStyle(
                            fontFamily: helveticaneuemedium,
                            color: Colors.white,
                            //         fontSize: 15
                            fontSize: screenwidth*0.04
                        ),),
                      )
                    ],),),
                  Container(                  margin:EdgeInsets.only(
                    //      top: 8
                      top: screenwidth*0.0213
                  ),
                    child: Row(children: [
                      Container(
                          margin:EdgeInsets.only(
                            //        left: 6
                              left: screenwidth*0.016
                          ),
                          child:
                          IconButton(icon: Icon(FeatherIcons.heart,
                              color: Colors.white,
                              //      size: 27,
                              size: screenwidth*0.072
                          ), onPressed: (){

                          })),
                      Container(
                        margin: EdgeInsets.only(
                          //          left: 10
                            left: screenwidth*0.0266
                        ),
                        child: Text("Add to Favorites",style: TextStyle(
                            fontFamily: helveticaneuemedium,
                            color: Colors.white,
                            //          fontSize: 15
                            fontSize: screenwidth*0.04
                        ),),
                      )
                    ],),),
                  Container(                  margin:EdgeInsets.only(
                    //       top: 8
                      top: screenwidth*0.0213
                  ),
                    child: Row(children: [
                      Container(
                          margin:EdgeInsets.only(
                            //          left: 6
                              left: screenwidth*0.016
                          ),
                          child:
                          IconButton(icon: Icon(FeatherIcons.download,
                              color: Colors.white,
                              //      size: 27,
                              size: screenwidth*0.072
                          ), onPressed: (){

                          })),
                      Container(
                        margin: EdgeInsets.only(
                          //      left: 10
                            left: screenwidth*0.0266
                        ),
                        child: Text("Download",style: TextStyle(
                            fontFamily: helveticaneuemedium,
                            color: Colors.white,
                            //     fontSize: 15
                            fontSize: screenwidth*0.04
                        ),),
                      )
                    ],),),
                ],
              ),),
          )
        ],),
    );

  }
  Widget staggeredgridview(BuildContext context){
    double screenwidth=MediaQuery.of(context).size.width;
    double screenheight=MediaQuery.of(context).size.height;
    double screenarea=screenwidth*screenheight;

    return          LimitedBox(
        key: UniqueKey(),
        maxWidth: screenwidth,
        maxHeight: screenheight*0.8,
        child:
         StaggeredGridView.countBuilder(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          crossAxisCount: 4,
          itemCount: _searchtracks.length,
          itemBuilder: (BuildContext context, int index) =>
          _searchtracks.length>0?
          new
          GestureDetector(
              onLongPress: (){
                showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    isDismissible: true,
                    context: context,
                    builder: (context){
                      return individualtrackbottomsheet(context);
                    }
                );
              },
              child:
              Container(child:Column(children: [
                ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    child:
                    Container(
                      //  height: 135,
                      height:index.isOdd?screenheight*0.359:screenheight*0.202,
                      width: screenwidth*0.42,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      child: CachedNetworkImage(
                        imageUrl:
                        _searchtracks[index].image
                        ,fit: BoxFit.cover,),)),
                Container(
                  width: screenwidth*0.42,

                  margin: EdgeInsets.only(
                    //      top: 8,bottom: 8
                      top:screenarea*0.0000319
                      ,bottom: screenarea*0.0000319),
                  child: Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,

                    mainAxisSize:MainAxisSize.max,
                    children: [

                      Expanded(child:
                      Text(
                        _searchtracks[index].title!=null?
                        _searchtracks[index].title.length>28?
                        _searchtracks[index].title.substring(0,28):
                        _searchtracks[index].title:"",style: TextStyle(
                          fontFamily: helveticaneuemedium,color: Colors.black87,
                          //   fontSize: 11
                          fontSize: screenwidth*0.0293
                      ),)),
                      GestureDetector(
                          onTap: (){
                            showModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                isDismissible: true,
                                context: context,
                                builder: (context){
                                  return individualtrackbottomsheet(context);
                                }
                            );
                          },
                          child:
                          Icon(Icons.more_vert,
                            //  size: 15.5,
                            size:screenwidth*0.0413,
                            color: Colors.black87,))
                    ],),
                )
              ],))):SizedBox(height: 0,),

          staggeredTileBuilder: (int index) =>
          new StaggeredTile.count(2, index.isEven ? 2.34 : 3.67),
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
        ));

  }
  deselecttextfield(){
    setState(() {
      _searchtracks=[];
    });
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }

  }
  settextfieldempty(){
    setState(() {
      searchcontroller.text="";
    });
  }
  getgenretracks(int id)async{
    Map genretracks=await locator<ApiService>().getGenreTracks(id:id,page: 1,perpage: 30);
    List<dynamic> affirmtracks=genretracks['data'] as List;
    var aftr = affirmtracks.map<Track>((json) => Track.fromJson(json));
    setState(() {
      _searchtracks.addAll(aftr);

    });
  }
  removegenretrack(int id)async{
    setState(() {
      _searchtracks.removeWhere((element) => element.gid==id);
    });
  }
  emptycode(){}
}

