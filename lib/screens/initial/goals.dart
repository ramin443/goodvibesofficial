import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:goodvibesofficial/constants/fontconstants.dart';
import 'package:goodvibesofficial/constants/styleconstants.dart';
import 'package:goodvibesofficial/screens/home/base.dart';
import 'package:goodvibesofficial/screens/initial/intropage.dart';
class Goals extends StatefulWidget {
  @override
  _GoalsState createState() => _GoalsState();
}

class _GoalsState extends State<Goals> {
  bool iszero=true;
bool sleep=false;
bool meditate=false;
bool anxiety=false;
bool lofi=false;
bool stress=false;
bool binaurial=false;
bool calm=false;
bool nature=false;
bool instruments=false;
bool rain=false;
countchecker(){
  if(sleep==true){
    return true;
  }
  if(meditate==true){
    return true;
  }  if(anxiety==true){
    return true;
  }  if(lofi==true){
    return true;
  }  if(stress==true){
    return true;
  }  if(binaurial==true){
    return true;
  }  if(calm==true){
    return true;
  }  if(nature==true){
    return true;
  }
  if(instruments==true){
    return true;
  }if(rain==true){
    return true;
  }
  else{
    return false;
  }
}
emptycode(){

}
  @override
  Widget build(BuildContext context) {
    Platform.isAndroid?
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Color(0xfff5f5f5),
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Color(0xfff5f5f5),
        systemNavigationBarIconBrightness: Brightness.dark
    )):emptycode();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    double screenheight=MediaQuery.of(context).size.height;
    double screenwidth=MediaQuery.of(context).size.width;
    double screenarea=screenheight*screenwidth;
    return Stack(children: [
      Image.asset('assets/images/goalsbg.png',  fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,),
      Scaffold(
        backgroundColor: Colors.transparent,
        body:
        SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child:
        Container(
          alignment: Alignment.center,
          height: screenheight,
          width: screenwidth,
color: Colors.transparent,
        child: Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(children: [
              Container(margin:EdgeInsets.only(
              //    left: 36
                left: screenarea*0.0001439
              ),
                  child:
                  ClipOval(
                    child: Container(
                      //     margin: EdgeInsets.only(left: 36),
                //      height:80 ,
                  //    width: 80,
                      height: screenheight*0.119,
                      width: screenheight*0.119,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.20),
                      ),
                      alignment: Alignment.center,
                      child: Center(child:
                      SvgPicture.asset('assets/images/white_logo.svg',
                      //  width: 32,
                      width: screenwidth*0.0853,
                      ),
                      ),
                    ),
                  ))
            ],),Row(
                children:[
                  Container(
                    margin: EdgeInsets.only(
                //        top: 32,
                  top: screenarea*0.000127,
                      //  bottom: 8,
                      bottom:  screenarea*0.0000319
                        ,
                        left: screenarea*0.0001439
                      //left: 36
                    ),
                    child: Text('What brings you to\nGood Vibes',style: TextStyle(
                        fontFamily: helveticaneuemedium,
                        color: Colors.white,
               //         fontSize: 28
                 fontSize: screenwidth*0.0746
                    ),
                    ),
                  )]),
            Row(children:[
              Container(
                margin: EdgeInsets.only(
                 //   left: 36
                left: screenarea*0.0001439
                ),
                child:
                Text('This will help us personalize our\nrecommendations for you',style: TextStyle(
                    fontFamily: helveticaneueregular,
                    color: Colors.white.withOpacity(0.42),
                 //   fontSize: 15
                fontSize: screenwidth*0.04
                ),),),
            ]),
       Container(
         margin: EdgeInsets.only(left:screenwidth* 0.0375,right: screenwidth* 0.0375),
         child: Column(children: [

         Container(margin: EdgeInsets.only(
     //        top: 38
       top: screenarea*0.000151
         ),
         child:Row(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
children: [
  GestureDetector(
         onTap: (){
           setState(() {
             sleep=!sleep;
           });
         },
         child:
  AnimatedContainer(
  //  width: 87,
 //     height: 32,
   height: screenheight*0.0479,
      width: screenwidth*0.24,
    duration: Duration(milliseconds: 150),
    padding: EdgeInsets.all(
    //    8
    screenarea*0.0000319
    ),
    decoration: BoxDecoration(
      color: sleep?Color(0xff12c2e9):Colors.white30,
      borderRadius: BorderRadius.all(Radius.circular(24)),
    ),
    child:     Center(child:
    Text("Sleep",style: TextStyle(
      fontFamily: helveticaneueregular,
      color: Colors.white,
//      fontSize: 14
  fontSize: screenwidth*0.0373
    ),),)
  )),
          GestureDetector(
            onTap: (){
              setState(() {
                meditate=!meditate;
              });
            },
            child:
  AnimatedContainer(
 //     height: 32,
      height: screenheight*0.0479,
      width: screenwidth*0.24,
    duration: Duration(milliseconds: 150),
    padding: EdgeInsets.all(
  //      8
        screenarea*0.0000319
    ),
    decoration: BoxDecoration(
      color:meditate?Color(0xff12c2e9): Colors.white30,
      borderRadius: BorderRadius.all(Radius.circular(24)),
    ),
    child:     Center(child:
    Text("Meditate",style: TextStyle(
        fontFamily: helveticaneueregular,
        color: Colors.white,
 //       fontSize: 14
        fontSize: screenwidth*0.0373
    ),),)
  )),
          GestureDetector(
            onTap: (){
              setState(() {
                anxiety=!anxiety;
              });
            },
            child:
  AnimatedContainer(
    duration: Duration(milliseconds: 150),
 //   height: 32,
    height: screenheight*0.0479,
    width: screenwidth*0.24,
    padding: EdgeInsets.all(    screenarea*0.0000319
    ),
    decoration: BoxDecoration(
      color: anxiety?Color(0xff12c2e9):Colors.white30,
      borderRadius: BorderRadius.all(Radius.circular(24)),
    ),
    child:
    Center(child:
    Text("Anxiety",style: TextStyle(
        fontFamily: helveticaneueregular,
        color: Colors.white,
 //       fontSize: 14
        fontSize: screenwidth*0.0373
    ),)),
  )),
],
         )),
           Container(
               margin: EdgeInsets.only(
          //         top: 28,bottom: 28
            top: screenarea*0.0001119,bottom: screenarea*0.0001119
               ),
               child:
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: [
               GestureDetector(
               onTap: (){
           setState(() {
           lofi=!lofi;
           });
           },
             child:
               AnimatedContainer(
                 //  width: 87,
           //        height: 32,
                   height: screenheight*0.0479,
                   width: screenwidth*0.24,
                   duration: Duration(milliseconds: 150),
                   padding: EdgeInsets.all(    screenarea*0.0000319
                   ),
                   decoration: BoxDecoration(
                     color: lofi?Color(0xff12c2e9):Colors.white30,
                     borderRadius: BorderRadius.all(Radius.circular(24)),
                   ),
                   child:     Center(child:
                   Text("Lo-Fi",style: TextStyle(
                       fontFamily: helveticaneueregular,
                       color: Colors.white,
       //                fontSize: 14
                       fontSize: screenwidth*0.0373
                   ),),)
               )),
          GestureDetector(
            onTap: (){
              setState(() {
                stress=!stress;
              });
            },
            child:
               AnimatedContainer(
           //        height: 32,
                   height: screenheight*0.0479,
                   width: screenwidth*0.24,
                   duration: Duration(milliseconds: 150),
                   padding: EdgeInsets.all(    screenarea*0.0000319
                   ),
                   decoration: BoxDecoration(
                     color: stress?Color(0xff12c2e9):Colors.white30,
                     borderRadius: BorderRadius.all(Radius.circular(24)),
                   ),
                   child:     Center(child:
                   Text("Stress",style: TextStyle(
                       fontFamily: helveticaneueregular,
                       color: Colors.white,
           //            fontSize: 14
                       fontSize: screenwidth*0.0373
                   ),),)
               )),
          GestureDetector(
            onTap: (){
              setState(() {
                binaurial=!binaurial;
              });
            },
            child:
               AnimatedContainer(
                 duration: Duration(milliseconds: 150),
         //        height: 32,
                 height: screenheight*0.0479,
                 width: screenwidth*0.24,
                 padding: EdgeInsets.all(    screenarea*0.0000319
                 ),
                 decoration: BoxDecoration(
                   color:binaurial?Color(0xff12c2e9): Colors.white30,
                   borderRadius: BorderRadius.all(Radius.circular(24)),
                 ),
                 child:
                 Center(child:
                 Text("Binaurial",style: TextStyle(
                     fontFamily: helveticaneueregular,
                     color: Colors.white,
          //           fontSize: 14
                     fontSize: screenwidth*0.0373
                 ),)),
               )),
             ],
           )),
           Container(
             margin: EdgeInsets.only(
         //        bottom: 28
               bottom: screenarea*0.0001119

             ),
           child:
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: [
               GestureDetector(
               onTap: (){
           setState(() {
           calm=!calm;
           });
           },
             child:
               AnimatedContainer(
                 //  width: 87,
             //      height: 32,
                   height: screenheight*0.0479,
                   width: screenwidth*0.24,
                   duration: Duration(milliseconds: 150),
                   padding: EdgeInsets.all(    screenarea*0.0000319
                   ),
                   decoration: BoxDecoration(
                     color:calm?Color(0xff12c2e9): Colors.white30,
                     borderRadius: BorderRadius.all(Radius.circular(24)),
                   ),
                   child:     Center(child:
                   Text("Calm",style: TextStyle(
                       fontFamily: helveticaneueregular,
                       color: Colors.white,
               //        fontSize: 14
                       fontSize: screenwidth*0.0373
                   ),),)
               )),
          GestureDetector(
            onTap: (){
              setState(() {
                nature=!nature;
              });
            },
            child:
               AnimatedContainer(
             //      height: 32,
                   height: screenheight*0.0479,
                   width: screenwidth*0.24,
                   duration: Duration(milliseconds: 150),
                   padding: EdgeInsets.all(    screenarea*0.0000319
                   ),
                   decoration: BoxDecoration(
                     color:nature?Color(0xff12c2e9): Colors.white30,
                     borderRadius: BorderRadius.all(Radius.circular(24)),
                   ),
                   child:     Center(child:
                   Text("Nature",style: TextStyle(
                       fontFamily: helveticaneueregular,
                       color: Colors.white,
           //            fontSize: 14
                       fontSize: screenwidth*0.0373
                   ),),)
               )),
          GestureDetector(
            onTap: (){
              setState(() {
                instruments=!instruments;
              });
            },
            child:
               AnimatedContainer(
                 duration: Duration(milliseconds: 150),
         //        height: 32,
                 height: screenheight*0.0479,
                 width: screenwidth*0.24,
                 padding: EdgeInsets.all(    screenarea*0.0000319
                 ),
                 decoration: BoxDecoration(
                   color:instruments?Color(0xff12c2e9): Colors.white30,
                   borderRadius: BorderRadius.all(Radius.circular(24)),
                 ),
                 child:
                 Center(child:
                 Text("Instruments",style: TextStyle(
                     fontFamily: helveticaneueregular,
                     color: Colors.white,
          //           fontSize: 14
                     fontSize: screenwidth*0.0373
                 ),)),
               ),)
             ],
           )),
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: [  GestureDetector(
               onTap: (){
                 setState(() {
                   rain=!rain;
                 });
               },
               child:
               AnimatedContainer(
                 //  width: 87,
           //        height: 32,
                   height: screenheight*0.0479,
                   width: screenwidth*0.24,
                   duration: Duration(milliseconds: 150),
                   padding: EdgeInsets.all(    screenarea*0.0000319
                   ),
                   decoration: BoxDecoration(
                     color: rain?Color(0xff12c2e9):Colors.white30,
                     borderRadius: BorderRadius.all(Radius.circular(24)),
                   ),
                   child:     Center(child:
                   Text("Rain",style: TextStyle(
                       fontFamily: helveticaneueregular,
                       color: Colors.white,
              //         fontSize: 14
                       fontSize: screenwidth*0.0373
                   ),),)
               )),
               AnimatedContainer(
             //      height: 32,
                   height: screenheight*0.0479,
                   width: screenwidth*0.24,
                   duration: Duration(milliseconds: 150),
                   padding: EdgeInsets.all(    screenarea*0.0000319
                   ),
                   decoration: BoxDecoration(
                     color: Colors.transparent,
                     borderRadius: BorderRadius.all(Radius.circular(24)),
                   ),
                   child:     Center(child:
                   Text("Meditate",style: TextStyle(
                       fontFamily: helveticaneueregular,
                       color: Colors.transparent,
             //         fontSize: 14
                       fontSize: screenwidth*0.0373
                   ),),)
               ),
               AnimatedContainer(
                 duration: Duration(milliseconds: 150),
           //      height: 32,
                 height: screenheight*0.0479,
                 width: screenwidth*0.24,
                 padding: EdgeInsets.all(    screenarea*0.0000319
                 ),
                 decoration: BoxDecoration(
                   color: Colors.transparent,
                   borderRadius: BorderRadius.all(Radius.circular(24)),
                 ),
                 child:
                 Center(child:
                 Text("Anxiety",style: TextStyle(
                     fontFamily: helveticaneueregular,
                     color: Colors.transparent,
              //       fontSize: 14
                     fontSize: screenwidth*0.0373
                 ),)),
               ),
             ],
           ),
    //       Container(child: ListView(scrollDirection: Axis.horizontal,
      //         children: [Container(height: screenwidth*0.96, child: Column(children: [Container()
        //       ],),)],),)

         ],
         ),
       ),
            GestureDetector(
                onTap: (){
                  countchecker()?
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>IntroPage())):zerocount();

                },
                child:
                Container(
              //    height: 40,
                height: screenheight*0.0599,
               width: screenwidth*0.805,
                  //   width: 302,
                  margin: EdgeInsets.only(
                 top: screenarea*0.000179
                    //     top: 45
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30),
                    ),
                    color: Color(0xff9797de),
                  ),
                  child: Center(
                    child: Text(
                      'Continue',style: authtextstyles,
                    ),
                  ),
                )),
          ],
        ),),)),)
    ],);
  }
  zerocount(){
  setState(() {
    iszero=false;
  });
  }
}
