import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goodvibesofficial/constants/fontconstants.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
class Recommended extends StatefulWidget {
  @override
  _RecommendedState createState() => _RecommendedState();
}

class _RecommendedState extends State<Recommended> {
  bool first=false;
  bool second=false;
  bool third=false;

  bool iszero=true;
  bool sleep=false;
  bool meditate=false;
  bool relax=false;
  bool anxiety=false;
  bool lofi=false;
  bool stress=false;
  bool binaurial=false;
  bool calm=false;
  bool nature=false;
  bool instruments=false;
  bool rain=false;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    double screenheight=MediaQuery.of(context).size.height;
    double screenwidth=MediaQuery.of(context).size.width;
    double screenarea=screenheight*screenwidth;
    return Scaffold(
      backgroundColor: Color(0xfff5f5f5),
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: false,
          title:
              GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
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
      body:
      SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child:
      Container(
        margin: EdgeInsets.only(
          //  left: 18,right: 18
     left: screenarea*0.0000719, right: screenarea*0.0000719

        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
Row(mainAxisAlignment:MainAxisAlignment.start,children: [
  Container(child: Text("Recommended",style: TextStyle(fontFamily: helveticaneuemedium,
  color: Colors.black87,
 //     fontSize: 22
  fontSize: screenwidth*0.0586
  ),),)
],),Row(children:[
            Container(
              margin: EdgeInsets.only(
        //          top: 9
          top: screenarea*0.0000359
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
Container(child: Text("All tracks",style: TextStyle(
  fontFamily: helveticaneuemedium,color: Colors.black87,
//    fontSize: 12.5
fontSize: screenwidth*0.0333
),),),
                Container(
                  margin: EdgeInsets.only(
              //        top: 2
                top: screenarea*0.0000079
                  ),
              //    height: 3,
               //   width: 53,
                  height:screenheight*0.004497,width: screenwidth*0.14133,
                  decoration: BoxDecoration(
                    color: Color(0xff9797de)
                  ),
                )
              ],),
            )]),
            Container(margin: EdgeInsets.only(
              //   top: 16
                top: screenarea*0.0000639
            ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    //     height:35 ,
                      height: screenheight*0.05247,
                      //    width: 244,
                      width:screenwidth*0.65,
                      padding: EdgeInsets.only(
                        //    left: 10,
                          left: screenarea*0.00003998,
                          bottom: 0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                      ),child:Center(child: TextField(
                    style: TextStyle(
                        fontFamily: helveticaneueregular,
                        color: Colors.grey[800],
                        //  fontSize: 14
                        fontSize: screenwidth*0.0373
                    ),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                            fontFamily: helveticaneueregular,
                            color: Colors.grey[300],
                            //        fontSize: 14
                            fontSize: screenwidth*0.0373
                        ),
                        hintText: 'Search'
                    ),
                  ),)
                  ),
                  Container(
                    // width: 60,
                    //      height: 35,
                    width: screenwidth*0.16,
                    height: screenheight*0.05247,
                    margin: EdgeInsets.only(
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                    ),
                    child: Center(child: Icon(Icons.search,
                      //             size:20,
                      size: screenwidth*0.0533,
                      color: Colors.grey[600],),),
                  )
                ],),),
            Container(
              margin: EdgeInsets.only(
           //       top: 16
             top: screenarea*0.0000639
              ),
              child:
                  Row(children:[
                  Container(child: Text("Category",style: TextStyle(
                      fontFamily: helveticaneuemedium,color: Colors.black87,
                      //fontSize: 12.5
                      fontSize: screenwidth*0.0333
                  ),),),])
            ),
            Container(
              margin: EdgeInsets.only(
            //      top: 9
                  top: screenarea*0.0000359
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
Row(
  mainAxisAlignment:MainAxisAlignment.spaceBetween,
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
    //      height: 29,
      height: screenheight*0.0434,
          width: screenwidth*0.2,
          duration: Duration(milliseconds: 150),
          decoration: BoxDecoration(
            color: sleep?Color(0xff9797de):Colors.black.withOpacity(0.3),
            borderRadius: BorderRadius.all(Radius.circular(24)),
          ),
          child:     Center(child:
          Text("Sleep",style: TextStyle(
              fontFamily: helveticaneueregular,
              color: Colors.white,
     //         fontSize: 13
       fontSize: screenwidth*0.03466
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
        //  width: 87,
//          height: 29,
          height: screenheight*0.0434,
          width: screenwidth*0.2,
          duration: Duration(milliseconds: 150),
          decoration: BoxDecoration(
            color: meditate?Color(0xff9797de):Colors.black.withOpacity(0.3),
            borderRadius: BorderRadius.all(Radius.circular(24)),
          ),
          child:     Center(child:
          Text("Meditate",style: TextStyle(
              fontFamily: helveticaneueregular,
              color: Colors.white,
  //            fontSize: 13
              fontSize: screenwidth*0.03466
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
        //  width: 87,
   //       height: 29,
          height: screenheight*0.0434,
          width: screenwidth*0.2,
          duration: Duration(milliseconds: 150),
          decoration: BoxDecoration(
            color: stress?Color(0xff9797de):Colors.black.withOpacity(0.3),
            borderRadius: BorderRadius.all(Radius.circular(24)),
          ),
          child:     Center(child:
          Text("Stress",style: TextStyle(
              fontFamily: helveticaneueregular,
              color: Colors.white,
     //         fontSize: 13
              fontSize: screenwidth*0.03466
          ),),)
      )),
  GestureDetector(
      onTap: (){
        setState(() {
          relax=!relax;
        });
      },
      child:
      AnimatedContainer(
        //  width: 87,
     //     height: 29,
          height: screenheight*0.0434,
          width: screenwidth*0.2,
          duration: Duration(milliseconds: 150),
          decoration: BoxDecoration(
            color: relax?Color(0xff9797de):Colors.black.withOpacity(0.3),
            borderRadius: BorderRadius.all(Radius.circular(24)),
          ),
          child:     Center(child:
          Text("Relax",style: TextStyle(
              fontFamily: helveticaneueregular,
              color: Colors.white,
    //          fontSize: 13
              fontSize: screenwidth*0.03466
          ),),)
      )),
],)
                  ,
                  Container(
                      margin: EdgeInsets.only(
                 //         top: 9
                          top: screenarea*0.0000359
                      ),
                      child:
                  Row(
                    mainAxisAlignment:MainAxisAlignment.spaceBetween,
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
               //               height: 29,
                              height: screenheight*0.0434,
                              width: screenwidth*0.2,
                              duration: Duration(milliseconds: 150),
                              decoration: BoxDecoration(
                                color: calm?Color(0xff9797de):Colors.black.withOpacity(0.3),
                                borderRadius: BorderRadius.all(Radius.circular(24)),
                              ),
                              child:     Center(child:
                              Text("Calm",style: TextStyle(
                                  fontFamily: helveticaneueregular,
                                  color: Colors.white,
               //                   fontSize: 13
                                  fontSize: screenwidth*0.03466
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
                            //  width: 87,
                 //             height: 29,
                              height: screenheight*0.0434,
                              width: screenwidth*0.2,
                              duration: Duration(milliseconds: 150),
                              decoration: BoxDecoration(
                                color: binaurial?Color(0xff9797de):Colors.black.withOpacity(0.3),
                                borderRadius: BorderRadius.all(Radius.circular(24)),
                              ),
                              child:     Center(child:
                              Text("Binaurial",style: TextStyle(
                                  fontFamily: helveticaneueregular,
                                  color: Colors.white,
                   //               fontSize: 13
                                  fontSize: screenwidth*0.03466
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
                            //  width: 87,
                    //          height: 29,
                              height: screenheight*0.0434,
                              width: screenwidth*0.2,
                              duration: Duration(milliseconds: 150),
                              decoration: BoxDecoration(
                                color: nature?Color(0xff9797de):Colors.black.withOpacity(0.3),
                                borderRadius: BorderRadius.all(Radius.circular(24)),
                              ),
                              child:     Center(child:
                              Text("Nature",style: TextStyle(
                                  fontFamily: helveticaneueregular,
                                  color: Colors.white,
                    //              fontSize: 13
                                  fontSize: screenwidth*0.03466
                              ),),)
                          )),
                      GestureDetector(
                          onTap: (){
                            setState(() {
                              rain=!rain;
                            });
                          },
                          child:
                          AnimatedContainer(
                            //  width: 87,
                    //          height: 29,
                              height: screenheight*0.0434,
                              width: screenwidth*0.2,
                              duration: Duration(milliseconds: 150),
                              decoration: BoxDecoration(
                                color: rain?Color(0xff9797de):Colors.black.withOpacity(0.3),
                                borderRadius: BorderRadius.all(Radius.circular(24)),
                              ),
                              child:     Center(child:
                              Text("Rain",style: TextStyle(
                                  fontFamily: helveticaneueregular,
                                  color: Colors.white,
                    //              fontSize: 13
                                  fontSize: screenwidth*0.03466
                              ),),)
                          )),
                    ],)),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(
                     //     top: 29,
top: screenwidth*0.0773,
                          left: 0,right: 0),
                      child:
                      Column(children:[
                        Container(
                            margin:EdgeInsets.only(
                       //         bottom: 9
                         bottom: screenarea*0.0000359
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
                           //         left: 11
                                    left: screenarea*0.0000439
                                ),
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment:
                                  MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin:EdgeInsets.only(
                                       // bottom: 4
                                        bottom: screenarea*0.0000159),
                                        child: Text("Get motivated",style: TextStyle(
                                            fontFamily: helveticaneuemedium,color: Color(0xff12c2e9),
                                            //fontSize: 12.5
                                        fontSize: screenwidth*0.0333
                                        ),),),
                                      Container(child: Text("Reach your goals with this advice",style: TextStyle(
                                          fontFamily: helveticaneueregular,color: Color(0xff12c2e9).withOpacity(0.5),
                                      //    fontSize: 10.5
                                   fontSize: screenwidth*0.028
                                      ),),),
                                    ],),),
                                Expanded(child:
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children:[
                                      Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children:[
                                      Text(
                                        "17:24",
                                        textAlign:TextAlign.end,style: TextStyle(
                                          fontFamily: helveticaneuemedium,color: Color(0xff12c2e9),
                                          //fontSize: 12.5
                                          fontSize: screenwidth*0.0333

                                      ),
                                      ),
                                           GestureDetector(
                                    child:       Icon(Icons.more_vert,
                                              color: Color(0xff12c2e9),
                                     // size: 20,
                                       size: screenwidth*0.0533,
                                              ),
                                              onTap: (){
showModalBottomSheet(
  backgroundColor: Colors.transparent,
  isDismissible: true,
  context: context,
  builder: (context){
    return Container(
      height: screenwidth*0.761,
      decoration: BoxDecoration(
        color: Color(0xff757575),
        borderRadius: BorderRadius.only(topLeft: Radius.circular(12),topRight:Radius.circular(12) )
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        Container(
  //        height:4,width: 75,
    height:screenwidth*0.0106,width: screenwidth*0.2,
          margin: EdgeInsets.only(
        //      top: 8
          top: screenwidth*0.0213
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
        ),
          Container(
            margin: EdgeInsets.only(
       //         top: 40
         top: screenwidth*0.086
            ),
            child: LimitedBox(
              maxHeight: screenwidth*0.561,
              child: ListView(
                physics: BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              children: [
                Container(child: Row(children: [
                  Container(
                      margin:EdgeInsets.only(
                //          left: 6
                  left: screenwidth*0.016
                      ),
                      child:
                  IconButton(icon: Icon(CupertinoIcons.plus,
                  color: Colors.white,
               //   size: 27,
                 size: screenwidth*0.072
                    , ), onPressed: (){

                  })),
                  Container(
                    margin: EdgeInsets.only(
                  //      left: 10
                        left: screenwidth*0.0266
                    ),
                    child: Text("Add to Existing Playlist",style: TextStyle(
                        fontFamily: helveticaneuemedium,
                        color: Colors.white,
               //         fontSize: 15
                 fontSize: screenwidth*0.04
                    ),),
                  )
                ],),),
                Container(
                  margin:EdgeInsets.only(
           //           top: 8
                      top: screenwidth*0.0213
                  ),
                  child: Row(children: [
                  Container(
                      margin:EdgeInsets.only(
                    //      left: 6
                          left: screenwidth*0.016
                      ),
                      child:
                      IconButton(icon: Icon(CupertinoIcons.plus_circled,
                        color: Colors.white,
             //           size: 27,
                          size: screenwidth*0.072
                      ), onPressed: (){

                      })),
                  Container(
                    margin: EdgeInsets.only(
                  //      left: 10
                        left: screenwidth*0.0266
                    ),
                    child: Text("Create Playlist",style: TextStyle(
                        fontFamily: helveticaneuemedium,
                        color: Colors.white,
               //         fontSize: 15
                        fontSize: screenwidth*0.04
                    ),),
                  )
                ],),),
                Container(                  margin:EdgeInsets.only(
              //      top: 8
                    top: screenwidth*0.0213
                ),
                  child: Row(children: [
                  Container(
                      margin:EdgeInsets.only(
                  //        left: 6
                          left: screenwidth*0.016
                      ),
                      child:
                      IconButton(icon: Icon(FeatherIcons.heart,
                        color: Colors.white,
                  //      size: 27,
                          size: screenwidth*0.072
                      ), onPressed: (){

                      })),
                  Container(
                    margin: EdgeInsets.only(
              //          left: 10
                        left: screenwidth*0.0266
                    ),
                    child: Text("Add to Favorites",style: TextStyle(
                        fontFamily: helveticaneuemedium,
                        color: Colors.white,
              //          fontSize: 15
                        fontSize: screenwidth*0.04
                    ),),
                  )
                ],),),
                Container(                  margin:EdgeInsets.only(
             //       top: 8
               top: screenwidth*0.0213
                ),
                  child: Row(children: [
                  Container(
                      margin:EdgeInsets.only(
                //          left: 6
                          left: screenwidth*0.016
                      ),
                      child:
                      IconButton(icon: Icon(FeatherIcons.download,
                        color: Colors.white,
                  //      size: 27,
                          size: screenwidth*0.072
                      ), onPressed: (){

                      })),
                  Container(
                    margin: EdgeInsets.only(
                  //      left: 10
                   left: screenwidth*0.0266
                    ),
                    child: Text("Download",style: TextStyle(
                        fontFamily: helveticaneuemedium,
                        color: Colors.white,
                   //     fontSize: 15
                        fontSize: screenwidth*0.04
                    ),),
                  )
                ],),),
              ],
            ),),
          )
      ],),
    );
  }
);
                                              })
                                          ]),]))
                              ],
                            )),
                        Divider(thickness: 1,color: Colors.grey[400],)
                      ])
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(
                       //   top: 18,
                          top: screenarea*0.0000719,

                          left: 0,right: 0),
                      child:
                      Column(children:[
                        Container(
                            margin:EdgeInsets.only(
                         //       bottom: 9
                           bottom: screenarea*0.0000359
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
                                        //    bottom: 4
                                            bottom: screenarea*0.0000159  ),
                                        child: Text("Remove negative blockage",style: TextStyle(
                                            fontFamily: helveticaneuemedium,color: Colors.black87,
                                      //      fontSize: 12.5
                                                                                fontSize: screenwidth*0.0333
),),),
                                      Container(child: Text("Reach your goals with this advice",style: TextStyle(
                                          fontFamily: helveticaneueregular,color: Colors.black87.withOpacity(0.5),
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
                                          fontFamily: helveticaneuemedium,color: Colors.black38,
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
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(
                      //    top: 18,
                          top: screenarea*0.0000719,

                          left: 0,right: 0),
                      child:
                      Column(children:[
                        Container(
                            margin:EdgeInsets.only(
                       //         bottom: 9
                         bottom: screenarea*0.0000359
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
                             //       left: 11
                                    left: screenarea*0.0000439
                                ),
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment:
                                  MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin:EdgeInsets.only(
                                   //     bottom: 4
                                       bottom: screenarea*0.0000159   ),
                                        child: Text("Happiness Frequency",style: TextStyle(
                                            fontFamily: helveticaneuemedium,color: Colors.black87,
                                            //fontSize: 12.5
                                                                                fontSize: screenwidth*0.0333
),),),
                                      Container(child: Text("Reach your goals with this advice",style: TextStyle(
                                          fontFamily: helveticaneueregular,color: Colors.black87.withOpacity(0.5),
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
                                          fontFamily: helveticaneuemedium,color: Colors.black38,
                                          //fontSize: 12.5
                                          fontSize: screenwidth*0.0333

                                      ),
                                      ),]))
                              ],
                            )),
                        Divider(thickness: 1,color: Colors.grey[400],)
                      ])
                  ),
                  Row(mainAxisAlignment:MainAxisAlignment.start,children: [
                    Container(
                      margin:EdgeInsets.only(
                   //       top: 21
                     top:screenarea*0.0000839
                      ),
                      child: Text("More Recommended",style: TextStyle(fontFamily: helveticaneuemedium,
                        color: Colors.black87,
                         // fontSize: 17
                      fontSize: screenwidth*0.0453
                      ),),)
                  ],)
              ],),
            ),
            Container(
              //      height: 500,
                margin: EdgeInsets.only(
                  top: screenarea*0.0000879,
                  //         left: 22,right: 22,bottom: 18
     //               left:screenarea*0.0000879,right: screenarea*0.0000879,
                    bottom:screenarea*0.0000719
                ),
//              left: screenarea*0.0001039,
                child:
                Column(mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(children: [
                          Container(child:Column(children: [
                            ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(8)),
                                child:
                                Container(
                                  //  height: 135,
                                  height:screenheight*0.202,
                                  width: screenwidth*0.42,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(8)),
                                  ),
                                  child: Image.asset(images(0),fit: BoxFit.cover,),)),
                            Container(
                              width: screenwidth*0.42,

                              margin: EdgeInsets.only(
                                //      top: 8,bottom: 8
                                  top:screenarea*0.0000319
                                  ,bottom: screenarea*0.0000319),
                              child: Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,

                                mainAxisSize:MainAxisSize.max,
                                children: [
                                  Container(
                                    //height: 30,
                                    height:screenheight*0.0449,
                                    child: Text("Binaurial tracks to reduce\nstress",style: TextStyle(
                                        fontFamily: helveticaneuemedium,color: Colors.black87,
                                        //   fontSize: 11
                                        fontSize: screenwidth*0.0293
                                    ),),),
                                  Icon(Icons.more_vert,
                                    //  size: 15.5,
                                    size:screenwidth*0.0413,
                                    color: Colors.black87,)
                                ],),
                            )
                          ],)),
                          Container(child:Column(children: [
                            ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(8)),
                                child:
                                Container(
                                  //  height: 240,
                                  height: screenheight*0.359,
                                  width: screenwidth*0.42,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(8)),
                                  ),
                                  child: Image.asset(images(1),fit: BoxFit.cover,),)),
                            Container(
                              width: screenwidth*0.42,

                              margin: EdgeInsets.only(
                                //       top: 8,bottom: 8
                                  top:screenarea*0.0000319
                                  ,bottom: screenarea*0.0000319 ),
                              child: Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,

                                mainAxisSize:MainAxisSize.max,
                                children: [
                                  Container(
                                    //height: 30,
                                    height:screenheight*0.0449,
                                    child: Text("Instrumental Beats",style: TextStyle(
                                        fontFamily: helveticaneuemedium,color: Colors.black87,
                                        //fontSize: 11
                                        fontSize: screenwidth*0.0293
                                    ),),),
                                  Icon(Icons.more_vert,
                                    //      size: 15.5,
                                    size:screenwidth*0.0413,
                                    color: Colors.black87,)
                                ],),
                            )
                          ],))
                        ],),
                        Column(children: [
                          Container(child:Column(children: [
                            ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(8)),
                                child:
                                Container(
                                  //     height: 240,
                                  height: screenheight*0.359,
                                  width: screenwidth*0.42, decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(8)),
                                ),
                                  child: Image.asset(images(2),fit: BoxFit.cover,),)),
                            Container(          width: screenwidth*0.42,
                              margin: EdgeInsets.only(
                                //    top: 8,bottom: 8
                                  top:screenarea*0.0000319
                                  ,bottom: screenarea*0.0000319
                              ),
                              child: Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize:MainAxisSize.max,
                                children: [
                                  Container(
                                    //height: 30,
                                    height:screenheight*0.0449,

                                    child: Text("Time to relax",style: TextStyle(
                                        fontFamily: helveticaneuemedium,color: Colors.black87,
                                        //fontSize: 11
                                        fontSize: screenwidth*0.0293
                                    ),),),
                                  Icon(Icons.more_vert,
                                    //      size: 15.5,
                                    size:screenwidth*0.0413,
                                    color: Colors.black87,)
                                ],),
                            )
                          ],)),
                          Container(
                              child:Column(children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.all(Radius.circular(8)),
                                    child:     Container(
                                      //   height: 135,
                                      height:screenheight*0.202,
                                      width: screenwidth*0.42, decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(8)),
                                    ),
                                      child: Image.asset(images(3),fit: BoxFit.cover,),)),
                                Container(          width: screenwidth*0.42,

                                  margin: EdgeInsets.only(
                                    //     top: 8
                                      top:screenarea*0.0000319
                                  ),
                                  child: Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize:MainAxisSize.max,
                                    children: [
                                      Container(
                                        //      height: 30,
                                        height:screenheight*0.0449,
                                        child: Text("ASMR - Time to relax",style: TextStyle(
                                            fontFamily: helveticaneuemedium,color: Colors.black87,
                                            //fontSize: 11
                                            fontSize: screenwidth*0.0293
                                        ),),),
                                      Icon(Icons.more_vert,
                                        //   size: 15.5,
                                        size:screenwidth*0.0413,
                                        color: Colors.black87,)
                                    ],),
                                )
                              ],))
                        ],),

                      ],),
                  ],)
            )
        ],),
      )),
    );
  }
  images(int index){
    if(index==0){
      return "assets/images/pexels-pixabay-355209.jpg";
    }
    if(index==1){
      return "assets/images/pexels-hoang-loc-1905054.jpg";
    }    if(index==2){
      return "assets/images/pexels-karolina-grabowska-4203102.jpg";
    }    if(index==3){
      return "assets/images/pexels-maël-balland-3099153.jpg";
    }


  }

}
