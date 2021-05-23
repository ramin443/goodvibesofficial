import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goodvibesoffl/constants/fontconstants.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
class Stress extends StatefulWidget {
  @override
  _StressState createState() => _StressState();
}

class _StressState extends State<Stress> with SingleTickerProviderStateMixin{
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
    double screenwidth=MediaQuery.of(context).size.width;
    double screenheight=MediaQuery.of(context).size.height;
    double screenarea=screenheight*screenwidth;
    final animation=Tween<double>(begin: 24,end: 30).animate(_scaleanimationcontroller);

    return  Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton:
        ClipRect(child:
        BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8,sigmaY: 8),
            child:Container(
              margin: EdgeInsets.only(
                //   left: 40,
                  left: screenarea*0.000159,
                  right: screenarea*0.0000319
                //  right: 8
              ),
              padding: EdgeInsets.symmetric(
                // vertical: 18
                  vertical: screenarea*0.0000719
              ),
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
                        //     height: 54,width: 54,
                        height: screenheight*0.08095,width:  screenheight*0.08095,
                        child: Image.asset("assets/images/stressbg.png",fit: BoxFit.cover,),
                      )),
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
                  Expanded(child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(onTap:(){},child: Container(child: Icon(Icons.skip_previous,
                        //    size: 26,
                        size: screenwidth*0.0693,
                        color: Colors.black87,),)),
                      GestureDetector(onTap:(){},child: Container(child: Icon(Icons.play_arrow,
                        //      size: 26,
                        size: screenwidth*0.0693,
                        color: Colors.black87,),)),
                      GestureDetector(onTap:(){},child: Container(child: Icon(Icons.skip_next,
                        //        size: 26,
                        size: screenwidth*0.0693,
                        color: Colors.black87,),)),

                    ],),)
                ],
              ),
            ))),
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
                          tag: "stress",
                          child:
                          Image.asset("assets/images/stressbg.png",fit: BoxFit.cover,),)
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
                                      builder:(context,child){ return              Icon(pressed?MdiIcons.heart:MdiIcons.heartOutline,

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
                          margin: EdgeInsets.only(
                            //   bottom: 38,left: 26,right: 26
                              bottom:screenarea*0.000151
                              ,  left:screenarea*0.0001039,right: screenarea*0.0001039
                          ),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.all(Radius.circular(6)),
                                  child:BackdropFilter(
                                      filter: ImageFilter.blur(sigmaY: 10,sigmaX: 10),
                                      child:
                                      Container(
                                        color: Colors.white.withOpacity(0.1),
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
                                      ))),
                              Container(
                                child: Text("00:10:00",
                                  style: TextStyle(
                                      fontFamily: helveticaneueregular,
                                      color: Colors.white,
                                      //   fontSize: 17
                                      fontSize: screenwidth*0.0453
                                  ),),)

                            ],),))
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
                          left: screenarea*0.000103,top:screenarea*0.000123
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
                  Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(
                          top: screenarea*0.000115,
                          // top: 29,
                          //  left: 26, right: 26
                          left: screenarea*0.000103,right: screenarea*0.000103
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
                                        child: Text("Introduction to guided meditation",style: TextStyle(
                                            fontFamily: helveticaneuemedium,color: Color(0xff12c2e9),
                                            //fontSize: 12.5
                                            fontSize: screenwidth*0.0333
                                        ),),),
                                      Container(child: Text("Reach your goals with this advice",style: TextStyle(
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
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(
                        //     top: 26,left: 26,right: 26
                          top: screenarea*0.000103,left: screenarea*0.000103,right: screenarea*0.000103
                      ),
                      child:
                      Column(children:[
                        Container(
                            margin:EdgeInsets.only(
                                bottom: screenarea*0.0000359
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
                                        child: Text("Intimate meditation",style: TextStyle(
                                            fontFamily: helveticaneuemedium,color: Colors.black87,
                                            //fontSize: 12.5
                                            fontSize: screenwidth*0.0333
                                        ),),),
                                      Container(child: Text("Love and intimate relationship meditation",style: TextStyle(
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

                  Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(
                        // top: 26,left: 26,right: 26
                          top: screenarea*0.000103,left: screenarea*0.000103,right: screenarea*0.000103
                      ),
                      child:
                      Column(children:[
                        Container(
                            margin:EdgeInsets.only(
                              //      bottom: 9
                                bottom: screenarea*0.0000359
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
                                  //   left: 11
                                    left: screenarea*0.0000439
                                ),
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment:
                                  MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin:EdgeInsets.only(
                                          //    bottom: 4
                                            bottom: screenarea*0.0000159
                                        ),
                                        child: Text("(528Hz- 10000Hz) DNA simulation",style: TextStyle(
                                            fontFamily: helveticaneuemedium,color: Colors.black87,
                                            //         fontSize: 12.5
                                            fontSize: screenwidth*0.0333
                                        ),),),
                                      Container(child: Text("Full restore your whole being, binaurial beats",style: TextStyle(
                                          fontFamily: helveticaneueregular,color: Colors.black54
                                          .withOpacity(0.5),
                                          //  fontSize: 10.5
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

                  Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(
                        //     top: 26,left: 26,right: 26,bottom: 64
                          top: screenarea*0.000103,left: screenarea*0.000103,right: screenarea*0.000103,
                          bottom: screenarea*0.000255
                      ),
                      child:
                      Column(children:[
                        Container(
                            margin:EdgeInsets.only(
                              //     bottom: 9
                                bottom: screenarea*0.0000359

                            ),
                            child:
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipOval(child: Container(
                                  // height: 35,width: 35,
                                  height: screenwidth*0.093,width: screenwidth*0.093,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border:Border.all(color: Colors.grey[700],width: 1,style: BorderStyle.solid)
                                    //  color: Color(0xff12c2e9),
                                  ),
                                  child: Center(child: Icon(Icons.play_arrow,
                                    color: Colors.black87,
                                    //        size: 26.5,
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
                                          //     bottom: 4
                                            bottom: screenarea*0.0000159
                                        ),
                                        child: Text("Manifest financial prosperity",style: TextStyle(
                                            fontFamily: helveticaneuemedium,color: Colors.black87,
                                            //fontSize: 12.5
                                            fontSize: screenwidth*0.0333
                                        ),),),
                                      Container(child: Text("Good Fortune miracle music",style: TextStyle(
                                          fontFamily: helveticaneueregular,color: Colors.black54
                                          .withOpacity(0.5),
                                          //fontSize: 10.5
                                          fontSize: screenwidth*0.028),),),
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



                ]))
    );
  }
}
