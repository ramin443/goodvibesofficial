import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:goodvibesoffl/constants/fontconstants.dart';
import 'package:goodvibesoffl/screens/sharables/music_player.dart';
import 'package:goodvibesoffl/constants/styleconstants.dart'as Styleconst;

class TrackDetails extends StatefulWidget {
  final String imageasset;
  final String title;
  String description;

  TrackDetails({Key key, @required this.imageasset,@required this.title,@required this.description}) : super(key: key);

  @override
  _TrackDetailsState createState() => _TrackDetailsState();
}

class _TrackDetailsState extends State<TrackDetails> {
  PlayerState _playerState;

  @override
  initState() {
    super.initState();
    addcurrentaudiolistener();
  }
  addcurrentaudiolistener()async{
    Styleconst.constassetsAudioPlayer.playerState.listen((event) {
      _playerState=event;
    });
  }
  @override
  Widget build(BuildContext context) {
    double screenwidth= MediaQuery.of(context).size.width;
    double screenheight= MediaQuery.of(context).size.height;
    return
      Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(
            builder: (context)=>MusicPlayer(imageasset: widget.imageasset,
                title:  widget.title,
                description: widget.description)
            ));
          },
          child: Container(
            margin: EdgeInsets.only(
        //        bottom: 24
          bottom: screenwidth*0.064

            ),
       //     height: 49,width: 188,
         height: screenwidth*0.1066,width: screenwidth*0.373,
            padding: EdgeInsets.symmetric(
          //      horizontal: 14
            horizontal: screenwidth*0.032
            ),
            decoration: BoxDecoration(
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.23),blurRadius: 20,
              offset: Offset(0,4))],
color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                _playerState==PlayerState.play?
                CupertinoIcons.pause_solid:CupertinoIcons.play_arrow_solid,
              color: Colors.black.withOpacity(0.72),
        //      size: 28,
          size: screenwidth*0.0693,
              ),
              Container(
                child: Text("Play Now",style: TextStyle(
                  fontFamily: helveticaneuemedium,
                  color: Colors.black.withOpacity(0.72),
             //     fontSize: 18
               fontSize: screenwidth*0.04266
                ),),
              )
            ],
            ),
          ),

        ),
      backgroundColor: Colors.white,
body:      SafeArea(child:
        Stack(
  children: [
    Column(mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Image.asset("assets/images/trackdes.png",width: screenwidth,),
    ],
    ),
    Positioned.fill(
        child:Container(
            alignment: Alignment.bottomCenter,
            child:
    Container(
      height: screenheight*0.647,
      width: screenwidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(16),topRight:Radius.circular(16) ),
        color: Colors.white
      ),
      padding: EdgeInsets.all(
    //      22
screenwidth*0.0533
      ),
      child: Column(mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
        Container(
child: Text("Track Description",style: TextStyle(
  fontFamily: helveticaneuebold,
  color: Colors.black.withOpacity(0.62),
//  fontSize: 22
fontSize: screenwidth*0.0533
),),
        ),
        Container(
          margin: EdgeInsets.symmetric(
     //         vertical: 28
       vertical: screenwidth*0.06933
          ),
          child: Text(widget.title,style: TextStyle(
              fontFamily: helveticaneuemedium,
              color: Colors.black87,
    //          fontSize: 28
           fontSize:   screenwidth*0.06933
          ),),
        ),])),

        Container(
          child: Text("With the power of 12000 Hz full restore all 7 "
              "chakras at once. This meditation music session "
              "with delta binaural beats heals your whole body, "
              "activates kundalini, allows oneself to experience "
          "altered states restoring the whole chakras to "
              "their potential.\n\n"
              "To experience the best sound, Use a pair of "
              "headphones. Listen to this music in a quiet "
              "place for at least 20 / 25 minutes daily “If "
              "Possible”. If you are a beginner then don’t try to "
              "fit too much at once)",style: TextStyle(
              fontFamily: helveticaneueregular,

              color: Colors.black.withOpacity(0.76),
      //        fontSize: 15
        fontSize: screenwidth*0.036

          ),),
        ),

      ],
      ),
    ))),
    AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        onPressed: (){
          Navigator.pop(context);
        },
        icon: Icon(CupertinoIcons.back,
       // size: 28,
        size: screenwidth*0.0746,
          color: Colors.white,),
      ),
    )

  ],
),)
    );
  }
}
