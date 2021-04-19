
import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goodvibesofficial/constants/fontconstants.dart';
import 'package:goodvibesofficial/screens/sharables/music_player.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
class Library extends StatefulWidget {
  @override
  _LibraryState createState() => _LibraryState();
}

class _LibraryState extends State<Library>with TickerProviderStateMixin {
  TabController tabController;
  bool favorites=true;
bool tracks=true;
bool first=false;
bool second=false;
bool third=false;
  @override
  void initState() {
    super.initState();
    tabController=TabController(length: 2, vsync: this);

  }
  @override
  Widget build(BuildContext context) {
    double screenheight=MediaQuery.of(context).size.height;
    double screenwidth=MediaQuery.of(context).size.width;
    double screenarea=screenheight*screenwidth;
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
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          floatingActionButton:
          GestureDetector(
              onVerticalDragStart: (v){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>
                    MusicPlayer(imageasset: "assets/images/medi.png",
                        title: "Get Motivated",
                        description: "Reach your goals with this advice")));
              },
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>
                    MusicPlayer(imageasset: "assets/images/medi.png",
                        title: "Get Motivated",
                        description: "Reach your goals with this advice")));
              },
              child:
              ClipRect(child:
              BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 3.5,sigmaY: 3.5),
                  child:Container(
                    margin: EdgeInsets.only(left: 40,right: 8),
                    padding: EdgeInsets.symmetric(vertical: 18),
                    width: screenwidth,

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(                borderRadius: BorderRadius.all(Radius.circular(6)),
                            child:
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(6))
                              ),
                              height: 54,width: 54,
                              child:

                              Image.asset("assets/images/medi.png",fit: BoxFit.cover,),
                            )),
                        Container(
                          margin: EdgeInsets.only(left: 16),
                          height: 54,
                          child: Column(crossAxisAlignment:CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(child: Text("Get Motivated",style: TextStyle(
                                  fontFamily: helveticaneuebold,color: Colors.black87,fontSize: 13.5
                              ),),),
                              Container(
                                margin: EdgeInsets.only(top: 5),
                                child: Text("Reach your goals with this advice",style: TextStyle(
                                    fontFamily: helveticaneueregular,color: Colors.black54,fontSize: 10
                                ),),),
                            ],),),
                        Expanded(child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(onTap:(){},child: Container(child: Icon(Icons.skip_previous,size: 26,color: Colors.black87,),)),
                            GestureDetector(onTap:(){},child: Container(child: Icon(Icons.play_arrow,size: 26,color: Colors.black87,),)),
                            GestureDetector(onTap:(){},child: Container(child: Icon(Icons.skip_next,size: 26,color: Colors.black87,),)),

                          ],),)
                      ],
                    ),
                  )))),
        backgroundColor: Colors.transparent,
        appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: Color(0xfff5f5f5),
            centerTitle: false,
            title: Container(
              margin: EdgeInsets.only(
     //             left: 14
       left: screenarea*0.0000559
              ),
              //        padding: EdgeInsets.all(8),
              child: SvgPicture.asset('assets/images/logo 2.svg',
                color: Color(0xff9797de),
                //      fit: BoxFit.cover,
                //          width: 35,
              ),
            ),
        ),
        body: SingleChildScrollView(child:
        Container(
          width: screenwidth,

          margin: EdgeInsets.only(
        //      left: 22,right: 22
left: screenwidth*0.0586,right:screenwidth*0.0586
          ),
          child: Column(mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                child:
          Row(mainAxisAlignment:MainAxisAlignment.start,children: [
            GestureDetector(
                onTap: (){
setState(() {
  favorites==false?favorites=true:emptycode();
});
                },
                child:
            Container(child: Text("Favorites",style: TextStyle(
              fontFamily: helveticaneuemedium,color:favorites?Colors.black87:Colors.black38,
        //        fontSize: 22
          fontSize: screenwidth*0.0586
            ),),)),
            GestureDetector(
                onTap: (){
                  setState(() {
                    favorites==true?favorites=false:emptycode();
                  });
                },
                child:
                    favorites?
                Container(margin:EdgeInsets.only(
           //         left: 21
left: screenarea*0.0000839
                ),child: Text("Downloads",style: TextStyle(
                    fontFamily: helveticaneuemedium,color:Colors.black38,
             //       fontSize: 22
                    fontSize: screenwidth*0.0586
                ),),):  Container(margin:EdgeInsets.only(
                    //    left: 21
                        left: screenarea*0.0000839
                    ),child: Text("Downloads",style: TextStyle(
                        fontFamily: helveticaneuemedium,color: Colors.black87,
               //         fontSize: 22
                        fontSize: screenwidth*0.0586
                    ),),)),

          ],)),
          Container(
child:
Row(mainAxisAlignment: MainAxisAlignment.start,
    children:[
      Container(child: AnimatedSwitcher(
        duration: Duration(milliseconds: 1000,
        ),
        child: favorites?
        favoritestab():downloadstab(),
      ),),

            ])),

        ],),
        ))
      );
  }
  Widget favoritestab(){
    double screenheight=MediaQuery.of(context).size.height;
    double screenwidth=MediaQuery.of(context).size.width;
    double screenarea=screenheight*screenwidth;
    return Container(
      key: Key("swit"),
      margin: EdgeInsets.only(
    //      top: 12
      top: screenarea*0.0000479
      ),
      child: Column(mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: screenwidth*0.42,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: (){
                          setState(() {
                            tracks?emptycode():tracks=true;
                      //      trackslist()=favplaylist();
                          });
                        },
                        child:
                    Container(child: Text("Tracks",style: TextStyle(
                        fontFamily: helveticaneuemedium,color:tracks? Colors.black87:Colors.black38,
                        //fontSize: 13
                        fontSize: screenwidth*0.0346
                    ),),)),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          tracks?tracks=false:emptycode();
                        });
                      },
                      child:
                    Container(
                      child: Text("Favorite Playlist",style: TextStyle(
                          fontFamily: helveticaneuemedium,color:tracks?Colors.black38: Colors.black87,
        //                  fontSize: 13
          fontSize: screenwidth*0.0346
                      ),),)),
                  ],)
              ],),),
          AnimatedContainer(
       //     height: 3,
         height: screenheight*0.00449,
            margin: EdgeInsets.only(
    //            top: 4.5
                top: screenarea*0.0000179
            ),
            duration: Duration(milliseconds: 250),
width: screenwidth*0.42,
alignment: tracks?Alignment.centerLeft:Alignment.centerRight,
            child:

            AnimatedContainer(
              duration: Duration(milliseconds: 250),
 //             height: 3,
              height: screenheight*0.00449,

              width: tracks?
             // 45:96
screenwidth*0.12:screenwidth*0.256
              ,
              decoration: BoxDecoration(color: Color(0xff9797de)),
            ),
          ),
      Container(child: AnimatedSwitcher(
      //  key: UniqueKey(),
        duration: Duration(milliseconds: 350),
        child: tracks?trackslist():favplaylist(),
      ),),

              ])


        );
  }
  Widget favplaylist(){
    double screenheight=MediaQuery.of(context).size.height;
    double screenwidth=MediaQuery.of(context).size.width;
    double screenarea=screenheight*screenwidth;
    return Column(
      key: UniqueKey(),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
    Container(
    margin: EdgeInsets.only(
 //       top: 20
   top: screenarea*0.0000799
    ),
    child: Row(mainAxisAlignment: MainAxisAlignment.start,
    children: [
    Container(
 //   height:30,width: 30,
   height: screenheight*0.0449,width: screenheight*0.0449,
    alignment: Alignment.center,
    decoration: BoxDecoration(
    shape: BoxShape.circle,
    border:Border.all(color: Colors.grey[600],width: 1)
    ),
    child: Center(child:
    Icon(CupertinoIcons.plus,
    //  size: 25,
      size: screenwidth*0.0666,
      color: Colors.black54.withOpacity(0.72),),)),
    Container(
    margin: EdgeInsets.only(
  //      left: 11
    left: screenarea*0.0000439
    ),
    child: Text("Create playlist",style: TextStyle(
    fontFamily: helveticaneuemedium,color: Colors.black87,
    ),),)
    ],),),
    Container(
    width: MediaQuery.of(context).size.width*0.85,
    margin: EdgeInsets.only(
//    top: 20,
        top: screenarea*0.0000799
    //  left: 26, right: 26
    //     right: screenarea*0.000103
    ),
    child:
    Column(children:[
    Container(
    margin:EdgeInsets.only(
    //  bottom: 9
//    bottom: 8
  bottom: screenarea*0.0000319
    ),
    child:
    Row(

    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    ClipOval(child: Container(
    //           height: 35,width: 35,
    height: screenwidth*0.093,width: screenwidth*0.093,
    decoration: BoxDecoration(
    shape: BoxShape.circle,
    border:Border.all(color: Color(0xff12c2e9),width: 1,style: BorderStyle.solid)
    //  color: Color(0xff12c2e9),
    ),
    child: Center(child: Icon(Icons.play_arrow,
    color: Color(0xff12c2e9),
    //     size: 26.5,
    size: screenwidth*0.0706,
    ),),
    ),),
    Container(margin: EdgeInsets.only(
    //   left: 11
    left: screenarea*0.0000439
    ),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment:
    MainAxisAlignment.start,
    children: [
    Container(
    margin:EdgeInsets.only(
    //   bottom: 4
    bottom: screenarea*0.0000159
    ),
    child: Text("My Playlist #1",style: TextStyle(
    fontFamily: helveticaneuemedium,color: Color(0xff12c2e9),
    //fontSize: 12.5
    fontSize: screenwidth*0.0333
    ),),),
    Container(child: Text("By Sebastian",style: TextStyle(
    fontFamily: helveticaneueregular,color: Color(0xff12c2e9).withOpacity(0.5),
    //fontSize: 10.5
    fontSize: screenwidth*0.028
    ),),),
    ],),),
    Expanded(child:
    Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children:[
    Text(
    "17:24",
    textAlign:TextAlign.end,style: TextStyle(
    fontFamily: helveticaneuemedium,color: Color(0xff12c2e9),
    // fontSize: 12.5
    fontSize: screenwidth*0.0333
    ),
    ),]))
    ],
    )),
    Divider(thickness: 1,color: Colors.grey[400],)
    ])
    ),

    Container(
    width: MediaQuery.of(context).size.width*0.85,
    margin: EdgeInsets.only(
    //     top: 26,left: 26,right: 26
 //   top: 18,
   top: screenarea*0.0000719
    ),
    child:
    Column(children:[
    Container(
    margin:EdgeInsets.only(
 //   bottom: 8
        bottom: screenarea*0.0000319
    ),
    child:
    Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    ClipOval(child: Container(
    //      height: 35,width: 35,
    height: screenwidth*0.093,width: screenwidth*0.093,
    decoration: BoxDecoration(
    shape: BoxShape.circle,
    border:Border.all(color: Colors.grey[700],width: 1,style: BorderStyle.solid)
    //  color: Color(0xff12c2e9),
    ),
    child: Center(child: Icon(Icons.play_arrow,
    color: Colors.black87,
    //  size: 26.5,
    size: screenwidth*0.0706,
    ),),
    ),),
    Container(margin: EdgeInsets.only(
    //         left: 11
    left: screenarea*0.0000439
    ),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment:
    MainAxisAlignment.start,
    children: [
    Container(
    margin:EdgeInsets.only(
    //  bottom: 4
    bottom: screenarea*0.0000159
    ),
    child: Text("Sleep Playlist",style: TextStyle(
    fontFamily: helveticaneuemedium,color: Colors.black87,
    //fontSize: 12.5
    fontSize: screenwidth*0.0333
    ),),),
    Container(child: Text("By Sebastian",style: TextStyle(
    fontFamily: helveticaneueregular,color: Colors.black54
        .withOpacity(0.5),
    //fontSize: 10.5
    fontSize: screenwidth*0.028
    ),),),
    ],),),
    Expanded(child:
    Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children:[
    Text(
    "17:24",
    textAlign:TextAlign.end,style: TextStyle(
    fontFamily: helveticaneuemedium,color: Colors.black87,
    //fontSize: 12.5
    fontSize: screenwidth*0.0333

    ),
    ),]))
    ],
    )),
    Divider(thickness: 1,color: Colors.grey[400],)
    ])
    ),

    ]);
  }
  Widget trackslist(){
    double screenheight=MediaQuery.of(context).size.height;
    double screenwidth=MediaQuery.of(context).size.width;
    double screenarea=screenheight*screenwidth;
    return Column(
        key: UniqueKey(),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              width: MediaQuery.of(context).size.width*0.85,
              margin: EdgeInsets.only(top:  screenarea*0.000115),

              child:
              Column(children:[
    Slidable(
    actionPane: SlidableDrawerActionPane(),
    actionExtentRatio: 0.24,
        secondaryActions: <Widget>[
          Column(
              mainAxisAlignment:MainAxisAlignment.start,children:[
          Container(
       //       height: 40,width: 40,
         height: screenwidth*0.1066,width: screenwidth*0.1066,
              decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.red,
            ),
            child: Center(child:Container(
           //   height: 4.5,
             height: screenwidth*0.012,
          width: screenwidth*0.048,
              //    width: 18,
              color: Colors.white,
            ),)
          ),
        ])
        ],
    child:
    Container(
                    margin:EdgeInsets.only(
                      //  bottom: 9
           //             bottom: 8
                        bottom: screenarea*0.0000319
                    ),
                    child:
                    Row(

                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(3)),
                          child: Container(
                            height: screenwidth*0.09,width: screenwidth*0.09,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(3)),
                              image: DecorationImage(
                                image: AssetImage("assets/images/medi.png"),
                                fit: BoxFit.cover
                              )
                            ),
child: GestureDetector(
  onTap: (){
    setState(() {
      first=!first;
    });
  },
  child: Icon(first?MdiIcons.heart:FeatherIcons.heart,size: screenwidth*0.044,
  color:first?Colors.redAccent: Colors.white54,),
),
                          ),
                        ),
                        Container(margin: EdgeInsets.only(
                          //   left: 11
                            left: screenarea*0.0000439
                        ),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment:
                          MainAxisAlignment.start,
                            children: [
                              Container(
                                margin:EdgeInsets.only(
                                  //   bottom: 4
                                    bottom: screenarea*0.0000159
                                ),
                                child: Text("Get motivated",style: TextStyle(
                                    fontFamily: helveticaneuemedium,color: Color(0xff12c2e9),
                                    //fontSize: 12.5
                                    fontSize: screenwidth*0.0333
                                ),),),
                              Container(child: Text("Reach your goals with this advice",style: TextStyle(
                                  fontFamily: helveticaneueregular,color: Color(0xff12c2e9).withOpacity(0.5),
                                  //fontSize: 10.5
                                  fontSize: screenwidth*0.028
                              ),),),
                            ],),),
                        Expanded(child:
                        Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children:[
                              Text(
                                "17:24",
                                textAlign:TextAlign.end,style: TextStyle(
                                  fontFamily: helveticaneuemedium,color: Color(0xff12c2e9),
                                  // fontSize: 12.5
                                  fontSize: screenwidth*0.0333
                              ),
                              ),]))
                      ],
                    ))),
                Divider(thickness: 1,color: Colors.grey[400],)
              ])
          ),

          Container(
              width: MediaQuery.of(context).size.width*0.85,
              margin: EdgeInsets.only(
                //     top: 26,left: 26,right: 26
      //          top: 18,
                  top: screenarea*0.0000719
              ),
              child:
              Column(children:[
                Container(
                    margin:EdgeInsets.only(
                //        bottom: 8
                        bottom: screenarea*0.0000319
                    ),
                    child:
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(3)),
                          child: Container(
                            height: screenwidth*0.09,width: screenwidth*0.09,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(3)),
                                image: DecorationImage(
                                    image: AssetImage("assets/images/pexels-karolina-grabowska-4203102.jpg"),
                                    fit: BoxFit.cover
                                )
                            ),
                            child: GestureDetector(
                              onTap: (){
                                setState(() {
                                  second=!second;
                                });
                              },
                              child: Icon(second?MdiIcons.heart:FeatherIcons.heart,size: screenwidth*0.044,
                                color:second?Colors.redAccent: Colors.white54,),
                            ),
                          ),
                        ),
                        Container(margin: EdgeInsets.only(
                          //         left: 11
                            left: screenarea*0.0000439
                        ),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment:
                          MainAxisAlignment.start,
                            children: [
                              Container(
                                margin:EdgeInsets.only(
                                  //  bottom: 4
                                    bottom: screenarea*0.0000159
                                ),
                                child: Text("Remove negative blockage",style: TextStyle(
                                    fontFamily: helveticaneuemedium,color: Colors.black87,
                                    //fontSize: 12.5
                                    fontSize: screenwidth*0.0333
                                ),),),
                              Container(child: Text("Erase Subconscious negative patterns",style: TextStyle(
                                  fontFamily: helveticaneueregular,color: Colors.black54
                                  .withOpacity(0.5),
                                  //fontSize: 10.5
                                  fontSize: screenwidth*0.028
                              ),),),
                            ],),),
                        Expanded(child:
                        Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children:[
                              Text(
                                "17:24",
                                textAlign:TextAlign.end,style: TextStyle(
                                  fontFamily: helveticaneuemedium,color: Colors.black87,
                                  //fontSize: 12.5
                                  fontSize: screenwidth*0.0333

                              ),
                              ),]))
                      ],
                    )),
                Divider(thickness: 1,color: Colors.grey[400],)
              ])
          ),
          Container(
              width: MediaQuery.of(context).size.width*0.85,
              margin: EdgeInsets.only(
                //     top: 26,left: 26,right: 26
        //        top: 18,
                  top: screenarea*0.0000719
              ),
              child:
              Column(children:[
                Container(
                    margin:EdgeInsets.only(
                  //      bottom: 8
                        bottom: screenarea*0.0000319
                    ),
                    child:
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(3)),
                          child: Container(
                            height: screenwidth*0.09,width: screenwidth*0.09,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(3)),
                                image: DecorationImage(
                                    image: AssetImage("assets/images/pexels-pixabay-355209.jpg"),
                                    fit: BoxFit.cover
                                )
                            ),
                            child: GestureDetector(
                              onTap: (){
                                setState(() {
                                  third=!third;
                                });
                              },
                              child: Icon(third?MdiIcons.heart:FeatherIcons.heart,size: screenwidth*0.044,
                                color:third?Colors.redAccent: Colors.white54,),
                            ),
                          ),
                        ),
                        Container(margin: EdgeInsets.only(
                          //         left: 11
                            left: screenarea*0.0000439
                        ),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment:
                          MainAxisAlignment.start,
                            children: [
                              Container(
                                margin:EdgeInsets.only(
                                  //  bottom: 4
                                    bottom: screenarea*0.0000159
                                ),
                                child: Text("Happiness frequency",style: TextStyle(
                                    fontFamily: helveticaneuemedium,color: Colors.black87,
                                    //fontSize: 12.5
                                    fontSize: screenwidth*0.0333
                                ),),),
                              Container(child: Text("Reach your goals with this advice",style: TextStyle(
                                  fontFamily: helveticaneueregular,color: Colors.black54
                                  .withOpacity(0.5),
                                  //fontSize: 10.5
                                  fontSize: screenwidth*0.028
                              ),),),
                            ],),),
                        Expanded(child:
                        Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children:[
                              Text(
                                "17:24",
                                textAlign:TextAlign.end,style: TextStyle(
                                  fontFamily: helveticaneuemedium,color: Colors.black87,
                                  //fontSize: 12.5
                                  fontSize: screenwidth*0.0333

                              ),
                              ),]))
                      ],
                    )),
                Divider(thickness: 1,color: Colors.grey[400],),
              ])
          ),

        ]);
  }
  Widget downloadstab(){
    double screenheight=MediaQuery.of(context).size.height;
    double screenwidth=MediaQuery.of(context).size.width;
    double screenarea=screenheight*screenwidth;
    return Container(
        key: Key("swit"),
        margin: EdgeInsets.only(
        //    top: 12
            top: screenarea*0.0000479
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
            //    width: screenwidth*0.42,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment:MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                            onTap: (){
                              setState(() {

                              });
                            },
                            child:
                            Container(
                              child: Text("Downloaded Tracks",style: TextStyle(
                                  fontFamily: helveticaneuemedium,color:Colors.black87,
                                  //fontSize: 13
                                  fontSize: screenwidth*0.0346

                              ),),)),
                      ],)
                  ],),),
              AnimatedContainer(
              //  height: 3,
                height: screenheight*0.00449,
                decoration: BoxDecoration(color: Color(0xff9797de)),
                margin: EdgeInsets.only(
                //    top: 4.5
                top: screenarea*0.0000179
                ),
                duration: Duration(milliseconds: 250),
                width: screenwidth*0.32,
     //           alignment: tracks?Alignment.centerLeft:Alignment.centerRight,

              ),
              Container(child: premiumpage()),

            ])


    );
  }
Widget premiumpage(){
    double screenheight=MediaQuery.of(context).size.height;
    double screenwidth=MediaQuery.of(context).size.width;
    double screenarea=screenheight*screenwidth;
    return Column(mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            child:
            Container(
//          color: Colors.black87,
              margin: EdgeInsets.only(
                //         top: 22
                  top: screenarea*0.0000879   ),
              width: screenwidth*0.86,
              decoration: BoxDecoration(

                //   color: Colors.black87,
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              //     height: 164,
              height: screenwidth*0.4373,
              child:
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  image: DecorationImage(
                    image: AssetImage("assets/images/premcont.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child:
                Stack(children:[
                  Container(
                      margin: EdgeInsets.only(
                        //     left: 12,top: 16
                          left: screenwidth*0.032,top: screenwidth*0.0426
                      ),
                      child:
                      Column(children:[
                        Row(mainAxisAlignment:MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipOval(child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 10,sigmaY: 10),
                                child:
                                Container(
                                  //      height: 68,width: 68,
                                  height: screenheight*0.1019,width: screenheight*0.1019,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white24
                                  ),
                                  child: Center(
                                    child: Icon(MdiIcons.crownOutline,
                                      color: Color(0xff9797de),
                                      //           size: 30,
                                      size: screenwidth*0.1,
                                    ),
                                  ),
                                )),),
                            Container(
                              margin: EdgeInsets.only(
                                //    left:22
                                  left: screenarea*0.0000879
                              ),
                              child: Column(mainAxisAlignment:MainAxisAlignment.start,crossAxisAlignment:
                              CrossAxisAlignment.start,children: [
                                Container(child: Text("Try Premium?",style: TextStyle(
                                    fontFamily: helveticaneuemedium,
                                    color: Colors.black87,
                                    //              fontSize: 17
                                    fontSize: screenwidth*0.0453
                                ),),),
                                Container(margin: EdgeInsets.only(
                                  //       top: 12
                                    top: screenarea*0.0000479
                                ),
                                  child: Text("Switch to premium for unlimited\ndownloads and uninterrupted\nmusic streaming",
                                    style: TextStyle(
                                        fontFamily: helveticaneueregular,
                                        color: Colors.black38,
                                        //             fontSize: 12.5
                                        fontSize: screenwidth*0.0333
                                    ),),),
                              ],),
                            )

                          ],),
                      ])
                  ),
                  Positioned(
                      right: 12,
                      bottom: 15,
                      child:
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:[
                            SvgPicture.asset('assets/images/white_logo.svg',
//                        height: 350,
                              //        height: 130,
                              height: screenwidth*0.3573,
//                    width: 350*327/426.7,
                              //            fit: BoxFit.scaleDown,
                              //                       alignment: new Alignment(-200,0),
                              //    width: 426*372/426.7,
                              color:Color(0xff9797de).withOpacity(0.45),
                            )])),
                  Positioned(
                      right: 10,
                      bottom: 20,
                      child: Container(
                        //     height: 24,
                        height: screenheight*0.0359,
                        width: screenwidth*0.2026,
                        //      width: 76,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(3)),
                          color: Colors.white,
                        ),
                        child:Center(child:Text("Learn more",style:TextStyle(
                            fontFamily: helveticaneueregular,
                            color: Colors.grey,
                            //       fontSize: 10.5
                            fontSize: screenwidth*0.028
                        ),)),
                      ))
                ]),
              ),




            )),

        Container(
          margin:EdgeInsets.only(
        //      top: 45
         top: screenarea*0.000179
          ),child: Center(
child: Column(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.start,
children: [
  Container(child:

  Text("No downloads yet",style: TextStyle(
    fontFamily: helveticaneuemedium,
    color: Colors.black87,
  //  fontSize: 18
 fontSize: screenwidth*0.048
  ),)),
  Container(margin:EdgeInsets.only(
 //     top: 5
  top: screenarea*0.0000199
  ),child:
      Row(children:[
        Text("Tap ",style: TextStyle(
            fontFamily: helveticaneueregular,
            color: Colors.black38,
      //      fontSize: 10
        fontSize: screenwidth*0.0266
        ),),
  Icon(FeatherIcons.download,
  //  size: 10,
    size: screenwidth*0.0266,
    color: Colors.black38
    ,),
  Text(" on track to listen without connection",style: TextStyle(
      fontFamily: helveticaneueregular,
      color: Colors.black38,
   //   fontSize: 10
      fontSize: screenwidth*0.0266

  ),)])),
],),
        ),)
      ],
    );
}
  emptycode(){}
}
