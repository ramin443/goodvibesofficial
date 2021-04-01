import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
class ExampleStartScreen extends StatefulWidget {
  @override
  _ExampleStartScreenState createState() => _ExampleStartScreenState();
}

class _ExampleStartScreenState extends State<ExampleStartScreen> {
  @override
  Widget build(BuildContext context) {
    double screenwidth=MediaQuery.of(context).size.width;
    double screenheight=MediaQuery.of(context).size.height;
    Color initialcolor=Color(0xff9797de);
    Color finalcolor=Color(0xff32386A);
    return
Stack(children:[
  Image.asset('assets/images/X - 1@2x.png',  fit: BoxFit.cover,
width: screenheight,
  ),
      Scaffold(
        backgroundColor: Colors.transparent,
body: Column(
  mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.center,
  children:[
    Container(
        alignment:Alignment.center,
        margin: EdgeInsets.only(bottom:50),
        child:
    ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (Rect bounds){
        return LinearGradient(colors: [finalcolor,Color(0xff9797de)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          //                   stops: [0.0,0.5]
        ).createShader(bounds);
      }
      ,child:
        Hero(
            tag: 'logo',
            child:
  SvgPicture.asset('assets/images/white_logo.svg',
    height: 100,
    width: 100,
    color:finalcolor ,
  )))),]
),
    ),


]);
  }
}
