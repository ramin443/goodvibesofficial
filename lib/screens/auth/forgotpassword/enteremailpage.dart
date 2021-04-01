import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goodvibesofficial/constants/fontconstants.dart';
import 'package:goodvibesofficial/constants/styleconstants.dart';
import 'package:goodvibesofficial/utils/validator.dart';
class EnterEmailaPage extends StatefulWidget {
  @override
  _EnterEmailaPageState createState() => _EnterEmailaPageState();
}

class _EnterEmailaPageState extends State<EnterEmailaPage> {
  String  displayname;
  final TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final screenwidth=MediaQuery.of(context).size.width;

    return Container(

      color: Colors.transparent,
      child: Column(
        children: [
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
                child:Center(child:
                SvgPicture.asset('assets/images/forgot-2.svg' ,width: 59,color: Colors.white,)),)))),
          Row(children:[
            Container(
              margin: EdgeInsets.only(top: 35,left: 36),
              child:
              Text('Forgot Password?',style: TextStyle(
                  fontFamily: helveticaneuemedium,
                  color: Colors.white,
                  fontSize: 28
              ),),),]),
          Row(children:[
            Container(
              margin: EdgeInsets.only(left: 36,top: 6),
              child:
              Text('Enter your email address to reset your\npassword',style: TextStyle(
                  fontFamily: helveticaneueregular,
                  color: Colors.white.withOpacity(0.42),
                  fontSize: 15
              ),),),
          ]),
          Container(
            margin: EdgeInsets.only(left: 36,right: 36,top: 43),
            child:

            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress ?? TextInputType.text,
              autocorrect: false,
              autofocus: false,
              onSaved: (val) => displayname = val,
              style: TextStyle(
                  fontFamily: helveticaneueregular,color: Colors.white,
                  fontSize: 14
              ),
              readOnly: false,
              decoration: InputDecoration(

                suffixIcon:
                Padding(
                    padding: EdgeInsets.only(bottom: 7),
                    child:
                    Icon(Icons.mail_outline,
                      color: Colors.white,
                      size: 18,)),
                hintText: "robertfox@mail.com",
                hintStyle: TextStyle(
                    fontFamily: helveticaneueregular,color: Colors.white70,
                    fontSize: 14
                ),
                errorStyle: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .copyWith(color: Colors.red),
                border: InputBorder.none,
              ),
              validator: (value) => emailValidator(value),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 54,left: 36,right: 36),
            //     margin: EdgeInsets.symmetric(horizontal: 35),
            height: 1,
            width: screenwidth,
            color: Colors.white70,
          ),

          InkWell(
              onTap: (){
setState(() {

});
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
                    'Continue',style: authtextstyles,
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
