import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goodvibesofficial/constants/fontconstants.dart';
import 'package:goodvibesofficial/screens/initcategories/anxiety.dart';
import 'package:goodvibesofficial/screens/initcategories/calm.dart';
import 'package:goodvibesofficial/screens/initcategories/sleep.dart';
import 'package:goodvibesofficial/screens/initcategories/stress.dart';
import 'package:goodvibesofficial/screens/plays/breathe.dart';
import 'package:goodvibesofficial/screens/plays/meditate.dart';
import 'package:intl/intl.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String currenttimeofday='Morning';
  @override
  void initState() {
    super.initState();
 // timeofdaygreeting();
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    double screenwidth=MediaQuery.of(context).size.width;
    double screeheight=MediaQuery.of(context).size.height;
double screenarea=screeheight*screenwidth;
    return
    SafeArea(child:
    CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(

          actions: [
            Container(
        //      height: 45,
          //    width: 45,
              height: screenarea*0.0001799,
              width: screenarea*0.0001799,
              margin: EdgeInsets.only(
                top:8,
             //     right: 20
                right: screenarea*0.00007996
              ),
              child: Image.asset('assets/images/profile@3x.png',
             //   width: 45,
                width:screenwidth*0.12,
                fit: BoxFit.contain,
              ),
            )
          ],
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Color(0xfff5f5f5),
          centerTitle: false,
          title:
          Container(
            margin: EdgeInsets.only(
                top:8,
                //        left: 14
left: screenarea*0.00005597
            ),
            //        padding: EdgeInsets.all(8),
            child: SvgPicture.asset('assets/images/white_logo.svg',
              color: Color(0xff9797de),
              //      fit: BoxFit.cover,
                    width: screenwidth*0.101
              //  width: 38,
            ),
          ),
        ),  SliverList(
        delegate: SliverChildListDelegate(
        [
        SingleChildScrollView(child:
        Column(mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(

                margin: EdgeInsets.only(
                 //   left:26
                  left: screenarea*0.0001039,
                  top: screenarea*0.00001999
                  //  top: 5
                ),
                child: Text(
                  int.parse(DateFormat.H('en_US').format(DateTime.now()))<12?'Good\nMorning'
                      :'Good\nAfternoon',
                  style: TextStyle(
                      fontFamily: helveticaneuebold,
                      color:Colors.black87,
                      fontSize: screenwidth*0.096

                  ),
                )
            ),
            Container(
                margin: EdgeInsets.only(
                  left: screenarea*0.0001039,
                ),
                child: Text(
                  'How are you feeling today?',style: TextStyle(
                    fontFamily: helveticaneueregular,
                    color:Colors.grey[600],
                 //   fontSize: 14
                fontSize: screenwidth*0.03733
                ),
                )
            ),
            Container(margin: EdgeInsets.only(
             //   top: 16
            top: screenarea*0.0000639
            ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                 //     height:35 ,
                   height: screeheight*0.05247,
                  //    width: 244,
                    width: screenwidth*0.597,
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
                height: screeheight*0.05247,
                    margin: EdgeInsets.only(
                        left: screenarea*0.00007996
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
                    //left:26 ,
                  left: screenarea*0.0001039,
                //    top: 12
            top: screenarea*0.0000479
                ),
                child:
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children:[
                      Text("For you",style: TextStyle(
                          fontFamily: helveticaneuemedium,
                          color: Colors.black87,
                 //         fontSize: 18
                   fontSize: screenwidth*0.048
                      ),),])),
            Container(
              margin: EdgeInsets.symmetric(
                  vertical:  screenarea*0.0000639
              ),
           //   height: 68,
              height: screeheight*0.1019,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                      onTap:(){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>
                        Anxiety()));
                      },
                      child:
                  Container(
            //        height: 68,
              //      width: 68,
                    height: screeheight*0.1019,
width:  screeheight*0.1019,
child:
    Hero(
    tag: "anxiety",
    child:
Image.asset("assets/images/anxiety.png",
//  width: 68,
width:  screeheight*0.1019,
)),
                  )),
                  GestureDetector(
                      onTap:(){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>
                        Calm()));
                  },child:
                  Container(
               //     height: 68,
             //       width: 68,
                 height:  screeheight*0.1019,
                      width:  screeheight*0.1019,
                      child:
    Hero(
    tag: "calm",
    child:
                      Image.asset("assets/images/calm.png",
                     //   width: 68,
                      width:  screeheight*0.1019,
                      ),
    )
                  ))
                  ,    GestureDetector(
    onTap:(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>
    Stress()));
    },child:
                  Container(
                    //height: 68,width: 68,
                    height:  screeheight*0.1019,width:  screeheight*0.1019,
                    child:
    Hero(
    tag: "stress",
    child:
                    Image.asset("assets/images/stress icon@2x.png",
                  //    width: 68,
                    width:  screeheight*0.1019,
                    )),
                  ))
                  ,
    GestureDetector(
    onTap:(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>
    Sleep()));
    },child:
                  Container(
                    //height: 68,width: 68,
                    height:  screeheight*0.1019,width:  screeheight*0.1019,
                    child:   Hero(
    tag: "sleep",
    child:Image.asset("assets/images/sleep icon@3x.png",
                  //    width: 68,
                      width:  screeheight*0.1019,
    )),
                  ))
                ],
              ),),

            Container(
                margin: EdgeInsets.only(
                left: screenarea*0.0001039,
                  //    left:26 ,
                //    top: 4
top: screenarea*0.00001599
                ),
                child:
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children:[
                      Text("Explore",style: TextStyle(
                          fontFamily: helveticaneuemedium,
                          color: Colors.black87,
                     //     fontSize: 18
                          fontSize: screenwidth*0.048
                      ),),])),
            Container(margin: EdgeInsets.only(
                top: screenarea*0.00007996
            ),
          //    height: 239,
              height: screeheight*0.358,
      //        width: 239*855/987,
              child:

             new ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>
                        Breathe()));
                      },
                      child:
Container(
    margin: EdgeInsets.only(
    left: screenarea*0.0001039
      //    left: 26
    ),
    child:
               new       Stack(
                   children:[
                   Hero(
                   tag: "picture",
                   child:
    Image.asset("assets/images/medi.png",fit: BoxFit.cover,
                      )),

                     Column(mainAxisAlignment:MainAxisAlignment.end,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                       Row(
                         mainAxisAlignment:MainAxisAlignment.start,children: [
                           Container(
                               margin: EdgeInsets.only(
                                   left: screenarea*0.00003998
                               ),
                               child:
                         Text("Breathing with your body",style: TextStyle(
                           fontFamily: helveticaneuemedium,
                           color: Colors.white,
                         //    fontSize: 15
                        fontSize: screenwidth*0.04
                         ),))
                       ],),
                       Row(mainAxisAlignment:MainAxisAlignment.start,
                         children: [
                      Container(
                          margin: EdgeInsets.only(
                              left: screenarea*0.00003998,
                          //    top: 4
                        top: screenarea*0.0000159
                          ),
                          child:     Text("Harmonize Your Body, Mind\nAnd Inner Self",style: TextStyle(
                               fontFamily: helveticaneueregular,
                               color: Colors.white54,
                          //    fontSize: 12
                          fontSize: screenwidth*0.032
                          ),))
                         ],),
Row(children: [
  Container(margin: EdgeInsets.symmetric(
    //  vertical: 12,
  //    horizontal: 6
    vertical:  screenarea*0.0000479,
  horizontal: screenarea*0.0000239
  ),
  padding:EdgeInsets.symmetric(
    //  horizontal: 6
  horizontal: screenarea*0.0000239
  ),
  child: Row(mainAxisAlignment:MainAxisAlignment.center,children: [
    Container(
  //    height:34,width: 34,
      height: screenwidth*0.0906,width: screenwidth*0.0906,
      child: Icon(Icons.play_arrow,color: Colors.white70,
     //   size: 24,
      size: screenwidth*0.064,
      ),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey[600]
      ),
    ),
    Container(margin: EdgeInsets.only(
   //     left: 8
      left: screenarea*0.0000319
    ),
      child: Text('10 Min',style: TextStyle(
        fontFamily: helveticaneueregular,
        color: Colors.white.withOpacity(0.80),
     //    fontSize:12
          fontSize: screenwidth*0.032
      ),),
    )
  ],),
  )
],
)
                     ],)
                   ]))),
    new       Container(
    margin: EdgeInsets.symmetric(
      horizontal: screenarea*0.0001039
      //  horizontal: 26
    ),
    child:Stack(children:[
              new    Image.asset("assets/images/candle.png",
                  ),
      Column(mainAxisAlignment:MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment:MainAxisAlignment.start,children: [
            Container(
                margin: EdgeInsets.only(
                    left: screenarea*0.00003998
                ),
                child:
                Text("Meditation",style: TextStyle(
                    fontFamily: helveticaneuemedium,
                    color: Colors.white,
                    //fontSize: 15
                fontSize: screenwidth*0.04
                ),))
          ],),
          Row(mainAxisAlignment:MainAxisAlignment.start,
            children: [
              Container(
                  margin: EdgeInsets.only(
                      left: screenarea*0.00003998,
                   //   top: 4
                    top: screenarea*0.0000159
                  ),
                  child:     Text("Calming Sounds For You To Find\nMotivation",style: TextStyle(
                      fontFamily: helveticaneueregular,
                      color: Colors.white54,
         //             fontSize: 12
                      fontSize: screenwidth*0.032
                  ),))
            ],),
          Row(children: [
            Container(margin: EdgeInsets.symmetric(
          //      vertical: 12,
            vertical:  screenarea*0.0000479,
              //    horizontal: 6
                horizontal: screenarea*0.0000239),
              padding:EdgeInsets.symmetric(
              //    horizontal: 6
                horizontal: screenarea*0.0000239
              ),
              child: Row(mainAxisAlignment:MainAxisAlignment.center,children: [
                Container(
          //        height:34,width: 34,
                  height: screenwidth*0.0906,width: screenwidth*0.0906,

                  child: Icon(Icons.play_arrow,color: Colors.white70,
                  //  size: 24,
                  size:  screenwidth*0.064,
                  ),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[600]
                  ),
                ),
                Container(margin: EdgeInsets.only(
        //            left: 8
                    left: screenarea*0.0000319
                ),
                  child: Text('10 Min',style: TextStyle(
                      fontFamily: helveticaneueregular,
                      color: Colors.white.withOpacity(0.80),
                  //    fontSize:12
                      fontSize: screenwidth*0.032

                  ),),
                )
              ],),
            )
          ],
          )
        ],)

    ]),),
                  Container(
                      margin: EdgeInsets.only(
                        right: screenarea*0.0001039
                        // right: 26
                      ),
                      child:
                      new       Stack(
                          children:[
                            Image.asset("assets/images/medi.png",fit: BoxFit.cover,
                            ),

                            Column(mainAxisAlignment:MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:MainAxisAlignment.start,children: [
                                  Container(
                                      margin: EdgeInsets.only(
                                          left: screenarea*0.00003998
                                      ),
                                      child:
                                      Text("Meditation",style: TextStyle(
                                          fontFamily: helveticaneuemedium,
                                          color: Colors.white,
                                         // fontSize: 15
                                      fontSize: screenwidth*0.04
                                      ),))
                                ],),
                                Row(mainAxisAlignment:MainAxisAlignment.start,
                                  children: [
                                    Container(
                                        margin: EdgeInsets.only(
                                            left: screenarea*0.00003998,
                                 //           top: 4
                                   top: screenarea*0.0000159
                                        ),
                                        child:     Text("Calming Sounds For You To Find\nMotivation",style: TextStyle(
                                            fontFamily: helveticaneueregular,
                                            color: Colors.white54,
                                        //    fontSize: 12
                                            fontSize: screenwidth*0.032

                                        ),))
                                  ],),
                                Row(children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        //vertical: 12,
                                    //    horizontal: 6
                                    vertical:  screenarea*0.0000479,
                                        horizontal: screenarea*0.0000239
                                    ),
                                    padding:EdgeInsets.symmetric(
                                     //   horizontal: 6
                                        horizontal: screenarea*0.0000239
                                    ),
                                    child: Row(mainAxisAlignment:MainAxisAlignment.center,children: [
                                      Container(
                             //           height:34,width: 34,
                                        height: screenwidth*0.0906,width: screenwidth*0.0906,

                                        child: Icon(Icons.play_arrow,color: Colors.white70,
                                     //     size: 24,
                                          size:  screenwidth*0.064,
                                        ),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.grey[600]
                                        ),
                                      ),
                                      Container(margin: EdgeInsets.only(
                                   //       left: 8
                                          left: screenarea*0.0000319
                                      ),
                                        child: Text('10 Min',style: TextStyle(
                                            fontFamily: helveticaneueregular,
                                            color: Colors.white.withOpacity(0.80),
                                        //    fontSize:12
                                            fontSize: screenwidth*0.032

                                        ),),
                                      )
                                    ],),
                                  )
                                ],
                                )
                              ],)
                          ])),

                ],),        ),
            Container(
              margin: EdgeInsets.only(
                 // left:26 ,
                 left: screenarea*0.0001039,
right: screenarea*0.0001039,
               //   top: 10
                top: screenarea*0.00003998
              ),
                //  right: 26),
              child:
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:[
              Text("Recommended",style: TextStyle(
                fontFamily: helveticaneuemedium,
                color: Colors.black87,
              //    fontSize: 18
                  fontSize: screenwidth*0.048
              ),),
                  Text('Show All',style: TextStyle(
                    fontFamily: helveticaneueregular,
                    color: Colors.black.withOpacity(0.4),
                      //fontSize: 14
                      fontSize: screenwidth*0.0373

                  ),)
                  ])),
            Container(
              margin: EdgeInsets.only(
               //   top: 16,
                 // bottom:16
              top:  screenarea*0.0000639,bottom:  screenarea*0.0000639
              ),
            //  height: 130,
              height: screeheight*0.194,
              child:

              ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                      //height: 100,
                    height:screeheight*0.1499,
                      margin: EdgeInsets.only(
                   //       right: 26,
                     //     left: 26
                      right: screenarea*0.0001039,
                      left: screenarea*0.0001039
                      ),

                          child:
                  Stack(children:[
                  Image.asset("assets/images/illustration@3x.png",
             //     width: screenwidth*0.90,
              //      width: screeheight*screenwidth*0.00042,
                  ),
                    Container(

                        child:Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:[
                          Container(margin:EdgeInsets.only(top: 15,
                           //   left: 10
                            left: screenarea*0.00003998
                          ),
                              child:
                    Text('Activate your higher mind for\nsuccess subconscious mind\nprogramming',style: TextStyle(
                        fontFamily: helveticaneuemedium,
                        color: Colors.white,
                    //    fontSize: 14
                        fontSize: screenwidth*0.0373
                    ),)),
                          Row(mainAxisAlignment:MainAxisAlignment.start,children: [
                            Container(margin: EdgeInsets.symmetric(
                       //         vertical: 12,
                         //       horizontal: 6
                              vertical:  screenarea*0.0000479,
                                horizontal: screenarea*0.0000239
                            ),
                              padding:EdgeInsets.symmetric(
                                  horizontal: screenarea*0.0000239
                                // horizontal: 6
                              ),
                              child: Row(mainAxisAlignment:MainAxisAlignment.center,children: [
                                Container(
                        //          height:34,width: 34,
                                  height: screenwidth*0.0906,width: screenwidth*0.0906,

                                  child: Icon(Icons.play_arrow,color: Colors.white70,
                               //     size: 24,
                                    size:  screenwidth*0.064,

                                  ),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white38
                                  ),
                                ),
                                Container(margin: EdgeInsets.only(
                       //             left: 8
                                    left: screenarea*0.0000319
                                ),
                                  child: Text('10 Min',style: TextStyle(
                                      fontFamily: helveticaneueregular,
                                      color: Colors.white.withOpacity(0.80),
                                  //    fontSize:12
                                      fontSize: screenwidth*0.032

                                  ),),
                                )
                              ],),
                            )
                          ],
                          )
                        ])),

                  ])),
                  Container(
             //         height: 150,
                    height: screeheight*0.2248,
margin: EdgeInsets.only(
   // right: 26
right: screenarea*0.0001039
),
                      child:
                      Stack(children:[
                        Image.asset("assets/images/illustration@2x.png",
                          //     width: screenwidth*0.90,
                          //      width: screeheight*screenwidth*0.00042,
                        ),
                        Container(child:Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:[
                              Container(margin:EdgeInsets.only(top: 15,
                               //   left: 10
                              left: screenarea*0.00003998
                              ),
                                  child:
                                  Text('Activate your higher mind for\nsuccess subconscious mind\nprogramming',style: TextStyle(
                                      fontFamily: helveticaneuemedium,
                                      color: Colors.white,
                      //                fontSize: 14
                                      fontSize: screenwidth*0.0373

                                  ),)),
                              Row(mainAxisAlignment:MainAxisAlignment.start,children: [
                                Container(margin: EdgeInsets.symmetric(
                                 //   vertical: 12,
                                //    horizontal: 6
                                 vertical:  screenarea*0.0000479,
                                    horizontal: screenarea*0.0000239

                                ),
                                  padding:EdgeInsets.symmetric(
                        //              horizontal: 6
                                      horizontal: screenarea*0.0000239
                                  ),
                                  child: Row(mainAxisAlignment:MainAxisAlignment.center,children: [
                                    Container(
                         //             height:34,width: 34,
                                      height: screenwidth*0.0906,width: screenwidth*0.0906,

                                      child: Icon(Icons.play_arrow,color: Colors.white70,
                                //        size: 24,
                                        size:  screenwidth*0.064,

                                      ),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white38
                                      ),
                                    ),
                                    Container(margin: EdgeInsets.only(
                             //           left: 8
                                        left: screenarea*0.0000319
                                    ),
                                      child: Text('10 Min',style: TextStyle(
                                          fontFamily: helveticaneueregular,
                                          color: Colors.white.withOpacity(0.80),
                                         // fontSize:12
                                          fontSize: screenwidth*0.032

                                      ),),
                                    )
                                  ],),
                                )
                              ],
                              )
                            ])),
                      ])),
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.only(
              //      left:26 ,
                //    right: 26
                left: screenarea*0.0001039,
                  right: screenarea*0.0001039
                ),
                child:
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children:[
                      Text("Meditate",style: TextStyle(
                          fontFamily: helveticaneuemedium,
                          color: Colors.black87,
                  //        fontSize: 18
                          fontSize: screenwidth*0.048

                      ),),

                    ])),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>
                Meditate()));
              },
                child:
            Container(
              margin: EdgeInsets.only(
  //                top: 13,
                top: screenarea*0.0000519,
            //      right: 26,
              //    left:26,
                //  bottom:26
    right: screenarea*0.0001039,
                left: screenarea*0.0001039,
                bottom: screenarea*0.0001039
     ),
         //     height: 168,
              height: screeheight*0.2518,
              child: Center(child:Stack(children: [
                Hero(tag: 'log',
                    child:
                Image.asset("assets/images/lotus@3x.png",
             //     width: 323,
                  width: screenwidth*0.861,
                )),
                Container(
                  margin: EdgeInsets.all(screenarea*0.00003998
                  //    10
                  ),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(margin:EdgeInsets.only(
                 //         top: 6,
                        top: screenarea*0.0000239
                          ,
                        left: screenarea*0.00003998
                        //  left: 10
                      ),
                          child:
                          Text('Ready To Start\nMeditation?',style: TextStyle(
                              fontFamily: helveticaneuemedium,
                              color: Colors.white,
                       //       fontSize: 18
                              fontSize: screenwidth*0.048

                          ),)),
                      Container(
                          margin: EdgeInsets.only(
                      //        left: 10,
                            left: screenarea*0.00003998,
                            top:  screenarea*0.0000639
                            //  top: 16
                          ),
                          child:     Text("Regain Your Inner\nPeace",style: TextStyle(
                              fontFamily: helveticaneueregular,
                              color: Colors.white54,
                           //   fontSize: 12
                              fontSize: screenwidth*0.032

                          ),)),
                      Row(children: [
                        Container(margin: EdgeInsets.only(
                       //     top: 13,
                          top: screenarea*0.0000519,
                      //      left: 6,right:6
                          left:  screenarea*0.0000239,right:  screenarea*0.0000239
                        ),
                          padding:EdgeInsets.symmetric(
                          //    horizontal: 6
                            horizontal:  screenarea*0.0000239
                          ),
                          child: Row(mainAxisAlignment:MainAxisAlignment.center,children: [
                            Container(
                  //            height:34,width: 34,
                              height: screenwidth*0.0906,width: screenwidth*0.0906,

                              child: Icon(Icons.play_arrow,color: Colors.white70,
                       //         size: 24,
                                size:  screenwidth*0.064,
                              ),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white38
                              ),
                            ),
                            Container(margin: EdgeInsets.only(
                           //     left: 8
                              left: screenarea*0.0000319
                            ),
                              child: Text('10 Min',style: TextStyle(
                                  fontFamily: helveticaneueregular,
                                  color: Colors.white.withOpacity(0.80),
                             //     fontSize:12
                                  fontSize: screenwidth*0.032
                              ),),
                            )
                          ],),
                        )
                      ],
                      )
                ],),)
              ],)),
            ))
          ],))]))

      ],
    ));

  }
  timeofdaygreeting(){
    if(int.parse(DateFormat.H('en_US').format(DateTime.now()))<12){
setState(() {
  currenttimeofday='Morning';
});
    }
    if(int.parse(DateFormat.H('en_US').format(DateTime.now()))>12 && int.parse(DateFormat.H('en_US').format(DateTime.now()))<5){
     setState(() {
       currenttimeofday='Afternoon';
     });
    }
    if(int.parse(DateFormat.H('en_US').format(DateTime.now()))>12 && int.parse(DateFormat.HOUR)<5){
setState(() {
  currenttimeofday='Evening';
});    }
  }
}
