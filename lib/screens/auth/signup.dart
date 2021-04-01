import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:goodvibesofficial/constants/fontconstants.dart';
import 'package:goodvibesofficial/constants/styleconstants.dart';
import 'package:goodvibesofficial/provider/login_provider.dart';
import 'package:goodvibesofficial/screens/initial/goals.dart';
import 'package:goodvibesofficial/utils/validator.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String email, pass, displayname, confirmPass;
  final _formKey = GlobalKey<FormState>();
  bool showpassword = true;
  FormMode formMode = FormMode.LOGIN;
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _phonenumbercontroller = TextEditingController();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    double screenheight=MediaQuery.of(context).size.height;
    double screenwidth=MediaQuery.of(context).size.width;
    double screenarea=screenheight*screenwidth;
    final sizeManager = ResponsiveFlutter.of(context);
    return Stack(children: [
      Image.asset('assets/images/timothee-duran-ilfsT5p_qvA-unsplash.png',  fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,),
      Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(CupertinoIcons.back,
            color: Colors.white,
            //size: 30,
            size: screenwidth*0.08,
            ),onPressed: (){
              Navigator.pop(context);
          },
          ),
        ),
        backgroundColor: Colors.transparent,
      body: Container(
        alignment: Alignment.center,
        height: screenheight,
        width: screenwidth,
        child:
        Center(child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
Row(children: [
  Container(margin:EdgeInsets.only(
  //    left: 36
  left: screenarea*0.00014
  ),
      child:
  ClipOval(
      child: Container(
   //     margin: EdgeInsets.only(left: 36),
   //     height:80 ,
     //   width: 80,
       height:screenheight*0.119 ,
        width: screenheight*0.119 ,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.20),
        ),
        alignment: Alignment.center,
        child: Center(child:
        SvgPicture.asset('assets/images/white_logo.svg',
      //   width: 32,
        width:screenwidth*0.0853
        ),
        ),
      ),
  ))
],),Row(
                children:[
            Container(
              margin: EdgeInsets.only(
            //      top: 32,
              //    bottom: 32,
                top: screenarea*0.000127,
                  bottom: screenarea*0.000127,
           left: screenarea*0.00014
                //       left: 36

              ),
              child: Text('Create new account?',style: TextStyle(
                fontFamily: helveticaneuemedium,
                color: Colors.white,
         //       fontSize: 28
           fontSize: screenwidth*0.0746
              ),
              ),
            )]),
LimitedBox(
//  maxHeight: 200,
//    margin: EdgeInsets.only(bottom: 100),
    child:Column(children:[
            Container(
              margin: EdgeInsets.symmetric(
              //    horizontal: 35
              horizontal: screenarea*0.000139
              ),
              child:


                TextFormField(
                  controller: _namecontroller,
                  keyboardType: TextInputType.text,
                  autocorrect: false,
                  autofocus: false,
                  onSaved: (val) => displayname = val,
                  style: TextStyle(
                      fontFamily: helveticaneueregular,color: Colors.white,
                   //   fontSize: 14
                  fontSize: screenwidth*0.0373
                  ),
                  readOnly: false,
                  decoration: InputDecoration(

                    suffixIcon:
                    Padding(
                        padding: EdgeInsets.only(
                        //    bottom: 10
                        bottom: screenarea*0.000039
                        ),
                        child:
                        Icon(CupertinoIcons.person,
                          color: Colors.white,
                        //  size: 18,
                        size:screenwidth*0.048 ,
                        )),
                    hintText: "Robert Fox",
                    hintStyle: TextStyle(
                        fontFamily: helveticaneueregular,color: Colors.white70,
                   //     fontSize: 14
                    fontSize: screenwidth*0.0373
                    ),
                    errorStyle: Theme.of(context)
                        .textTheme
                        .bodyText2
                        .copyWith(color: Colors.red),
                    border: InputBorder.none,
                  ),
                ),


            ),
            Container(

              margin: EdgeInsets.only(
             //     bottom: 12,
                bottom: screenarea*0.000047,
                  left: screenarea*0.000139,
             right: screenarea*0.000139
             //    left: 35,
             //     right: 35

              ),

              //     margin: EdgeInsets.symmetric(horizontal: 35),
              height: 1,
              width: screenwidth,
              color: Colors.white70,
            ),
            Container(
              margin: EdgeInsets.symmetric(
              //   horizontal: 35
              horizontal: screenarea*0.000139
              ),
              child:
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress ?? TextInputType.text,
                  autocorrect: false,
                  autofocus: false,
                  onSaved: (val) => displayname = val,
                  style: TextStyle(
                      fontFamily: helveticaneueregular,color: Colors.white,
                   //   fontSize: 14
                  fontSize: screenwidth*0.0373
                  ),
                  readOnly: false,
                  decoration: InputDecoration(

                    suffixIcon:
                    Padding(
                        padding: EdgeInsets.only(
                        //    bottom: 10
                        bottom: screenarea*0.000039
                        ),
                        child:
                        Icon(Icons.mail_outline,
                          color: Colors.white,
                        //  size: 18,
                        size: screenwidth*0.048,
                        )),
                    hintText: "robertfox@mail.com",
                    hintStyle: TextStyle(
                        fontFamily: helveticaneueregular,color: Colors.white70,
                     //   fontSize: 14
                    fontSize: screenwidth*0.0373
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
              margin: EdgeInsets.only(
                bottom: screenarea*0.000047,
                left: screenarea*0.000139,
                right: screenarea*0.000139,),
             //     bottom: 12,
               //   left: 35,
                 // right: 35),

              //     margin: EdgeInsets.symmetric(horizontal: 35),
              height: 1,
              width: screenwidth,
              color: Colors.white70,
            ),
            Container(
    margin: EdgeInsets.symmetric(
      horizontal: screenarea*0.000139
    //    horizontal: 35
    ),

    child:
                TextFormField(
                  controller: _phonenumbercontroller,
                  keyboardType:  TextInputType.phone,
                  autocorrect: false,
                  autofocus: false,
                  onSaved: (val) => displayname = val,
                  style: TextStyle(
                      fontFamily: helveticaneueregular,color: Colors.white,
                   //   fontSize: 14
                  fontSize: screenwidth*0.0373
                  ),
                  readOnly: false,
                  decoration: InputDecoration(

                    suffixIcon:

                        Icon(CupertinoIcons.device_phone_portrait,
                          color: Colors.white,
                       //   size: 18,
                        size: screenwidth*0.048,
                        ),
                    hintText: "Phone number",
                    hintStyle: TextStyle(
                        fontFamily: helveticaneueregular,color: Colors.white70,
                //        fontSize: 14
                  fontSize: screenwidth*0.0373
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
              margin: EdgeInsets.only(
                bottom: screenarea*0.000047,
                left: screenarea*0.000139,
                right: screenarea*0.000139,
                  //bottom: 12,
                //  left: 35,
              //    right: 35
              ),

              //     margin: EdgeInsets.symmetric(horizontal: 35),
              height: 1,
              width: screenwidth,
              color: Colors.white70,
            ),
Container(
    margin: EdgeInsets.symmetric(
        horizontal: screenarea*0.000139
    ),
    child:
           TextFormField(
                controller: _passwordController,
                autocorrect: false,
                autofocus: false,
                obscureText: showpassword,
                style: TextStyle(
                    fontFamily: helveticaneueregular,color: Colors.white,
                //    fontSize: 14
                fontSize: screenwidth*0.0373
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
                   //   size: 18,
size: screenwidth*0.048,
                      color: Colors.white,
                    ),),
                  hintText: 'Password',
                  enabled: true,
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                      fontFamily: helveticaneueregular,color: Colors.white70,
                      fontSize: screenwidth*0.0373
                    //   fontSize: 14
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
              margin: EdgeInsets.only(
                  bottom: 0,
             //     left: 35,right: 35
                left: screenarea*0.000139,
                right: screenarea*0.000139,
              ),
              //     margin: EdgeInsets.symmetric(horizontal: 35),
              height: 1,
              width: screenwidth,
              color: Colors.white70,
            ),
]
    )),
            GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Goals()));

                },
                child:
                Container(
margin: EdgeInsets.only(
  //  top: 45
top: screenarea*0.000179
),
                height: screenheight*0.0569,
                width:screenwidth*0.80,
                //  height: 44,
            //      width: 312,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30),
                    ),
                    color: Color(0xff9797de),
                  ),
                  child: Center(
                    child: Text(
                      'Sign Up',style: TextStyle(
                        fontFamily: helveticaneueregular,
                        color: Colors.white,
                        //        fontSize: 16
                        fontSize: screenwidth*0.0426
                    ),
                    ),
                  ),
                )),
            Container(margin: EdgeInsets.symmetric(
         //       vertical: 12
           vertical:  screenarea*0.0000479
            ),
              child: RichText(
                text: TextSpan(
                    style: TextStyle(
                        fontFamily: helveticaneueregular,
                        color: Colors.white,
                     //   fontSize: 16
                      fontSize: screenwidth*0.0426
                    ),
                    children: [
                      TextSpan(text: "Have an account? "),
                      TextSpan(text: 'Sign In',style: TextStyle(fontFamily: helveticaneuemedium,
                    fontSize: screenwidth*0.0426,
                        //    fontSize: 16,
                        color: Color(0xff9797de),),
                          recognizer:TapGestureRecognizer()..onTap=(){
                           Navigator.pop(context);
                          } )
                    ]
                ),
              ),
            )
        ],)),
      ),)
    ],);
  }
}
