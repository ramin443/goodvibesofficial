import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goodvibesofficial/constants/fontconstants.dart';
import 'package:goodvibesofficial/screens/explore/recommended.dart';
import 'package:goodvibesofficial/screens/initcategories/anxiety.dart';
import 'package:goodvibesofficial/screens/initcategories/calm.dart';
import 'package:goodvibesofficial/screens/initcategories/sleep.dart';
import 'package:goodvibesofficial/screens/initcategories/stress.dart';
import 'package:goodvibesofficial/screens/plays/breathe.dart';
import 'package:goodvibesofficial/screens/plays/meditate.dart';
import 'package:goodvibesofficial/screens/sharables/music_player.dart';
import 'package:goodvibesofficial/screens/sharables/single_playlist.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shimmer/shimmer.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String currenttimeofday='Morning';
  @override
  void initState() {
    super.initState();
 // timeofdaygreeting();
  }
  emptycode(){}
  @override
  Widget build(BuildContext context) {
    Platform.isAndroid?
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Color(0xfff5f5f5),
      systemNavigationBarColor: Color(0xfff5f5f5),
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark
    )):emptycode();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    double screenwidth=MediaQuery.of(context).size.width;
    double screeheight=MediaQuery.of(context).size.height;
double screenarea=screeheight*screenwidth;
    return
    SafeArea(child:
    CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        SliverList(
        delegate: SliverChildListDelegate(
        [
        SingleChildScrollView(child:
        Column(mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: screenwidth*0.0586,right: screenwidth*0.0586,top: 4),
              width: screenwidth,
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.only(
                    //    top:8,
                      top: screenarea*0.00003198,
                      //        left: 14
//left:10
                  ),
                  //        padding: EdgeInsets.all(8),
                  child: SvgPicture.asset('assets/images/white_logo.svg',
                      color: Color(0xff9797de),
                      //      fit: BoxFit.cover,
                      width: screenwidth*0.101
                    //  width: 38,
                  ),
                ),

                      Container(
                        height: screenwidth*0.12,
                        width: screenwidth*0.12,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle
                        ),
                        //    height:screenwidth*0.12,
                        //  width:screenwidth*0.12,
                        margin: EdgeInsets.only(

                        ),
                        child: Image.asset('assets/images/profile@3x.png',
                          //      width:screenwidth*0.12,
                          fit: BoxFit.fitWidth,
                        ),
                      )
              ],
              ),
            ),
            Container(

                margin: EdgeInsets.only(
                 //   left:26
                    left:screenwidth*0.0586,
               //   top: 9.5
                  top:screenarea*0.0000379
                  //  top: 5
                ),
                child: Text(
                  int.parse(DateFormat.H('en_US').format(DateTime.now()))<12?'Good\nMorning':
                  int.parse(DateFormat.H('en_US').format(DateTime.now()))<16?'Good\nAfternoon':'Good\nEvening',
                  style: TextStyle(
                      fontFamily: helveticaneuebold,
                      color:Colors.black87,
                      fontSize: screenwidth*0.096

                  ),
                )
            ),
            Container(
                margin: EdgeInsets.only(
                  left:screenwidth*0.0586
                  ,
                ),
                child: Text(
                  'How are you feeling today?',style: TextStyle(
                    fontFamily: helveticaneueregular,
                    color:Colors.grey[600],
                 //   fontSize: 14
                fontSize: screenwidth*0.03733
                ),
                )
            ),
            Container(margin: EdgeInsets.only(
              //   top: 16
                top: screenarea*0.0000639,
                left:screenwidth*0.0586
                ,   right:screenwidth*0.0586            ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    //     height:35 ,
                 //     height: screeheight*0.05247,
                   height: screenwidth*0.0933,
                      //    width: 244,
                      width: screenwidth*0.65,
                      padding: EdgeInsets.only(
                        //    left: 10,
                          left: screenarea*0.00003998,
                          bottom: 0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                      ),child:Center(child: TextField(

                    onChanged: (v){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>
                      Recommended()));
                    },
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
                        hintText: 'Search'
                    ),
                  ),)
                  ),
                  GestureDetector(
                      onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>
                              Recommended()));
                      },
                      child:
                  Container(
                    // width: 60,
                    //      height: 35,
                    width: screenwidth*0.16,
                    height: screeheight*0.05247,
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
                    //left:22 ,
                    left:screenwidth*0.0586,

                    //    top: 12
            top: screenarea*0.0000479,

                ),
                child:
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children:[
                      Text("For you",style: TextStyle(
                          fontFamily: helveticaneuemedium,
                          color: Colors.black87,
                 //         fontSize: 18
                   fontSize: screenwidth*0.048
                      ),),])),
            Container(
              margin: EdgeInsets.only(
                //top:16,
                top:screenwidth*0.04266,
                bottom:screenwidth*0.0586
                  ,
                  left: screenwidth*0.0586,
                right:screenwidth*0.0586,
              ),
           //   height: 68,
              height: screeheight*0.1019,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap:()async{
    Navigator.push(context, MaterialPageRoute(builder: (context)=>
    Anxiety()));
    },
                      child:
                  Container(
            //        height: 68,
              //      width: 68,
                    height: screenwidth*0.1813,
width:  screenwidth*0.1813,
child:
    Hero(
    tag: "anxiety",
    child:
Image.asset("assets/images/anxiety.png",
//  width: 68,
width:  screenwidth*0.1813,
)),
                  )),
                  GestureDetector(
                      onTap:(){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>
                        Calm()));
                  },child:
                  Container(
               //     height: 68,
             //       width: 68,
                 height:  screenwidth*0.1813,
                      width:  screenwidth*0.1813,
                      child:
    Hero(
    tag: "calm",
    child:
                      Image.asset("assets/images/calm.png",
                     //   width: 68,
                      width:  screenwidth*0.1813,
                      ),
    )
                  ))
                  ,    GestureDetector(
    onTap:(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>
    Stress()));
    },child:
                  Container(
                    //height: 68,width: 68,
                    height:  screenwidth*0.1813,width: screenwidth*0.1813,
                    child:
    Hero(
    tag: "stress",
    child:
                    Image.asset("assets/images/stress icon@2x.png",
                  //    width: 68,
                    width:  screenwidth*0.1813,
                    )),
                  ))
                  ,
    GestureDetector(
    onTap:(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>
    Sleep()));
    },child:
                  Container(
                    //height: 68,width: 68,
                    height:  screenwidth*0.1813,width: screenwidth*0.1813,
                    child:   Hero(
    tag: "sleep",
    child:Image.asset("assets/images/sleep icon@3x.png",
                  //    width: 68,
                      width:  screenwidth*0.1813,
    )),
                  ))
                ],
              ),),

            Container(
                margin: EdgeInsets.only(
    //            left: screenarea*0.0001039,
                    left:screenwidth*0.0586,

                    //    left:26 ,
                //    top: 4
                ),
                child:
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children:[
                      Text("Recommended",style: TextStyle(
                          fontFamily: helveticaneuemedium,
                          color: Colors.black87,
                     //     fontSize: 18
                          fontSize: screenwidth*0.048
                      ),),])),
            Container(margin: EdgeInsets.only(
            //    top: screenarea*0.00007996,
                top:screenwidth*0.04266,
                bottom:screenwidth*0.0586
            ),
          //    height: 239,
       //       height: screeheight*0.368,
      //        width: 239*855/987,
              child:
LimitedBox(
 //   maxHeight: screeheight*0.368,
   maxHeight:screenwidth*0.637,
    child:
             new ListView(
               physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: [
                  GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>
                       SinglePlaylist(imageasset: "assets/images/bannerimage and text@3x.png", title: "title", description: "description")
                        ));
                      },
                      child:

Container(
    margin: EdgeInsets.only(
 //   left: screenarea*0.0001039
   left:screenwidth*0.0586
      //    left: 26
    ),
    child:

                     Container(
               width: screenwidth*0.52,
           //    height: screeheight*0.368,
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.all(Radius.circular(12)),
                         image: DecorationImage(
                           image: AssetImage("assets/images/medi.png"),
                           fit: BoxFit.cover,
                         ),
                       ),
                       child:
                       Column(mainAxisAlignment:MainAxisAlignment.end,
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Row(
                             mainAxisAlignment:MainAxisAlignment.start,children: [
                             Container(
                                 margin: EdgeInsets.only(
                                     left: screenarea*0.00003998
                                 ),
                                 child:
                                 Text("Breathing With Your Body",style: TextStyle(
                                     fontFamily: helveticaneuemedium,
                                     color: Colors.white,
                                     //    fontSize: 15
                                     fontSize: screenwidth*0.04
                                 ),))
                           ],),
                           Row(mainAxisAlignment:MainAxisAlignment.start,
                             children: [
                               Container(
                                   margin: EdgeInsets.only(
                                       left: screenarea*0.00003998,
                                       //    top: 4
                                       top: screenarea*0.0000159
                                   ),
                                   child:     Text("Harmonize Your Body, Mind\nAnd Inner Self",style: TextStyle(
                                       fontFamily: helveticaneueregular,
                                       color: Colors.white54,
                                       //    fontSize: 12
                                       fontSize: screenwidth*0.032
                                   ),))
                             ],),
                           Row(children: [
                             Container(margin: EdgeInsets.symmetric(
                               //  vertical: 12,
                               //    horizontal: 6
                                 vertical:  screenarea*0.0000479,
                                 horizontal: screenarea*0.0000239
                             ),
                               padding:EdgeInsets.symmetric(
                                 //  horizontal: 6
                                   horizontal: screenarea*0.0000239
                               ),
                               child: Row(mainAxisAlignment:MainAxisAlignment.center,children: [
                                 Container(
                                   //    height:34,width: 34,
                                   height: screenwidth*0.0906,width: screenwidth*0.0906,
                                   child: Icon(Icons.play_arrow,color: Colors.white70,
                                     //   size: 24,
                                     size: screenwidth*0.064,
                                   ),
                                   decoration: BoxDecoration(
                                       shape: BoxShape.circle,
                                       color: Colors.grey[600]
                                   ),
                                 ),
                                 Container(margin: EdgeInsets.only(
                                   //     left: 8
                                     left: screenarea*0.0000319
                                 ),
                                   child: Text('10 Min',style: TextStyle(
                                       fontFamily: helveticaneueregular,
                                       color: Colors.white.withOpacity(0.80),
                                       //    fontSize:12
                                       fontSize: screenwidth*0.032
                                   ),),
                                 )
                               ],),
                             )
                           ],
                           )
                         ],),
                     ),
)),
    new       GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>
         SinglePlaylist(imageasset: "assets/images/candle.png", title: "title", description: "description") ));
        },
        child:Container(
    margin: EdgeInsets.symmetric(
      horizontal: screenwidth*0.0586
      //  horizontal: 26
    ),child:
      Container(
        width: screenwidth*0.52,
        //    height: screeheight*0.368,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          image: DecorationImage(
            image: AssetImage("assets/images/candle.png"),
            fit: BoxFit.cover,
          ),
        ),
        child:
        Column(mainAxisAlignment:MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment:MainAxisAlignment.start,children: [
              Container(
                  margin: EdgeInsets.only(
                      left: screenarea*0.00003998
                  ),
                  child:
                  Text("Meditation",style: TextStyle(
                      fontFamily: helveticaneuemedium,
                      color: Colors.white,
                      //    fontSize: 15
                      fontSize: screenwidth*0.04
                  ),))
            ],),
            Row(mainAxisAlignment:MainAxisAlignment.start,
              children: [
                Container(
                    margin: EdgeInsets.only(
                        left: screenarea*0.00003998,
                        //    top: 4
                        top: screenarea*0.0000159
                    ),
                    child:     Text("Calming Sounds For You To Find\nMotivation",style: TextStyle(
                        fontFamily: helveticaneueregular,
                        color: Colors.white54,
                        //    fontSize: 12
                        fontSize: screenwidth*0.032
                    ),))
              ],),
            Row(children: [
              Container(margin: EdgeInsets.symmetric(
                //  vertical: 12,
                //    horizontal: 6
                  vertical:  screenarea*0.0000479,
                  horizontal: screenarea*0.0000239
              ),
                padding:EdgeInsets.symmetric(
                  //  horizontal: 6
                    horizontal: screenarea*0.0000239
                ),
                child: Row(mainAxisAlignment:MainAxisAlignment.center,children: [
                  Container(
                    //    height:34,width: 34,
                    height: screenwidth*0.0906,width: screenwidth*0.0906,
                    child: Icon(Icons.play_arrow,color: Colors.white70,
                      //   size: 24,
                      size: screenwidth*0.064,
                    ),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey[600]
                    ),
                  ),
                  Container(margin: EdgeInsets.only(
                    //     left: 8
                      left: screenarea*0.0000319
                  ),
                    child: Text('10 Min',style: TextStyle(
                        fontFamily: helveticaneueregular,
                        color: Colors.white.withOpacity(0.80),
                        //    fontSize:12
                        fontSize: screenwidth*0.032
                    ),),
                  )
                ],),
              )
            ],
            )
          ],),
      ),

    )),
                  Container(
                      margin: EdgeInsets.only(
                        right: screenwidth*0.0586
                        // right: 26
                      ),
                      child:
                            Container(
                              width: screenwidth*0.52,
                              //    height: screeheight*0.368,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(12)),
                                image: DecorationImage(
                                  image: AssetImage("assets/images/medi.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child:
                              Column(mainAxisAlignment:MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:MainAxisAlignment.start,children: [
                                    Container(
                                        margin: EdgeInsets.only(
                                            left: screenarea*0.00003998
                                        ),
                                        child:
                                        Text("Meditate",style: TextStyle(
                                            fontFamily: helveticaneuemedium,
                                            color: Colors.white,
                                            //    fontSize: 15
                                            fontSize: screenwidth*0.04
                                        ),))
                                  ],),
                                  Row(mainAxisAlignment:MainAxisAlignment.start,
                                    children: [
                                      Container(
                                          margin: EdgeInsets.only(
                                              left: screenarea*0.00003998,
                                              //    top: 4
                                              top: screenarea*0.0000159
                                          ),
                                          child:     Text("Calming sounds for you to find\nmotivation",style: TextStyle(
                                              fontFamily: helveticaneueregular,
                                              color: Colors.white54,
                                              //    fontSize: 12
                                              fontSize: screenwidth*0.032
                                          ),))
                                    ],),
                                  Row(children: [
                                    Container(margin: EdgeInsets.symmetric(
                                      //  vertical: 12,
                                      //    horizontal: 6
                                        vertical:  screenarea*0.0000479,
                                        horizontal: screenarea*0.0000239
                                    ),
                                      padding:EdgeInsets.symmetric(
                                        //  horizontal: 6
                                          horizontal: screenarea*0.0000239
                                      ),
                                      child: Row(mainAxisAlignment:MainAxisAlignment.center,children: [
                                        Container(
                                          //    height:34,width: 34,
                                          height: screenwidth*0.0906,width: screenwidth*0.0906,
                                          child: Icon(Icons.play_arrow,color: Colors.white70,
                                            //   size: 24,
                                            size: screenwidth*0.064,
                                          ),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.grey[600]
                                          ),
                                        ),
                                        Container(margin: EdgeInsets.only(
                                          //     left: 8
                                            left: screenarea*0.0000319
                                        ),
                                          child: Text('10 Min',style: TextStyle(
                                              fontFamily: helveticaneueregular,
                                              color: Colors.white.withOpacity(0.80),
                                              //    fontSize:12
                                              fontSize: screenwidth*0.032
                                          ),),
                                        )
                                      ],),
                                    )
                                  ],
                                  )
                                ],),
                            ),

                          ),

                ],)),        ),
            Container(
              margin: EdgeInsets.only(
                 // left:22 ,right:22,

                  left: screenwidth*0.0586,right:screenwidth*0.0586,


               //   top: 13.5
              ),
                //  right: 26),
              child:
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:[
              Text("Explore",style: TextStyle(
                fontFamily: helveticaneuemedium,
                color: Colors.black87,
              //    fontSize: 18
                  fontSize: screenwidth*0.048
              ),),
                  GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>
                        Recommended()));
                      },
                      child:
                      Container(child:
                  Text('Show All',style: TextStyle(
                    fontFamily: helveticaneueregular,
                    color: Colors.black.withOpacity(0.4),
                      //fontSize: 14
                      fontSize: screenwidth*0.0373

                  ),)))
                  ])),
            Container(
              margin: EdgeInsets.only(
                  //top:  8,bottom:  12
                  top:screenwidth*0.02266,
                  bottom:screenwidth*0.0586
              ),
            //  height: 125,
         //    height: 125,
           height: screenwidth*0.3333,
              child:

              ListView(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                children: [
                  Container(
                      //height: 100,
     //               width:screenwidth,
                      margin: EdgeInsets.only(
                   //       right: 26,
                     //     left: 26
          //              left:22,right:22,
                      right: screenwidth*0.0586,
                      left: screenwidth*0.0586,
                      ),

                          child:

                    GestureDetector(
                        onTap:(){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>
                              MusicPlayer(imageasset: "assets/images/orange_circle.png",
                                  title: "Activate your higher mind",
                                  description: "")));
                        },
                        child:
                    Container(
                      width: screenwidth*0.52,

                      //    height: screeheight*0.368,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        image: DecorationImage(
                          image: AssetImage("assets/images/illustration@3x.png"),
                          fit: BoxFit.contain,

                        ),
                      ),
                    child:    Container(

                        child:Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:[
                              Container(margin:EdgeInsets.only(
                                //                      top: 15,
                                  top:screenarea*0.0000599,
                                  //   left: 10
                              ),
                                  child:
                                      Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children:[
                                  Text('Activate your higher mind for\nsuccess subconscious mind\nprogramming',style: TextStyle(
                                      fontFamily: helveticaneuemedium,
                                      color: Colors.white,
                                      //    fontSize: 13.5
                                      fontSize: screenwidth*0.036
                                  ),)])),
                              Row(mainAxisAlignment:MainAxisAlignment.start,children: [
                                Container(margin: EdgeInsets.only(
                                  //         vertical: 12,
                                  //       horizontal: 6
                                    top:  12,
                                ),
                                  padding:EdgeInsets.symmetric(
                                      horizontal: screenarea*0.0000239
                                    // horizontal: 6
                                  ),
                                  child: Row(mainAxisAlignment:MainAxisAlignment.center,children: [
                                    Container(
                                      //          height:34,width: 34,
                                      height: screenwidth*0.0906,width: screenwidth*0.0906,

                                      child: Icon(Icons.play_arrow,color: Colors.white70,
                                        //     size: 24,
                                        size:  screenwidth*0.064,

                                      ),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white38
                                      ),
                                    ),
                                    Container(margin: EdgeInsets.only(
                                      //             left: 8
                                        left: screenarea*0.0000319
                                    ),
                                      child: Text('10 Min',style: TextStyle(
                                          fontFamily: helveticaneueregular,
                                          color: Colors.white.withOpacity(0.80),
                                          //    fontSize:12
                                          fontSize: screenwidth*0.032

                                      ),),
                                    )
                                  ],),
                                )
                              ],
                              )
                            ])),
                    )),

                  ),
                  Container(
             //         height: 150,
                    height: screeheight*0.2248,
margin: EdgeInsets.only(
   // right: 26
right: screenarea*0.0001039
),
                      child:
GestureDetector(
onTap:(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>
    MusicPlayer(imageasset: "assets/images/purple circle@2x.png",
    title: "Activate your higher mind",
    description: "")));
    },
    child:
                        Container(
                          width: screenwidth*0.52,
                          height: screeheight*0.2248,

                          //    height: screeheight*0.368,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            image: DecorationImage(
                              image: AssetImage("assets/images/illustration@2x.png"),
                              fit: BoxFit.contain,

                            ),
                          ),
                          child:    Container(

                              child:Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children:[
                                    Container(margin:EdgeInsets.only(
                                      //                      top: 15,
                                      top:screenarea*0.0000599,
                                      //   left: 10
                                    ),
                                        child:
                                        Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children:[
                                              Text('Activate your higher mind for\nsuccess subconscious mind\nprogramming',style: TextStyle(
                                                  fontFamily: helveticaneuemedium,
                                                  color: Colors.white,
                                                  //    fontSize: 13.5
                                                  fontSize: screenwidth*0.036
                                              ),)])),
                                    Row(mainAxisAlignment:MainAxisAlignment.start,children: [
                                      Container(margin: EdgeInsets.only(
                                        //         vertical: 12,
                                        //       horizontal: 6
                                        top:  12,
                                      ),
                                        padding:EdgeInsets.symmetric(
                                            horizontal: screenarea*0.0000239
                                          // horizontal: 6
                                        ),
                                        child: Row(mainAxisAlignment:MainAxisAlignment.center,children: [
                                          Container(
                                            //          height:34,width: 34,
                                            height: screenwidth*0.0906,width: screenwidth*0.0906,

                                            child: Icon(Icons.play_arrow,color: Colors.white70,
                                              //     size: 24,
                                              size:  screenwidth*0.064,

                                            ),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white38
                                            ),
                                          ),
                                          Container(margin: EdgeInsets.only(
                                            //             left: 8
                                              left: screenarea*0.0000319
                                          ),
                                            child: Text('10 Min',style: TextStyle(
                                                fontFamily: helveticaneueregular,
                                                color: Colors.white.withOpacity(0.80),
                                                //    fontSize:12
                                                fontSize: screenwidth*0.032

                                            ),),
                                          )
                                        ],),
                                      )
                                    ],
                                    )
                                  ])),
                        )),


                      ),
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.only(
              //      left:26 ,
                //    right: 26
        //        left: screenarea*0.0001039,
       //           right: screenarea*0.0001039
  //       left:22,right:22,
    left: screenarea*0.0000879,right:screenarea*0.0000879,
                ),
                child:
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children:[
                      Text("Meditate",style: TextStyle(
                          fontFamily: helveticaneuemedium,
                          color: Colors.black87,
                  //        fontSize: 18
                          fontSize: screenwidth*0.048

                      ),),

                    ])),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>
                Meditate()));
              },
                child:
            Container(
              margin: EdgeInsets.only(
  //                top: 13,
                  top:screenwidth*0.04266,
                  bottom:screenwidth*0.0586,
            //      right: 26,
              //    left:26,
                //  bottom:26
            //      left:22,right:22,
                  left: screenwidth*0.0586,right:screenwidth*0.0586,
                //       bottom: 18
     ),
         //     height: 168,
        //      height: screeheight*0.2518,
              child: Center(child:
                Hero(tag: 'log',
                child:
                Container(
                  width: screenwidth,
                  height: screeheight*148/667,
                  //    height: screeheight*0.368,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    image: DecorationImage(
                      image: AssetImage("assets/images/lotus@3x.png"),
                      fit: BoxFit.cover,

                    ),
                  ),
                  child:     Container(
                    margin: EdgeInsets.all(screenarea*0.00003998

                      //    10
                    ),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize:MainAxisSize.max,
                      children: [
                        Container(child:Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:[
                            Container(margin:EdgeInsets.only(
                           // top: 2, left:2
left: screenarea*0.00000799,top: screenarea*0.00000799                        ),
                            child:
                            Text('Ready To Start\nMeditation?',style: TextStyle(
                                fontFamily: helveticaneuemedium,
                                color: Colors.white,
                                //       fontSize: 18
                                fontSize: screenwidth*0.048

                            ),)),
                        Container(
                            margin: EdgeInsets.only(
                              //        left: 10,
//                                left: screenarea*0.0000279,
                                top:screenarea*0.0000319
                              //       top:  8
                              //  top: 16
                            ),
                            child:     Text("Regain Your Inner\nPeace",style: TextStyle(
                                fontFamily: helveticaneueregular,
                                color: Colors.white70,
                                //   fontSize: 12
                                fontSize: screenwidth*0.032

                            ),))])),
                        Row(crossAxisAlignment:CrossAxisAlignment.end,children: [
                          Container(margin: EdgeInsets.only(
                            //       top: 13,
                              top:screenarea*0.0000519,
                              //      left: 6,right:6
//                              left:  screenarea*0.0000239,right:  screenarea*0.0000239
                          ),
                            padding:EdgeInsets.symmetric(
                              //    horizontal: 6
                                horizontal:  screenarea*0.0000239
                            ),
                            child: Row(mainAxisAlignment:MainAxisAlignment.center,children: [
                              Container(
                                //            height:34,width: 34,
                                height: screenwidth*0.0906,width: screenwidth*0.0906,

                                child: Icon(Icons.play_arrow,color: Colors.white70,
                                  //         size: 24,
                                  size:  screenwidth*0.064,
                                ),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white38
                                ),
                              ),
                              Container(margin: EdgeInsets.only(
                                //     left: 8
                                  left: screenarea*0.0000319
                              ),
                                child: Text('10 Min',style: TextStyle(
                                    fontFamily: helveticaneueregular,
                                    color: Colors.white.withOpacity(0.80),
                                    //     fontSize:12
                                    fontSize: screenwidth*0.032
                                ),),
                              )
                            ],),
                          )
                        ],
                        )
                      ],),)
                )),


              ),
            )),

          ],))]))

      ],
    ));

  }
  images(int index){
    if(index==0){
      return "assets/images/pexels-pixabay-355209.jpg";
    }
    if(index==1){
return "assets/images/pexels-hoang-loc-1905054.jpg";
    }    if(index==2){
return "assets/images/pexels-karolina-grabowska-4203102.jpg";
    }    if(index==3){
return "assets/images/pexels-maël-balland-3099153.jpg";
    }


  }

  timeofdaygreeting(){
    if(int.parse(DateFormat.H('en_US').format(DateTime.now()))<12){
setState(() {
  currenttimeofday='Morning';
});
    }
    if(int.parse(DateFormat.H('en_US').format(DateTime.now()))>12 && int.parse(DateFormat.H('en_US').format(DateTime.now()))<5){
     setState(() {
       currenttimeofday='Afternoon';
     });
    }
    if(int.parse(DateFormat.H('en_US').format(DateTime.now()))>12 && int.parse(DateFormat.HOUR)<5){
setState(() {
  currenttimeofday='Evening';
});    }
  }
}
