import 'dart:ui';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:goodvibesoffl/constants/fontconstants.dart';
import 'package:goodvibesoffl/constants/styleconstants.dart'as Styleconst;
import 'package:goodvibesoffl/models/model.dart';
import 'package:goodvibesoffl/models/music_model.dart';
import 'package:goodvibesoffl/services/api_service.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

import '../../locator.dart';
import 'MusicPlayer.dart';
import 'music_player.dart';

class PlaylistSharable extends StatefulWidget {
  final String playlistslug;
  final String playlistname;
  final String playlistduration;
  final String imageasset;
  final String title;
  String description;
  PlaylistSharable({Key key,@required this.playlistslug,
    @required this.playlistname,
    @required this.playlistduration
    ,@required this.imageasset,@required this.title,@required this.description}) : super(key: key);

  @override
  _PlaylistSharableState createState() => _PlaylistSharableState();
}

class _PlaylistSharableState extends State<PlaylistSharable> with SingleTickerProviderStateMixin{
  AnimationController _scaleanimationcontroller;
  bool playing=false;
  bool playmorethanonce=false;
  int totalduration=0;
  List<Playablee> _playlisttracks=[];
  int currentprogress=0;
  bool loop=false;
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
    fetchplaylisttracks();
    setState(() {

    });
    Future.delayed(Duration(milliseconds: 700),setstatefun);
  }
  setstatefun(){
    setState(() {

    });
  }
  fetchplaylisttracks()async{
    Map playlistresponse= await locator<ApiService>().getPlaylist(slug: widget.playlistslug,page: 1,perpage: 15);
    List<dynamic> playlistlist=playlistresponse['data'] as List;
    var plays=playlistlist.map<Playablee>((json) => Playablee.fromJson(json));
    setState(() {
      _playlisttracks.addAll(plays);
    });
  }
  addcurrentaudiolistener()async{

    Styleconst.constassetsAudioPlayer.currentPosition.listen((audioposition) {
      setState(() {
        currentprogress=audioposition.inMilliseconds;
      });
    });
    Styleconst.constassetsAudioPlayer.playerState.listen((event) {
    //  _playerState=event;
    });
    Styleconst.constassetsAudioPlayer.current.listen((event) {
      setState(() {
        totalduration= event.audio.duration.inMilliseconds;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    double screenheight=MediaQuery.of(context).size.height;
    double screenwidth=MediaQuery.of(context).size.width;
    double screenarea=screenheight*screenwidth;
    final animation=Tween<double>(begin: 24,end: 30).animate(_scaleanimationcontroller);
    return    Scaffold(

        body:
        SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child:
            Container(
                padding: EdgeInsets.only(
                ),
                child:
                Column(mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:[
                      Stack(children:[
                        Container(
                            child:
                            Stack(children:[
                              Hero(
                                tag: "tagg",
                                child:
                                ShaderMask(
                                    blendMode: BlendMode.srcATop,
                                    shaderCallback: (Rect bounds){
                                      return LinearGradient(colors: [Colors.transparent,Color(0xff0a3741).withOpacity(0.4)],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
//                   stops: [0.0,0.5]
                                      ).createShader(bounds);
                                    },
                                    child:
                                    Image.asset(widget.imageasset,fit: BoxFit.contain,width: screenheight,)),)
                              ,
                              Container(
                                width: screenwidth,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                        colors: [Colors.transparent,Color(0xff0a3741).withOpacity(0.4)]
                                    )
                                ),
                              )
                            ])
                        ),
                        Container(
                          child:

                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppBar(
                                backgroundColor: Colors.transparent,elevation: 0,
                                leading: IconButton(
                                  onPressed: (){Navigator.pop(context);},
                                  icon: Icon(CupertinoIcons.back,
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
                                          builder:(context,child){ return              Icon(pressed?MdiIcons.heart:FeatherIcons.heart,

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
                              //   width:320,
                                width: screenwidth*0.853,
                                margin: EdgeInsets.only(
                                    bottom:screenarea*0.000151
                                    ,  left:screenarea*0.0001039,right: screenarea*0.0001039
                                ),
                                child:
                                Column(children:[
                                  Row(mainAxisAlignment:MainAxisAlignment.start,children: [ Container(
                                    child: Column(crossAxisAlignment:CrossAxisAlignment.start,children: [
                                      Container(

                                        child: Text(widget.title,style: TextStyle(
                                            fontFamily: helveticaneuebold,
                                            color: Colors.white,
                                            //fontSize: 24
                                            fontSize: screenwidth*0.064
                                        ),),),
                                      Container(
                                        margin: EdgeInsets.only(
                                          //       top: 12,bottom: 28
                                            top: screenwidth*0.028,bottom: screenwidth*0.07466
                                        ),
                                        child: Text(widget.description,style: TextStyle(
                                            fontFamily: helveticaneueregular,
                                            color: Colors.white70,
                                            //fontSize: 14.5
                                            fontSize: screenwidth*0.03866
                                        ),),),
                                    ],),
                                  )]),
                                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
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
                                                      trackid:_playlisttracks[0].id.toString(), index: 0,
                                                      imageasset: "assets/images/orange_circle.png",
                                                      title: _playlisttracks[0].track.title!=null?
                                                      _playlisttracks[0].track.title.length>26?
                                                      _playlisttracks[0].track.title.substring(0,26):
                                                      _playlisttracks[0].track.title:"",
                                                      description: _playlisttracks[0].track.title!=null?
                                                      _playlisttracks[0].track.description.length>65?
                                                      _playlisttracks[0].track.description.substring(0,65):
                                                      _playlisttracks[0].track.description:""
                                                      ,
                                                      trackduration: _playlisttracks[0].track.duration,
                                                      trackurl: _playlisttracks[0].track.url,
                                                      downloadurl: _playlisttracks[0].track.trackDownloadUrl,
                                                      playableslist: _playlisttracks,
                                                    ))));
                                          },
                                          child:
                                      ClipRRect(
                                          borderRadius: BorderRadius.all(Radius.circular(6)),
                                          child:BackdropFilter(
                                              filter: ImageFilter.blur(sigmaY: 10,sigmaX: 10),
                                              child:
                                              Container(
                                                color: Colors.white.withOpacity(0.2),
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
                                              )))),
                                      Container(
                                        child: Text("00:10:00",
                                          style: TextStyle(
                                              fontFamily: helveticaneueregular,
                                              color: Colors.white,
                                              //   fontSize: 17
                                              fontSize: screenwidth*0.0453
                                          ),),)

                                    ],),

                                ])))
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
                              left: screenwidth*0.0586,top:screenwidth*0.0693
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
                            itemCount: _playlisttracks.length,
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
                                            GestureDetector(
                                                onTap:(){
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
                                                            trackid:_playlisttracks[index].id.toString(), index: index,
                                                            imageasset: "assets/images/orange_circle.png",
                                                            title: _playlisttracks[index].track.title!=null?
                                                            _playlisttracks[index].track.title.length>26?
                                                            _playlisttracks[index].track.title.substring(0,26):
                                                            _playlisttracks[index].track.title:"",
                                                            description: _playlisttracks[index].track.title!=null?
                                                            _playlisttracks[index].track.description.length>65?
                                                            _playlisttracks[index].track.description.substring(0,65):
                                                            _playlisttracks[index].track.description:""
                                                            ,
                                                            trackduration: _playlisttracks[index].track.duration,
                                                            trackurl: _playlisttracks[index].track.url,
                                                            downloadurl: _playlisttracks[index].track.trackDownloadUrl,
playableslist: _playlisttracks,
                                                          ))));
                                                },
                                                child:
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
                                            ),)),
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
                              _playlisttracks[index].typeObject!=null?
                                                       _playlisttracks[index].typeObject.title.length>29?
                                                       _playlisttracks[index].typeObject.title.substring(0,29):
                                                       _playlisttracks[index].typeObject.title:""
                                                      ,style: TextStyle(
                                                        fontFamily: helveticaneuemedium,color: Colors.black.withOpacity(0.75),
                                                        //fontSize: 12.5
                                                        fontSize: screenwidth*0.0333
                                                    ),),),
                                                  Container(child: Text(
                                                                                  _playlisttracks[index].typeObject!=null?
                              _playlisttracks[index].typeObject.description!=null?
                                                    _playlisttracks[index].typeObject.description.length>29?
                                                    _playlisttracks[index].typeObject.description.substring(0,30):
                                                    _playlisttracks[index].typeObject.description:"":"",style: TextStyle(
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
                                                    _playlisttracks[index].typeObject!=null?
                                                    _playlisttracks[index].track.duration:"",
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




                    ])))
    );
  }
  pauseorplay()async{
    Styleconst.constassetsAudioPlayer.isPlaying.value?Styleconst.constassetsAudioPlayer.pause():Styleconst.constassetsAudioPlayer.play();
  }
}
