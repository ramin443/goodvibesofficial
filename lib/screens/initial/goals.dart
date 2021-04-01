import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:goodvibesofficial/constants/fontconstants.dart';
import 'package:goodvibesofficial/constants/styleconstants.dart';
import 'package:goodvibesofficial/screens/home/base.dart';
class Goals extends StatefulWidget {
  @override
  _GoalsState createState() => _GoalsState();
}

class _GoalsState extends State<Goals> {
bool meditate=false;
bool sleepbetter=false;
bool reducestress=false;
bool reduceanxiety=false;
bool lofitrack=false;

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
      Image.asset('assets/images/goalsbg.png',  fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,),
      Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
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
            Row(children: [
              Container(
                width:screenwidth,
                padding:EdgeInsets.only(
                    //top: 28,
                 top: screenarea*0.000111,
                  left: screenarea*0.0001439
                  //  left: 36
                ),
                child: Column(children: [
                  Container(child:
                GestureDetector(
                onTap: (){
              setState(() {
              meditate?meditate=false:meditate=true;
              });
              },
                  child:
Row(mainAxisAlignment:MainAxisAlignment.start,children: [
Icon(meditate?Icons.radio_button_checked:
  Icons.radio_button_unchecked,
//  size: 23.5,
  size: screenwidth*0.0626,
  color: Color(0xff12c2e9),),
  Container(margin:EdgeInsets.only(
   //   left: 8
  left: screenarea*0.0000319
  ),child: Text('Meditate',style: TextStyle(
    fontFamily: helveticaneueregular,color: Colors.white,
      //fontSize: 17
  fontSize: screenwidth*0.0453
  ),),)
],))),
    Container(margin: EdgeInsets.only(
        top: screenarea*0.000119
      //     top: 30
    ),
        child:
    GestureDetector(
    onTap: (){
    setState(() {
    sleepbetter?sleepbetter=false:sleepbetter=true;
    });
    },
    child:
    Row(mainAxisAlignment:MainAxisAlignment.start,children: [
                        Icon(sleepbetter?Icons.radio_button_checked:
                        Icons.radio_button_unchecked,
                       //   size: 23.5,
                         size: screenwidth*0.0626,
                          color: Color(0xff12c2e9),),
                    Container(margin:EdgeInsets.only(
                      left:  screenarea*0.0000319
                      //  left: 8
                    ),child: Text('Sleep Better',style: TextStyle(
                        fontFamily: helveticaneueregular,color: Colors.white,
                        //fontSize: 17
                        fontSize: screenwidth*0.0453

                    ),),)
                  ],))),
                  Container(margin: EdgeInsets.only(
                 //     top: 30
                 top: screenarea*0.000119
                  ),
                      child:
                      GestureDetector(
                          onTap: (){
                            setState(() {
                              reducestress?reducestress=false:reducestress=true;
                            });
                          },
                          child:
                      Row(mainAxisAlignment:MainAxisAlignment.start,children: [
                            Icon(reducestress?Icons.radio_button_checked:
                            Icons.radio_button_unchecked,
                             // size: 23.5,
                             size: screenwidth*0.0626,
                              color: Color(0xff12c2e9),),
                        Container(margin:EdgeInsets.only(
                            left:  screenarea*0.0000319
                          //      left: 8
                        ),child: Text('Reduce Stress',style: TextStyle(
                            fontFamily: helveticaneueregular,color: Colors.white,
                            fontSize: screenwidth*0.0453
                          //fontSize: 17
                        ),),)
                      ],))),
                  Container(margin: EdgeInsets.only(
    top: screenarea*0.000119
    //top: 30
    ),
                      child:
                      GestureDetector(
                          onTap: (){
                            setState(() {
                              reduceanxiety?reduceanxiety=false:reduceanxiety=true;
                            });
                          },
                          child:
                      Row(mainAxisAlignment:MainAxisAlignment.start,children: [

                            Icon(reduceanxiety?Icons.radio_button_checked:
                            Icons.radio_button_unchecked,
                          //    size: 23.5,
                            size: screenwidth*0.0626,
                              color: Color(0xff12c2e9),),
                        Container(margin:EdgeInsets.only(
                            left:  screenarea*0.0000319
                          //   left: 8
                        ),child: Text('Reduce Anxiety',style: TextStyle(
                            fontFamily: helveticaneueregular,color: Colors.white,
                            fontSize: screenwidth*0.0453
                          //fontSize: 17
                        ),),)
                      ],))),
                  Container(margin: EdgeInsets.only(
                      top: screenarea*0.000119

                    //    top: 30
                  ),
                      child:
                      GestureDetector(
                          onTap: (){
                            setState(() {
                              lofitrack?lofitrack=false:lofitrack=true;
                            });
                          },
                          child:
                      Row(mainAxisAlignment:MainAxisAlignment.start,children: [
                            Icon(lofitrack?Icons.radio_button_checked:
                            Icons.radio_button_unchecked,
                              //size: 23.5,
                              size: screenwidth*0.0626,
                              color: Color(0xff12c2e9),),
                        Container(margin:EdgeInsets.only(
                            left:  screenarea*0.0000319
                          //    left: 8
                        ),child: Text('Lofi Track',style: TextStyle(
                            fontFamily: helveticaneueregular,color: Colors.white,
                            fontSize: screenwidth*0.0453
                          //fontSize: 17
                        ),),)
                      ],)
                      )),

                ],),
              )
            ],),
            InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Base()));
                  setState(() {

                  });
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
        ),),),)
    ],);
  }
}
