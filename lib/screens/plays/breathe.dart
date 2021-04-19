import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:goodvibesofficial/constants/fontconstants.dart';
import 'package:goodvibesofficial/screens/sharables/music_player.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
class Breathe extends StatefulWidget {

  @override
  _BreatheState createState() => _BreatheState();
}

class _BreatheState extends State<Breathe> with SingleTickerProviderStateMixin{
    AnimationController _scaleanimationcontroller;

  bool pressed=false;
@override
void initState() {
  super.initState();
  _scaleanimationcontroller=AnimationController(vsync: this,duration: Duration(milliseconds: 100));
  _scaleanimationcontroller.addListener(() {
    if(_scaleanimationcontroller.status==AnimationStatus.forward){
//_scaleanimationcontroller.reverse();
    }
  });
}
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
double screenwidth=MediaQuery.of(context).size.width;
  final animation=Tween<double>(begin: 24,end: 30).animate(_scaleanimationcontroller);
    return
    Scaffold(
floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
      floatingActionButton:
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
          filter: ImageFilter.blur(sigmaX: 3.5,sigmaY: 3.5),
          child:Container(
        margin: EdgeInsets.only(left: 40,right: 8),
        padding: EdgeInsets.symmetric(vertical: 18),
        width: screenwidth,

        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(                borderRadius: BorderRadius.all(Radius.circular(6)),
        child:
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(6))
              ),
              height: 54,width: 54,
              child:

              Image.asset("assets/images/medi.png",fit: BoxFit.cover,),
            )),
            Container(
              margin: EdgeInsets.only(left: 16),
              height: 54,
              child: Column(crossAxisAlignment:CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
Container(child: Text("Get Motivated",style: TextStyle(
  fontFamily: helveticaneuebold,color: Colors.black87,fontSize: 13.5
),),),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  child: Text("Reach your goals with this advice",style: TextStyle(
                    fontFamily: helveticaneueregular,color: Colors.black54,fontSize: 10
                ),),),
            ],),),
Expanded(child: Row(
  mainAxisAlignment: MainAxisAlignment.end,
  children: [
  GestureDetector(onTap:(){},child: Container(child: Icon(Icons.skip_previous,size: 26,color: Colors.black87,),)),
  GestureDetector(onTap:(){},child: Container(child: Icon(Icons.play_arrow,size: 26,color: Colors.black87,),)),
  GestureDetector(onTap:(){},child: Container(child: Icon(Icons.skip_next,size: 26,color: Colors.black87,),)),

],),)
          ],
        ),
      )))),
      body:
SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child:
      Column(mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:[
            Stack(children:[
      Container(
        child:
        Hero(
          tag: "picture",
          child:
        Image.asset("assets/images/bannerimage and text@3x.png",fit: BoxFit.cover,),)
      ),
       Container(
         child:

         Column(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
           AppBar(
             backgroundColor: Colors.transparent,elevation: 0,
             leading: GestureDetector(
               onTap: (){Navigator.pop(context);},
               child: Icon(CupertinoIcons.back,size: 24,color: Colors.white,),
             ),
             actions: [
               GestureDetector(child:
                   Container(
                       margin: EdgeInsets.only(right: 10),
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
                width:320,
                margin: EdgeInsets.only(bottom: 38,left: 26,right: 26),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        child:BackdropFilter(
                            filter: ImageFilter.blur(sigmaY: 10,sigmaX: 10),
                            child:
                            Container(
                              color: Colors.white.withOpacity(0.1),
                              height: 32,width: 78,
                              child: Row(mainAxisAlignment:MainAxisAlignment.spaceEvenly,children: [
                                Icon(Icons.play_arrow,color: Colors.white,size: 16,),
                                Container(child: Text("Play",style: TextStyle(fontFamily: helveticaneueregular,
                                    fontSize: 14,color: Colors.white),),)
                              ],),
                            ))),
                    Container(
                      child: Text("00:10:00",
                        style: TextStyle(
                      fontFamily: helveticaneueregular,
                      color: Colors.white,
                      fontSize: 17
                    ),),)

                  ],),))
            ]),
            Container(
              margin: EdgeInsets.only(top: 10),
              height: 4,width: 75,
              decoration: BoxDecoration(
                color: Colors.grey[700],borderRadius: BorderRadius.all(Radius.circular(18)),
              ),
            ),
Container(
    margin: EdgeInsets.only(left: 26,top: 31),
    child:
Row(mainAxisAlignment:MainAxisAlignment.start,
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
  Text("Tracks",style: TextStyle(fontFamily: helveticaneuebold,
  color: Colors.black87,fontSize: 19),)
],)),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 29,left: 26,right: 26),
              child:
              Column(children:[
                Container(
                    margin:EdgeInsets.only(bottom: 9),
                    child:
              Row(

              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipOval(child: Container(
                  height: 35,width: 35,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border:Border.all(color: Color(0xff12c2e9),width: 1,style: BorderStyle.solid)
                  //  color: Color(0xff12c2e9),
                  ),
                  child: Center(child: Icon(Icons.play_arrow,
                  color: Color(0xff12c2e9),size: 26.5,),),
                ),),
                Container(margin: EdgeInsets.only(left: 11),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment:
                    MainAxisAlignment.start,
                    children: [
Container(
  margin:EdgeInsets.only(bottom: 4),
  child: Text("Introduction to guided meditation",style: TextStyle(
  fontFamily: helveticaneuemedium,color: Color(0xff12c2e9),fontSize: 12.5
),),),
                      Container(child: Text("Reach your goals with this advice",style: TextStyle(
                          fontFamily: helveticaneueregular,color: Color(0xff12c2e9).withOpacity(0.5),fontSize: 10.5
                      ),),),
                ],),),
                Expanded(child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children:[
                Text(
                  "17:24",
                  textAlign:TextAlign.end,style: TextStyle(
                    fontFamily: helveticaneuemedium,color: Color(0xff12c2e9),fontSize: 12.5

                ),
                ),]))
              ],
            )),
                Divider(thickness: 1,color: Colors.grey[400],)
              ])
            ),

            Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(top: 26,left: 26,right: 26),
                child:
                Column(children:[
                  Container(
                      margin:EdgeInsets.only(bottom: 9),
                      child:
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipOval(child: Container(
                            height: 35,width: 35,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:Border.all(color: Colors.grey[700],width: 1,style: BorderStyle.solid)
                              //  color: Color(0xff12c2e9),
                            ),
                            child: Center(child: Icon(Icons.play_arrow,
                              color: Colors.black87,size: 26.5,),),
                          ),),
                          Container(margin: EdgeInsets.only(left: 11),
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment:
                            MainAxisAlignment.start,
                              children: [
                                Container(
                                  margin:EdgeInsets.only(bottom: 4),
                                  child: Text("Intimate meditation",style: TextStyle(
                                      fontFamily: helveticaneuemedium,color: Colors.black87,fontSize: 12.5
                                  ),),),
                                Container(child: Text("Love and intimate relationship meditation",style: TextStyle(
                                    fontFamily: helveticaneueregular,color: Colors.black54
                                    .withOpacity(0.5),fontSize: 10.5
                                ),),),
                              ],),),
                          Expanded(child:
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children:[
                            Text(
                              "17:24",
                              textAlign:TextAlign.end,style: TextStyle(
                                fontFamily: helveticaneuemedium,color: Colors.black87,fontSize: 12.5

                            ),
                            ),]))
                        ],
                      )),
                  Divider(thickness: 1,color: Colors.grey[400],)
                ])
            ),

            Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(top: 26,left: 26,right: 26),
                child:
                Column(children:[
                  Container(
                      margin:EdgeInsets.only(bottom: 9),
                      child:
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipOval(child: Container(
                            height: 35,width: 35,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:Border.all(color: Colors.grey[700],width: 1,style: BorderStyle.solid)
                              //  color: Color(0xff12c2e9),
                            ),
                            child: Center(child: Icon(Icons.play_arrow,
                              color: Colors.black87,size: 26.5,),),
                          ),),
                          Container(margin: EdgeInsets.only(left: 11),
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment:
                            MainAxisAlignment.start,
                              children: [
                                Container(
                                  margin:EdgeInsets.only(bottom: 4),
                                  child: Text("(528Hz- 10000Hz) DNA simulation",style: TextStyle(
                                      fontFamily: helveticaneuemedium,color: Colors.black87,fontSize: 12.5
                                  ),),),
                                Container(child: Text("Full restore your whole being, binaurial beats",style: TextStyle(
                                    fontFamily: helveticaneueregular,color: Colors.black54
                                    .withOpacity(0.5),fontSize: 10.5
                                ),),),
                              ],),),
                          Expanded(child:
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children:[
                            Text(
                              "17:24",
                              textAlign:TextAlign.end,style: TextStyle(
                                fontFamily: helveticaneuemedium,color: Colors.black87,fontSize: 12.5

                            ),
                            ),]))
                        ],
                      )),
                  Divider(thickness: 1,color: Colors.grey[400],)
                ])
            ),

            Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(top: 26,left: 26,right: 26,bottom: 24),
                child:
                Column(children:[
                  Container(
                      margin:EdgeInsets.only(bottom: 54),
                      child:
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipOval(child: Container(
                            height: 35,width: 35,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:Border.all(color: Colors.grey[700],width: 1,style: BorderStyle.solid)
                              //  color: Color(0xff12c2e9),
                            ),
                            child: Center(child: Icon(Icons.play_arrow,
                              color: Colors.black87,size: 26.5,),),
                          ),),
                          Container(margin: EdgeInsets.only(left: 11),
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment:
                            MainAxisAlignment.start,
                              children: [
                                Container(
                                  margin:EdgeInsets.only(bottom: 4),
                                  child: Text("Manifest financial prosperity",style: TextStyle(
                                      fontFamily: helveticaneuemedium,color: Colors.black87,fontSize: 12.5
                                  ),),),
                                Container(child: Text("Good Fortune miracle music",style: TextStyle(
                                    fontFamily: helveticaneueregular,color: Colors.black54
                                    .withOpacity(0.5),fontSize: 10.5
                                ),),),
                              ],),),
                          Expanded(child:
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children:[
                            Text(
                              "17:24",
                              textAlign:TextAlign.end,style: TextStyle(
                                fontFamily: helveticaneuemedium,color: Colors.black87,fontSize: 12.5

                            ),
                            ),]))
                        ],
                      )),
                  Divider(thickness: 1,color: Colors.grey[400],)
                ])
            ),



          ]))
    );
      Stack(children:[
        Hero(
            tag: "picture",
            child:
        Image.asset("assets/images/bannerimage and text@3x.png",fit: BoxFit.fitWidth,)),
      Scaffold(
        backgroundColor: Colors.transparent,

body:CustomScrollView(
  slivers: [
    SliverList(
    delegate: SliverChildListDelegate(
    [
      Image.asset("assets/images/bannerimage and text@3x.png",fit: BoxFit.fitWidth,color: Colors.transparent,),
AppBar(
  backgroundColor: Colors.blue,
),
      GestureDetector(
          onTap: (){Navigator.pop(context);},
          child:
      Container(height: 200,color: Colors.white,))
      ]))
  ],
)
    )
      ]);
  }
}
