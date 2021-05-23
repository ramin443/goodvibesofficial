import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:goodvibesoffl/constants/fontconstants.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'getpremium.dart';
class SubscriptionDetail extends StatefulWidget {
  @override
  _SubscriptionDetailState createState() => _SubscriptionDetailState();
}

class _SubscriptionDetailState extends State<SubscriptionDetail> {
  bool freeversion=true;
  @override
  Widget build(BuildContext context) {
    double screenheight=MediaQuery.of(context).size.height;
    double screenwidth=MediaQuery.of(context).size.width;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      backgroundColor: Color(0xfff5f5f5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(CupertinoIcons.back,
          color: Colors.black87.withOpacity(0.7),
        //  size: 24,
          size: screenwidth*0.064,
          ),onPressed: (){
            Navigator.pop(context);
        },
        ),
        centerTitle: true,
        title:
        GestureDetector(
            onTap: (){
              setState(() {
freeversion=!freeversion;
              });
            },
            child:
        Container(child:
          Text("Subscription Detail",style: TextStyle(
            fontFamily: helveticaneuemedium,
            color: Colors.black87,
         //   fontSize: 17
          fontSize: screenwidth*0.04533
          ),),)),
      ),
body: SingleChildScrollView(
  physics: BouncingScrollPhysics(),
  child:
  AnimatedSwitcher(
    duration: Duration(milliseconds:250),
 //   transitionBuilder: (Widget child, Animation<double> animation)=>ScaleTransition(
   // child: child,scale: animation,
   // ),
    child:
        freeversion?freeplan(context):
  Container(
    margin: EdgeInsets.symmetric(
      //        horizontal: 26
        horizontal: screenwidth*0.0693
    ),    key: UniqueKey(),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

Container(
  margin: EdgeInsets.symmetric(
//      vertical: 28
  vertical: screenwidth*0.0746
  ),
  padding: EdgeInsets.all(
//      16
screenwidth*0.0426
  ),
  height: screenwidth*0.472,
  width: screenwidth,
  decoration: BoxDecoration(
    boxShadow: [BoxShadow(color: Color(0xff32386a).withOpacity(0.29),offset: Offset(0,6),
    blurRadius: 30
    )],
    color: Color(0xff9797de),
    borderRadius: BorderRadius.all(Radius.circular(8)),
  ),
  child: Stack(children: [
    Positioned(
      bottom:0,right: 0,
      child: SvgPicture.asset("assets/images/white_logo.svg",width: screenwidth*0.2773,
      color: Colors.white.withOpacity(0.15),),
    ),
    Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(child: Text("Good Vibes Premium",style: TextStyle(
          fontFamily: helveticaneuemedium,
          color: Colors.white,
    //      fontSize: 17
            fontSize: screenwidth*0.04533
        ),),),
        Container(child: Text("CURRENT PLAN",style: TextStyle(
            fontFamily: helveticaneueregular,
            color: Colors.white60,
     //       fontSize: 9.5
       fontSize: screenwidth*0.0253
        ),),),
      ],
      ),
      Container(child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(              margin:EdgeInsets.only(
        //          bottom: 4
          bottom: screenwidth*0.0106
              ),
                child:
              Text("Subscription Type: Yearly",style: TextStyle(
       //         fontSize: 13.5,
         fontSize: screenwidth*0.036,
                color: Colors.white,
                fontFamily: helveticaneueregular
              ),),),
            ],
          ),
          Row(children: [
            Container(
                margin:EdgeInsets.only(
         //           bottom: 4
                    bottom: screenwidth*0.0106
                ),
                child:
            RichText(
              text: TextSpan(
                  style:   TextStyle(
           //           fontSize: 14.5,
                      fontSize: screenwidth*0.036,
                      color: Colors.white,
                      fontFamily: helveticaneueregular
                  ),
                  children: [
                    TextSpan(
                        text: "Status:"
                    ),
                    TextSpan(
                        text: " Active",style: TextStyle(
                      fontFamily: helveticaneuemedium,
                //      fontSize: 14.5,
                      fontSize: screenwidth*0.036,
                      color: Colors.white,
                    )
                    ),
                  ]
              ),
            )
            ),
          ],),
          Row(children: [
            Container(
              margin:EdgeInsets.only(
        //          bottom: 4
                  bottom: screenwidth*0.0106
              ),
              child:
            Text("Subscription Date: May 03, 2021",style: TextStyle(
           //     fontSize: 14.5,
                fontSize: screenwidth*0.036,
                color: Colors.white,
                fontFamily: helveticaneueregular
            ),),),
          ],),
          Row(children: [

            Container(child:
            Text("Subscription Expiry: May 04, 2022",style: TextStyle(
          //      fontSize: 14.5,
                fontSize: screenwidth*0.036,
                color: Colors.white,
                fontFamily: helveticaneueregular
            ),),),
          ],)
        ],
      ),)
    ],
    )
  ],),
),
              Container(
                margin: EdgeInsets.symmetric(
//      vertical: 28
                    vertical: screenwidth*0.0746
                ),
                padding: EdgeInsets.all(
//      16
                    screenwidth*0.0426
                ),
                height: screenwidth*0.586,
                width: screenwidth,
                decoration: BoxDecoration(
                  boxShadow: [BoxShadow(color: Color(0xff32386a).withOpacity(0.29),offset: Offset(0,6),
                      blurRadius: 30
                  )],
                  color: Color(0xff9797de),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: Stack(children: [
                  Positioned(
                    bottom:0,right: 0,
                    child: SvgPicture.asset("assets/images/white_logo.svg",width: screenwidth*0.2773,
                      color: Colors.white.withOpacity(0.15),),
                  ),
                  Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(child: Text("Good Vibes Premium",style: TextStyle(
                              fontFamily: helveticaneuemedium,
                              color: Colors.white,
                              //      fontSize: 17
                              fontSize: screenwidth*0.04533
                          ),),),
                          Container(child: Text("CURRENT PLAN",style: TextStyle(
                              fontFamily: helveticaneueregular,
                              color: Colors.white60,
                              //       fontSize: 9.5
                              fontSize: screenwidth*0.0253
                          ),),),
                        ],
                      ),
                      Container(child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(              margin:EdgeInsets.only(
                                //          bottom: 4
                                  bottom: screenwidth*0.0106
                              ),
                                child:
                                Text("Subscription Type: Yearly",style: TextStyle(
                                  //         fontSize: 13.5,
                                    fontSize: screenwidth*0.036,
                                    color: Colors.white,
                                    fontFamily: helveticaneueregular
                                ),),),
                            ],
                          ),
                          Row(children: [
                            Container(
                                margin:EdgeInsets.only(
                                  //           bottom: 4
                                    bottom: screenwidth*0.0106
                                ),
                                child:
                                RichText(
                                  text: TextSpan(
                                      style:   TextStyle(
                                        //           fontSize: 14.5,
                                          fontSize: screenwidth*0.036,
                                          color: Colors.white,
                                          fontFamily: helveticaneueregular
                                      ),
                                      children: [
                                        TextSpan(
                                            text: "Status:"
                                        ),
                                        TextSpan(
                                            text: " Active",style: TextStyle(
                                          fontFamily: helveticaneuemedium,
                                          //      fontSize: 14.5,
                                          fontSize: screenwidth*0.036,
                                          color: Colors.white,
                                        )
                                        ),
                                      ]
                                  ),
                                )
                            ),
                          ],),
                          Row(children: [
                            Container(
                              margin:EdgeInsets.only(
                                //          bottom: 4
                                  bottom: screenwidth*0.0106
                              ),
                              child:
                              Text("Subscription Date: May 03, 2021",style: TextStyle(
                                //     fontSize: 14.5,
                                  fontSize: screenwidth*0.036,
                                  color: Colors.white,
                                  fontFamily: helveticaneueregular
                              ),),),
                          ],),
                          Row(children: [

                            Container(child:
                            Text("Subscription Expiry: May 04, 2022",style: TextStyle(
                              //      fontSize: 14.5,
                                fontSize: screenwidth*0.036,
                                color: Colors.white,
                                fontFamily: helveticaneueregular
                            ),),),
                          ],),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                     //               top: 20
                       top: screenwidth*0.0533         ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.all(Radius.circular(
                                  //    4
                                  screenwidth*0.0106
                                  )),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(sigmaX: 30,sigmaY: 30,),
                                    child: Container(
                                      height: screenwidth*0.096,
                                      width: screenwidth*0.376,
                                      decoration: BoxDecoration(
                                        color:Colors.white.withOpacity(0.2),
                                        borderRadius: BorderRadius.all(Radius.circular(4))
                                      ),
                                      child: Center(
                                        child: Text("Renew Plan",style: TextStyle(
                                          fontFamily: helveticaneuemedium,
                                          color: Colors.white,
                                          fontSize: screenwidth*0.04
                                        ),),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )


                        ],
                      ),)
                    ],
                  )
                ],),
              ),
      ],
    ),
  )),
),

    );
  }
  Widget freeplan(BuildContext context){
    double screenheight=MediaQuery.of(context).size.height;
    double screenwidth=MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(
  //        horizontal: 26
    horizontal: screenwidth*0.0693
      ),
      key: UniqueKey(),
      child:
      Column(mainAxisAlignment: MainAxisAlignment.start,
      children: [
       Container(
              padding: EdgeInsets.symmetric(
          //        horizontal: 18
            horizontal: screenwidth*0.048
              ),
          width: screenwidth,
         margin: EdgeInsets.only(
     //        top: 22
       top: screenwidth*0.0586  ),

         height: screenwidth*0.1306,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: Color(0xff9797de),
          ),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(child: Text("Good Vibes Free",style: TextStyle(
                  fontFamily: helveticaneuemedium,
                  color: Colors.white,
                  fontSize: screenwidth*0.036
                ),),),
                Container(child: Text("CURRENT PLAN",style: TextStyle(
                    fontFamily: helveticaneueregular,
                    color: Colors.white70,
                    fontSize: screenwidth*0.0253
                ),),),
              ],
              ),
        ),
        Container(
          margin: EdgeInsets.symmetric(
     //         vertical: 18
       vertical: screenwidth*0.048   ),
          child: Row(mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              child: Text("Upgrade Now!",style: TextStyle(fontFamily: helveticaneuemedium,
              color: Colors.black87,
         //     fontSize: 17
           fontSize: screenwidth*0.0453   ),),
            )
          ],
          ),
        ),
        ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            child:
            Container(
//          color: Colors.black87,

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
                                  height: screenwidth*0.1813,width: screenwidth*0.1813,
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
                                  left: screenwidth*0.0586
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
                                    top: screenwidth*0.032
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
                              alignment: new Alignment(-screenheight*screenwidth*0.00079,0),
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
                            height: screenwidth*0.064,
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

      ],
      ),);
  }

}
