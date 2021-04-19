import 'dart:io';
import 'dart:ui';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:goodvibesofficial/constants/fontconstants.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
class MusicPlayer extends StatefulWidget {
  final String imageasset;
  final String title;
  String description;

  MusicPlayer({Key key, @required this.imageasset,@required this.title,@required this.description}) : super(key: key);

  @override
  _MusicPlayerState createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  String imageasset;
//  bool favorite=false;
bool pause=false;
  bool favoritespressed=false;
  emptycode(){}
  @override
  Widget build(BuildContext context) {
    Platform.isAndroid?
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Color(0xfff5f5f5),

        systemNavigationBarColor: Color(0xfff5f5f5),
      //  systemNavigationBarIconBrightness: Brightness.dark
    )):emptycode();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    double screenwidth=MediaQuery.of(context).size.width;
    double screenheight=MediaQuery.of(context).size.height;
    double screenarea=screenheight*screenwidth;
    return Stack(
      children: [
      Image.asset('assets/images/X - 1@2x.png',fit: BoxFit.cover,width: screenheight,),
        Scaffold(
          bottomNavigationBar: Container(
            margin: EdgeInsets.only(
    //            bottom: 35
      bottom: screenarea*0.000139
            ),
            width: screenwidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(child: Icon(FeatherIcons.download,
             //     size: 30,
                  size:screenwidth*0.08,
                  color: Colors.white70,
                ),
                    onTap: (){

                    }) ,
              GestureDetector(child: Icon(
                favoritespressed?MdiIcons.heart:
                FeatherIcons.heart,
         //     size: 30,
                size:screenwidth*0.08,
                color:favoritespressed?Colors.redAccent: Colors.white,
              ),
                  onTap: (){
                setState(() {
                  favoritespressed=!favoritespressed;
                });
              }) ,
                GestureDetector(child: Icon(CupertinoIcons.plus_circled,
      //            size: 30,
                  size:screenwidth*0.08,
                color: Colors.white,
                ),
                    onTap: (){

                    }) ,
              ],
            ),
          ),
          backgroundColor: Colors.transparent,
          appBar:

          AppBar(
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
                    favoritespressed=!favoritespressed;
                  });
                },
                child:
            Container(margin: EdgeInsets.only(
            //    right: 15
            right: screenarea*0.0000599
            ),
              child: Icon(
                favoritespressed?MdiIcons.heart:FeatherIcons.heart,
              color:favoritespressed?Colors.redAccent: Colors.black87,
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
          ),
          body: Container(
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
                       top: screenarea*0.0000799,
                                left: 0),
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
                    left: screenarea*0.000135,right: screenarea*0.000135

                ),
                  child: Column(
                    children: [
                    Container(width: double.infinity,
                      alignment: Alignment.centerLeft,
                  //    height: 4,
                    height: screenheight*0.00599,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(14)),
                      ),
                      child:

                      Container(
                        height: double.infinity,
                    //    width: 178,
                      width: screenwidth*0.474,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xff9797de),Color(0xff32386a)]
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(14)),                        ),
                      ),
                    ),
                      Container(
                          width: screenwidth,
                          margin: EdgeInsets.only(
                          //    top: 8
                              top: screenarea*0.0000319
                          ),
                          child:
                      Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children: [
                        Container(child: Text("5:57",style: TextStyle(
    fontFamily: helveticaneueregular,color: Colors.black38,
                       //     fontSize: 12
                          fontSize: screenwidth*0.032
    ),)),
                        Container(child: Text("10:00",style: TextStyle(
                            fontFamily: helveticaneueregular,color: Colors.black38,
                          //  fontSize: 12
                            fontSize: screenwidth*0.032

                        ),)),
                      ],)),
                      Container(
                        margin: EdgeInsets.only(
                        //    top: 14
                        top: screenarea*0.0000559
                        ),
                       width: screenwidth,
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          ShaderMask(
                          blendMode: BlendMode.srcATop,
                          shaderCallback: (Rect bounds){
                            return LinearGradient(colors: [Color(0xff9797de),Color(0xff32386A)],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
//                   stops: [0.0,0.5]
                            ).createShader(bounds);
                          },child:
SvgPicture.asset("assets/images/shuffle.svg")),
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
                                  icon: Icon(pause?Icons.play_arrow:Icons.pause,
                                    color: Colors.black87,
                       //             size: 30,
                                     size:screenwidth*0.08,

                                  ),onPressed: (){
setState(() {
  pause=!pause;
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
                            SvgPicture.asset("assets/images/timer.svg")),

                          ],
                        ),
                      )
                  ],),
                )
            ],),
          ),
        )
      ],
    );
  }
}
