import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goodvibesoffl/constants/fontconstants.dart';
import 'package:goodvibesoffl/constants/styleconstants.dart';
class Resetpassword extends StatefulWidget {
  @override
  _ResetpasswordState createState() => _ResetpasswordState();
}

class _ResetpasswordState extends State<Resetpassword> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _resetpasswordController = TextEditingController();

  bool showpassword = true;
  String pass, confirmPass;

  @override
  Widget build(BuildContext context) {
    final screenwidth=MediaQuery.of(context).size.width;
    final screenheight=MediaQuery.of(context).size.height;

    return Container(
      child: Column(children: [
        Container(
            margin: EdgeInsets.only(top: 19),

            child:
            ClipOval(child:
            BackdropFilter(
                filter:ImageFilter.blur(sigmaX:8,sigmaY: 8),child:
            Container(
              height: 117,
              width: 117,
              color: Colors.white.withOpacity(0.12),
              padding: EdgeInsets.only(left:7),

              child:Center(child:
              SvgPicture.asset('assets/images/reset.svg' ,width: 59,color: Colors.white,)),)))),
        Row(children:[
          Container(
            margin: EdgeInsets.only(top: 35,left: 36),
            child:
            Text('Reset Password',style: TextStyle(
                fontFamily: helveticaneuemedium,
                color: Colors.white,
                fontSize: 28
            ),),),]),
        Row(children:[
          Container(
            margin: EdgeInsets.only(left: 36,top: 6),
            child:
            Text('Choose a strong password that is at least 8\ncharacters long',style: TextStyle(
                fontFamily: helveticaneueregular,
                color: Colors.white.withOpacity(0.42),
                fontSize: 15
            ),),),
        ]),
Container(
    margin: EdgeInsets.only(left: 35,top: 20,right: 35,bottom: 44),
    child:Column(children:[
        Container(
          child: TextFormField(
            controller: _passwordController,
            autocorrect: false,
            autofocus: false,
            obscureText: showpassword,
            style: TextStyle(
                fontFamily: helveticaneueregular,color: Colors.white,
                //   fontSize: 14
                fontSize: screenheight*screenwidth*0.000055
            ),
            decoration:
            InputDecoration(
              suffixIcon: GestureDetector(
                onTap: (){
                  setState(() {
                    showpassword?showpassword=false:showpassword=true;

                  });
                },
                child: Icon(
                  showpassword? Icons.remove_red_eye_outlined:Icons.remove_red_eye,
                  //       size: 18,
                  size: screenheight*screenwidth*0.0000719,
                  color: Colors.white,
                ),),
              hintText: 'New Password',
              enabled: true,
              border: InputBorder.none,
              hintStyle: TextStyle(
                  fontFamily: helveticaneueregular,color: Colors.white70,
                  //        fontSize: 14
                  fontSize:    screenheight*screenwidth*0.000055
              ),
            ),
            validator: (value) {
              if (value.length < 8) {
                return 'Password must be min 8 char';
              }
              confirmPass = value;
              return null;
            },
            onSaved: (val) => pass = val,
          ),
        ),
        Container(
          //     margin: EdgeInsets.only(top: 8),
          margin: EdgeInsets.only(top:0),
          height: 1,
          width: screenwidth,
          color: Colors.white.withOpacity(0.6),
        ),
        Container(
          margin: EdgeInsets.only(top: 12),
          child: TextFormField(
            controller: _resetpasswordController,
            autocorrect: false,
            autofocus: false,
            obscureText: showpassword,
            style: TextStyle(
                fontFamily: helveticaneueregular,color: Colors.white,
                //   fontSize: 14
                fontSize: screenheight*screenwidth*0.000055
            ),
            decoration:
            InputDecoration(
              suffixIcon: GestureDetector(
                onTap: (){
                  setState(() {
                    showpassword?showpassword=false:showpassword=true;

                  });
                },
                child: Icon(
                  showpassword? Icons.remove_red_eye_outlined:Icons.remove_red_eye,
                  //       size: 18,
                  size: screenheight*screenwidth*0.0000719,
                  color: Colors.white,
                ),),
              hintText: 'Re-enter Password',
              enabled: true,
              border: InputBorder.none,
              hintStyle: TextStyle(
                  fontFamily: helveticaneueregular,color: Colors.white70,
                  //        fontSize: 14
                  fontSize:    screenheight*screenwidth*0.000055
              ),
            ),
            validator: (value) {
              if (value.length < 8) {
                return 'Password must be min 8 char';
              }
              confirmPass = value;
              return null;
            },
            onSaved: (val) => pass = val,
          ),
        ),
        Container(
          //     margin: EdgeInsets.only(top: 8),
          margin: EdgeInsets.only(top:0),
          height: 1,
          width: screenwidth,
          color: Colors.white.withOpacity(0.6),
        ),
    ])),
        InkWell(
            onTap: (){

            },
            child:
            Container(
              height: 40,
              width: 302,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30),
                ),
                color: Color(0xff9797de),
              ),
              child: Center(
                child: Text(
                  'Reset Password',style: authtextstyles,
                ),
              ),
            )),
      ],),
    );
  }
}
