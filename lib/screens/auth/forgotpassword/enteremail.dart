import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goodvibesofficial/constants/fontconstants.dart';
import 'package:goodvibesofficial/constants/styleconstants.dart';
import 'package:goodvibesofficial/screens/auth/forgotpassword/enteremailpage.dart';
import 'package:goodvibesofficial/screens/auth/forgotpassword/enterotp.dart';
import 'package:goodvibesofficial/screens/auth/forgotpassword/resetpw.dart';
import 'package:goodvibesofficial/utils/validator.dart';
import 'package:intl/intl.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
class Enteremail extends StatefulWidget {
  @override
  _EnteremailState createState() => _EnteremailState();
}

class _EnteremailState extends State<Enteremail> with SingleTickerProviderStateMixin {
  String  displayname;
  final TextEditingController _emailController = TextEditingController();
  TabController _tabController;
int currentindex=0;
  String currentText='';
  TextEditingController otpcontroller=TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _resetpasswordController = TextEditingController();

  bool showpassword = true;
  String pass, confirmPass;
  @override
  void initState() {
    super.initState();
    _tabController=TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      _handleTabSelection();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      switch (_tabController.index) {
        case 0:
          _tabController.index=0;
          currentindex=0;
          break;
        case 1:
          _tabController.index=1;
          currentindex=1;

          break;
        case 2:
          _tabController.index=2;
          currentindex=2;

          break;
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    final screenwidth=MediaQuery.of(context).size.width;

    return
      Stack(children:[
        Image.asset('assets/images/blurredbg.png',  fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
        ),
  DefaultTabController(length: 3,
      initialIndex: 0,
      child:
   Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(child:
          Icon(CupertinoIcons.back,
            size: 30,
            color: Colors.white,
          )
          ,onTap: (){
          Navigator.pop(context);
        },),
        bottom: TabBar(

   //       physics: NeverScrollableScrollPhysics(),
          onTap: (v){
            _tabController.index=_tabController.index;
            currentindex=currentindex;
          },
          controller: _tabController,
          indicator: BoxDecoration(
            color: Colors.transparent
          ),
          tabs: [
            Tab(
              child: Container(
              margin: EdgeInsets.only(left: 40),
              height: 4,
              width: 61,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                color:
                currentindex==0?
                Color(0xff9797de):Colors.white
              ),
              ),),
            Tab(child: Container(
              height: 4,
              width: 61,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  color:       currentindex==1?
                  Color(0xff9797de):Colors.white
              ),
            ),),
            Tab(child: Container(
              margin: EdgeInsets.only(right: 40),

              height: 4,
              width: 61,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  color:      currentindex==2?
                  Color(0xff9797de):Colors.white
              ),
            ),),
          ],
        ),
      ),
      body:
      TabBarView(
        physics: NeverScrollableScrollPhysics(),
          controller: _tabController,
          children:[
            Container(

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
                        padding: EdgeInsets.only(left:7),
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
_tabController.index=1;
currentindex=1;
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
            ),
            Container(
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
                      padding: EdgeInsets.only(left:20),

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
setState(() {
  _tabController.index=2;
  currentindex=2;
});
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
            ),
        Resetpassword()
      ])
    ))
      ]);
  }
}
