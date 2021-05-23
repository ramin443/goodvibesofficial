import 'dart:ui';

import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:goodvibesoffl/constants/fontconstants.dart';
class ShareTrack extends StatefulWidget {
  final String imageasset;
  final String title;
  String description;
  ShareTrack({Key key, @required this.imageasset,@required this.title,@required this.description}) : super(key: key);

  @override
  _ShareTrackState createState() => _ShareTrackState();
}

class _ShareTrackState extends State<ShareTrack> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    double screenwidth=MediaQuery.of(context).size.width;
    double screenheight=MediaQuery.of(context).size.height;
    double screenarea=screenheight*screenwidth;
    AppBar appbar=AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: Icon(CupertinoIcons.back,
          size: 30,
          color: Colors.black87,),
        onPressed: (){
          Navigator.pop(context);
        },
      ),
    );
    double remainingheight=screenheight-appbar.preferredSize.height;
    return
      Stack(children:[
        Image.asset('assets/images/X - 1@2x.png',fit: BoxFit.cover,
          width: screenheight,
        ),
      Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
          elevation: 0,
        leading: IconButton(
          icon: Icon(CupertinoIcons.back,
          size: 30,
          color: Colors.black87,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: screenwidth*0.072),
          height: remainingheight,
          width: screenwidth,
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment:MainAxisAlignment.center,
              children:[
            ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                child:BackdropFilter(
                    filter: ImageFilter.blur(sigmaY: 50,sigmaX: 50),
                    child:
            Container(
//height: 300,width: 300,
  height: screenwidth*0.8,width: screenwidth*0.8,
              decoration: BoxDecoration(
                boxShadow: [BoxShadow(offset: Offset(0,0),color:
                Color(0xff9797de))],
                color: Colors.white.withOpacity(0.91),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppBar(
                      automaticallyImplyLeading: false,
                      backgroundColor: Colors.transparent,
                      elevation: 0,

                      centerTitle: false,
                      title:
                      GestureDetector(
                          onTap: (){
                            //           Navigator.pop(context);
                          },
                          child:
                          Row(
                            //  mainAxisAlignment: MainAxisAlignment.start,
                              children:[
                                Container(
                                  margin: EdgeInsets.only(
                                    //   right: 7
                                      right: screenarea*0.0000279
                                  ),
                                  child:  SvgPicture.asset('assets/images/white_logo.svg',fit: BoxFit.cover,
                                    color: Color(0xff9797de),
                                    //        width: 30,
                                    width: screenwidth*0.08,
//  width: screenwidth*0.128,
                                  ),
                                ),
                                SvgPicture.asset('assets/images/logo 2.svg',fit: BoxFit.cover,
                                  //        height: double.infinity,
                                  width:screenheight*screenwidth*0.000435,
                                  //     width: screenheight*screenwidth*0.000439,
                                  color: Color(0xff9797de),
                                  //         alignment: Alignment.center,
                                ),]))
                  ),
                  Container(
                    //    padding: EdgeInsets.all(43),
                      child: Center(child:ClipOval(
                        child:BackdropFilter(
                            filter: ImageFilter.blur(sigmaY: 50,sigmaX: 50),
                            child:
                            Container(
                              //       height: 246,width: 246,
                                height: screenwidth*0.429,width: screenwidth*0.429,
                                //            padding: EdgeInsets.all(30),
                                decoration: BoxDecoration(
                                    color: Color(0xff12c2e9).withOpacity(0.12),
                                    shape: BoxShape.circle
                                ),
                                child:Center(child:
                                Stack(children:[
                                  Center(child:
                                  Stack(children:[
                                    Center(
                                      //    top: 4,
                                      child:  Container(
                                          margin: EdgeInsets.only(
                                            //           top: 20,
                                              top: screenwidth*0.0533
                                              ,left: 0),
                                          child: ClipOval(
                                            child:
                                            Container(
                                              //   height: 175,width: 175,
                                                height: screenwidth*0.3488,width: screenwidth*0.3488,
                                                decoration: BoxDecoration(shape: BoxShape.circle),
                                                child:
                                                Image.asset(widget.imageasset,fit: BoxFit.fitWidth)),
                                          )),),
                                    Container(
                                      //      margin: EdgeInsets.only(top: 4,left: 4),
                                        child:
                                        ClipOval(child: BackdropFilter(
                                          filter: ImageFilter.blur(sigmaY: 10,sigmaX: 10),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle
                                                ,
                                                color: Colors.white.withOpacity(0.0)
                                            ),
                                            //        height: 246,width: 246,
                                            height: screenwidth*0.429,width: screenwidth*0.429,
                                          ),),)),
                                    Center(child:
                                    ClipOval(
                                      child:
                                      Container(

                                        //        height:175,width: 175,
                                          height: screenwidth*0.3488,width: screenwidth*0.3488,
                                          decoration: BoxDecoration(shape: BoxShape.circle),
                                          child:
                                          Hero(
                                              tag: 'player',
                                              child:
                                              Image.asset(widget.imageasset,fit: BoxFit.fitWidth,))),
                                    )),

                                  ])),

                                ]))
                            ) ),
                      ),)),
                  Container(
padding: EdgeInsets.symmetric(
//    horizontal:
horizontal: screenwidth*0.0426
),
                    width: screenwidth,
                  //  height: 52,
                 height: screenwidth*0.1386,
                    decoration: BoxDecoration(
                      color: Color(0xfff5a182),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 3),
                        child: Text("Activate Your Mind",style: TextStyle(
                          fontFamily: helveticaneuemedium,
                          color: Colors.black87,
                    //      fontSize: 15
                      fontSize: screenwidth*0.04
                        ),),
                      ),




                      Container(
                        child: Text("Breathing with your body",style: TextStyle(
                            fontFamily: helveticaneuemedium,
                            color: Colors.black54,
                            //      fontSize: 15
                            fontSize: screenwidth*0.026
                        ),),
                      ),
                    ],
                    ),
                  )
                ],
              ),
            )))]),
Container(child: Column(
  children: [
  Container(
    padding: EdgeInsets.symmetric(
        horizontal: screenwidth*0.035
    ),
 //   height: 42,width: 240,
  height: screenwidth*0.112,width: screenwidth*0.64,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(8)),
      boxShadow: [BoxShadow(color: Color(0xff32386a).withOpacity(0.25),
      offset: Offset(0,3),blurRadius: 20)]
    ),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      FaIcon(FontAwesomeIcons.instagram,
        //            size: 30,
        size:screenwidth*0.064,
        color: Colors.black87,
      ),
      Container(
     //   margin: EdgeInsets.only(left: screenwidth*0.04),
        child: Text("Share To Instagram Stories",style: TextStyle(
        fontFamily: helveticaneueregular,color: Colors.black87,
        fontSize: screenwidth*0.04
      ),),)
    ],),
  ),
    Container(
      margin: EdgeInsets.symmetric(
      //    vertical: 22
      vertical: screenwidth*0.0586
      ),

      padding: EdgeInsets.symmetric(
          horizontal: screenwidth*0.035
      ),
      //   height: 42,width: 240,
      height: screenwidth*0.112,width: screenwidth*0.64,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8)),
          boxShadow: [BoxShadow(color: Color(0xff32386a).withOpacity(0.25),
              offset: Offset(0,3),blurRadius: 20)]
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FaIcon(FontAwesomeIcons.facebookF,
            //            size: 30,
            size:screenwidth*0.054,
            color: Colors.black87,
          ),
          Container(
         //   margin: EdgeInsets.only(left: screenwidth*0.04),
            child: Text("Share To Facebook Stories",style: TextStyle(
                fontFamily: helveticaneueregular,color: Colors.black87,
                fontSize: screenwidth*0.04
            ),),)
        ],),
    ),
    Container(
      margin: EdgeInsets.only(bottom: screenwidth*0.0686),
      padding: EdgeInsets.symmetric(
          horizontal: screenwidth*0.035
      ),
      //   height: 42,width: 240,
      height: screenwidth*0.112,width: screenwidth*0.64,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8)),
          boxShadow: [BoxShadow(color: Color(0xff32386a).withOpacity(0.25),
              offset: Offset(0,3),blurRadius: 20)]
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(FeatherIcons.share2,
            //            size: 30,
            size:screenwidth*0.064,
            color: Colors.black87,
          ),
          Container(
            margin: EdgeInsets.only(left: screenwidth*0.04),
            child: Text("Share With Others",style: TextStyle(
                fontFamily: helveticaneueregular,color: Colors.black87,
                fontSize: screenwidth*0.04
            ),),)
        ],),
    ),
],),)


          ],
          ),
        ),
    )]);
  }
}
