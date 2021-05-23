import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goodvibesoffl/constants/fontconstants.dart';
import 'package:goodvibesoffl/constants/styleconstants.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
class EnterOTP extends StatefulWidget {
  @override
  _EnterOTPState createState() => _EnterOTPState();
}

class _EnterOTPState extends State<EnterOTP> {
  String currentText='';
  TextEditingController otpcontroller=TextEditingController();
  @override
  Widget build(BuildContext context) {
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
              child:Center(child:
              SvgPicture.asset('assets/images/otp.svg' ,width: 59,color: Colors.white,)),)))),
        Row(children:[
          Container(
            margin: EdgeInsets.only(top: 35,left: 36),
            child:
            Text('Check email for OTP',style: TextStyle(
                fontFamily: helveticaneuemedium,
                color: Colors.white,
                fontSize: 28
            ),),),]),
        Row(children:[
          Container(
            margin: EdgeInsets.only(left: 36,top: 6),
            child:
            Text('To reset your password, please enter the 4\ndigit pin sent to your email',style: TextStyle(
                fontFamily: helveticaneueregular,
                color: Colors.white.withOpacity(0.42),
                fontSize: 15
            ),),),
        ]),
        Container(
          margin: EdgeInsets.only(left: 50,right: 50,top: 20),
          child: PinCodeTextField(
            onTap: (){

            },

            enablePinAutofill: true,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.continueAction,
            length: 4,
            obscureText: true,
            enabled: true,
            pinTheme: PinTheme(
              borderWidth: 1,
    //          shape: PinCodeFieldShape.box,
              disabledColor: Colors.transparent,
              inactiveColor: Colors.white,
              inactiveFillColor: Colors.transparent,
              borderRadius: BorderRadius.circular(5),
              fieldHeight: 50,
              fieldWidth: 40,
              activeColor: Colors.black,
              activeFillColor: Colors.transparent,
            ),
            pastedTextStyle:TextStyle(
    fontFamily: helveticaneueregular,
    color: Colors.white,
    fontSize: 24
    ),
            textStyle: TextStyle(
              fontFamily: helveticaneueregular,
              color: Colors.white,
              fontSize: 24
            ),
            backgroundColor: Colors.transparent,
            enableActiveFill: true,
 //           errorAnimationController: errorController,
            controller: otpcontroller,
            onCompleted: (v) {

            },
            onChanged: (value) {
              print(value);
              setState(() {
                currentText = value;
              });
            },
            beforeTextPaste: (text) {
              print("Allowing to paste $text");

              return true;
            },
          ),
        ),
        InkWell(
            onTap: (){

            },
            child:
            Container(
              margin: EdgeInsets.only(top: 40,bottom: 18),
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
        Container(
          child: RichText(
            textAlign:TextAlign.center,
            text: TextSpan(

              style:

              TextStyle(
                fontFamily: helveticaneueregular,
                fontSize: 14,
                color: Colors.white,
              ),
              children: [
                TextSpan(

text: "Didn't get code?"
                ),
                TextSpan(
                  text: "\nResend code",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                      fontFamily: helveticaneueregular,
                      fontSize: 14,
                      color: Color(0xff9797de)
                  ),
                )
              ]
            ),
          ),
        )
      ],),
    );
  }
}
