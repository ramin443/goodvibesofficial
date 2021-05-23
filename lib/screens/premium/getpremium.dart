import 'dart:io';
import 'dart:ui';

import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:goodvibesoffl/constants/fontconstants.dart';
import 'package:goodvibesoffl/screens/premium/subscription_detail.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';
class GetPremium extends StatefulWidget {
  @override
  _GetPremiumState createState() => _GetPremiumState();
}

class _GetPremiumState extends State<GetPremium> {
  WebViewController _controller;
bool showtick=false;
bool monthtick=false;
  emptycode(){

  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    double screenwidth=MediaQuery.of(context).size.width;
    double screenheight=MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Image.asset('assets/images/X - 1@2x.png',fit: BoxFit.cover,
          width: screenheight,
        ),
        Positioned(
          // top: 97,
            top: screenwidth*0.2586,
            child: Image.asset("assets/images/dotted line@3x.png",width: screenwidth,
            color:Color(0xff9797de) ,)),
        Scaffold(

          backgroundColor: Colors.transparent,
          body:SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                padding: EdgeInsets.only(
                    //bottom: 87
               bottom: screenwidth*0.232
                ),
            width: screenwidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                        AppBar(
    backgroundColor: Colors.transparent,
                          elevation: 0,
                          leading:          IconButton(
                            icon: Icon(CupertinoIcons.xmark_circle,
                              color: Colors.black87,
                              //  size: 24,
                              size: screenwidth*0.086
                              ,
                            ),
                            onPressed: (){
                              Navigator.pop(context);
                            },
                          ),
    ),
                Container(
            margin:EdgeInsets.only(
   //             top: 65
   //  top: screenwidth*0.173
            ),
            child:
              ClipRect(
                  child:
        BackdropFilter(
            filter:ImageFilter.blur(sigmaY: 25,sigmaX: 25),
            child:
              Container(
    //            height: 114,
      //          width: 114,
        height: screenwidth*0.304,width: screenwidth*0.304,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white70,
                  shape: BoxShape.circle
                ),
                child: Image.asset("assets/images/diamond@3x.png",),
              )))),
Container(
  margin:EdgeInsets.only(top: screenwidth*0.0426),child: Text("Get Premium",style: TextStyle(
  fontFamily: helveticaneuemedium,
  color: Color(0xff9797de),
  fontSize: screenwidth*0.06466
),),),
                Container(
                  margin:EdgeInsets.only(
                      top: screenwidth*0.0426
                  ),child: Text("Try Premium For 7 Days Free",style: TextStyle(
                    fontFamily: helveticaneuemedium,
                    color: Colors.black87,
                    fontSize: screenwidth*0.0453
                ),),),
Container(
  //height:132
  height: screenwidth*0.42,
  margin: EdgeInsets.only(
      top: screenwidth*0.02,
  left: screenwidth*0.0466,right: screenwidth*0.0466
  ),
  child: ListView(
    scrollDirection: Axis.vertical,
    physics: NeverScrollableScrollPhysics(),
    children: [
      Container(child:
      Row(
        mainAxisAlignment:MainAxisAlignment.start
        ,children: [
        Container(
child: Icon(FeatherIcons.check,
color: Color(0xff9797de),
//size: 20,
size: screenwidth*0.0533,
),
        ),
        Container(
          margin: EdgeInsets.only(
      //        left: 11.5
        left: screenwidth*0.0306
          ),
          child: Text("Uninterrupted ad free listening",
          style: TextStyle(
            fontFamily: helveticaneueregular,
            color: Colors.black87,
      //      fontSize: 15
        fontSize: screenwidth*0.04
          ),)
        ),
      ],)),
      Container(
          margin: EdgeInsets.symmetric(
      //        vertical: 16
        vertical: screenwidth*0.0426  ),
          child:
      Row(
        mainAxisAlignment:MainAxisAlignment.start
        ,children: [
        Container(
          child: Icon(FeatherIcons.check,
            color: Color(0xff9797de),
       //     size: 20,
         size: screenwidth*0.0533,
          ),
        ),
        Container(
            margin: EdgeInsets.only(
        //        left: 11.5
                left: screenwidth*0.0306
            ),
            child: Text("Save Tracks offline",
              style: TextStyle(
                  fontFamily: helveticaneueregular,
                  color: Colors.black87,
          //        fontSize: 15
                  fontSize: screenwidth*0.04
              ),)
        ),
      ],)),
      Container(
          child:
      Row(
        mainAxisAlignment:MainAxisAlignment.start
        ,children: [
        Container(
          child: Icon(FeatherIcons.check,
            color: Color(0xff9797de),
     //       size: 20,
              size: screenwidth*0.0533,
          ),
        ),
        Container(
            margin: EdgeInsets.only(
       //         left: 11.5
                left: screenwidth*0.0306
            ),
            child: Text("Create your own custom playlist",
              style: TextStyle(
                  fontFamily: helveticaneueregular,
                  color: Colors.black87,
             //     fontSize: 15
                  fontSize: screenwidth*0.04
              ),)
        ),
      ],)),
      Container(
          margin: EdgeInsets.symmetric(vertical: 16),
          child:
      Row(
        mainAxisAlignment:MainAxisAlignment.start
        ,children: [
        Container(
          child: Icon(FeatherIcons.check,
            color: Color(0xff9797de),
       //     size: 20,
              size: screenwidth*0.0533,
          ),
        ),
        Container(
            margin: EdgeInsets.only(
        //        left: 11.5
                left: screenwidth*0.0306
            ),
            child:
            RichText(
            text: TextSpan(
            style: TextStyle(
    fontFamily: helveticaneueregular,
    color: Colors.black87,
  //  fontSize: 15
                fontSize: screenwidth*0.04
            ),
            children: [
              TextSpan(
    text: "Unlock the full"
    ),
    TextSpan(
    text: " Good Vibes ",style: TextStyle(
    fontFamily: helveticaneuemedium,
    color: Colors.black87,
   // fontSize: 15
        fontSize: screenwidth*0.04
    )
    ),
    TextSpan(
    text: "experience"
    ),
    ]
            ),
            )
        ),
      ],)),
    ],
  ),
),
Container(
  margin: EdgeInsets.only(top: screenwidth*0.0293),
  height: screenwidth*0.0853,
  width: screenwidth*0.389,
  decoration: BoxDecoration(
    color: Color(0xff9797de),
    borderRadius: BorderRadius.all(Radius.circular(4)),
  ),
  child: Center(
    child: Text("Get Premium",style: TextStyle(
      fontFamily: helveticaneueregular,
      color: Colors.white,
      fontSize: screenwidth*0.03333
    ),),
  ),
),
                Container(
                  margin: EdgeInsets.only(
             //         top:5
               top: screenwidth*0.0133
                  ),
                  child: Center(
                    child: Text("Get Promo Code",
                      style: TextStyle(
decoration: TextDecoration.underline,
                          fontFamily: helveticaneueregular,
                        color: Color(0xff9797de),
                        fontSize: screenwidth*0.0273
                    ),),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    //         top:5
                      top: screenwidth*0.0133
                  ),
                  child: Center(
                    child:
                    RichText(
                  textAlign: TextAlign.center,
    text: TextSpan(
    style: TextStyle(
      letterSpacing:0.1,
    fontFamily: helveticaneueregular,
    color: Colors.black87,
    fontSize: screenwidth*0.0273
    ),
    children:[
      TextSpan(text:"Only 1.99/ month. Offer only for people new to Premium. "),
    TextSpan(text: "Terms apply. ", style: TextStyle(
    fontFamily: helveticaneuemedium,
    color: Colors.black87,
    fontSize: screenwidth*0.0273
    ), )
    ]
    ),
                  )

                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>
                    SubscriptionDetail()));
                  },
                  child:
                Container(
                  padding: EdgeInsets.symmetric(horizontal: screenwidth*0.0533),
                  margin: EdgeInsets.only(top: screenwidth*0.04266),
                  height: screenwidth*0.1306,
                  width: screenwidth*0.914,
                  decoration: BoxDecoration(
                    color: Color(0xff9797de),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:[
                      Text("Good Vibes Free",style: TextStyle(
                        fontFamily: helveticaneuemedium,
                        color: Colors.white,
                        fontSize: screenwidth*0.04
                    ),),
                      Text("CURRENT PLAN",style: TextStyle(
                          fontFamily: helveticaneueregular,
                          color: Colors.white,
                          fontSize: screenwidth*.0266
                      ),),]
                  ),
                ),),
Container(
  height:screenwidth*0.474 ,
width: screenwidth,
  margin: EdgeInsets.only(top: screenwidth*0.0853),
  child:
  Stack(children:[
  Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    ClipRRect(
      borderRadius:BorderRadius.all(Radius.circular(8)),
    child:
        GestureDetector(
            onTap:(){
              setState(() {
                showtick=!showtick;
              });
    },
            child:
    Container(
      padding: EdgeInsets.all(14),
      height:screenwidth*0.474 ,
      width: screenwidth*0.442,
      decoration: BoxDecoration(
          borderRadius:BorderRadius.all(Radius.circular(8)),
          image: DecorationImage(
          image: AssetImage(
            "assets/images/premiumyearly.png"
          )
        )
      ),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(children:[
          Container(
            margin: EdgeInsets.only(
      //          top: 6
        top: screenwidth*0.016
            ),
            child: Text("Yearly",style: TextStyle(
              fontFamily: helveticaneuemedium,
              color: Colors.black87,
              fontSize: screenwidth*0.05466
          ),),),
            Container(
              margin: EdgeInsets.only(top:  screenwidth*0.016),
              child: Text("Save Upto 40%",style: TextStyle(
                  fontFamily: helveticaneueregular,
                  color: Colors.black38,
                  fontSize: screenwidth*0.02466
              ),),),]),
            Column(children:[
    AnimatedSwitcher(
    duration: Duration(milliseconds: 320),
    child:
    showtick?
            Container(
              margin: EdgeInsets.only(
         //         top: 13
           top: screenwidth*0.0346
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    Container(
        //              height: 40,
          //      width: 40,
           height:screenwidth*0.106,width: screenwidth*0.106,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xff9797de)
                ),
                child:
                    Center(child:

              Icon(
                FeatherIcons.check,
           //     size: 28,
             size: screenwidth*0.0746,
                color: Colors.white,
              ))),
              ])
            ):SizedBox(height: 0,)),
            Row(
                mainAxisAlignment:MainAxisAlignment.center,children:[
            Container(
              margin: EdgeInsets.only(
           //       top: 15
             top: screenwidth*0.04
              ),
              height: screenwidth*0.0853,
              width: screenwidth*0.32,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                color: Color(0xff9797de)
              ),
              child: Center(child: Text("Get Premium",style: TextStyle(
                fontFamily: helveticaneuemedium,
                color: Colors.white,
                fontSize: screenwidth*0.0293
              ),),),
            )])])
        ],),
      ),
    ))),
    ClipRRect(
        borderRadius:BorderRadius.all(Radius.circular(8)),
        child:
        GestureDetector(
            onTap:(){
              setState(() {
                monthtick=!monthtick;
              });
            },
            child:
        Container(
          padding: EdgeInsets.all(14),
          height:screenwidth*0.474 ,
          width: screenwidth*0.442,
          decoration: BoxDecoration(
              borderRadius:BorderRadius.all(Radius.circular(8)),
              image: DecorationImage(
                  image: AssetImage(
                      "assets/images/monthlypricetag.png"
                  )
              )
          ),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 6),
                  child: Text("Monthly",style: TextStyle(
                      fontFamily: helveticaneuemedium,
                      color: Colors.black87,
                      fontSize: screenwidth*0.05466
                  ),),),
Column(children:[
                Container(
                    margin: EdgeInsets.only(top:  screenwidth*0.0346),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:[
    AnimatedSwitcher(
    duration: Duration(milliseconds: 320),
    child:
    monthtick?
                          Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xff9797de)
                              ),
                              child:
                              Center(child:
                              Icon(
                                FeatherIcons.check,
                                size: screenwidth*0.0746,
                                color: Colors.white,
                              ))):SizedBox(height: 0,)),
                        ])
                ),
                Row(
                    mainAxisAlignment:MainAxisAlignment.center,children:[
                  Container(
                    margin: EdgeInsets.only(
                 //       top: 15
                        top: screenwidth*0.04
                    ),
                    height: screenwidth*0.0853,
                    width: screenwidth*0.32,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        color: Color(0xff9797de)
                    ),
                    child: Center(child: Text("Get Premium",style: TextStyle(
                        fontFamily: helveticaneuemedium,
                        color: Colors.white,
                        fontSize: screenwidth*0.0293
                    ),),),
                  )])
  ])
              ],),
          ),
        ))),
  ],),
  Positioned(
    left: screenwidth*0.3655,
    right: screenwidth*0.3655,
    bottom: 2,
child: SvgPicture.asset('assets/images/white_logo.svg',
width: screenwidth*0.2693,
color: Color(0xff9797de).withOpacity(0.2),),
  )
  ])
),
                Container(
                  margin: EdgeInsets.only(
             //       top: 26
               top: screenwidth*0.06933
                  ),
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      Text("Recurring Bill. Cancel Anytime",style: TextStyle(
                        fontFamily: helveticaneueregular,
                        color: Colors.black87,
                        fontSize: screenwidth*0.0293
                      ),)
                    ],),
                    Container(
                        margin: EdgeInsets.only(
                    //        top: 8
                      top: screenwidth*0.0213
                        ),
                        child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Restore Purchase",style: TextStyle(
                            fontFamily: helveticaneuemedium,
                            decoration: TextDecoration.underline,
                            color: Colors.black87,
                            fontSize: screenwidth*0.0293
                        ),)
                      ],)),
Container(
  margin: EdgeInsets.symmetric(
 //     vertical: 22
  vertical: screenwidth*0.0586
  ),
  child: Text("Your payment will be charged to your Google Play Store Account at regular price\n"
      "after trial or introductory period ends. Your Google Play Store account will be\n"
      "charged again when your subscription automatically renews at the end of your\n"
      "current subscription period unless auto-renew is turned off at least 24 hours prior to\n"
      "end of the current period.",
    textAlign:TextAlign.center,style: TextStyle(
    fontFamily: helveticaneueregular,
    color: Colors.black87,
 //   fontSize: 9
  fontSize: screenwidth*0.024
    ),),
),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: screenwidth*0.217),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Builder(
                              builder: (context) =>
                                  GestureDetector(
                                      onTap:(){
                                        Scaffold.of(context).showBottomSheet((context) =>
                                            ClipRRect(
                                                borderRadius: (BorderRadius.only(topLeft:Radius.circular(12),topRight: Radius.circular(9))),
                                                child:
                                                Container(
                                                    height:screenheight*0.9,
                                                    decoration: BoxDecoration(
                                                      borderRadius: (BorderRadius.only(topLeft:Radius.circular(12),topRight: Radius.circular(9))),
                                                    ),
                                                    child:

                                                    WebView(
                                                      initialUrl: 'https://goodvibesofficial.com/privacy-policy/',
                                                      javascriptMode: JavascriptMode.unrestricted,
                                                      gestureNavigationEnabled: true,

                                                      onProgress: (v){},
                                                      onWebViewCreated: (WebViewController webViewController) {
                                                        _controller = webViewController;
                                                      },
                                                    ))));

                                      },
                                      child:
                                      Container(
                                        child: Text("Privacy Policy",style: TextStyle(
                                            fontFamily: helveticaneuemedium,
                                            color: Colors.black87,
                                            fontSize: screenwidth*0.033
                                        ),),
                                      ))),
    Builder(
    builder: (context) =>
    GestureDetector(
    onTap:(){
      Scaffold.of(context).showBottomSheet(
              (context) =>
      ClipRRect(
          borderRadius: (BorderRadius.only(topLeft:Radius.circular(12),topRight: Radius.circular(9))),
          child:
              SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  child:

          Container(
          height:screenheight*0.9,
          decoration: BoxDecoration(
            borderRadius: (BorderRadius.only(topLeft:Radius.circular(12),topRight: Radius.circular(9))),
          ),
          child:

          WebView(
            initialUrl: 'https://goodvibesofficial.com/terms-and-conditions/',
            javascriptMode: JavascriptMode.unrestricted,
            gestureNavigationEnabled: true,
onPageStarted: (v){},
            onPageFinished: (n){},
            allowsInlineMediaPlayback: true,
            debuggingEnabled: true,
            onProgress: (v){},
            onWebViewCreated: (WebViewController webViewController) {
              _controller = webViewController;
            },
          )))));

    },
    child:
                          Container(
                            child: Text("Terms Of Use",style: TextStyle(
                                fontFamily: helveticaneuemedium,
                                color: Colors.black87,
                                fontSize: screenwidth*0.033
                            ),),
                          ))),
                        ],
                      ),
                    ),

                  ],),)

            ],),
          )),

        )
      ],
    );
  }
}
