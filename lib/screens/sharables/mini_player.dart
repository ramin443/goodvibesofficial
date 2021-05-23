import 'dart:ui';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goodvibesoffl/constants/fontconstants.dart';
class MiniPlayer extends StatefulWidget {
  @override
  _MiniPlayerState createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer> {
  final assetsAudioPlayer = AssetsAudioPlayer();
  int currentprogress=0;
  PlayerState _playerState;
  int totalduration=0;
  bool playmorethanonce=false;
  bool playing=false;
  bool loop=false;
  @override
  Widget build(BuildContext context) {
    double screenwidth=MediaQuery.of(context).size.width;
    double screenheight=MediaQuery.of(context).size.height;
    double screenarea=screenheight*screenwidth;
    return
    Container(
child:      Column(children:[
        Container(
          width: screenwidth,
          height: 1.8,
          color: Colors.black26,
          alignment: Alignment.centerLeft,
          child: Container(
            color: Color(0xff12c2e9),
            height: 1.8,
            width: screenwidth*0.6,
          ),
        ),
        ClipRect(child:BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 50,sigmaY: 50),
            child:
            Container(
              color: Colors.black.withOpacity(0.03),
              padding: EdgeInsets.symmetric(
                //       horizontal: 12,vertical: 9
                  horizontal: screenwidth*0.032,vertical: screenwidth*0.024
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          height:  screenwidth*0.144,width:  screenwidth*0.144,
                          child: Image.asset("assets/images/orange_circle.png",fit: BoxFit.cover,),
                        ))),
                    Container(
                      margin: EdgeInsets.only(
                        //   left: 16
                          left: screenarea*0.0000639
                      ),
                      //   height: 54,
                      height:  screenheight*0.08095,
                      child: Column(crossAxisAlignment:CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(child: Text("Get Motivated",style: TextStyle(
                              fontFamily: helveticaneuebold,color: Colors.black87,
                              //  fontSize: 13.5
                              fontSize: screenwidth*0.036
                          ),),),
                          Container(
                            margin: EdgeInsets.only(
                              //     top: 5
                                top: screenarea*0.00001999
                            ),
                            child: Text("Reach your goals with this advice",style: TextStyle(
                                fontFamily: helveticaneueregular,color: Colors.black54,
                                //fontSize: 10
                                fontSize:screenwidth*0.0266
                            ),),),
                        ],),),
                  ])),
                  Container(child:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(onTap:(){},child: Container(child: Icon(Icons.skip_previous,
                        //    size: 26,
                        size: screenwidth*0.0693,
                        color: Colors.black87,),)),
                      GestureDetector(onTap:()async{
                        playmorethanonce?pauseorplay():
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

                        setState(() {
                          //       assetsAudioPlayer.current.value.audio.
                          totalduration=assetsAudioPlayer.current.value.audio.duration.inMilliseconds;
//                    totalduration=
                          playing=!playing;
                          playmorethanonce=true;
                        });
                      },child: Container(child: Icon(
                        _playerState==PlayerState.play?
                        CupertinoIcons.pause_solid:CupertinoIcons.play_arrow_solid,
                        //      size: 26,
                        size: screenwidth*0.0693,
                        color: Colors.black87,),)),
                      GestureDetector(onTap:(){},child: Container(child: Icon(Icons.skip_next,
                        //        size: 26,
                        size: screenwidth*0.0693,
                        color: Colors.black87,),)),

                    ],))
                ],),
            )))]));
  }
  pauseorplay()async{
    assetsAudioPlayer.isPlaying.value?assetsAudioPlayer.pause():assetsAudioPlayer.play();
    setState(() {
      totalduration= assetsAudioPlayer.current.value.audio.duration.inMilliseconds;
    });
  }
}
