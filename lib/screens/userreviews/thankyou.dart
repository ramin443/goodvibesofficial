import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:goodvibesoffl/constants/fontconstants.dart';
class ThankYou extends StatefulWidget {
  @override
  _ThankYouState createState() => _ThankYouState();
}

class _ThankYouState extends State<ThankYou> {

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
    double screenarea=screenheight*screenwidth;

    return    Stack(children:[
      Image.asset('assets/images/X - 1@2x.png',fit: BoxFit.cover,
        width: screenheight,
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        bottomNavigationBar: Container(
          //  height: 60,
          height: screenwidth*0.16,
          color: Colors.transparent,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton:   RichText(
            text:TextSpan(
                style: TextStyle(
                    fontSize: screenwidth*0.048,
                    fontFamily: helveticaneuemedium,
                    color: Color(0xff32386A)
                ),
                children: [
                  TextSpan(text: "By "),
                  TextSpan(text: "ClickandPress",style:TextStyle(
                      fontSize: screenwidth*0.042,
                      fontFamily: helveticaneueregular,
                      color: Color(0xff32386A)
                  ), )
                ]
            )
        ),
        body: Center(child:
        Stack(children:[
        Container(
          margin: EdgeInsets.only(
            //     bottom: 50
          ),
          padding: EdgeInsets.all(22),
          height: screenwidth*1.1,
          width: screenwidth*0.805,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8))
          ),
          child: Column(
            children: [

              Image.asset("assets/images/casual-life-3d-meditation-1@3x.png",width: screenwidth*0.6293,),
              Container(
                child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        margin: EdgeInsets.only(
                          //       top: 22
                            top: screenwidth*0.058
                        ),
                        child:
                        Text("Thank You For Rating Us!",style: TextStyle(
                            fontFamily: helveticaneuemedium,
                            color: Colors.black87,
                            fontSize: screenwidth*0.0453
                        ),)),
                    Container(
                        margin: EdgeInsets.only(
                          //       top: 16
                            top: screenwidth*0.04266
                        ),
                        child:
                        Text( Platform.isIOS?
                        "Review us on app store?":
                        "Review us on play store?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: helveticaneueregular,
                              color: Colors.black54,
                              fontSize: screenwidth*0.029
                          ),)),

                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  //         left: 17,right: 17,
                    left: screenwidth*0.0453,right: screenwidth*0.0453,
                    //    top: 39
                    top: screenwidth*0.104
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
Image.asset("assets/images/downloadonappstore.png",height: 30,),
                    Image.asset("assets/images/google-play-badge@3x.png",height: 30,),

                  ],
                ),
              )
            ],
          ),
        ),
          Positioned(
            right: 0,top: 0,
            child:  IconButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                icon:Icon( CupertinoIcons.xmark_circle,
                  //    size: 30,
                  size: screenwidth*0.08,

                  color: Colors.black45,)

            ),)]),),

      )]);
  }
}
