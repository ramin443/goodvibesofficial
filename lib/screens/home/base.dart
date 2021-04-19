
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:goodvibesofficial/constants/fontconstants.dart';
import 'package:goodvibesofficial/screens/home/home.dart';
import 'package:goodvibesofficial/screens/home/library.dart';
import 'package:goodvibesofficial/screens/home/profile.dart';
class Base extends StatefulWidget {
  @override
  _BaseState createState() => _BaseState();
}

class _BaseState extends State<Base> {
  int currentindex=0;
List _children=[
  Home(),
  Library(),
  Profile()
];
  void onTabTapped(int index) {
    setState(() {
      currentindex = index;
    });
  }
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
    return
      
      Scaffold(

      backgroundColor: Color(0xfff5f5f5),
        body: _children[currentindex], // new

        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentindex,
          onTap: onTabTapped,
backgroundColor: Color(0xfff5f5f5),
          elevation: 0,
          items: [
            BottomNavigationBarItem(

              icon: SvgPicture.asset("assets/images/home copy.svg",
        width: 23,color: currentindex==0?Color(0xff9797de):Colors.black38,)
              ,
              title:
              Container(
                margin: EdgeInsets.only(top: 4,bottom: 2),
                child:
              Text('Home',style: TextStyle(
                fontFamily: helveticaneuemedium,
                color:
                currentindex==0?
                Color(0xff9797de):Color(0xff32386a).withOpacity(0.5)
              ),)),
            ),
            BottomNavigationBarItem(
              icon:
              SvgPicture.asset("assets/images/noun_Library_2005386.svg",
    width:23,color: currentindex==1?Color(0xff9797de):Colors.black38
    ),
              title:  Container(
                  margin: EdgeInsets.only(top: 4,bottom: 2),
                  child:
    Text('Library',style: TextStyle(
                  fontFamily: helveticaneuemedium,
                  color:
                  currentindex==1?
                  Color(0xff9797de):Color(0xff32386a).withOpacity(0.5)
              ),)),
            ),
            BottomNavigationBarItem(
                icon:   Image.asset("assets/images/profileicon.png",
    width:23,color: currentindex==2?Color(0xff9797de):Colors.black87
    ),
                title:Container(
                    margin: EdgeInsets.only(top: 4,bottom: 2),
                    child: Text('Profile',style: TextStyle(
                    fontFamily: helveticaneuemedium,
                    color:currentindex==2?
                    Color(0xff9797de):Color(0xff32386a).withOpacity(0.5)
                ),))
            )
          ],
        ),

    );
  }
}
