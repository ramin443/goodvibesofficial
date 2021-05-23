import 'dart:ui';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goodvibesoffl/constants/fontconstants.dart';
import 'package:goodvibesoffl/constants/styleconstants.dart';
import 'package:goodvibesoffl/screens/auth/forgotpassword/enteremailpage.dart';
import 'package:goodvibesoffl/screens/auth/forgotpassword/enterotp.dart';
import 'package:goodvibesoffl/screens/auth/forgotpassword/resetpw.dart';
import 'package:goodvibesoffl/utils/validator.dart';
import 'package:intl/intl.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
class Enteremail extends StatefulWidget {
  @override
  _EnteremailState createState() => _EnteremailState();
}

class _EnteremailState extends State<Enteremail> with SingleTickerProviderStateMixin {
  String  displayname;
   TextEditingController _emailController = TextEditingController();
int currentindex=0;
bool emailpage=true;
  String currentText='';
  TextEditingController otpcontroller=TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _resetpasswordController = TextEditingController();

  bool showpassword = true;
  String pass, confirmPass;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenwidth=MediaQuery.of(context).size.width;

    return
      Stack(children:[
        Image.asset('assets/images/X - 1@2x.png',  fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
        ),

   Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(child:
          Icon(CupertinoIcons.back,
     //       size: 30,
       size: screenwidth*0.08,
            color: Colors.black12.withOpacity(0.74),
          )
          ,onTap: (){
          Navigator.pop(context);
        },),

      ),
      body:

            SingleChildScrollView(child:

            Container(

              color: Colors.transparent,
              child: Column(
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedContainer(
                          margin: EdgeInsets.only(
                    //          right: 16
                      right: screenwidth*0.0426
                          ),
                          duration: Duration(milliseconds: 350),
                 //       height: 4,width: 61,
                   height: screenwidth*0.0106,width: screenwidth*0.162,
                          decoration: BoxDecoration(
                            color:emailpage?Color(0xff9797de) :Color(0xff32386a).withOpacity(0.33),
                            borderRadius: BorderRadius.all(Radius.circular(20)),

                          ),
                        ),
                        AnimatedContainer(
                          margin: EdgeInsets.only(right:0),
                          duration: Duration(milliseconds: 350),
                     //     height: 4,width: 61,
                          height: screenwidth*0.0106,width: screenwidth*0.162,
                          decoration: BoxDecoration(
                            color:emailpage?Color(0xff32386a).withOpacity(0.33):Color(0xff9797de) ,
                            borderRadius: BorderRadius.all(Radius.circular(20)),

                          ),
                        ),
                      ],
                    ),
                  ),
                  emailpage?
                  Container(
                      key: UniqueKey(),
                      child:Column(children:[
                  Container(
                      margin: EdgeInsets.only(top: 19),

                      child:
                      ClipOval(child:
                      BackdropFilter(
                          filter:ImageFilter.blur(sigmaX:8,sigmaY: 8),child:
                      Container(
                  //      height: 117, width: 117,
                    height: screenwidth*0.312,width: screenwidth*0.312,
                        color: Color(0xff9797de),
                        padding: EdgeInsets.only(left:7),
                        child:Center(child:
                        SvgPicture.asset('assets/images/forgot-2.svg' ,
                     //     width: 59,
                       width: screenwidth*0.157,
                          color: Colors.white,)),)))),
                  Row(children:[
                    Container(
                      margin: EdgeInsets.only(
                   //       top: 35,left: 36
                     top: screenwidth*0.09333,left: screenwidth*0.096
                      ),
                      child:
                      Text('Forgot Password?',style: TextStyle(
                          fontFamily: helveticaneuemedium,
                          color: Colors.black12.withOpacity(0.74),
                  //        fontSize: 28
                    fontSize: screenwidth*0.0746
                      ),),),]),
                  Row(children:[
                    Container(
                //      margin: EdgeInsets.only(left: 36,top: 6),
                  margin: EdgeInsets.only(left: screenwidth*0.096,top: screenwidth*0.016),
                      child:
                      Text('Enter your email address to reset your\npassword',style: TextStyle(
                          fontFamily: helveticaneueregular,
                          color: Colors.black.withOpacity(0.62),
                   //       fontSize: 15
                     fontSize: screenwidth*0.04
                      ),),),
                  ]),
                  Container(
                    margin: EdgeInsets.only(
//                        left: 36,right: 36, top: 43
                        left: screenwidth*0.096,right: screenwidth*0.096, top: screenwidth*0.1146
                    ),
                    child:

                    TextFormField(
                      validator: (value) => emailValidator(value),
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress ,
                      onChanged: (v){
                      },
                      style: TextStyle(
                          fontFamily: helveticaneueregular,
                          color: Colors.black.withOpacity(0.62),
                  //        fontSize: 14.5
                    fontSize: screenwidth*0.0386
                      ),
                      decoration: InputDecoration(

                        suffixIcon:
                        Padding(
                            padding: EdgeInsets.only(
                       //         bottom: 7
                         bottom: screenwidth*0.01866
                            ),
                            child:
                            Icon(Icons.mail_outline,
                              color: Colors.black54,
                     //         size: 18,
                       size: screenwidth*0.048
                              ,     )),
                        hintText: "robertfox@mail.com",
                        hintStyle: TextStyle(
                            fontFamily: helveticaneueregular,
                            color: Colors.black.withOpacity(0.62),
                  //          fontSize: 14.5
                            fontSize: screenwidth*0.0386
                        ),
                        errorStyle: Theme.of(context)
                            .textTheme
                            .bodyText2
                            .copyWith(color: Colors.redAccent),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 54,
                  //      left: 36,right: 36
                        left:screenwidth*0.096,right:screenwidth*0.096
                    ),
                    //     margin: EdgeInsets.symmetric(horizontal: 35),
                    height: 1,
                    width: screenwidth,
                    color: Colors.black.withOpacity(0.52),
                  ),

                  InkWell(
                      onTap: (){
                        setState(() {
                          EmailValidator.validate(_emailController.text)?emailpage=false:emptycode()
                          ;
                        });
                      },
                      child:
                      Container(
                      //  height: 40, width: 302,
                        height: screenwidth*0.1066,width: screenwidth*0.8053,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30),
                          ),
                          color:
                          Color(0xff9797de),
                        ),
                        child: Center(
                          child: Text(
                            'Continue',style: authtextstyles,
                          ),
                        ),
                      )),])):resetpasswordpage(context)
                ],
              ),
            ) ),

    )
      ]);
  }
  Widget resetpasswordpage(BuildContext context){
    final screenwidth=MediaQuery.of(context).size.width;
    final screenheight=MediaQuery.of(context).size.height;

    return Container(
      key: UniqueKey(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Container(
            margin: EdgeInsets.only(top: 19),

            child:
            ClipOval(child:
            BackdropFilter(
                filter:ImageFilter.blur(sigmaX:8,sigmaY: 8),child:
            Container(
          //    height: 117, width: 117,
              height: screenwidth*0.312,width: screenwidth*0.312,

              color: Colors.blue,
              padding: EdgeInsets.only(
          //        left:7
                  left: screenwidth*0.01866
              ),

              child:Center(child:
              SvgPicture.asset('assets/images/reset.svg' ,
             //   width: 59,
                width: screenwidth*0.157,
                color: Colors.white,)),)))),
        Row(children:[
          Container(
       //    margin: EdgeInsets.only(top: 35,left: 36),
         margin: EdgeInsets.only(   top: screenwidth*0.09333,left: screenwidth*0.096
         ),
            child:
            Text('Reset Password Link\nhas been sent to your\nemail address',style: TextStyle(
                fontFamily: helveticaneuemedium,
                color: Colors.black12.withOpacity(0.74),
          //      fontSize: 28
                fontSize: screenwidth*0.0746

            ),),),]),
        Row(children:[
          Container(
        //    margin: EdgeInsets.only(left: 36,top: 6),
            margin: EdgeInsets.only(left: screenwidth*0.096,top: screenwidth*0.016),
            child:
            Text('Choose a strong password that is at least 8\ncharacters long',style: TextStyle(
                fontFamily: helveticaneueregular,
                color:Colors.black.withOpacity(0.62),
         //       fontSize: 15
                fontSize: screenwidth*0.04
            ),),),
        ]),
Container(
    margin: EdgeInsets.only(
  //      top: 80
    top: screenwidth*0.213
    ),
    child:
        InkWell(
            onTap: (){
Navigator.pop(context);
            },
            child:
            Container(
              //height: 40, width: 302,
              height: screenwidth*0.1066,width: screenwidth*0.8053,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30),
                ),
                color: Color(0xff9797de),
              ),
              child: Center(
                child: Text(
                  'Okay',style: authtextstyles,
                ),
              ),
            )),)
      ],),
    );
  }
  emptycode(){}
}
