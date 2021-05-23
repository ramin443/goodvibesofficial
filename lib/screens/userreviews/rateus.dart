import 'dart:io';

import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:goodvibesoffl/constants/fontconstants.dart';
import 'package:goodvibesoffl/screens/userreviews/thankyou.dart';
class RateUs extends StatefulWidget {
  @override
  _RateUsState createState() => _RateUsState();
}

class _RateUsState extends State<RateUs> {
  int numberofstars=0;
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

    return
      Stack(children:[
        Image.asset('assets/images/X - 1@2x.png',fit: BoxFit.cover,
          width: screenheight,
        ),
      Scaffold(
        appBar: AppBar(
          actions: [

            Container(
              margin: EdgeInsets.only(
              //    right: 4
              right: screenwidth*0.0106
              ),
              child: IconButton(
                onPressed: (){
                  numberofstars>0?
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context)=>ThankYou()
                  )):emptycode();
                },
                icon: Icon(CupertinoIcons.check_mark_circled_solid,
                color: numberofstars>0?Colors.greenAccent:Colors.black45,
             //   size: 30,
               size: screenwidth*0.08,
                ),
              ),
            )
          ],
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon:Icon( CupertinoIcons.xmark_circle,
        //    size: 30,
              size: screenwidth*0.08,

              color: Colors.black45,)

          ),
        ),
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
        body: Center(child: Container(
          margin: EdgeInsets.only(
         //     bottom: 50
bottom: screenwidth*0.1333
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
    Text("Rate Us?!",style: TextStyle(
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
    Text(
      "We are always trying to improve what we do\nand your feedback is valuable",
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
             left: screenwidth*0.0503,right: screenwidth*0.0503,
            //    top: 39
              top: screenwidth*0.104
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: (){
setState(() {
  numberofstars=1;
});
                      },
    child:
                    Icon(
                      numberofstars>0?Icons.star:
                      FeatherIcons.star,color: numberofstars>0?Color(0xff12c2e9): Colors.black54
                      ,
             //         size: 24,
               size: screenwidth*0.064,
                    )),
                    GestureDetector(
                        onTap: (){
setState(() {
numberofstars=2;
});
                        },
                        child:
                        Icon( numberofstars>1?Icons.star:
                        FeatherIcons.star,color: numberofstars>1? Color(0xff12c2e9):Colors.black54,
                   //       size: 24,
                          size: screenwidth*0.064,
                        )),
                    GestureDetector(
                        onTap: (){
                          setState(() {
                            numberofstars=3;
                          });
                        },
                        child:
                        Icon( numberofstars>2?Icons.star:
                        FeatherIcons.star,color:numberofstars>2? Color(0xff12c2e9): Colors.black54,
                  //        size: 24,
                          size: screenwidth*0.064,
                        )),

                    GestureDetector(
                        onTap: (){
                          setState(() {
                            numberofstars=4;
                          });
                        },
                        child:
                        Icon( numberofstars>3?Icons.star:
                        FeatherIcons.star,color: numberofstars>3? Color(0xff12c2e9):Colors.black54,
                   //      size: 24,
                          size: screenwidth*0.064,
                        )),
                    GestureDetector(
                        onTap: (){
                          setState(() {
                            numberofstars=5;
                          });
                        },
                        child:
                        Icon( numberofstars>4?Icons.star:
                        FeatherIcons.star,color:numberofstars>4? Color(0xff12c2e9): Colors.black54,
                   //       size: 24,
                          size: screenwidth*0.064,
                        )),
                  ],
                ),
              )
            ],
          ),
        ),),

      )]);
  }
}
