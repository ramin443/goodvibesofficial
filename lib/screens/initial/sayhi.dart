import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goodvibesoffl/constants/fontconstants.dart';
import 'package:goodvibesoffl/screens/auth/login.dart';
import 'package:swipedetector/swipedetector.dart';

class SayHi extends StatefulWidget {
  @override
  _SayHiState createState() => _SayHiState();
}

class _SayHiState extends State<SayHi> {
  bool switchpages = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    double screenheight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;
    double screenarea = screenheight * screenwidth;
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
        ),
        Image.asset(
          'assets/images/background_latest@2x.png',
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
        ),
        Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Container(
//  color: Colors.white38,
//  width: 70,
              width: screenwidth * 0.186,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AnimatedContainer(
                    duration: Duration(milliseconds: 180),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    //  height: 5,
                    height: screenheight * 0.00749,
                    width: switchpages ? 14 : 36,
                  ),
                  AnimatedContainer(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    //    margin: EdgeInsets.only(right: 8),
                    duration: Duration(milliseconds: 225),
                    //    height: 5,
                    height: screenheight * 0.00749,
                    width: switchpages ? 36 : 14,
                  ),
                ],
              ),
            ),
            bottomNavigationBar: Container(
//  height: 50,
              height: screenheight * 0.0749,
              width: screenwidth,
              margin: EdgeInsets.only(
                  bottom: screenwidth * 0.1,
                  left: screenwidth * 0.1,
                  right: screenwidth * 0.1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      },
                      child: Container(
                        child: Text(
                          "Skip",
                          style: TextStyle(
                              fontFamily: helveticaneueregular,
                              color: Colors.white54,
                              //   fontSize: 16
                              fontSize: screenwidth * 0.0426),
                        ),
                      )),
                  GestureDetector(
                      onTap: () {
                        switchpages ? tointro() : switchpage();
                      },
                      child: Container(
                          child: Row(children: [
                        Container(
                            child: Text(
                          "Next",
                          style: TextStyle(
                              fontFamily: helveticaneueregular,
                              color: Colors.white,
                              //    fontSize: 16
                              fontSize: screenwidth * 0.0426),
                        )),
                        Container(
                            margin: EdgeInsets.only(
                                //     left: 4
                                left: screenarea * 0.0000159),
                            child: Icon(Icons.arrow_forward,
                                color: Colors.white,
                                //      size: 16,
                                size: screenwidth * 0.0426)),
                      ]))),
                ],
              ),
            ),
            backgroundColor: Colors.transparent,
            appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.transparent,
                elevation: 0,
                centerTitle: false,
                title: Row(
                    //  mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            //                 right: 7
                            right: screenarea * 0.0000279),
                        child: SvgPicture.asset(
                          'assets/images/white_logo.svg', fit: BoxFit.cover,
                          color: Color(0xff9797de),
//width: 30,
                          width: screenwidth * 0.08,
//  width: screenwidth*0.128,
                        ),
                      ),
                      SvgPicture.asset(
                        'assets/images/logo 2.svg', fit: BoxFit.cover,
                        //        height: double.infinity,
                        //  width:screenheight*screenwidth*0.000435,
                        width: screenwidth * 0.290,
                        color: Color(0xff9797de),
                        //         alignment: Alignment.center,
                      ),
                    ])),
            body: SwipeDetector(
                onSwipeLeft: () {
                  setState(() {
                    switchpages = !switchpages;
                  });
                },
                onSwipeRight: () {
                  setState(() {
                    switchpages = !switchpages;
                  });
                },
                child: Center(
                    child: AnimatedSwitcher(
                  child: switchpages ? secondone() : firstone(),
                  duration: Duration(milliseconds: 225),
                ))))
      ],
    );
  }

  Widget secondone() {
    double screenheight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;
    double screenarea = screenheight * screenwidth;
    return Container(
      key: UniqueKey(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.only(
                //      top:125,
                //      left: 45,right: 45
                //    left:screenarea*0.000199,right:screenarea*0.000199,
                left: screenwidth * 0.12,
                right: screenwidth * 0.12),
            child: Image.asset(
              "assets/images/casual-life-theotherone.png",
              fit: BoxFit.cover,
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                //     top: 40
                top: screenarea * 0.000159),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Text(
                    "Save your favorites",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: helveticaneuemedium,
                        color: Colors.white,
                        //        fontSize: 22
                        fontSize: screenwidth * 0.0586),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      //               top: 18
                      top: screenarea * 0.0000719),
                  child: Text(
                    "Save your favorite tracks as well as create\n"
                    "custom playlist. Get reminders and set\n"
                    "tracks to reduce stress, anxiety, stay calm,\n"
                    "daily goals to stay consistent and mindful.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        letterSpacing: 0.1,
                        fontFamily: helveticaneueregular,
                        color: Colors.white,
                        //     fontSize: 15
                        fontSize: screenwidth * 0.04),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget firstone() {
    double screenheight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;
    double screenarea = screenheight * screenwidth;
    return Container(
      key: UniqueKey(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.only(
                //     top:25,
                //    left: 45,right: 45
                left: screenwidth * 0.12,
                right: screenwidth * 0.12),
            child: Image.asset(
              "assets/images/casual-life-3d-meditation-1@3x.png",
              fit: BoxFit.cover,
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                //    top: 40
                top: screenarea * 0.000159),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap: () async {},
                    child: Container(
                      child: Text(
                        "Say Hi To Your\nSelf-Care Journal",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: helveticaneuemedium,
                            color: Colors.white,
                            //           fontSize: 22
                            fontSize: screenwidth * 0.0586),
                      ),
                    )),
                Container(
                  margin: EdgeInsets.only(
                      //          top: 18
                      top: screenarea * 0.0000719),
                  child: Text(
                    "Meditation is the key to happiness,\n"
                    "productivity, and longevity. Find thousands of\n"
                    "tracks to reduce stress, anxiety, stay calm,\n"
                    "sleep better, and meditate",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        letterSpacing: 0.1,
                        fontFamily: helveticaneueregular,
                        color: Colors.white,
                        //              fontSize: 15
                        fontSize: screenwidth * 0.04),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  tointro() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
  }

  switchpage() {
    setState(() {
      switchpages = true;
    });
  }

  Route _createLoginRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => Login(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
