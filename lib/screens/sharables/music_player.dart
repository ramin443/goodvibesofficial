import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:goodvibesofficial/constants/fontconstants.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
class MusicPlayer extends StatefulWidget {
  @override
  _MusicPlayerState createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {

  bool favoritespressed=false;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    double screenwidth=MediaQuery.of(context).size.width;
    double screenheight=MediaQuery.of(context).size.height;
    double screenarea=screenheight*screenwidth;
    return Stack(
      children: [
      Image.asset('assets/images/X - 1@2x.png',fit: BoxFit.cover,width: screenheight,),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.transparent,elevation: 0,
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(CupertinoIcons.back,
            size: 24,color: Colors.black87,),
          ),
          actions: [
            GestureDetector(
                onTap: (){
                  setState(() {
                    favoritespressed=!favoritespressed;
                  });
                },
                child:
            Container(margin: EdgeInsets.only(right: 15),
              child: Icon(
                favoritespressed?MdiIcons.heart:MdiIcons.heartOutline,
              color:favoritespressed?Colors.redAccent: Colors.black87,size: 24,),
            ))
          ],
          title: Text("Now Playing",style: TextStyle(
            fontFamily: helveticaneuemedium,fontSize: 17,color: Colors.black87
          ),),
          ),
          body: Container(
            child: Column(mainAxisAlignment:MainAxisAlignment.start,
              crossAxisAlignment:CrossAxisAlignment.center,children: [
              Container(margin:EdgeInsets.only(top: 34),
            //    padding: EdgeInsets.all(43),
                child: Center(child:ClipOval(
                  child:BackdropFilter(
                      filter: ImageFilter.blur(sigmaY: 50,sigmaX: 50),
                      child:
                  Container(
                    height: 246,width: 246,
                    padding: EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: Color(0xff12c2e9).withOpacity(0.12),
                      shape: BoxShape.circle
                    ),
                    child: ClipOval(

                      child:
                    Image.asset("assets/images/medi.png",fit: BoxFit.cover,),
                        ),
                  ) ),
                ),)),
                Container(margin: EdgeInsets.only(top: 44),
                  child: Center(
                    child: Column(children: [
                      Container(child: Text("Get Motivated",style: TextStyle(fontFamily: helveticaneuebold,
                      color: Colors.black87,fontSize: 24),),),
                      Container(margin: EdgeInsets.only(top: 8),
                        child: Text("Breathing with your body",style: TextStyle(fontFamily: helveticaneueregular,
                          color: Colors.black45,fontSize: 13.5),),)
                    ],),
                  ),),
                Container(margin: EdgeInsets.only(top: 38,left: 34,right: 34),
                  child: Column(
                    children: [
                    Container(width: double.infinity,
                      alignment: Alignment.centerLeft,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(14)),
                      ),
                      child:

                      Container(
                        height: double.infinity,
                        width: 178,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xff9797de),Color(0xff32386a)]
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(14)),                        ),
                      ),
                    ),
                      Container(
                          width: screenwidth,
                          margin: EdgeInsets.only(top: 8),
                          child:
                      Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children: [
                        Container(child: Text("5:57",style: TextStyle(
    fontFamily: helveticaneueregular,color: Colors.black38,fontSize: 12
    ),)),
                        Container(child: Text("10:00",style: TextStyle(
                            fontFamily: helveticaneueregular,color: Colors.black38,fontSize: 12
                        ),)),
                      ],))
                  ],),
                )
            ],),
          ),
        )
      ],
    );
  }
}
