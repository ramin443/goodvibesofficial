

import 'dart:ui';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:goodvibesoffl/Goal/goalmodel.dart';
import 'package:goodvibesoffl/Goal/goalsdbhelper.dart';
import 'package:goodvibesoffl/constants/fontconstants.dart';
import 'package:goodvibesoffl/models/music_model.dart';
import 'package:goodvibesoffl/models/playable_model.dart';
import 'package:goodvibesoffl/providertest/newtest.dart';
import 'package:goodvibesoffl/screens/explore/recommended.dart';
import 'package:goodvibesoffl/screens/home/home.dart';
import 'package:goodvibesoffl/screens/home/library.dart';
import 'package:goodvibesoffl/screens/home/profile.dart';
import 'package:goodvibesoffl/screens/initcategories/anxiety.dart';
import 'package:goodvibesoffl/screens/initcategories/calm.dart';
import 'package:goodvibesoffl/screens/initcategories/sleep.dart';
import 'package:goodvibesoffl/screens/initcategories/stress.dart';
import 'package:goodvibesoffl/screens/plays/meditate.dart';
import 'package:goodvibesoffl/screens/premium/getpremium.dart';
import 'package:goodvibesoffl/screens/sharables/MusicPlayer.dart';
import 'package:goodvibesoffl/screens/sharables/mini_player.dart';
import 'package:goodvibesoffl/screens/sharables/music_player.dart';
import 'package:goodvibesoffl/screens/sharables/playlist_sharable.dart';
import 'package:goodvibesoffl/screens/sharables/single_playlist.dart';
import 'package:goodvibesoffl/services/api_service.dart';
import 'package:intl/intl.dart';
import 'package:goodvibesoffl/constants/styleconstants.dart'as Styleconst;
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../locator.dart';

class Base extends StatefulWidget {
  @override
  _BaseState createState() => _BaseState();
}

class _BaseState extends State<Base> {
  GoalsDatabaseHelper goalsDatabaseHelper = GoalsDatabaseHelper();
  List<GoalsModel> goalsList;
  int count = 0;
  List<Playablee> _exploretracks=[];
  List<Track> _todaytracks=[];

  bool playing=false;
  bool playmorethanonce=false;
  String currenttimeofday='Morning';
  int currentindex=0;
  bool tabtap=false;
  int totalduration=0;
  int currentprogress=0;
bool loop=false;
  List _children=[
  Home(),
  Library(),
  Profile()
];
  @override
  initState() {
    super.initState();
//    addcurrentaudiolistener();
    updateListView();

    fetchexploretracks();
    fetchtodaytracks();
    if (goalsList == null) {
      goalsList = List<GoalsModel>();
      updateListView();
    }
print(goalsList.length);
  }
  getexploreillustration(int index){
    if(index.isEven){
      return "assets/images/illustration@3x.png";
    }
    if(index.isOdd){
      return "assets/images/illustration@2x.png";
    }
  }
  getrecenttrackpicture(int index){
    if(index==0){
      return "assets/images/simpleleaf.png";
    }
    if(index==1){
return "assets/images/darkerleaf.png";
    }
  }
  fetchexploretracks()async{
    Map exploretracksresponse= await locator<ApiService>().getPlaylist(slug: 'suggested',page: 1,perpage: 15);
    List<dynamic> playlistlist=exploretracksresponse['data'] as List;
    var plays=playlistlist.map<Playablee>((json) => Playablee.fromJson(json));
    setState(() {
      _exploretracks.addAll(plays);
    });
  }
  fetchtodaytracks()async{
    Map todaytracksresponse= await locator<ApiService>().getRecentTracks(page: 1,perpage: 2);
    List<dynamic> playlistlist=todaytracksresponse['data'] as List;
    var todaytracs=playlistlist.map<Track>((json) => Track.fromJson(json));
    setState(() {
      _todaytracks.addAll(todaytracs);
    });
  }
  getrecommendedimage(int index){
    if(index.isEven){
      return  "assets/images/meds.png";
    }
    if(index.isOdd){
      return "assets/images/candlee.png";
    }

  }
  getrecommendedslug(String playlist){
    if(playlist=='sleep'){
      return 'deep-sleep';
    }
    if(playlist=='calm'){
      return 'Anti-Anxiety';
    }
    if(playlist=='sleep'){
      return 'deep-sleep';
    }
    if(playlist=='meditate'){
      return 'day_meditation';
    }
    if(playlist=='anxiety'){
      return 'anxiety';
    }
    if(playlist=='lofi'){
      return 'lofi';
    }
    if(playlist=='stress'){
      return 'sleep_music';
    }
    if(playlist=='binaurial'){
      return 'Binaural_beats';
    }
    if(playlist=='nature'){
      return 'nature';
    }
    if(playlist=='rain'){
      return 'beginner';
    }
    if(playlist=='instruments'){
      return 'night_meditation';
    }  }
  getplaylisttitle(String goaltitle){
    if(goaltitle=='sleep'){
      return 'Deep Sleep';
    }
    if(goaltitle=='calm'){
      return 'Anti-Anxiety Armour';
    }
    if(goaltitle=='sleep'){
      return 'Deep Sleep';
    }
    if(goaltitle=='meditate'){
      return 'Day-Meditation';
    }
    if(goaltitle=='anxiety'){
      return 'Anxiety';
    }
    if(goaltitle=='lofi'){
      return 'GV Lofi Bearts';
    }
    if(goaltitle=='stress'){
      return 'Relieve Stress';
    }
    if(goaltitle=='binaurial'){
      return 'Binaural Beats';
    }
    if(goaltitle=='nature'){
      return 'Nature';
    }
    if(goaltitle=='rain'){
      return 'Beginner';
    }
    if(goaltitle=='instruments'){
      return "Night Meditation";
    }
  }
  void updateListView() {

    final Future<Database> dbFuture = goalsDatabaseHelper.initializeDatabase();
    dbFuture.then((database) {

      Future<List<GoalsModel>> goalListFuture = goalsDatabaseHelper.getGoalsList();
      goalListFuture.then((gList) {
        setState(() {
          this.goalsList = gList;
          this.count = gList.length;
        });
      });
    });
  }

  void onTabTapped(int index) {
    setState(() {
      currentindex = index;
      tabtap=false;
    });
  }

  emptycode(){}
  @override
  Widget build(BuildContext context) {
    final musicplays=Provider.of<MusicPlays>(context);

    if (goalsList == null) {
      goalsList = List<GoalsModel>();
      updateListView();
    }

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    double screenwidth=MediaQuery.of(context).size.width;
    double screeheight=MediaQuery.of(context).size.height;
    double screenarea=screeheight*screenwidth;
    return
      
      Scaffold(
//floatingActionButton: MiniPlayer(),
      backgroundColor: Color(0xfff5f5f5),
        body:tabtap?Recommended():
        currentindex==0?
            SafeArea(child:
        Scaffold(
floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            floatingActionButton:
            musicplays.getminiplayer(context),
            body:
        CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverList(
                delegate: SliverChildListDelegate(
                    [
                      SingleChildScrollView(child:
                      Column(mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: screenwidth*0.0586,right: screenwidth*0.0586,top: 4),
                            width: screenwidth,
                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                GestureDetector(
                                    onTap: (){
                                      print(goalsList.length);
                                      print(this.goalsList[0].goalcount);
                                      print(this.goalsList[0].goalpreferences);

                                    },
                                    child:
                                Container(
                                  margin: EdgeInsets.only(
                                    //    top:8,
                                    top: screenarea*0.00003198,
                                    //        left: 14
//left:10
                                  ),
                                  //        padding: EdgeInsets.all(8),
                                  child: SvgPicture.asset('assets/images/white_logo.svg',
                                      color: Color(0xff9797de),
                                      //      fit: BoxFit.cover,
                                      width: screenwidth*0.101
                                    //  width: 38,
                                  ),
                                )),
GestureDetector(
    onTap: (){
      setState(() {
        currentindex=2;
      });
    },
    child:
                                Container(
                                  height: screenwidth*0.12,
                                  width: screenwidth*0.12,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle
                                  ),
                                  //    height:screenwidth*0.12,
                                  //  width:screenwidth*0.12,
                                  margin: EdgeInsets.only(

                                  ),
                                  child:
                                  Hero(
                                      tag: 'avatar',
                                      child:
                                  Image.asset('assets/images/profile@3x.png',
                                    //      width:screenwidth*0.12,
                                    fit: BoxFit.fitWidth,
                                  )),
                                ))
                              ],
                            ),
                          ),
                          Container(

                              margin: EdgeInsets.only(
                                //   left:26
                                  left:screenwidth*0.0586,
                                  //   top: 9.5
                                  top:screenarea*0.0000379
                                //  top: 5
                              ),
                              child:
                              Text(
                                int.parse(DateFormat.H('en_US').format(DateTime.now()))<12?'Good\nMorning':
                                int.parse(DateFormat.H('en_US').format(DateTime.now()))<16?'Good\nAfternoon':'Good\nEvening',
                                style: TextStyle(
                                    fontFamily: helveticaneuebold,
                                    color:Colors.black87,
                                    fontSize: screenwidth*0.096

                                ),
                              )
                          ),
                          Container(
                              margin: EdgeInsets.only(
                                left:screenwidth*0.0586
                                ,
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
                              top: screenarea*0.0000639,
                              left:screenwidth*0.0586
                              ,   right:screenwidth*0.0586            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  //     height:35 ,
                                  //     height: screeheight*0.05247,
                                    height: screenwidth*0.0933,
                                    //    width: 244,
                                    width: screenwidth*0.65,
                                    padding: EdgeInsets.only(
                                      //    left: 10,
                                        left: screenarea*0.00003998,
                                        bottom: 0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(Radius.circular(6)),
                                    ),child:Center(child: TextField(
                                  onTap: (){
                                    setState(() {
                                      tabtap=true;
                                    });
                                  },

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
                                GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        tabtap=true;

                                      });
                                    },
                                    child:
                                    Container(
                                      // width: 60,
                                      //      height: 35,
                                      width: screenwidth*0.16,
                                      height: screeheight*0.05247,
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
                                    ))
                              ],),),
                          Container(
                              margin: EdgeInsets.only(
                                //left:22 ,
                                left:screenwidth*0.0586,

                                //    top: 12
                                top: screenarea*0.0000479,

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
                            margin: EdgeInsets.only(
                              //top:16,
                              top:screenwidth*0.04266,
                              bottom:screenwidth*0.0586
                              ,
                              left: screenwidth*0.0586,
                              right:screenwidth*0.0586,
                            ),
                            //   height: 68,
                            height: screeheight*0.1019,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                    onTap:()async{
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                          SinglePlaylist(
                                            categoryid: 85,
                                              imageasset: "assets/images/anxbg.png",
                                              title: "Anxiety",
                                              description: "Go easy on yourself. Whatever you do\n"
                                                  "today, let it be enough")));
                                    },
                                    child:
                                    Container(
                                      //        height: 68,
                                      //      width: 68,
                                      height: screenwidth*0.1813,
                                      width:  screenwidth*0.1813,
                                      child:
                                      Hero(
                                          tag: "anxiety",
                                          child:
                                          Image.asset("assets/images/anxiety.png",
//  width: 68,
                                            width:  screenwidth*0.1813,
                                          )),
                                    )),
                                GestureDetector(
                                    onTap:(){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                          SinglePlaylist(
                                              categoryid: 44,
                                              imageasset: "assets/images/clmbg.png",
                                              title: "Calm",
                                              description: "It's all about finding the calm\nin the chaos")));
                                    },child:
                                Container(
                                  //     height: 68,
                                  //       width: 68,
                                    height:  screenwidth*0.1813,
                                    width:  screenwidth*0.1813,
                                    child:
                                    Hero(
                                      tag: "calm",
                                      child:
                                      Image.asset("assets/images/calm.png",
                                        //   width: 68,
                                        width:  screenwidth*0.1813,
                                      ),
                                    )
                                ))
                                ,    GestureDetector(
                                    onTap:(){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                          SinglePlaylist(
                                              categoryid: 58,
                                              imageasset: "assets/images/strsbg.png",
                                              title: "Stress",
                                              description: "It's not stress that kills us, it's our\n"
                                                  "reaction to it")));
                                    },child:
                                Container(
                                  //height: 68,width: 68,
                                  height:  screenwidth*0.1813,width: screenwidth*0.1813,
                                  child:
                                  Hero(
                                      tag: "stress",
                                      child:
                                      Image.asset("assets/images/stress icon@2x.png",
                                        //    width: 68,
                                        width:  screenwidth*0.1813,
                                      )),
                                ))
                                ,
                                GestureDetector(
                                    onTap:(){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                          SinglePlaylist(
                                              categoryid: 44,

                                              imageasset: "assets/images/slpbg.png",
                                              title: "Sleep",
                                              description: "Tired minds don't plan well. Sleep\n"
                                                  "first, plan later.")));
                                    },child:
                                Container(
                                  //height: 68,width: 68,
                                  height:  screenwidth*0.1813,width: screenwidth*0.1813,
                                  child:   Hero(
                                      tag: "sleep",
                                      child:Image.asset("assets/images/sleep icon@3x.png",
                                        //    width: 68,
                                        width:  screenwidth*0.1813,
                                      )),
                                ))
                              ],
                            ),),
                          Container(
                              margin: EdgeInsets.only(
                                //            left: screenarea*0.0001039,
                                left:screenwidth*0.0586,

                                //    left:26 ,
                                //    top: 4
                              ),
                              child:
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children:[
                                    Text("Recently Played",style: TextStyle(
                                        fontFamily: helveticaneuemedium,
                                        color: Colors.black87,
                                        //     fontSize: 18
                                        fontSize: screenwidth*0.048
                                    ),),])),
                          Container(
                            margin: EdgeInsets.only(
                                top: screenwidth*0.0426,
                                bottom: screenwidth*0.0586
                            ),
                           // padding: EdgeInsets.only(right: screenwidth*0.0586),
                            child:
                            LimitedBox(
                                maxHeight: screenwidth*0.517,
                                child:
                            ListView(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              children: [
Container(
  height: screenwidth*0.517,
  width: screenwidth*0.52,
  margin: EdgeInsets.only(left: screenwidth*0.0586),

  decoration: BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    image: DecorationImage(
      image: AssetImage("assets/images/pexels-maël-balland-3099153.jpg"),
      fit: BoxFit.cover
    )
  ),
  child: Stack(children: [
    Container(
      height: screenwidth*0.517,
      width: screenwidth*0.52,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(8)),
gradient: LinearGradient(
  begin: Alignment.topCenter,end: Alignment.bottomCenter,
  colors: [Color(0xff265f59).withOpacity(0.23),Color(0xff081312).withOpacity(0.4)]
)    )
    ),
    Container(
        height: screenwidth*0.517,
        width: screenwidth*0.52,
    padding: EdgeInsets.all(
 //       10
   screenwidth*0.0266 ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height:screenwidth*0.08,width: screenwidth*0.08,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black12,
            ),
            child:Container(
                margin:EdgeInsets.only(
             //       left: 4.5
               left: screenwidth*0.012 ),
                child: Icon(CupertinoIcons.play_arrow_solid,
            color: Colors.white.withOpacity(0.8),
        //    size: 18,
          size: screenwidth*0.048,
                )),
          ),
          ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              child:BackdropFilter(
              filter: ImageFilter.blur(sigmaY: 10,sigmaX: 10),
              child:
          Container(
            padding: EdgeInsets.all(screenwidth*0.0213),
            width: screenwidth,
            height: screenwidth*0.168,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.07),
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
            child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(child:Text("Remove negative blockage",style: TextStyle(
                  fontFamily: helveticaneuemedium,
                  color: Colors.white.withOpacity(0.87),
             //     fontSize: 12
              fontSize: screenwidth*0.032
                ),)),
                Container(child:Text("Erase subconscious negative\npatterns",style: TextStyle(
                    fontFamily: helveticaneueregular,
                    color: Colors.white.withOpacity(0.87),
           //         fontSize: 11
             fontSize: screenwidth*0.0293
                ),)),
              ],
            ),
          )))
        ],
      ),
    ),

  ],),
),
                                Container(
                                  height: screenwidth*0.517,
                                  width: screenwidth*0.52,
                                  margin: EdgeInsets.only(left: screenwidth*0.0586,right: screenwidth*0.0586),

                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(8)),
                                      image: DecorationImage(
                                          image: AssetImage("assets/images/pexels-pixabay-355209.jpg"),
                                          fit: BoxFit.cover
                                      )
                                  ),
                                  child: Stack(children: [
                                    Container(
                                        height: screenwidth*0.517,
                                        width: screenwidth*0.52,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(8)),
                                            gradient: LinearGradient(
                                                begin: Alignment.topCenter,end: Alignment.bottomCenter,
                                                colors: [Color(0xff265f59).withOpacity(0.23),Color(0xff081312).withOpacity(0.4)]
                                            )    )
                                    ),
                                    Container(
                                      height: screenwidth*0.517,
                                      width: screenwidth*0.52,
                                      padding: EdgeInsets.all(
                                   //       10
                                          screenwidth*0.0266  ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height:screenwidth*0.08,width: screenwidth*0.08,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.black12,
                                            ),
                                            child:Container(
                                                margin:EdgeInsets.only(
                                           //         left: 4.5
                                                    left: screenwidth*0.012    ),
                                                child: Icon(CupertinoIcons.play_arrow_solid,
                                                  color: Colors.white.withOpacity(0.8),
                                     //             size: 18,
                                                  size: screenwidth*0.048,
                                                )),
                                          ),
                                          ClipRRect(
                                              borderRadius: BorderRadius.all(Radius.circular(4)),
                                              child:BackdropFilter(
                                                  filter: ImageFilter.blur(sigmaY: 10,sigmaX: 10),
                                                  child:
                                                  Container(
                                                    padding: EdgeInsets.all(screenwidth*0.0213),
                                                    width: screenwidth,
                                                    height: screenwidth*0.168,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white.withOpacity(0.07),
                                                      borderRadius: BorderRadius.all(Radius.circular(4)),
                                                    ),
                                                    child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Container(child:Text("Happiness Frequency",style: TextStyle(
                                                            fontFamily: helveticaneuemedium,
                                                            color: Colors.white.withOpacity(0.87),
                                               //             fontSize: 12
                                                            fontSize: screenwidth*0.032
                                                        ),)),
                                                        Container(child:Text("Reach your goals with this\nadvice",style: TextStyle(
                                                            fontFamily: helveticaneueregular,
                                                            color: Colors.white.withOpacity(0.87),
                                                    //        fontSize: 11
                                                            fontSize: screenwidth*0.0293
                                                        ),)),
                                                      ],
                                                    ),
                                                  )))
                                        ],
                                      ),
                                    ),

                                  ],),
                                ),

                              ],
                            )),
                          ),
                          Container(
                              margin: EdgeInsets.only(
                                //            left: screenarea*0.0001039,
                                left:screenwidth*0.0586,

                                //    left:26 ,
                                //    top: 4
                              ),
                              child:
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children:[
                                    Text("Recommended",style: TextStyle(
                                        fontFamily: helveticaneuemedium,
                                        color: Colors.black87,
                                        //     fontSize: 18
                                        fontSize: screenwidth*0.048
                                    ),),])),
                          Container(margin: EdgeInsets.only(
                            //    top: screenarea*0.00007996,
                              top:screenwidth*0.04266,
                              bottom:screenwidth*0.0586
                          ),
                            //    height: 239,
                            //       height: screeheight*0.368,
                            //        width: 239*855/987,
                            child:
                            LimitedBox(
                              //   maxHeight: screeheight*0.368,
                                maxHeight:screenwidth*0.637,
                                child:
                                ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: goalsList.length>0?this.goalsList[0].goalcount:0,
                                    itemBuilder: (context,index){
                                      return     GestureDetector(
                                          onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                            PlaylistSharable(
                                                playlistslug:   index==0?
                                                getrecommendedslug(   this.goalsList[0].goalpreferences.substring(index,
                                                    this.goalsList[0].goalpreferences.indexOf((index+1).toString())
                                                ))
                                                    :
                                                getrecommendedslug(    this.goalsList[0].goalpreferences.substring(
                                                    this.goalsList[0].goalpreferences.indexOf((index).toString())+1,
                                                    this.goalsList[0].goalpreferences.indexOf((index+1).toString()))),
                                                imageasset: getrecommendedimage(index),
                                                title:    index==0?
                                                getplaylisttitle(   this.goalsList[0].goalpreferences.substring(index,
                                                    this.goalsList[0].goalpreferences.indexOf((index+1).toString())
                                                ))
                                                    :
                                                getplaylisttitle(    this.goalsList[0].goalpreferences.substring(
                                                    this.goalsList[0].goalpreferences.indexOf((index).toString())+1,
                                                    this.goalsList[0].goalpreferences.indexOf((index+1).toString()))),
                                                description: "")
                                        ));
                                      },child:Container(
                                        width: screenwidth*0.525,
                                        margin: EdgeInsets.only(
                                          //   left: screenarea*0.0001039
                                            left:screenwidth*0.0586,
                                          right: index==this.goalsList[0].goalcount-1?screenwidth*0.0586:0
                                          //    left: 26
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(12)),
                                          image: DecorationImage(
                                            image: AssetImage(
                                                getrecommendedimage(index)
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child:       Column(mainAxisAlignment:MainAxisAlignment.end,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:MainAxisAlignment.start,children: [
                                              Container(
                                                  margin: EdgeInsets.only(
                                                      left: screenarea*0.00003998
                                                  ),
                                                  child:
                                                  Text(
                                                    index==0?
                                                    getplaylisttitle(   this.goalsList[0].goalpreferences.substring(index,
                                                        this.goalsList[0].goalpreferences.indexOf((index+1).toString())
                                                        ))
                                                        :
                                                    getplaylisttitle(    this.goalsList[0].goalpreferences.substring(
                                                        this.goalsList[0].goalpreferences.indexOf((index).toString())+1,
                                                        this.goalsList[0].goalpreferences.indexOf((index+1).toString()))),
                                                    style: TextStyle(
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
                                          ],),
                                      ));
                                    })
                            ),        ),
                          Container(
                              margin: EdgeInsets.only(
                                // left:22 ,right:22,

                                left: screenwidth*0.0586,right:screenwidth*0.0586,


                                //   top: 13.5
                              ),
                              //  right: 26),
                              child:
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children:[
                                    Text("Explore",style: TextStyle(
                                        fontFamily: helveticaneuemedium,
                                        color: Colors.black87,
                                        //    fontSize: 18
                                        fontSize: screenwidth*0.048
                                    ),),
                                    GestureDetector(
                                        onTap: (){
                                         setState(() {
                                           tabtap=true;
                                         });
                                        },
                                        child:
                                        Container(child:
                                        Text('Show All',style: TextStyle(
                                            fontFamily: helveticaneueregular,
                                            color: Colors.black.withOpacity(0.4),
                                            //fontSize: 14
                                            fontSize: screenwidth*0.0373

                                        ),)))
                                  ])),
                          Container(
                            margin: EdgeInsets.only(
                              //top:  8,bottom:  12
                                top:screenwidth*0.02266,
                                bottom:screenwidth*0.0586
                            ),
                            //  height: 125,
                            //    height: 125,
                            height: screenwidth*0.3333,
                            child:

                            ListView.builder(
                              itemCount: 6,
                              scrollDirection: Axis.horizontal,
                              physics: BouncingScrollPhysics(),
                              itemBuilder:(context,index) {
return

                                  GestureDetector(
                                      onTap:(){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>

                                            MultiProvider(
                                                providers: [
                                                  ChangeNotifierProvider<MusicPlays>(
                                                    create: (_)=>MusicPlays(),
//  builder: (_,child)
                                                    //  => DataProvider(),
                                                  ),
                                                ],
                                                child:
                                            MusicPlayer(

                                                imageasset: "assets/images/orange_circle.png",
                                                title: _exploretracks[index].track.title,
                                                description: _exploretracks[index].track.description,
                                            trackid:_exploretracks[index].id.toString() ,
playableslist: _exploretracks,
                                              downloadurl: _exploretracks[index].track.trackDownloadUrl,
                                              trackduration: _exploretracks[index].track.duration,
                                              trackurl: _exploretracks[index].track.url,
                                              index: index,
                                              navigatedfromminiplayer: false,

                                            ))));
                                      },
                                      child:
                                      Container(
                                        padding: EdgeInsets.only(
                                          top: 18,
                                            bottom: 16,
                                            left: 12,right: 12
                                        ),
                                        height: double.infinity,
                                        width: screenwidth*0.52,
                                        margin: EdgeInsets.only(left: screenwidth*0.0586,
                                        right: index==5?screenwidth*0.0586:0
                                        ),
                                        //    height: screeheight*0.368,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(12)),
                                          image: DecorationImage(
                                            image: AssetImage(getexploreillustration(index)),
                                            fit: BoxFit.contain,

                                          ),
                                        ),
                                            child:Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children:[
                                                  Container(margin:EdgeInsets.only(
                                                    //                      top: 15,
                                                    //   left: 10
                                                  ),
                                                      child:
                                                      Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children:[
                                                            Expanded(
                                                                child:Text(
                                                      _exploretracks.length>0?
                                                                  _exploretracks[index].typeObject.title.length>70?
                                                                  _exploretracks[index].typeObject.title.substring(0,70):
                                                                  _exploretracks[index].typeObject.title:"",
                                                                  style: TextStyle(
                                                                fontFamily: helveticaneuemedium,
                                                                color: Colors.white,
                                                                //    fontSize: 13.5
                                                                fontSize: screenwidth*0.036
                                                            ),),
                                                            )])),
                                                  Row(mainAxisAlignment:MainAxisAlignment.start,children: [
                                                    Container(margin: EdgeInsets.only(
                                                      //         vertical: 12,
                                                      //       horizontal: 6
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
                                                          child: Text(
                                                            _exploretracks.length>0?
                                                            _exploretracks[index].track.duration:"",style: TextStyle(
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
                                                ]),
                                      ))

                                ;
                              }
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(
                                //      left:26 ,
                                //    right: 26
                                //        left: screenarea*0.0001039,
                                //           right: screenarea*0.0001039
                                //       left:22,right:22,
                                left: screenarea*0.0000879,right:screenarea*0.0000879,
                              ),
                              child:
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children:[
                                    Text("Meditate",style: TextStyle(
                                        fontFamily: helveticaneuemedium,
                                        color: Colors.black54,
                                        //        fontSize: 18
                                        fontSize: screenwidth*0.048

                                    ),),

                                  ])),
                          GestureDetector(
                              onTap: (){
                           //     Navigator.push(context, MaterialPageRoute(builder: (context)=>
                         //           SinglePlaylist(imageasset: "assets/images/lotusmeditatebg.png",
                       //                 title: "Get Motivated",
                     //                   description: "Reach your goals with this advice")));
                              },
                              child:
                              Container(
                                margin: EdgeInsets.only(
                                  //                top: 13,
                                  top:screenwidth*0.04266,
                                  bottom:screenwidth*0.0586,
                                  //      right: 26,
                                  //    left:26,
                                  //  bottom:26
                                  //      left:22,right:22,
                                  left: screenwidth*0.0586,right:screenwidth*0.0586,
                                  //       bottom: 18
                                ),
                                //     height: 168,
                                //      height: screeheight*0.2518,
                                child: Center(child:
                                Hero(tag: 'log',
                                    child:
                                    Container(
                                        width: screenwidth,
                                        height: screeheight*148/667,
                                        //    height: screeheight*0.368,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(12)),
                                          image: DecorationImage(
                                            image: AssetImage("assets/images/lotus@3x.png"),
                                            fit: BoxFit.cover,

                                          ),
                                        ),
                                        child:     Container(
                                          margin: EdgeInsets.all(screenarea*0.00003998

                                            //    10
                                          ),
                                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            mainAxisSize:MainAxisSize.max,
                                            children: [
                                              Container(child:Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children:[
                                                    Container(margin:EdgeInsets.only(
                                                      // top: 2, left:2
                                                        left: screenarea*0.00000799,
                                                    //    top: screenarea*0.00000799 ,
                                                    right:screenarea*0.00000799),
                                                        child:
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children:[
                                                        Text('Ready To Start\nMeditation?',style: TextStyle(
                                                            fontFamily: helveticaneuemedium,
                                                            color: Colors.white,
                                                            //       fontSize: 18
                                                            fontSize: screenwidth*0.048

                                                        ),),
                                                            GestureDetector(
                                                              onTap: (){
                                                                Navigator.push(context,
                                                                MaterialPageRoute(builder: (context)=>
                                                                GetPremium()));
                                                              },
                                                              child:Icon(Ionicons.lock_closed,
                                                              size: 26,
                                                                  color: Colors.white70,
                                                              )
                                                            )
                                                            ])),
                                                    Container(
                                                        margin: EdgeInsets.only(
                                                          //        left: 10,
//                                left: screenarea*0.0000279,
                                                            top:screenarea*0.0000319
                                                          //       top:  8
                                                          //  top: 16
                                                        ),
                                                        child:     Text("Regain Your Inner\nPeace",style: TextStyle(
                                                            fontFamily: helveticaneueregular,
                                                            color: Colors.white70,
                                                            //   fontSize: 12
                                                            fontSize: screenwidth*0.032

                                                        ),))])),
                                              Row(crossAxisAlignment:CrossAxisAlignment.end,children: [
                                                Container(margin: EdgeInsets.only(
                                                  //       top: 13,
                                                  top:screenarea*0.0000519,
                                                  //      left: 6,right:6
//                              left:  screenarea*0.0000239,right:  screenarea*0.0000239
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
                                    )),


                                ),
                              )),
                          Container(
                            margin: EdgeInsets.only(
                              //left:22 ,
                              left:screenwidth*0.0586,

                              //    top: 12

                            ),
                            child:
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children:[
                                  Text("Today's Release",style: TextStyle(
                                      fontFamily: helveticaneuemedium,
                                      color: Colors.black87,
                                      //         fontSize: 18
                                      fontSize: screenwidth*0.048
                                  ),),]),
                          ),
                          Container(
                              width: screenwidth,
                              margin:
                              EdgeInsets.only(
                                //        bottom: 20
                                  bottom: screenwidth*0.0533
                              ),
                              child:
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children:[
                                    LimitedBox(
                                      maxWidth:screenwidth,
maxHeight: screenwidth*0.8,
child:                                    ListView.builder(
                                        itemCount:2,
                                        scrollDirection: Axis.vertical,
                                        physics: BouncingScrollPhysics(),
                                        itemBuilder: (context,index){
                                      return
                                        GestureDetector(
                                            onTap: (){
                                              Navigator.push(context, MaterialPageRoute(builder: (context)
                                              =>
                                                  MultiProvider(
                                                      providers: [
                                                        ChangeNotifierProvider<MusicPlays>(
                                                          create: (_)=>MusicPlays(),
//  builder: (_,child)
                                                          //  => DataProvider(),
                                                        ),
                                                      ],
                                                      child:
                                                  MusicPlayer(
                                                  navigatedfromminiplayer: false,
                                                  trackid: _todaytracks[index].id.toString(), index: index,
                                                  imageasset: "assets/images/orange_circle.png",
                                                  title: _todaytracks[index].title!=null?
                                                  _todaytracks[index].title.length>26?
                                                  _todaytracks[index].title.substring(0,26):
                                                  _todaytracks[index].title:"",
                                                    description: _todaytracks[index].title!=null?
                                                    _todaytracks[index].description.length>65?
                                                    _todaytracks[index].description.substring(0,65):
                                                    _todaytracks[index].description:""
                                                    ,
                                                  trackduration: _todaytracks[index].duration, trackurl: _todaytracks[index].url,
                                                  downloadurl: _todaytracks[index].trackDownloadUrl,
                                                  trackslist: _todaytracks,
                                                ))));
                                            },
                                            child:
                                        Container(

                                        margin: EdgeInsets.only(
                                          //    top: 22,
                                          top: screenwidth*0.0586,  left: screenwidth*0.0586,right:screenwidth*0.0586,
                                        ),
                                        height:screenwidth*0.32,
                                        width: screenwidth,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(Radius.circular(8)),
                                            boxShadow:[ BoxShadow(
                                                color: Color(0xff2a315d).withOpacity(0.16),
                                                blurRadius: 50,
                                                offset: Offset(0,3)
                                            )]
                                        ),
                                        child: Stack(children: [

                                          Container(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                    margin: EdgeInsets.only(
                                                      //         left:10
                                                        left: screenwidth*0.0266
                                                    ),
                                               //     padding: EdgeInsets.all(5),
                                                    height: screenwidth*0.078, width: screenwidth*0.234,
                                                    decoration: BoxDecoration(
                                                      color: Color(0xffefefef),
                                                      borderRadius: BorderRadius.all(Radius.circular(4)),
                                                    ),
                                                    child:Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                      children: [
                                                        Icon(CupertinoIcons.play_arrow_solid,
                                                            color: Color(0xff9797de),
                                                            //    size: 14,
                                                            size:screenwidth*0.03733
                                                        ),
                                                        Text(_todaytracks.length>0?
                                                          this._todaytracks[index].duration:"",
                                                          style: TextStyle(
                                                              fontFamily: helveticaneuemedium,
                                                              color: Color(0xff9797de),
                                                              //          fontSize: 12.5
                                                              fontSize: screenwidth*0.0333
                                                          ),)
                                                      ],)
                                                ),
                                                Container(
                                                    margin: EdgeInsets.only(
                                                      //         left: 10
                                                        left: screenwidth*0.0266
                                                    ),
                                                    child:Text(
                                                      _todaytracks.length>0?
                                                      this._todaytracks[index].title.length>30?
                                                      this._todaytracks[index].title:
                                                      this._todaytracks[index].title.substring(0,30):"",style: TextStyle(
                                                        fontFamily: helveticaneuemedium,
                                                        color: Color(0xff9797de),
//  fontSize: 12.5
                                                        fontSize: screenwidth*0.0333
                                                    ),)
                                                ),
                                                Container(
                                                    margin: EdgeInsets.only(
                                                      //     left: 10
                                                        left: screenwidth*0.0266
                                                    ),

                                                    child:Text(_todaytracks.length>0?
                                                    this._todaytracks[index].description.length<120?
                                                    this._todaytracks[index].description:
                                                    this._todaytracks[index].description.substring(0,120) :""
                                                      ,style: TextStyle(
                                                        fontFamily: helveticaneueregular,
                                                        color: Colors.black87,
                                                        //          fontSize: 12
                                                        fontSize: screenwidth*0.032
                                                    ),)
                                                ),
                                              ],
                                            ),
                                          ),
                                          Positioned(
                                              right:3,
                                              //    bottom: -10,
                                              bottom:-screenwidth*0.0266,
                                              child: Image.asset(getrecenttrackpicture(index),
                                                  height:screenwidth*0.36)),
                                        ],),
                                      ));
                                    })),

                                  ]))
                        ],))]))

          ],
        ))):currentindex==1?Library():
        Profile(), // new

        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentindex,
          onTap: onTabTapped,
backgroundColor: Color(0xfff5f5f5),
          elevation: 0,
          items: [
            BottomNavigationBarItem(

              icon: SvgPicture.asset("assets/images/home copy.svg",
        width: 23,color: currentindex==0?Color(0xff9797de):Colors.black38,)
              ,
              activeIcon:
              Container(
                margin: EdgeInsets.only(top: 4,bottom: 2),
                child:
              Text('Home',style: TextStyle(
                fontFamily: helveticaneuemedium,
                color:
                currentindex==0?
                Color(0xff9797de):Color(0xff32386a).withOpacity(0.5)
              ),)),
            ),
            BottomNavigationBarItem(
              icon:

              SvgPicture.asset("assets/images/noun_Library_2005386.svg",
    width:23,color: currentindex==1?Color(0xff9797de):Colors.black38
    ),
              activeIcon:  Container(
                  margin: EdgeInsets.only(top: 4,bottom: 2),
                  child:
    Text('Library',style: TextStyle(
                  fontFamily: helveticaneuemedium,
                  color:
                  currentindex==1?
                  Color(0xff9797de):Color(0xff32386a).withOpacity(0.5)
              ),)),
            ),
            BottomNavigationBarItem(
                icon:   Image.asset("assets/images/user@2x.png",
    width:23,color: currentindex==2?Color(0xff9797de):Color(0xff32386a).withOpacity(0.5)
    ),
                activeIcon:Container(
                    margin: EdgeInsets.only(top: 4,bottom: 2),
                    child: Text('Profile',style: TextStyle(
                    fontFamily: helveticaneuemedium,
                    color:currentindex==2?
                    Color(0xff9797de):Color(0xff32386a).withOpacity(0.5)
                ),))
            )
          ],
        ),

    );
  }
  pauseorplay()async{
    Styleconst.constassetsAudioPlayer.isPlaying.value?Styleconst.constassetsAudioPlayer.pause():Styleconst.constassetsAudioPlayer.play();
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
