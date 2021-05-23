import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:goodvibesoffl/Goal/goalmodel.dart';
import 'package:goodvibesoffl/Goal/goalsdbhelper.dart';
import 'package:goodvibesoffl/constants/fontconstants.dart';
import 'package:goodvibesoffl/constants/styleconstants.dart';
import 'package:goodvibesoffl/screens/home/base.dart';
import 'package:goodvibesoffl/screens/initial/intropage.dart';
class Goals extends StatefulWidget {
  @override
  _GoalsState createState() => _GoalsState();
}

class _GoalsState extends State<Goals> {
  GoalsDatabaseHelper goalsDatabaseHelper = GoalsDatabaseHelper();
  List goalslist=[];
  int count = 0;
  int clickcount=0;
  bool iszero=true;
bool sleep=false;
String gprefs="";
bool meditate=false;
bool anxiety=false;
bool lofi=false;
bool stress=false;
bool binaurial=false;
bool calm=false;
bool nature=false;
bool instruments=false;
bool rain=false;
String finalgoals="";
emptycode(){

}
  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    double screenheight=MediaQuery.of(context).size.height;
    double screenwidth=MediaQuery.of(context).size.width;
    double screenarea=screenheight*screenwidth;
    return Stack(children: [
      Scaffold(backgroundColor: Colors.white,),
      Image.asset('assets/images/background_latest@2x.png',  fit: BoxFit.cover,
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
          width: screenwidth,
color: Colors.transparent,
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           Row(
                children:[
                  Container(
                    margin: EdgeInsets.only(
                //        top: 32,
               //  top: screenarea*0.000127,
                      //  bottom: 8,
                      bottom:  screenarea*0.0000319
                        ,top: screenwidth*0.20,
                        left: screenwidth*0.0686
                      //left: 36
                    ),
                    child: Text('What brings you to\nGood Vibes',style: TextStyle(
                        fontFamily: helveticaneuemedium,
                        color: Colors.black87,
               //         fontSize: 28
                 fontSize: screenwidth*0.0746
                    ),
                    ),
                  )]),
            Row(children:[

              Container(
                margin: EdgeInsets.only(
                 //   left: 36
                left: screenwidth*0.0686
                ),
                child:
                Text('This will help us personalize our\nrecommendations for you',style: TextStyle(
                    fontFamily: helveticaneueregular,
                    color: Colors.black.withOpacity(0.76),
                 //   fontSize: 15
                fontSize: screenwidth*0.04
                ),),),
            ]),

          ],
        ),)),),
      Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton:
        Container(margin: EdgeInsets.only(
//bottom: 30
            bottom: screenwidth*0.06
          //     top: 45
        ),
//height: 70,
            height: screenwidth*0.186,
            child:Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  Container(
                    margin: EdgeInsets.only(
                      //   bottom: 9,left: 6
                        bottom: screenwidth*0.024,left: screenwidth*0.016
                    ),
                    child: Text(
                      clickcount>2?"":
                      "Select at least three categories",style: TextStyle(
                        fontFamily: helveticaneueregular,
                        color: Colors.white70,
                        //  fontSize: 12.5
                        fontSize: screenwidth*0.0333
                    ),),
                  ),
                  GestureDetector(
                      onTap: (){
                        clickcount>2?
                      nextbuttonclicked() :emptycode();

                      },
                      child:
                      AnimatedContainer(
                        duration: Duration(milliseconds: 240),
                        //    height: 40,
                        height: screenwidth*0.1066,
                        width: screenwidth*0.805,
                        //   width: 302,

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          color:
                          clickcount>2?Colors.white:Color(0xff9797de).withOpacity(0),
                        ),
                        child: Center(
                          child: Text(clickcount>2?
                          'Next':'',style: TextStyle(
                              fontFamily: helveticaneueregular,
                              color: Color(0xff9797de),
                              //    fontSize: 18
                              fontSize: screenwidth*0.048

                          ),
                          ),
                        ),
                      ))])),

        backgroundColor: Colors.transparent,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(
                  //        top: 6
                  //     top: screenwidth*0.0586
                ),
                //      padding: EdgeInsets.symmetric(horizontal: 36),
                height: screenwidth*1.1,
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        //       left: 36
                          left: screenwidth*0.096
                      ),
                      height: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ClipOval(child:
                          BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 15,sigmaY: 15),
                              child:
                              GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      sleep=!sleep;
                                      sleep?clickcount++:clickcount--;
                                      sleep?goalslist.add("sleep"):goalslist.remove("sleep");
                                      print(goalslist);
                                    });
                                  },
                                  child:
                                  AnimatedContainer(
                                    padding: EdgeInsets.symmetric(
                                      //       vertical: 14
                                        vertical: screenwidth*0.0373
                                    ),
                                    duration: Duration(milliseconds: 850),
                                    //       height: 100, width: 100,
                                    height: screenwidth*0.266,width: screenwidth*0.266,
                                    decoration: BoxDecoration(
                                      //    boxShadow: sleep?[BoxShadow(color: Color(0xff32386a),
                                      //  offset: Offset(0,3),blurRadius: 20)]:[],
                                      color:sleep?Colors.white: Colors.white38,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset("assets/images/moon.svg",
                                            //     width: 26,
                                            width: screenwidth*0.06933,
                                            color:
                                            sleep?Color(0xff32386a):
                                            Colors.black38,),
                                          Container(
                                              child:
                                              Text("Sleep",style: TextStyle(
                                                  fontFamily: helveticaneueregular,
                                                  //     fontSize: 15,
                                                  fontSize: screenwidth*0.04,
                                                  color:   sleep?Color(0xff32386a):
                                                  Colors.black38
                                              ),))
                                        ],),
                                    ),
                                  )))),
                          ClipOval(child:
                          BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 15,sigmaY: 15),
                              child:
                              GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      calm=!calm;
                                      calm?clickcount++:clickcount--;
                                      calm?goalslist.add("calm"):goalslist.remove("calm");
                                      print(goalslist);
                                    });
                                  },
                                  child:
                                  AnimatedContainer(
                                    padding: EdgeInsets.symmetric(
                                      //       vertical: 14
                                        vertical: screenwidth*0.0373

                                    ),
                                    duration: Duration(milliseconds: 850),
                                    //     height: 100, width: 100,
                                    height: screenwidth*0.266,width: screenwidth*0.266,
                                    decoration: BoxDecoration(
                                      color:calm?Colors.white.withOpacity(0.9): Colors.white38,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset("assets/images/water.svg",
                                            //     width: 35,
                                            width: screenwidth*0.0933,
                                            color:  calm?Color(0xff32386a):
                                            Colors.black38,),
                                          Container(
                                              child:
                                              Text("Calm",style: TextStyle(
                                                  fontFamily: helveticaneueregular,
                                                  //  fontSize: 15,
                                                  fontSize: screenwidth*0.04,
                                                  color:  calm?Color(0xff32386a):
                                                  Colors.black38
                                              ),))
                                        ],),
                                    ),
                                  )))),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                        //       horizontal: 39
                          horizontal: screenwidth*0.104
                      ),
                      height:  double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ClipOval(child:
                          BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 15,sigmaY: 15),
                              child:
                              GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      meditate=!meditate;
                                      meditate?clickcount++:clickcount--;
                                      meditate?goalslist.add("meditate"):goalslist.remove("meditate");
                                      print(goalslist);
                                    });
                                  },
                                  child:
                                  AnimatedContainer(
                                    duration: Duration(milliseconds: 850),
                                    padding: EdgeInsets.symmetric(
                                      //           vertical: 14
                                        vertical: screenwidth*0.0373
                                    ),
                                    //    height: 100, width: 100,
                                    height: screenwidth*0.266,width: screenwidth*0.266,
                                    decoration: BoxDecoration(
                                      color:meditate?Colors.white.withOpacity(0.9):Colors.white38,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset("assets/images/lotus.svg",
                                            //    width: 30,
                                            width: screenwidth*0.08,
                                            color:
                                            meditate?Color(0xff32386a):
                                            Colors.black38,),
                                          Container(
                                              child:
                                              Text("Meditate",style: TextStyle(
                                                fontFamily: helveticaneueregular,
                                                //    fontSize: 15,
                                                fontSize: screenwidth*0.04,
                                                color:meditate?Color(0xff32386a):Colors.black38,
                                              ),))
                                        ],),
                                    ),
                                  )))),
                          ClipOval(child:
                          BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 15,sigmaY: 15),
                              child:
                              GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      anxiety=!anxiety;
                                      anxiety?clickcount++:clickcount--;
                                      anxiety?goalslist.add("anxiety"):goalslist.remove("anxiety");
                                      print(goalslist);
                                    });
                                  },
                                  child:
                                  AnimatedContainer(
                                    duration: Duration(milliseconds: 850),
                                    padding: EdgeInsets.symmetric(
                                      //        vertical: 14
                                        vertical: screenwidth*0.0373
                                    ),
                                    //    height: 100, width: 100,
                                    height: screenwidth*0.266,width: screenwidth*0.266,
                                    decoration: BoxDecoration(
                                      color: anxiety?Colors.white.withOpacity(0.9):Colors.white38,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset("assets/images/noun_anxiety_2683238.svg",
                                            //     width: 40,
                                            width: screenwidth*0.1066,
                                            color:
                                            anxiety?Color(0xff32386a):Colors.black38,),
                                          Container(
                                              child:
                                              Text("Anxiety",style: TextStyle(
                                                  fontFamily: helveticaneueregular,
                                                  //      fontSize: 15,
                                                  fontSize: screenwidth*0.04,
                                                  color: anxiety?Color(0xff32386a):Colors.black38
                                              ),))
                                        ],),
                                    ),
                                  )))),
                          ClipOval(child:
                          BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 15,sigmaY: 15),
                              child:
                              GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      lofi=!lofi;
                                      lofi?clickcount++:clickcount--;
                                      lofi?goalslist.add("lofi"):goalslist.remove("lofi");
                                      print(goalslist);
                                    });
                                  },
                                  child:
                                  AnimatedContainer(
                                    duration: Duration(milliseconds: 850),
                                    //     height: 100, width: 100,
                                    height: screenwidth*0.266,width: screenwidth*0.266,
                                    decoration: BoxDecoration(
                                      color:lofi?Colors.white.withOpacity(0.9): Colors.white38,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset("assets/images/moon.svg",
                                            //width: 26,
                                            width: screenwidth*0.06933,
                                            color:
                                            lofi?Color(0xff32386a):Colors.black38,),
                                          Container(
                                              margin:EdgeInsets.only(top: 9),child:
                                          Text("Lo-Fi",style: TextStyle(
                                              fontFamily: helveticaneueregular,
                                              //      fontSize: 15,
                                              fontSize: screenwidth*0.04,
                                              color:lofi?Color(0xff32386a): Colors.black38
                                          ),))
                                        ],),
                                    ),
                                  )))),
                        ],
                      ),
                    ),
                    Container(
                      height:  double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ClipOval(child:
                          BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 15,sigmaY: 15),
                              child:
                              GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      stress=!stress;
                                      stress?clickcount++:clickcount--;
                                      stress?goalslist.add("stress"):goalslist.remove("stress");
                                      print(goalslist);
                                    });
                                  },
                                  child:
                                  AnimatedContainer(
                                    duration: Duration(milliseconds: 850),
                                    //   height: 100, width: 100,
                                    height: screenwidth*0.266,width: screenwidth*0.266,
                                    decoration: BoxDecoration(
                                      color: stress?Colors.white.withOpacity(0.9):Colors.white38,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset("assets/images/noun_anxiety_2683238.svg",
                                            //   width: 40,
                                            width: screenwidth*0.1066,
                                            color:
                                            stress?Color(0xff32386a):Colors.black38,),
                                          Container(
                                              margin:EdgeInsets.only(
                                                //                top: 9
                                                  top: screenwidth*0.024
                                              ),child:
                                          Text("Stress",style: TextStyle(
                                              fontFamily: helveticaneueregular,
                                              //       fontSize: 15,
                                              fontSize: screenwidth*0.04,
                                              color: stress?Color(0xff32386a): Colors.black38
                                          ),))
                                        ],),
                                    ),
                                  )))),
                          ClipOval(child:
                          BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 15,sigmaY: 15),
                              child:
                              GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      binaurial=!binaurial;
                                      binaurial?clickcount++:clickcount--;
                                      binaurial?goalslist.add("binaurial"):goalslist.remove("binaurial");
                                      print(goalslist);
                                    });
                                  },
                                  child:
                                  AnimatedContainer(
                                    duration: Duration(milliseconds: 850),
                                    //      height: 100, width: 100,
                                    height: screenwidth*0.266,width: screenwidth*0.266,
                                    decoration: BoxDecoration(
                                      color:binaurial?Colors.white.withOpacity(0.9): Colors.white38,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset("assets/images/water.svg",
                                            //    width: 35,
                                            width: screenwidth*0.0933,
                                            color:
                                            binaurial?Color(0xff32386a):Colors.black38,),
                                          Container(
                                              margin:EdgeInsets.only(
                                                //       top: 9
                                                  top: screenwidth*0.024
                                              ),child:
                                          Text("Binaurial",style: TextStyle(
                                              fontFamily: helveticaneueregular,
                                              //    fontSize: 15,
                                              fontSize: screenwidth*0.04,
                                              color:
                                              binaurial?Color(0xff32386a):Colors.black38
                                          ),))
                                        ],),
                                    ),
                                  )))),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                        //       horizontal: 39
                          horizontal: screenwidth*0.104
                      ),
                      height:  double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ClipOval(child:
                          BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 15,sigmaY: 15),
                              child:
                              GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      nature=!nature;
                                      nature?clickcount++:clickcount--;
                                      nature?goalslist.add("nature"):goalslist.remove("nature");
                                      print(goalslist);
                                    });
                                  },
                                  child:
                                  AnimatedContainer(
                                    duration: Duration(milliseconds: 850),
                                    //       height: 100, width: 100,
                                    height: screenwidth*0.266,width: screenwidth*0.266,
                                    decoration: BoxDecoration(
                                      color:nature?Colors.white.withOpacity(0.9): Colors.white38,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset("assets/images/lotus.svg",
                                            //width: 30,
                                            width: screenwidth*0.08,

                                            color: nature?Color(0xff32386a):Colors.black38,),
                                          Container(
                                              margin:EdgeInsets.only(
                                                //       top: 9
                                                  top: screenwidth*0.024
                                              ),child:
                                          Text("Nature",style: TextStyle(
                                              fontFamily: helveticaneueregular,
                                              //   fontSize: 15,
                                              fontSize: screenwidth*0.04,
                                              color:nature?Color(0xff32386a): Colors.black38
                                          ),))
                                        ],),
                                    ),
                                  )))),
                          ClipOval(child:
                          BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 15,sigmaY: 15),
                              child:
                              GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      rain=!rain;
                                      rain?clickcount++:clickcount--;
                                      rain?goalslist.add("rain"):goalslist.remove("rain");
                                      print(goalslist);
                                    });
                                  },
                                  child:
                                  AnimatedContainer(
                                    duration: Duration(milliseconds: 850),
                                    //    height: 100, width: 100,
                                    height: screenwidth*0.266,width: screenwidth*0.266,
                                    decoration: BoxDecoration(
                                      color:rain?Colors.white.withOpacity(0.9): Colors.white38,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset("assets/images/water.svg",
                                            //   width: 35,
                                            width: screenwidth*0.0933,
                                            color: rain?Color(0xff32386a):Colors.black38,),
                                          Container(
                                              margin:EdgeInsets.only(
                                                //       top: 9
                                                  top: screenwidth*0.024
                                              ),child:
                                          Text("Rain",style: TextStyle(
                                              fontFamily: helveticaneueregular,
                                              //      fontSize: 15,
                                              fontSize: screenwidth*0.04,
                                              color: rain?Color(0xff32386a):Colors.black38
                                          ),))
                                        ],),
                                    ),
                                  ) ))),
                          ClipOval(child:
                          BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 15,sigmaY: 15),
                              child:
                              GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      instruments=!instruments;
                                      instruments?clickcount++:clickcount--;
                                      instruments?goalslist.add("instruments"):goalslist.remove("instruments");
                                      print(goalslist);
                                    });
                                  },
                                  child:
                                  AnimatedContainer(
                                    duration: Duration(milliseconds: 850),
                                    //   height: 100, width: 100,
                                    height: screenwidth*0.266,width: screenwidth*0.266,
                                    decoration: BoxDecoration(
                                      color: instruments?Colors.white.withOpacity(0.9):Colors.white38,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset("assets/images/moon.svg",
                                            //     width: 26,
                                            width: screenwidth*0.06933,
                                            color:
                                            instruments?Color(0xff32386a):Colors.black38,),
                                          Container(
                                              margin:EdgeInsets.only(
                                                //       top: 9
                                                  top: screenwidth*0.024
                                              )      ,child:
                                          Text("Instruments",style: TextStyle(
                                              fontFamily: helveticaneueregular,
                                              //    fontSize: 15,
                                              fontSize: screenwidth*0.04,
                                              color: instruments?Color(0xff32386a):Colors.black38
                                          ),))
                                        ],),
                                    ),
                                  )))),
                        ],
                      ),
                    ),
                  ],),
              ),

            ],
          ),
        ),
      )

    ],);
  }
  void _savegoal(GoalsModel goalsModel) async {

    int result;
  // Case 2: Insert Operation
      result = await goalsDatabaseHelper.insertGoals(goalsModel);


    if (result != 0) {  // Success
      print( 'Goals Added');
    } else {  // Failure
      print('Problem Saving to Goals');
    }

  }
  nextbuttonclicked()async{
for(int i=0;i<=goalslist.length-1;i++){
  setState(() {
    finalgoals=finalgoals+goalslist[i]+(i+1).toString();
  });
}
print(finalgoals);
  _savegoal(GoalsModel(finalgoals, clickcount));

  Navigator.push(context, MaterialPageRoute(builder: (context)=>IntroPage()));
  }
  zerocount(){
  setState(() {
    iszero=false;
  });
  }
}
