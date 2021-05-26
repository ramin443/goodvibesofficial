import 'dart:ui';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goodvibesoffl/constants/fontconstants.dart';
import 'package:goodvibesoffl/models/music_model.dart';
import 'package:goodvibesoffl/models/playable_model.dart';

import 'Timer.dart';
import 'music_player.dart';

class MusicPlays extends ChangeNotifier{
  List<Track> playlistTracks = List();
  final assetsAudioPlayer=AssetsAudioPlayer();
PlayerState playerState;
String test="testsuccesful";
String playingstate='stopped';
   List<Track> trackslist;
   List<Playable> playableslist;
   bool loop=false;

   listentoplayerstate() {
     assetsAudioPlayer.playerState.listen((event) {
       playerState=event;
     });
     notifyListeners();
   }
   Widget getminiplayer(BuildContext context){
     double screenwidth=MediaQuery.of(context).size.width;
     double screenheight=MediaQuery.of(context).size.height;
     double screenarea=screenwidth*screenheight;
 return
 Container(
  // color: Colors.white,
     height: screenwidth*0.2026,
     width: screenwidth,
     child:
     StreamBuilder(
         stream:assetsAudioPlayer.current,
         builder:(context,currentsnaps){
           return
     StreamBuilder(
     stream:assetsAudioPlayer.currentPosition,
     builder:(context,currentpossnapshot){
       final Duration duration = currentpossnapshot.data;
       return
         currentsnaps.data==null?
SizedBox(height: 0,):
         Column(
         mainAxisAlignment: MainAxisAlignment.end,
         children:[
           ProgressBar(
             progress: Duration(milliseconds: duration.inHours),
             //  buffered: Duration(milliseconds: 2000),
             total: Duration(milliseconds:
             assetsAudioPlayer.current.value.audio.duration.inMilliseconds),
             thumbRadius: 1.8,
             thumbColor:Colors.white,
             timeLabelLocation: TimeLabelLocation.none,
             progressBarColor: Color(0xff12c2e9),
             baseBarColor:  Colors.transparent,
             barHeight: 1.8,


           ),

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
                   filter: ImageFilter.blur(sigmaX: 10,sigmaY:10),
                   child:Container(
                     color: Colors.white.withOpacity(0.1),
                     //  margin: EdgeInsets.only(left: 40),
                     padding: EdgeInsets.symmetric(
                       //         vertical: 8
                         vertical: screenwidth*0.02133
                         ,horizontal: 17.5
                     ),
                     width: screenwidth,

                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       crossAxisAlignment: CrossAxisAlignment.center,
                       children: [
                         Container(child:Row(children:[
                           Container(child:
                           ClipRRect(                borderRadius: BorderRadius.all(Radius.circular(6)),
                               child:
                               Container(
                                 decoration: BoxDecoration(
                                     borderRadius: BorderRadius.all(Radius.circular(6))
                                 ),
                                 //     height: 54,width: 54,
                                 height:  screenwidth*0.124,width:  screenwidth*0.124,
                                 child: Image.asset("assets/images/orange_circle.png",fit: BoxFit.cover,),
                               ))),
                           Container(
                             margin: EdgeInsets.only(
                               //           left: 16
                                 left: screenwidth*0.0426     ),
                             //  height: 54,
                             height: screenwidth*0.144,
                             child: Column(crossAxisAlignment:CrossAxisAlignment.start,
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 Container(child: Text("Get Motivated",style: TextStyle(
                                     fontFamily: helveticaneuebold,color: Colors.black87,fontSize: screenwidth*0.036
                                 ),),),
                                 Container(
                                   margin: EdgeInsets.only(top: 5),
                                   child: Text("Reach your goals with this advice",style: TextStyle(
                                       fontFamily: helveticaneueregular,color: Colors.black54,fontSize: screenwidth*0.0266
                                   ),),),
                               ],),)])),
                         Container(child:
                         Row(
                           mainAxisAlignment: MainAxisAlignment.end,
                           children: [
                             GestureDetector(onTap:(){},child: Container(child: Icon(Icons.skip_previous,
                               //    size: 26,
                               size: screenwidth*0.0693,
                               color: Colors.black87,),)),
                             GestureDetector(onTap:()async{
                               await assetsAudioPlayer.open(
                                 Audio("assets/audio/2 Minute Timer - Calm and Relaxing Music.mp3",
                                   metas: Metas(
                                     title:  "test1",
                                     artist: "Florent Champigny",
                                     album: "CountryAlbum",
                                     image: MetasImage.asset("assets/images/orange_circle.png"), //can be MetasImage.network
                                   ),

                                 ),
                                 loopMode:loop? LoopMode.single:LoopMode.none,
                                 volume: 80,
                                 showNotification: true,
                                 //   playInBackground: PlayInBackground.enabled,

                               );

                             },child: Container(child: Icon(
                               playerState==null?
                               CupertinoIcons.play_arrow_solid:
                               playerState==PlayerState.pause?
                               CupertinoIcons.play_arrow_solid:
                               CupertinoIcons.pause_solid ,
                               //      size: 26,
                               size: screenwidth*0.0693,
                               color: Colors.black87,),)),
                             GestureDetector(onTap:(){},child: Container(child: Icon(Icons.skip_next,
                               //        size: 26,
                               size: screenwidth*0.0693,
                               color: Colors.black87,),)),

                           ],))
                       ],
                     ),
                   ))))]);});}));
   }
  playtrack(
     int index, String trackid, String tracktitle,String trackdescription,String trackduration,
      String trackurl,String trackdownloadurl,List<Track> tracks,List<Playablee>
  playables
      )async{
   await  assetsAudioPlayer.stop();
   await   assetsAudioPlayer.open(
      Playlist(
        startIndex: index,
        audios:           tracks!=null?
        [
          for(int i=0;i<=
              tracks.length-1;i++)
          Audio.network(
              tracks!=null?
              tracks[i].url:playables[i].track.url,
              metas: Metas(
                title:               tracks!=null?
                tracks[index].title:
                playables[index].track.title,
                artist:              tracks!=null?
                tracks[i].description:                playables[index].track.description,
                album: "Anxiety",

              )),
        ]:[
          for(int i=0;i<=
              playables.length-1;i++)
            Audio.network(
               playables[i].track.url,
                metas: Metas(
                  title:
                  playables[index].track.title,
                  artist:             playables[index].track.description,
                  album: "Anxiety",

                )),
        ]
      ),

showNotification: true,

    );
    listentoplayerstate();
    setplayingnow();
    notifyListeners();
  }
 String getpauseorplaystatus(){
    return
    assetsAudioPlayer.playerState.value==PlayerState.stop?
        'notplaying': assetsAudioPlayer.playerState.value==PlayerState.pause?
    'pause':'playing';
  }
  setloopmode(LoopMode loopmode){
    assetsAudioPlayer.setLoopMode(loopmode);
    notifyListeners();
  }
Duration gettracklength(){
  return  assetsAudioPlayer.playerState.value==PlayerState.stop?
        Duration(milliseconds: 200):assetsAudioPlayer.current.value.audio.duration;
}
  setplayingnow(){
    playingstate='playing';
    notifyListeners();
  }
  setpausednow(){
    playingstate='paused';
    notifyListeners();
  }
  setnotplayingnow(){
    playingstate='stopped';
    notifyListeners();
  }
  pauseorplay(){
    playerState==PlayerState.pause?
        assetsAudioPlayer.play():assetsAudioPlayer.pause();
    playerState==PlayerState.pause?
    setplayingnow():setpausednow();
    listentoplayerstate();
    notifyListeners();
  }
  Widget getcurrenttitleanddescription(BuildContext context,String trtitle,String trdescription,List<Track> trlist,
      List<Playablee> plalist
      ){
    double screenwidth=MediaQuery.of(context).size.width;
    double screenheight=MediaQuery.of(context).size.height;
    double screenarea=screenwidth*screenheight;
    return    Container(margin: EdgeInsets.only(
  //           top: 34
    top: screenarea*0.000085
),
  child:
  StreamBuilder(
  stream:assetsAudioPlayer.realtimePlayingInfos,
  builder:(context,playinfos){
return  Center(
    child: Column(children: [

      Container(
        margin: EdgeInsets.only(
          //        top: 8
          left: screenwidth*0.05,
          right: screenwidth*0.05,
          //     top: screenarea*0.0000319
        ),child:
      trlist!=null?
      Text(
    //    assetsAudioPlayer.current.value.playlist.currentIndex
        playinfos.data!=null?
        playinfos.data.current!=null?
    trlist[playinfos.data.current.playlist.currentIndex].title.length<26?
    trlist[playinfos.data.current.playlist.currentIndex].title.contains("|")?
    trlist[playinfos.data.current.playlist.currentIndex].title.substring(0,
        trlist[playinfos.data.current.playlist.currentIndex].title.indexOf("|")):
    trlist[playinfos.data.current.playlist.currentIndex].title:
    trlist[playinfos.data.current.playlist.currentIndex].title.substring(0,26):
            trtitle:
        trtitle
        ,style: TextStyle(fontFamily: helveticaneuebold,
          color: Colors.black87,
          //    fontSize: 22
          fontSize: screenwidth*0.0586
      ),):
      Text(
        //    assetsAudioPlayer.current.value.playlist.currentIndex
        playinfos.data!=null?
        playinfos.data.current!=null?
        plalist[playinfos.data.current.playlist.currentIndex].track.title.length<26?
        plalist[playinfos.data.current.playlist.currentIndex].track.title.contains("|")?
        plalist[playinfos.data.current.playlist.currentIndex].track.title.substring(0,
            plalist[playinfos.data.current.playlist.currentIndex].track.title.indexOf("|")):
        plalist[playinfos.data.current.playlist.currentIndex].track.title:
        plalist[playinfos.data.current.playlist.currentIndex].track.title.substring(0,26):
        trtitle:
        trtitle
        ,style: TextStyle(fontFamily: helveticaneuebold,
          color: Colors.black87,
          //    fontSize: 22
          fontSize: screenwidth*0.0586
      ),),),
      Container(margin: EdgeInsets.only(
        //        top: 8
          left: screenwidth*0.05,
          right: screenwidth*0.05,
          top: screenarea*0.0000319
      ),
        child:
        trlist!=null?
        Text(
          playinfos.data!=null?
          playinfos.data.current!=null?
          trlist[playinfos.data.current.playlist.currentIndex
          ].description.length>80?
          trlist[playinfos.data.current.playlist.currentIndex].description.substring(0,80):
          trlist[playinfos.data.current.playlist.currentIndex].description:
          trdescription:
          trdescription,
          textAlign: TextAlign.center,
          style: TextStyle(fontFamily: helveticaneueregular,
              color: Colors.black45,
              //      fontSize: 13.5
              fontSize: screenwidth*0.036
          ),):
        Text(
          playinfos.data!=null?
          playinfos.data.current!=null?
          plalist[playinfos.data.current.playlist.currentIndex
          ].track.description.length>80?
          plalist[playinfos.data.current.playlist.currentIndex].track.description.substring(0,80):
          plalist[playinfos.data.current.playlist.currentIndex].track.description:
          trdescription:
          trdescription,
          textAlign: TextAlign.center,
          style: TextStyle(fontFamily: helveticaneueregular,
              color: Colors.black45,
              //      fontSize: 13.5
              fontSize: screenwidth*0.036
          ),),)
    ],),
  );}),);
  }

  Widget getpauseplaybutton(BuildContext context,
      int index, String trackid,String title,
      String description,String trackduration,
      String trackurl,String downloadurl,List<Track> traclist,
      List<Playablee> playabllist
      ){
double screenwidth=MediaQuery.of(context).size.width;
double screenheight=MediaQuery.of(context).size.height;
double screenarea=screenwidth*screenheight;

return LimitedBox(
  maxWidth: screenwidth,
  maxHeight: screenheight*0.0974,
  child: StreamBuilder(
    stream: assetsAudioPlayer.playerState,
    builder: (context,playerstate){
      return     Container(
        margin: EdgeInsets.only(
          //    top: 14
            top: screenarea*0.0000559
        ),
        width: screenwidth,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
                onTap: (){
assetsAudioPlayer.currentLoopMode==LoopMode.single?
assetsAudioPlayer.setLoopMode(LoopMode.playlist):
                   assetsAudioPlayer.setLoopMode(LoopMode.single)
                    ;
                    loop=!loop;
                    notifyListeners();
                    },
                child:
                loop?
                ShaderMask(
                    blendMode: BlendMode.srcATop,
                    shaderCallback: (Rect bounds){
                      return LinearGradient(colors: [Color(0xff9797de),Color(0xff32386A)],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
//                   stops: [0.0,0.5]
                      ).createShader(bounds);
                    },child:
                SvgPicture.asset("assets/images/repeat.svg",width: 20,)):
                ShaderMask(
                    blendMode: BlendMode.srcATop,
                    shaderCallback: (Rect bounds){
                      return LinearGradient(colors: [Color(0xff9797de),Color(0xff32386A)],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
//                   stops: [0.0,0.5]
                      ).createShader(bounds);
                    },child:

                SvgPicture.asset("assets/images/shuffle.svg",width: 20,))),

            IconButton(icon: Icon(CupertinoIcons.backward_end_fill,
              color: Colors.black.withOpacity(0.7),
              //                 size: 30,
              size:screenwidth*0.066,
            ),
                onPressed: (){
                  assetsAudioPlayer.previous();

                }),
            Container(
              //                height: 65,
              //              width: 65,
              height: screenheight*0.0974,width: screenheight*0.0974,
              decoration: BoxDecoration(
                color: Colors.white60,shape: BoxShape.circle,
              ),
              child: Center(
                child: IconButton(
                  icon: Icon(
                playerState==null?
                    CupertinoIcons.play_arrow_solid:
                playerState==PlayerState.pause?
                CupertinoIcons.play_arrow_solid:
                CupertinoIcons.pause_solid  ,
                    color: Colors.black87,
                    //             size: 30,
                    size:screenwidth*0.08,

                  ),onPressed: ()async{
                 getpauseorplaystatus()=='notplaying'?

                 playtrack(
                      index,  trackid, title,
                      description,  trackduration,
                      trackurl,  downloadurl,  traclist,playabllist):
                  pauseorplay();

                },
                ),
              ),
            ),
            IconButton(icon: Icon(CupertinoIcons.forward_end_fill,
              color: Colors.black.withOpacity(0.7),
              //        size: 30,
              size:screenwidth*0.066,

            ),
                onPressed: (){
//                  playnext();
  assetsAudioPlayer.next();
                }),
            ShaderMask(
                blendMode: BlendMode.srcATop,
                shaderCallback: (Rect bounds){
                  return LinearGradient(colors: [Color(0xff9797de),Color(0xff32386A)],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
//                   stops: [0.0,0.5]
                  ).createShader(bounds);
                },child:
            GestureDetector(
                onTap: (){
//                                timer=true;
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>
                        Timer()));
                },
                child:
                SvgPicture.asset("assets/images/timer.svg"))),

          ],
        ),
      );
    },
  ),
);
  }
  Widget playprogbar(BuildContext context){
    return       LimitedBox(
        maxHeight:30,
        child:

        StreamBuilder(
            stream:assetsAudioPlayer.currentPosition,
            builder: (context,currentpossnapshot){
              final Duration duration = currentpossnapshot.data;
              return
               assetsAudioPlayer.current.value==null?
                         ProgressBar(
                  progress: Duration(milliseconds: 0),
                  //  buffered: Duration(milliseconds: 2000),
                  total: Duration(milliseconds:
                  0),
                  thumbRadius: 10.5,
                  thumbColor:Color(0xff9797de),
                  timeLabelLocation: TimeLabelLocation.below,
                  timeLabelTextStyle: TextStyle(
                      fontFamily: helveticaneueregular,
                      color:Colors.black54,
                      fontSize: 12.5
                  ),
                  progressBarColor: Colors.deepPurple,
                  baseBarColor: Colors.white,
                  //     thumbGlowRadius: 4,
                  timeLabelType: TimeLabelType.totalTime,
                  onSeek: (duration) {
                    //    MusicPlays().assetsAudioPlayer.seek(Duration(milliseconds: duration.inMilliseconds));
                    //  print('User selected a new time: $duration');
                  },
                ):
                ProgressBar(
                  progress: Duration(milliseconds: duration.inMilliseconds),
                  //  buffered: Duration(milliseconds: 2000),
                  total: Duration(milliseconds:
                  assetsAudioPlayer.current.value.audio.duration.inMilliseconds),
                  thumbRadius: 10.5,
                  thumbColor:Color(0xff9797de),
                  timeLabelLocation: TimeLabelLocation.below,
                  timeLabelTextStyle: TextStyle(
                      fontFamily: helveticaneueregular,
                      color:Colors.black54,
                      fontSize: 12.5
                  ),
                  progressBarColor: Colors.deepPurple,
                  baseBarColor: Colors.white,
                  //     thumbGlowRadius: 4,
                  timeLabelType: TimeLabelType.totalTime,
                  onSeek: (dur) {
                  assetsAudioPlayer.seek(Duration(milliseconds: dur.inMilliseconds));
                    //  print('User selected a new time: $duration');
                  },
                )
              ;}));
  }
}
