import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:goodvibesoffl/constants/fontconstants.dart';
class UpdateAvailable extends StatefulWidget {
  @override
  _UpdateAvailableState createState() => _UpdateAvailableState();
}

class _UpdateAvailableState extends State<UpdateAvailable> {
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

    return  Stack(children:[
      Image.asset('assets/images/X - 1@2x.png',fit: BoxFit.cover,
        width: screenheight,
      ),
      Scaffold(
        backgroundColor: Colors.black38,
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
                    color: Colors.white
                ),
                children: [
                  TextSpan(text: "By "),
                  TextSpan(text: "ClickandPress",style:TextStyle(
                      fontSize: screenwidth*0.042,
                      fontFamily: helveticaneueregular,
                      color: Colors.white
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
            height: screenwidth*1.2,
            width: screenwidth*0.805,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8))
            ),
            child: Column(
              children: [

                Image.asset("assets/images/Saly-1@3x.png",width: screenwidth*0.7146,),
                Container(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          margin: EdgeInsets.only(
                            //       top: 22
                        //      top: screenwidth*0.028
                          ),
                          child:
                          Text("Update Available!",style: TextStyle(
                              fontFamily: helveticaneuemedium,
                              color: Colors.black87,
                              fontSize: screenwidth*0.05333
                          ),)),
                      Container(
                          margin: EdgeInsets.only(
                            //       top: 16
                              top: screenwidth*0.04266
                          ),
                          child:
                              RichText(
textAlign: TextAlign.center,
    text: TextSpan(
        style: TextStyle(
            fontFamily: helveticaneueregular,
            color: Colors.black87,
            fontSize: screenwidth*0.032
        ),
    children: [
      TextSpan(
    text: "There is a newer version of the app available.\n"
    ),
    TextSpan( text:"Please update our"),
    TextSpan(text:" Good Vibes ",style: TextStyle(
    fontFamily: helveticaneuemedium,
    color: Colors.black87,
   fontSize: screenwidth*0.032
    ))
    , TextSpan( text:"app to\nimprove our experience"),
    ]
    ),
    )),

                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    //         left: 17,right: 17,
                      left: screenwidth*0.0453,right: screenwidth*0.0453,
                      //    top: 39
             //         top: screenwidth*0.104
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [


                    ],
                  ),
                ),
                GestureDetector(
                    onTap: () async{
                    },
                    child:
                    Container(
                      margin: EdgeInsets.only(
                        //  top: 45
                          top:26,
                      ),
                      height: screenwidth * 0.101,
                      width: screenwidth * 0.80,
                      //  height: 44,
                      //      width: 312,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30),
                        ),
                        color:

                        Color(0xff9797de),
                      ),
                      child: Center(
                        child: Text(
                          'Update Now', style: TextStyle(
                            fontFamily: helveticaneueregular,
                            color: Colors.white,
                            //        fontSize: 16
                            fontSize: screenwidth * 0.0426
                        ),
                        ),
                      ),
                    )),
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

                  color: Color(0xff9797de),)

            ),)]),),

      )]);
  }
}
