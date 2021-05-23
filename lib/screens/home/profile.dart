import 'dart:ui';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goodvibesoffl/constants/fontconstants.dart';
import 'package:goodvibesoffl/screens/premium/findfriends.dart';
import 'package:goodvibesoffl/screens/premium/getpremium.dart';
import 'package:goodvibesoffl/screens/sharables/music_player.dart';
import 'package:goodvibesoffl/userpreferences/settings.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:goodvibesoffl/constants/styleconstants.dart'as Styleconst;

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
  emptycode(){}
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    double screenwidth=MediaQuery.of(context).size.width;
    double screeheight=MediaQuery.of(context).size.height;
    double screenarea=screeheight*screenwidth;
    return
      SafeArea(child:
          Scaffold(
            backgroundColor: Color(0xfff5f5f5),
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
          CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers:[
                SliverAppBar(
          actions: [
          Container(child: IconButton(
            icon: Icon(Icons.settings,
            color: Colors.black87,
       //       size: 28,
         size: screenwidth*0.0746,
            ),
        onPressed: (){
Navigator.push(context, MaterialPageRoute(builder: (context)=>
Settings()));
        },
      ),)
    ],
    backgroundColor: Colors.transparent,
    elevation: 0,
          ),
    SliverList(
    delegate: SliverChildListDelegate(
    [
       SingleChildScrollView(

        physics: BouncingScrollPhysics(),
        child: Container(
color: Color(0xfff5f5f5),
            margin: EdgeInsets.only(
        //        left: 24,right: 24
         left:screenwidth*0.0586,right: screenwidth*0.0586,
            ),
            child:Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              Hero(
              tag: 'avatar',
              child:
            Container(
                height: screeheight*0.124,width:  screeheight*0.124,

                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage("assets/images/profile@3x.png"),
                      fit: BoxFit.contain,
                    )
                ),
                child:Stack(
                  children: [Positioned(
                      right:0,
                      top: 0,
                      child: Container(
                        //    height: 37,width: 37,
                        height: screenwidth*0.0646,width: screenwidth*0.0646,
                        decoration: BoxDecoration(
                            border:Border.all(
                              //     width: 4,
                                width: 3,
                                color: Color(0xFFF5F5F5)),
                            color: Color.fromRGBO(134, 182, 180, 1),
                            shape: BoxShape.circle
                        ),
                        child: Center(child:SvgPicture.asset("assets/images/pencil.svg",
                          // color: Colors.black87,
                          //    height: 15,
                          height: screenwidth*0.027,
                        )),
                      ))],

                )

            ),),
            Container(

                margin: EdgeInsets.only(
                  //   left:26
               //     top: 12
                top: screenarea*0.0000479
                ),
                child: Text(
                  int.parse(DateFormat.H('en_US').format(DateTime.now()))<12?'Good Morning':
                  int.parse(DateFormat.H('en_US').format(DateTime.now()))<3?'Good Afternoon':'Good Evening',
                  style: TextStyle(
                      fontFamily: helveticaneuebold,
                      color:Colors.black87,
           //           fontSize: 12.5
fontSize: screenwidth*0.0333
                  ),
                )
            ),
            Container(

                margin: EdgeInsets.only(
                  //   left:26
                    top: 1
                  //  top: 5
                ),
                child: Text(
                  "Sebastian",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontFamily: helveticaneuemedium,
                      color:Color(0xff9797de),
              //        fontSize: 32
fontSize: screenwidth*0.0853
                  ),
                )
            ),
            ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                child:
                Container(
//          color: Colors.black87,
                  margin: EdgeInsets.only(
             //         top: 22
               top: screenarea*0.0000879   ),
                  width: screenwidth,
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
                                  height: screeheight*0.1019,width: screeheight*0.1019,
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
                                    alignment: new Alignment(-screeheight*screenwidth*0.00079,0),
                                    //    width: 426*372/426.7,
                                    color:Color(0xff9797de).withOpacity(0.45),
                                  )])),
                        Positioned(
                            right: 10,
                            bottom: 20,
                            child:   GestureDetector(
    onTap: (){
    Navigator.push(context, MaterialPageRoute(
    builder: (context)=>GetPremium()
    ));
    },
    child:Container(
                              //     height: 24,
                              height: screeheight*0.0359,
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
              margin: EdgeInsets.only(
             //     top: 20
              top: screenarea*0.0000799
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text("Statistics",style: TextStyle(
                      fontFamily: helveticaneuemedium,
                      color: Colors.black87,
            //          fontSize: 17
                        fontSize: screenwidth*0.0453
                    ),),
                  )
                ],
              ),
            ),
            Container(
margin: EdgeInsets.only(
//  top: 22,
    top: screenarea*0.0000879),
              child: Row(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                Container(
                  padding: EdgeInsets.all(
             //         14
               screenarea*0.0000559
                  ),
          //        height: 131,
            //      width: 131,
              height: screeheight*0.1964,
                  width: screeheight*0.1964,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    shape:BoxShape.circle
                  ),
                  child:
                  Container(
decoration: BoxDecoration(
  color: Colors.white,
  shape: BoxShape.circle
),                      child:
                  SleekCircularSlider(
                    appearance: CircularSliderAppearance(
                      startAngle: 270,
                      infoProperties: InfoProperties(
                        mainLabelStyle: TextStyle(
                          fontFamily: helveticaneueregular,
                          color: Colors.black87,
                 //         fontSize: 26
                   fontSize: screenwidth*0.0693
                        )
                      ),
                      customWidths: CustomSliderWidths(
                        handlerSize: 8,
                        trackWidth: 0,
                        progressBarWidth: 4
                      ),
                      customColors: CustomSliderColors(
                        dotColor: Color(0xff12c2e9),
trackColor: Colors.transparent,
                        progressBarColor: Color(0xff12c2e9)
                      ),
                      counterClockwise: false,
                      animationEnabled: true,
               //       size: 100,
                 size: screeheight*0.1499,
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

                  )),
                ),
                  Container(
                    padding: EdgeInsets.all(
                     //   8
                        screenarea*0.0000319

                    ),
                    margin: EdgeInsets.only(
          //              left: 40,right: 10
            left: screenarea*0.000159,right: screenarea*0.0000399
                    ),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.start,
                      children: [
Container(child: Text("Daily Goal",style: TextStyle(
  fontFamily: helveticaneueregular,color: Colors.black87
 //   ,fontSize: 17
     ,fontSize: screenwidth*0.0453
),),) ,
                        Container(child: Text("60 Min",style: TextStyle(
                            fontFamily: helveticaneuebold,color: Colors.black87
                            ,
                  //          fontSize: 22
                   fontSize: screenwidth*0.05866
                        ),),) , ],),
                  ),
              ],),
            ),
            Container(
              margin: EdgeInsets.only(
                //    top: 20
                  top: screenarea*0.0000799
              ),
              child:
              Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,
                children:[
                  Container(
                    child: Text("Invite Friends",style: TextStyle(
                        fontFamily: helveticaneuemedium,
                        color: Colors.black87,
                        //               fontSize: 17
                        fontSize: screenwidth*0.0453
                    ),),
                  ),
                  Container(
                    padding: EdgeInsets.all(
                      //    8
                        screenarea*0.0000319
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        border: Border.all(color: Color(0xff12c2e9),width: 1)
                    ),
                    child: Text("Add Friends",style: TextStyle(
                        fontFamily: helveticaneueregular,
                        color: Color(0xff12c2e9),
                        //         fontSize: 12.5
                        fontSize: screenwidth*0.0333
                    ),),
                  ),


                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: screenwidth*0.0553),
              padding: EdgeInsets.all(16),
              height: screenwidth*0.418,
              width: screenwidth,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8)),
                boxShadow: [BoxShadow(blurRadius: 20,offset: Offset(0,3),
                color: Color(0xff32386a).withOpacity(0.15))]
              ),
              child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
               //       height: 80, width: 80,
                 height: screenwidth*0.2133,width: screenwidth*0.2133,
                      child: Image.asset("assets/images/casual-life-3d-gift-box-min.png",
                        width: screenwidth*0.2133,),
                    ),
Container(child: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
  Container(child: Text("Get Free Good Vibes\nPremium!",style: TextStyle(
    fontFamily: helveticaneuemedium,
    color: Colors.black87,
 //   fontSize:15
  fontSize: screenwidth*0.04

  ),),),
    Container(
      margin: EdgeInsets.only(
 //         top: 6
   top: screenwidth*0.016   ),
      child: Text("Refer at least 3 friends to get 1 month\nGood Vibes premium for free!",style: TextStyle(
        fontFamily: helveticaneueregular,
        color: Colors.black87,
 //       fontSize:12.5
  fontSize: screenwidth*0.0333
    ),),),
],),)
                  ],
                ),
                GestureDetector(
                    onTap: (){
Navigator.push(context, MaterialPageRoute(builder: (context)=>
FindFriends()
));
                    },
                    child:
                Container(
                  width: screenwidth,
                  height: screenwidth*0.0906,
                  decoration: BoxDecoration(
                    color: Color(0xff9797de),
                    borderRadius: BorderRadius.all(Radius.circular(4))
                  ),
                  child: Center(child: Container(child: Text("Invite Friends",style: TextStyle(
                    fontFamily: helveticaneuemedium,
                    color: Colors.white,
            //        fontSize: 15
                      fontSize: screenwidth*0.04
                  ),),),),
                ))
              ],
              ),
            ),
            Container(

              child:
                  Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,
                      children:[
                  Container(
                    child: Text("Daily Meditation Goals",style: TextStyle(
                        fontFamily: helveticaneuemedium,
                        color: Colors.black87,
         //               fontSize: 17
                        fontSize: screenwidth*0.0453
                    ),),
                  ),
                        Container(
                          padding: EdgeInsets.all(
                          //    8
                              screenarea*0.0000319
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            border: Border.all(color: Color(0xff12c2e9),width: 1)
                          ),
                          child: Text("This week",style: TextStyle(
                              fontFamily: helveticaneueregular,
                              color: Color(0xff12c2e9),
                     //         fontSize: 12.5
                              fontSize: screenwidth*0.0333
                          ),),
                        ),


                ],
              ),
            ),
          Container(
            margin: EdgeInsets.only(
       //         top: 23
        top: screenwidth*0.0613
            ),
            child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding:EdgeInsets.all(
               //       8
                  screenarea*0.0000319
                  ),
                  width: screenwidth,
             //     height: 63,
                  height: screeheight*0.0944,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1,color: Color(0xff12c2e9),),
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                  ),
                  child: Column(children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(child: Text("Saturday",style: TextStyle(
                        fontFamily: helveticaneuemedium,
                        color: Colors.black87,
                  //      fontSize: 12.5
                          fontSize: screenwidth*0.0333
                      ),)),
                      Container(child: Text("80%",style: TextStyle(
                          fontFamily: helveticaneuemedium,
                          color: Colors.black87,
                 //         fontSize: 12.5
                          fontSize: screenwidth*0.0333
                      ),)),
                    ],),
                    Container(
                      margin: EdgeInsets.only(
                 //         top: 11
                   top: screenarea*0.0000439
                      ),
                      width: screenwidth,
                //      height: 2.4,
                  height: screeheight*0.003598,
                      alignment: Alignment.centerLeft,
                      child: Container(
                 //       height: 2.4,
                        height: screeheight*0.003598,
                     //   width: 140,
                       width: screenwidth*0.3733,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            color: Color(0xff9797de)
                        ),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          color: Colors.grey[300]
                      ),
                    )
                  ],),
                ),
                Container(
                  padding:EdgeInsets.all(
                  //    8
                  screenarea*0.0000319

                  ),
                  margin: EdgeInsets.only(
              //       top: 15
                top: screenarea*0.0000599
                  ),
                  width: screenwidth,
              height: screeheight*0.0944,
                  //    height: 63,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1,color: Color(0xff12c2e9),),
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                  ),
                  child: Column(children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(child: Text("Friday",style: TextStyle(
                            fontFamily: helveticaneuemedium,
                            color: Colors.black87,
                //            fontSize: 12.5
                            fontSize: screenwidth*0.0333
                        ),)),
                        Container(child: Text("80%",style: TextStyle(
                            fontFamily: helveticaneuemedium,
                            color: Colors.black87,
                  //          fontSize: 12.5
                            fontSize: screenwidth*0.0333
                        ),)),
                      ],),
                    Container(
                      margin: EdgeInsets.only(
                 //         top: 11
                          top: screenarea*0.0000439
                      ),
                      width: screenwidth,
               //       height: 2.4,
                      height: screeheight*0.003598,
                      alignment: Alignment.centerLeft,
                      child: Container(
                 //       height: 2.4,
                        height: screeheight*0.003598,
                  //      width: 140,
                        width: screenwidth*0.3733,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            color: Color(0xff9797de)
                        ),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          color: Colors.grey[300]
                      ),
                    )
                  ],),
                ),
                Container(
                  padding:EdgeInsets.all(
             //        8
                    screenarea*0.0000319
                  ),
                  margin: EdgeInsets.only(
            //          top: 15
                      top: screenarea*0.0000599
                  ),
                  width: screenwidth,
           //       height: 63,
                  height: screeheight*0.0944,

                  decoration: BoxDecoration(
                    border: Border.all(width: 1,color: Color(0xff12c2e9),),
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                  ),
                  child: Column(children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(child: Text("Thursday",style: TextStyle(
                            fontFamily: helveticaneuemedium,
                            color: Colors.black87,
                 //           fontSize: 12.5
                            fontSize: screenwidth*0.0333
                        ),)),
                        Container(child: Text("80%",style: TextStyle(
                            fontFamily: helveticaneuemedium,
                            color: Colors.black87,
                    //        fontSize: 12.5
                            fontSize: screenwidth*0.0333
                        ),)),
                      ],),
                    Container(
                      margin: EdgeInsets.only(
                      //    top: 11
                          top: screenarea*0.0000439
                      ),
                      width: screenwidth,
               //       height: 2.4,
                      height: screeheight*0.003598,
                      alignment: Alignment.centerLeft,
                      child: Container(
                  //      height: 2.4,
                        height: screeheight*0.003598,
                 //       width: 140,
                        width: screenwidth*0.3733,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            color: Color(0xff9797de)
                        ),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          color: Colors.grey[300]
                      ),
                    )
                  ],),
                ),
            ],),
          ),


          ],
        )),
          )]),
    )])));
  }
}
