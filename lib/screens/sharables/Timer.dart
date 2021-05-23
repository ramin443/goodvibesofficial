import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goodvibesoffl/constants/fontconstants.dart';
import 'package:goodvibesoffl/screens/plays/meditate.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
class Timer extends StatefulWidget {
  @override
  _TimerState createState() => _TimerState();
}

class _TimerState extends State<Timer> {
  ScrollController scrollController=ScrollController();
  String message='';
  String time='0';
 // AnimationController controller =AnimationController(vsync: this);
  int timetapped=0;
  @override
  void initState() {
    scrollController.addListener(_scrollListener);
    super.initState();
 //   scrollController.jumpTo(value)

  }
  _scrollListener() {
    setState(() {
      if(scrollController.offset/scrollController.position.maxScrollExtent*720>60){
        if((scrollController.offset/scrollController.position.maxScrollExtent*720-
            int.parse((scrollController.offset/scrollController.position.maxScrollExtent*720/60).
            toStringAsFixed(0))*60)<0){
        time=(((scrollController.offset/scrollController.position.maxScrollExtent*720/60).floor()).toStringAsFixed(0)+'h '+
          (59+(scrollController.offset/scrollController.position.maxScrollExtent*720-
              int.parse((scrollController.offset/scrollController.position.maxScrollExtent*720/60).
              toStringAsFixed(0))*60)).toStringAsFixed(0)+"m"
      );}else{
          time=(((scrollController.offset/scrollController.position.maxScrollExtent*720/60).floor()).toStringAsFixed(0)+'h '+
              (scrollController.offset/scrollController.position.maxScrollExtent*720-
                  int.parse((scrollController.offset/scrollController.position.maxScrollExtent*720/60).
                  toStringAsFixed(0))*60).toStringAsFixed(0)+"m"
          );
        }
      }else{
        time=(scrollController.offset/scrollController.position.maxScrollExtent*720).toStringAsFixed(0)+"m";
      }
    });

  }
  @override
  Widget build(BuildContext context) {
    double screenwidth=MediaQuery.of(context).size.width;
    Color purpleone=Color(0xff9797de);
    return Scaffold(
      backgroundColor: purpleone,
      appBar: AppBar(
        backgroundColor: purpleone,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(CupertinoIcons.xmark,
          color: Colors.white,
       //   size: 24,
         size: screenwidth*0.064,
          ),
          onPressed: (){
            Navigator.pop(context);
          },
        ),

        title: Text("Set a timer",style: TextStyle(
          fontFamily: helveticaneuemedium,color: Colors.white,
      //      fontSize: 17
        fontSize: screenwidth*0.0453
        ),),
      ),
      body: Center(child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
Container(child: Text(time,style: TextStyle(
  fontFamily: sfprothin,
  color: Colors.white,
//  fontSize: 75
fontSize: screenwidth*0.2
),textAlign: TextAlign.center,),),
            Container(
              child: Text("min",style: TextStyle(
                  fontFamily: sfproregular,
                  color: Colors.white.withOpacity(0.6),
           //       fontSize: 17
                  fontSize: screenwidth*0.0453
              ),textAlign: TextAlign.center,),
            ),
            Container(
              margin: EdgeInsets.only(
         //         top: 5,bottom: 8.5
           top: screenwidth*0.0133,bottom: screenwidth*0.0226
              ),
        //      height: 14,width: 14,
          height: screenwidth*0.0373,width: screenwidth*0.0373,
              decoration: BoxDecoration(
gradient: LinearGradient(begin: Alignment.topCenter,end: Alignment.bottomCenter,
colors: [Colors.white70,Color(0xffefefef).withOpacity(0.4)]
),              shape: BoxShape.circle,

            ),),
            ShaderMask(
                blendMode: BlendMode.srcATop,
                shaderCallback:  (Rect bounds) {

                  return LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,

                    colors: [Colors.white30, Colors.white30],
                  ).createShader(bounds);
                },
            child:
            Container(
              margin: EdgeInsets.only(
           //       bottom: 12.5
             bottom: screenwidth*0.033
              ),
              height: screenwidth*0.3173,
              width: screenwidth,
              child: ListView(
                controller: scrollController,
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                children: [
                  Container(
                //    width: 175,
                  width: screenwidth*0.466,
                  ),
                  for(int i=1;i<=12;i++)
                    Container(
                      margin: EdgeInsets.symmetric(
                  //        horizontal: 12.5
                    horizontal: screenwidth*0.033
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                        //    width: 2,height: 83,
                          width:screenwidth*0.00533,height: screenwidth*0.221,
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                       //         horizontal: 25
                         horizontal: screenwidth*0.0666
                            ),
                        //    width: 2,height: 39.5,
                            width:screenwidth*0.00533,height: screenwidth*0.1053,
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                        //        right: 25
                          right: screenwidth*0.0666
                            ),
                          //  width: 2,height: 39.5,
                            width:screenwidth*0.00533,height: screenwidth*0.1053,
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                          ),
                          Container(
                         //   width: 2,height: 39.5,
                            width:screenwidth*0.00533,height: screenwidth*0.1053,

                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  Container(
             //       width:175,
                    width: screenwidth*0.466,
                  ),

                ],
              ),
            )),

          Icon(CupertinoIcons.triangle_fill,
          color: Colors.white70,
        //  size: 22,
          size: screenwidth*0.0586,
          ),
            Container(
              margin: EdgeInsets.only(
            //      top: 35,bottom: 30
              top: screenwidth*0.0933,bottom: screenwidth*0.08
              ),
              child: Row(mainAxisAlignment:MainAxisAlignment.spaceEvenly,children: [
                GestureDetector(
                    onTap: (){
                      setState(() {
                        timetapped=5;
                        time='5m';
                        scrollController.animateTo(5/720*scrollController.position.maxScrollExtent,
                            duration: Duration(milliseconds: 350),
                            curve: Curves.ease
                        );                      });
                    },
                    child:
                AnimatedContainer(
                  duration: Duration(milliseconds: 250),
             //     height: 48,width: 48,
               height: screenwidth*0.128,width: screenwidth*0.128,
                decoration: BoxDecoration(
                  color: timetapped==5?Colors.white:Colors.white30,
                  shape: BoxShape.circle
                ),
                  child: Center(child:Text("5",style: TextStyle(
                    fontFamily: sfproregular,
                    color:timetapped==5?purpleone: Colors.white,
               //       fontSize: 15
                 fontSize: screenwidth*0.04
                  ),)),
                )),
                GestureDetector(
                    onTap: (){
                      setState(() {
                        timetapped=10;
                        time='10m';
                        scrollController.animateTo(10/720*scrollController.position.maxScrollExtent,
                            duration: Duration(milliseconds: 350),
                            curve: Curves.ease
                        );
                      });
                    },
                    child:
                    AnimatedContainer(
                      duration: Duration(milliseconds: 250),
               //       height: 48,width: 48,
                      height: screenwidth*0.128,width: screenwidth*0.128,
                      decoration: BoxDecoration(
                          color: timetapped==10?Colors.white:Colors.white30,
                          shape: BoxShape.circle
                      ),
                      child: Center(child:Text("10",style: TextStyle(
                          fontFamily: sfproregular,
                          color:timetapped==10?purpleone: Colors.white,
                          //fontSize: 15
                          fontSize: screenwidth*0.04
                      ),)),
                    )),
                GestureDetector(
                    onTap: (){
                      setState(() {
                        timetapped=15;
                        time='15m';
                        scrollController.animateTo(15/720*scrollController.position.maxScrollExtent,
                            duration: Duration(milliseconds: 350),
                            curve: Curves.ease
                        );
                      });
                    },
                    child:
                    AnimatedContainer(
                      duration: Duration(milliseconds: 250),
                //      height: 48,width: 48,
                      height: screenwidth*0.128,width: screenwidth*0.128,
                      decoration: BoxDecoration(
                          color: timetapped==15?Colors.white:Colors.white30,
                          shape: BoxShape.circle
                      ),
                      child: Center(child:Text("15",style: TextStyle(
                          fontFamily: sfproregular,
                          color: timetapped==15?purpleone:Colors.white,
                  //        fontSize: 15
                          fontSize: screenwidth*0.04
                      ),)),
                    )),
                GestureDetector(
                    onTap: (){
                      setState(() {
                        timetapped=45;
                        scrollController.animateTo(45/720*scrollController.position.maxScrollExtent,
                            duration: Duration(milliseconds: 350),
                            curve: Curves.ease
                        );
                        time='45m';

                      });
                    },
                    child:
                    AnimatedContainer(
                      duration: Duration(milliseconds: 250),
                   //   height: 48,width: 48,
                      height: screenwidth*0.128,width: screenwidth*0.128,
                      decoration: BoxDecoration(
                          color: timetapped==45?Colors.white:Colors.white30,
                          shape: BoxShape.circle
                      ),
                      child: Center(child:Text("45",style: TextStyle(
                          fontFamily: sfproregular,
                          color: timetapped==45?purpleone:Colors.white,
                          //ontSize: 15
                          fontSize: screenwidth*0.04
                      ),)),
                    )),
                GestureDetector(
                    onTap: (){
                      setState(() {
                        timetapped=90;
                        scrollController.animateTo(89/720*scrollController.position.maxScrollExtent,
                            duration: Duration(milliseconds: 350),
                        curve: Curves.ease
                        );
                        time='1h 30m';

                      });
                    },
                    child:
                    AnimatedContainer(
                      duration: Duration(milliseconds: 250),
                 //     height: 48,width: 48,
                      height: screenwidth*0.128,width: screenwidth*0.128,
                      decoration: BoxDecoration(
                          color: timetapped==90?Colors.white:Colors.white30,
                          shape: BoxShape.circle
                      ),
                      child: Center(child:Text("90",style: TextStyle(
                          fontFamily: sfproregular,
                          color:timetapped==90?purpleone: Colors.white,
                          //fontSize: 15
                          fontSize: screenwidth*0.04
                      ),)),
                    )),
              ],),
            ),
            GestureDetector(
                onTap: (){
                  setState(() {
scrollController.offset>0?Navigator.pop(context):emptycode();

                  });
                },
                child:
                AnimatedContainer(
                  duration: Duration(milliseconds: 250),
              //    height: 110,width: 110,
                height: screenwidth*0.2933,width: screenwidth*0.2933,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle
                  ),
                  child: Center(child:Text("SET",style: TextStyle(
                      fontFamily: sfprosemibold,
                      color:purpleone,
                 //     fontSize: 46
                  fontSize: screenwidth*0.1026
                  ),)),
                )),
        ],),
      ),),
    );
  }
  emptycode(){}
}
