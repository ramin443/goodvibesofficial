import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:goodvibesoffl/constants/fontconstants.dart';
import 'package:goodvibesoffl/models/playable_model.dart';
import 'package:goodvibesoffl/screens/sharables/music_player.dart';
import 'package:goodvibesoffl/services/api_service.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../locator.dart';
class Meditate extends StatefulWidget {
  final String playlistslug;
  final String playlistname;
  final String playlistduration;
  final String imageasset;
  final String title;
  String description;
  Meditate({Key key,@required this.playlistslug,
    @required this.playlistname,
    @required this.playlistduration
    ,@required this.imageasset,@required this.title,@required this.description}) : super(key: key);

  @override
  _MeditateState createState() => _MeditateState();
}

class _MeditateState extends State<Meditate> with SingleTickerProviderStateMixin{
  AnimationController _scaleanimationcontroller;
List meditatelist=[];
bool pressed=false;
  @override
  void initState() {
    super.initState();
    _scaleanimationcontroller=AnimationController(vsync: this,duration: Duration(milliseconds: 100));
    _scaleanimationcontroller.addListener(() {
      if(_scaleanimationcontroller.status==AnimationStatus.forward){
//_scaleanimationcontroller.reverse();
      }
    });
    fetchmeditatetracks();

  }
  fetchmeditatetracks()async{
    Map medilvl5= await locator<ApiService>().getPlaylist(slug: 'lets_meditate_level_5',page: 1,perpage: 5);
    Map medilvl6= await locator<ApiService>().getPlaylist(slug: 'lets_meditate_level_6',page: 1,perpage: 5);
    Map medilvl7= await locator<ApiService>().getPlaylist(slug: 'lets_meditate_level_7',page: 1,perpage: 5);
    Map medilvl8= await locator<ApiService>().getPlaylist(slug: 'lets_meditate_level_8',page: 1,perpage: 5);
    Map medilvl9= await locator<ApiService>().getPlaylist(slug: 'lets_meditate_level_9',page: 1,perpage: 5);
    Map medilvl10= await locator<ApiService>().getPlaylist(slug: 'lets_meditate_level_10',page: 1,perpage: 5);

    Map nightmeditationresponse= await locator<ApiService>().getPlaylist(slug: 'day_meditation',page: 1,perpage: 5);
    Map daymeditationresponse= await locator<ApiService>().getPlaylist(slug: 'night_meditation',page: 1,perpage: 5);
    List<dynamic> daymeditation=daymeditationresponse['data'] as List;
    var daymedplays=daymeditation.map<Playable>((json) => Playable.fromJson(json));
    setState(() {
      meditatelist.addAll(daymedplays);
    });
    List<dynamic> nightmeditation=nightmeditationresponse['data'] as List;
    var nightmedplays=nightmeditation.map<Playable>((json) => Playable.fromJson(json));
    setState(() {
      meditatelist.addAll(nightmedplays);
    });
    List<dynamic> meditationlvl5=medilvl5['data'] as List;
    var medl5plays=meditationlvl5.map<Playable>((json) => Playable.fromJson(json));
    setState(() {
      meditatelist.addAll(medl5plays);
    });
    List<dynamic> meditationlvl6=medilvl6['data'] as List;
    var medl6plays=meditationlvl6.map<Playable>((json) => Playable.fromJson(json));
    setState(() {
      meditatelist.addAll(medl6plays);
    });
    List<dynamic> meditationlvl7=medilvl7['data'] as List;
    var medl7plays=meditationlvl7.map<Playable>((json) => Playable.fromJson(json));
    setState(() {
      meditatelist.addAll(medl7plays);
    });
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
    final animation=Tween<double>(begin: 24,end: 30).animate(_scaleanimationcontroller);

    return     Scaffold(
        body:
        SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child:
            Column(mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children:[
                  Stack(children:[
                    Container(
                        child:
                        Hero(
                          tag: "log",
                          child:
                          Image.asset("assets/images/lotusmeditatebg.png",fit: BoxFit.cover,),)
                    ),
                    Container(
                      child:

                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppBar(
                            backgroundColor: Colors.transparent,elevation: 0,
                            leading: GestureDetector(
                              onTap: (){Navigator.pop(context);},
                              child: Icon(CupertinoIcons.back,
                         //       size: 24,
                           size: screenwidth* 0.064,
                                color: Colors.white,),
                            ),
                            actions: [
                              GestureDetector(child:
                              Container(
                                  margin: EdgeInsets.only(
                                  //    right: 10
                                  right: screenarea*0.0000399
                                  ),
                                  child:
                                  AnimatedBuilder(
                                      animation: animation,
                                      builder:(context,child){ return              Icon(pressed?MdiIcons.heart:MdiIcons.heartOutline,

                                          size:animation.value);})),onTap: (){
                                _scaleanimationcontroller.forward();
                                setState(() {
                                  pressed?pressed=false:
                                  pressed=true;
                                });
                              }, )
                            ],
                          ),

                        ],
                      ),),Positioned(
                        bottom: 0,
                        child:
                        Container(
                          width:320,
                          margin: EdgeInsets.only(
                           //   bottom: 38,left: 26,right: 26
                            bottom:screenarea*0.000151
                              ,  left:screenarea*0.0001039,right: screenarea*0.0001039
                          ),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.all(Radius.circular(6)),
                                  child:BackdropFilter(
                                      filter: ImageFilter.blur(sigmaY: 10,sigmaX: 10),
                                      child:
                                      Container(
                                        color: Colors.white.withOpacity(0.1),
                                     //   height: 32,
                                    //    width: 78,
                                        width: screenwidth*0.208,
                                        height:screenwidth*0.085 ,
                                        child: Row(mainAxisAlignment:MainAxisAlignment.spaceEvenly,children: [
                                          Icon(Icons.play_arrow,color: Colors.white,
                                       //     size: 16
                                         size: screenwidth*0.0426
                                            ,),
                                          Container(child: Text("Play",style: TextStyle(fontFamily: helveticaneueregular,
                                             // fontSize: 14,
                                              fontSize: screenwidth*0.03733,
                                              color: Colors.white),),)

                                        ],),
                                      ))),
                              Container(
                                child: Text("00:10:00",
                                  style: TextStyle(
                                      fontFamily: helveticaneueregular,
                                      color: Colors.white,
                                   //   fontSize: 17
                                    fontSize: screenwidth*0.0453
                                  ),),)

                            ],),))
                  ]),
                  Container(
                    margin: EdgeInsets.only(
                  //      top: 10
                    top: screenarea*0.0000399
                    ),
          //          height: 4,
                    height: screenheight*0.00599,
               width: screenwidth*0.2,
                  //  width: 75,

                    decoration: BoxDecoration(
                      color: Colors.grey[700],borderRadius: BorderRadius.all(Radius.circular(18)),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(
                       //   left: 26,top: 31
left: screenarea*0.000103,top:screenarea*0.000123
                      ),
                      child:
                      Row(mainAxisAlignment:MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Tracks",style: TextStyle(fontFamily: helveticaneuebold,
                              color: Colors.black87,
                          //    fontSize: 19
                            fontSize: screenwidth*0.0506
                          ),)
                        ],)),

                  LimitedBox(
                    maxHeight: screenheight*0.8,
                    maxWidth: screenwidth,
                    child: ListView.builder(
                        itemCount: meditatelist.length,
                        scrollDirection: Axis.vertical,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context,index){
                          return      Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.only(
                                  top: screenwidth*0.0373,
                                  // top: 29,
                                  //  left: 26, right: 26
                                  left: screenwidth*0.0586,right:screenwidth*0.0586
                              ),
                              child:
                              Column(children:[
                                Container(
                                    margin:EdgeInsets.only(
                                      //  bottom: 9
                                        bottom: screenarea*0.0000359
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
                                              border:Border.all(color: Colors.black.withOpacity(0.87),width: 1,style: BorderStyle.solid)
                                            //  color: Color(0xff12c2e9),
                                          ),
                                          child: Center(child: Icon(Icons.play_arrow,
                                            color:Colors.black.withOpacity(0.87),
                                            //     size: 26.5 ,
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
                                                child: Text(
                                                  meditatelist[index].typeObject!=null?
                                                  meditatelist[index].typeObject.title.length>29?
                                                  meditatelist[index].typeObject.title.substring(0,29):
                                                  meditatelist[index].typeObject.title:""
                                                  ,style: TextStyle(
                                                    fontFamily: helveticaneuemedium,color: Colors.black.withOpacity(0.75),
                                                    //fontSize: 12.5
                                                    fontSize: screenwidth*0.0333
                                                ),),),
                                              Container(child: Text(
                                                meditatelist[index].typeObject!=null?
                                                meditatelist[index].typeObject.description!=null?
                                                meditatelist[index].typeObject.description.length>29?
                                                meditatelist[index].typeObject.description.substring(0,30):
                                                meditatelist[index].typeObject.description:"":"",style: TextStyle(
                                                  fontFamily: helveticaneueregular,color: Colors.black.withOpacity(0.5),
                                                  //fontSize: 10.5
                                                  fontSize: screenwidth*0.028
                                              ),),),
                                            ],),),
                                        Expanded(child:
                                        Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children:[
                                              Text(
                                                meditatelist[index].typeObject!=null?
                                                meditatelist[index].track.duration:"",
                                                textAlign:TextAlign.end,style: TextStyle(
                                                  fontFamily: helveticaneuemedium,color: Colors.black.withOpacity(0.45),
                                                  // fontSize: 12.5
                                                  fontSize: screenwidth*0.0333
                                              ),
                                              ),]))
                                      ],
                                    )),
                                Divider(thickness: 1,color: Colors.grey[400],)
                              ])
                          );
                        }),
                  ),



                ]))
    );
  }
}
