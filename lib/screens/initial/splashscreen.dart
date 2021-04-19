
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as Svgprovider;
import 'package:goodvibesofficial/constants/fontconstants.dart';
import 'package:goodvibesofficial/constants/styleconstants.dart';
import 'package:goodvibesofficial/example%20page.dart';
import 'package:goodvibesofficial/screens/initial/intropage.dart';
import 'package:goodvibesofficial/screens/initial/sayhi.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:simple_animations/simple_animations.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  bool _isPlaying = false;
  AnimationController _scaleanimationcontroller;
  Animation<double> _pulseAnimation;
  Tween<double> _tweenSize;
  Animation<double> _animationSize;
  Animation _firstcolorTween;
  Animation _secondcolorTween;
  AnimationController _animationController;
  Color initialcolor=Color(0xff9797de);
  Color finalcolor=Color(0xff32386A);
  void animate() {
    if (_isPlaying)
      _scaleanimationcontroller.stop();
    else
      _scaleanimationcontroller.forward();

    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  @override
  void initState() {
//depolyanimation();
//Future.delayed(Duration(milliseconds: 18000),
//navigatetohomescreen);
//_animationController.addStatusListener((status) {
//  if(status==AnimationStatus.completed){
  //  _animationController.reverse();
//  }
//}
//);
//  _pulseAnimation=Tween<double>(begin: 1.0,end: 1.0).animate(CurvedAnimation(
  //    parent: _scaleanimationcontroller, curve: Curves.ease));

depolyanimation();
Future.delayed(Duration(seconds: 7),navigatetohomescreen);
    super.initState();
  }

  depolyanimation(){
    _scaleanimationcontroller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 850),);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.4).animate(
        CurvedAnimation(parent: _scaleanimationcontroller, curve: Curves.easeIn));
//    _scaleanimationcontroller.forward();
    Future.delayed(Duration(seconds: 3),(){
      _scaleanimationcontroller.forward();
    });
    _scaleanimationcontroller.addStatusListener((status) {
      if(status==AnimationStatus.dismissed){

      }
    });
  }

  navigatetohomescreen(){
    Navigator.of(context).push(_createRoute());


  }
  @override
  void dispose() {
//    _animationController.dispose();
    super.dispose();
  }
  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => SayHi(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
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
    double screenwidth=MediaQuery.of(context).size.width;
    double screenheight=MediaQuery.of(context).size.height;
double screenarea=screenheight*screenwidth;
    return
          Stack(
          children:[
      //      SvgPicture.asset('assets/images/new_gradient.svg',fit: BoxFit.cover,
        //      width: screenheight,),

     Image.asset('assets/images/X - 1@2x.png',fit: BoxFit.cover,
     width: screenheight,
     ),
      Scaffold(
      backgroundColor: Colors.transparent,
        body:Stack(children:[
          Center(child:
              PlayAnimation<Color>(
                delay: Duration(seconds: 3),
                duration: Duration(milliseconds: 850),
                  tween: ColorTween(begin: initialcolor.withOpacity(0.5),end: finalcolor), // <-- define tween
                  builder:(context,child,value){
return              ScaleTransition(
            scale: _pulseAnimation,
            child: ShaderMask(
    blendMode: BlendMode.srcATop,
    shaderCallback: (Rect bounds){
    return LinearGradient(colors: [value,initialcolor],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
//                   stops: [0.0,0.5]
    ).createShader(bounds);
    },
              child:
Hero(
  tag: 'logo',
  child:
              SvgPicture.asset('assets/images/white_logo.svg'),)
            ),
          );})),
          Column(mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          Container(
            alignment: Alignment.center,
              margin: EdgeInsets.only(bottom: ResponsiveFlutter.of(context).moderateScale(60)),
              child:
              PlayAnimation<Color>(
                tween: ColorTween(begin: Colors.transparent,end:
                Color(0xff32386a)),
    delay: Duration(seconds: 3),
    duration: Duration(milliseconds: 850),
    builder:(context,child,value){
return
  RichText(
    text:TextSpan(
      style: TextStyle(
          fontSize: screenwidth*0.048,
          fontFamily: helveticaneuemedium,
          color: value
      ),
      children: [
TextSpan(text: "By "),
        TextSpan(text: "ClickandPress",style:TextStyle(
            fontSize: screenwidth*0.042,
            fontFamily: helveticaneueregular,
            color: value
        ), )
      ]
    )
  );
    }
    )
          )    ],)
        ])

    )]);
  }

}
