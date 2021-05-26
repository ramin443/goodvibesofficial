
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goodvibesoffl/constants/fontconstants.dart';
import 'package:goodvibesoffl/screens/auth/login.dart';
import 'package:goodvibesoffl/screens/home/base.dart';
import 'package:goodvibesoffl/screens/sharables/MusicPlayer.dart';
import 'package:provider/provider.dart';
class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    double screenwidth=MediaQuery.of(context).size.width;
    double screenheight=MediaQuery.of(context).size.height;
    Color initialcolor=Color(0xff9797de);
    double screenarea=screenheight*screenwidth;
    Color finalcolor=Color(0xff32386A);
    return Stack(

        children:[
      Image.asset('assets/images/X - 1@2x.png',  fit: BoxFit.cover,
        width: screenheight,
      ),
Positioned(
 //   left: -100,
  left: -screenheight*screenwidth*0.0004,
top: screenheight*screenwidth*0.000579,
//    top: 145,
    child:
     Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[

              Container(
            //    margin: EdgeInsets.only(right: 170),
                  alignment:Alignment.centerLeft,
           //       margin: EdgeInsets.only(bottom:50),
                  child:
Hero(
    tag: 'logo',
    child:
                      SvgPicture.asset('assets/images/white_logo.svg',
//                        height: 350,
                      height: screenheight*screenwidth*0.00139,
width: screenheight*screenwidth*0.00107,
//                    width: 350*327/426.7,
            //            fit: BoxFit.scaleDown,
 //                       alignment: new Alignment(-200,0),
                        alignment: new Alignment(-screenheight*screenwidth*0.00079,0),
                    //    width: 426*372/426.7,
                        color:Color(0xff9797de).withOpacity(0.15),
                      ))),]
        ),
      ),
Column(mainAxisAlignment: MainAxisAlignment.start,
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Container(
      alignment: Alignment.topLeft,
  //    margin: EdgeInsets.only(top: 120,left: 18),
    margin: EdgeInsets.only(top: screenheight*screenwidth*0.00047,
        left: screenheight*screenwidth*0.0000719),
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            fontFamily: helveticaneueregular,
            color: Color(0xff32386a),
      //      fontSize: 25
        fontSize: screenwidth*0.0666
          ),
         children: [
           TextSpan(text: 'Express Gratitude\nGenerate '),
           TextSpan(text: 'Good Vibes.',style: TextStyle(fontFamily: helveticaneuemedium,
      //     fontSize: 25,
      fontSize: screenwidth*0.0666
,
      color: Color(0xff32386a),
           ))
         ]
        ),

      ),
    )
  ],
),
      Scaffold(
          backgroundColor: Colors.transparent,
          body:
      Column(
        mainAxisAlignment: MainAxisAlignment.end,crossAxisAlignment: CrossAxisAlignment.end,
        children: [
        Container(
          alignment: Alignment.bottomRight,
 //         margin: EdgeInsets.only(right: 30, bottom:60 ),
   margin: EdgeInsets.only(right: screenheight*screenwidth*0.000119,
   bottom: screenheight*screenwidth*0.000239),
          child:
          GestureDetector(
              onTap: (){
                Navigator.of(context).push(_createRoute());
              },
              child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(Icons.arrow_forward,
         //       size: 22,
                size: screenwidth*0.0586,
                color: Color(0xff32386a),),
              Text('Get Started',style: TextStyle(
             //     fontSize: 18,
                fontSize: screenwidth*0.048,
                  fontFamily: helveticaneueregular,
                  color: Color(0xff32386a)
              ),)
            ],
          ) ),
        )
      ],))

    ]);
  }
  
  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>  MultiProvider(
      providers: [
        ChangeNotifierProvider<MusicPlays>(
          create: (_)=>MusicPlays(),
//  builder: (_,child)
          //  => DataProvider(),
        ),
      ],
      child:Base()),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
