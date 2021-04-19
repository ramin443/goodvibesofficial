import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goodvibesofficial/constants/fontconstants.dart';
import 'package:goodvibesofficial/userpreferences/settings.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  emptycode(){}
  @override
  Widget build(BuildContext context) {
    Platform.isAndroid?
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Color(0xfff5f5f5),
        systemNavigationBarColor: Color(0xfff5f5f5),
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
            Container(
              //      height: 45,
              //    width: 45,
         //     height: 83,width:83,
              height: screeheight*0.124,width:  screeheight*0.124,
              margin: EdgeInsets.only(
        //          top:8,
          top: screenarea*0.0000319
                  //     right: 20
        //          right: screenarea*0.00007996
              ),
              child:  Hero(
                tag: 'avatar',
                child: Image.asset('assets/images/profile@3x.png',
                //   width: 45,
                width:screenwidth*0.40,
                fit: BoxFit.contain,
              ),)
            ),
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
                            child: Container(
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
                            ))
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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

                      ])
                ],
              ),
            ),
          Container(
            margin: EdgeInsets.only(top: 23),
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
    )]));
  }
}
