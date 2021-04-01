import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:goodvibesofficial/constants/fontconstants.dart';
import 'package:goodvibesofficial/constants/styleconstants.dart';
import 'package:goodvibesofficial/provider/login_provider.dart';
import 'package:goodvibesofficial/screens/auth/forgotpassword/enteremail.dart';
import 'package:goodvibesofficial/screens/auth/signup.dart';
import 'package:goodvibesofficial/screens/initial/goals.dart';
import 'package:goodvibesofficial/services/connectivity_service.dart';
import 'package:goodvibesofficial/utils/validator.dart';
import 'package:goodvibesofficial/widgets/common_widgets/pages_wrapper_with_background.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email, pass, displayname, confirmPass;
  final _formKey = GlobalKey<FormState>();
  bool showpassword = true;
  FormMode formMode = FormMode.LOGIN;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  void initState() {
    super.initState();
    getitinstance();
  }
  getitinstance()async{
     GetIt.instance;
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    double screenheight=MediaQuery.of(context).size.height;
    double screenwidth=MediaQuery.of(context).size.width;

    return
          Stack(children:[
            Image.asset('assets/images/bg@3x.png',  fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.center,
//height: 1493,
//width: 2436,
            ),

    Scaffold(
    resizeToAvoidBottomInset: true,
        appBar: AppBar(
          automaticallyImplyLeading: false, // Don't show the leading button

          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: false,
          title:

            SvgPicture.asset('assets/images/logo 2.svg',fit: BoxFit.cover,
      //        height: double.infinity,
              width:screenheight*screenwidth*0.000435,
         //     width: screenheight*screenwidth*0.000439,
              color: Colors.white,
     //         alignment: Alignment.center,
            ),


        ),
        backgroundColor: Colors.transparent,
      body:
    Container(
          alignment: Alignment.topCenter,
          height: screenheight,
          width: screenwidth,
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipOval(child:
              BackdropFilter(
                  child:
Container(
//  height:117 ,
  //width: 117,
  height: screenheight*0.175,
  width:screenheight*0.175 ,
  color: Colors.white.withOpacity(0.1),
  alignment: Alignment.center,
  child: Center(child:

    SvgPicture.asset('assets/images/white_logo.svg',
//    width: 48,
  width: screenwidth*0.128,
    ),
  ),
),
              filter: ImageFilter.blur(sigmaX: 8,sigmaY: 8),

              )),
Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children:[
           Container(
             //margin: EdgeInsets.only(left:36 ,top: 36),
             margin: EdgeInsets.only(left: screenheight*screenwidth*0.000143,
             top:screenwidth*screenheight*0.00007996,
       //      top: 20
             ),
             child: Text('Lets get\nyou started!',style: TextStyle(
             fontFamily: helveticaneuemedium,
             color: Colors.white,
             fontSize: screenwidth*0.0746
     //     fontSize: 28
           ),
           ),),
]),

          SignInButton(),
          InkWell(
              onTap: (){

              },
              child:
              Container(
   //             margin: EdgeInsets.symmetric(vertical: 14),
     margin: EdgeInsets.symmetric(vertical: screenheight*screenwidth*0.0000559),
//  height: 38,
                height: screenheight*0.0569,
                width: screenwidth*0.8,
     //           height: 41,
       //         width: 312,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30),
                  ),
                  color: Colors.grey[700],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                //        margin: EdgeInsets.only(left:32,right: 24),
                margin: EdgeInsets.only(left: screenheight*screenwidth*0.000127,right: screenheight*screenwidth*0.000095),
                        child:
                        Icon(MdiIcons.google,
                //          size: 24,
                          size: screenwidth*0.064,
                          color: Colors.white,)
                    ),


                    Text(
                    'Continue with Gmail',
                      style:TextStyle(
                        fontFamily: helveticaneueregular,
                        color: Colors.white,
                //        fontSize: 16
                   fontSize: screenwidth*0.0426
                    ),
                  ),]
                ),
              )),
          InkWell(
              onTap: (){

              },
              child:
              Container(
       //    height: 38,
                height: screenheight*0.0569,
           width: screenwidth*0.8,
                //     width: 312,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30),
                  ),
                  color: Colors.grey[700],
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children:[
                      Container(
        //                  margin: EdgeInsets.only(left:32,right: 24),
                          margin: EdgeInsets.only(left: screenheight*screenwidth*0.000127,right: screenheight*screenwidth*0.000095),

                          child:

                   Icon(MdiIcons.facebook,size:  screenwidth*0.064,color: Colors.white,)
                      ),
                    Text(
                    'Continue with Facebook',style: TextStyle(
                        fontFamily: helveticaneueregular,
                        color: Colors.white,
                        //        fontSize: 16
                        fontSize: screenwidth*0.0426
                    ),
                  ),]
                ),
              )),
          Container(
          //  margin: EdgeInsets.symmetric(vertical: 16),
            margin: EdgeInsets.symmetric(vertical: screenheight*screenwidth*0.0000639),

            child: RichText(
              text: TextSpan(
                  style: TextStyle(
                      fontFamily: helveticaneueregular,
                      color: Colors.white,
                   //   fontSize: 16
                    fontSize: screenwidth*0.0426
                  ),
                  children: [
                    TextSpan(text: "Don't have an account? "),
                    TextSpan(text: 'Sign Up',style: TextStyle(fontFamily: helveticaneuemedium,
                  //    fontSize: 16,
                      fontSize: screenwidth*0.0426,
                      color: Color(0xff9797de),),
                    recognizer:TapGestureRecognizer()..onTap=(){
                      Navigator.of(context).push(_createRoute());
                    } )
                  ]
              ),
            ),
          )
      ],)),
    )]);
  }
  getPasswordTextFieldDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      border: InputBorder.none,
      hintStyle: Theme.of(context).textTheme.subtitle1,
      errorStyle:
      Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.red),
      // prefixIcon: Icon(
      //   Icons.lock,
      //   color: Color(0xFFEEAEFF),
      //   size: getFontSize(context, 3.3),
      // ),
    );
  }
  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => SignUp(),
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
  Route forgotpwroute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => Enteremail(),
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
class SignInButton extends StatefulWidget {

  @override
  _SignInButtonState createState() => _SignInButtonState();
}

class _SignInButtonState extends State<SignInButton> {
  String email, pass, displayname, confirmPass;
  final _formKey = GlobalKey<FormState>();
  bool showpassword = true;
  FormMode formMode = FormMode.LOGIN;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    double screenheight=MediaQuery.of(context).size.height;
    double screenwidth=MediaQuery.of(context).size.width;
    return

      Column(children:[
      Container(
        //         margin: EdgeInsets.only(top: 45,bottom: 50,left: 35,right: 35),
        margin: EdgeInsets.only(
            top: 33,
            bottom: 40,
            left: screenheight*screenwidth*0.000139,
            right:  screenheight*screenwidth*0.000139
        ),
        child:
        Form(
          key: _formKey,
          child:  LimitedBox(
//  maxHeight:100,
              maxHeight: screenheight*screenwidth*0.000399,
              maxWidth: screenwidth,
              child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child:
                    Expanded(
                      child:

                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress ?? TextInputType.text,
                        autocorrect: false,
                        autofocus: false,
                        onSaved: (val) => displayname = val,
                        style: TextStyle(
                            fontFamily: helveticaneueregular,color: Colors.white,
                            //  fontSize: 14
                            fontSize: screenwidth*0.0373
                        ),
                        readOnly: false,
                        decoration: InputDecoration(

                          suffixIcon:

                          Icon(Icons.mail_outline,
                            color: Colors.white,
                            size: screenwidth*0.048,
                            //size:18
                          ),
                          hintText: "robertfox@mail.com",
                          hintStyle: TextStyle(
                              fontFamily: helveticaneueregular,color: Colors.white70,
                              //              fontSize: 14
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

                  ),
                  Container(
//      margin: EdgeInsets.only(bottom: 28,top: 8),
                    margin: EdgeInsets.only(bottom: screenheight*screenwidth*0.00011,
                        top: screenheight*screenwidth*0.000031),
                    //     margin: EdgeInsets.symmetric(horizontal: 35),
                    height: 1,
                    width: screenwidth,
                    color: Colors.white70,
                  ),

                  Expanded(
                    child: TextFormField(
                      controller: _passwordController,
                      autocorrect: false,
                      autofocus: false,
                      obscureText: showpassword,
                      style: TextStyle(
                          fontFamily: helveticaneueregular,color: Colors.white,
                          //   fontSize: 14
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
                            //       size: 18,
                            size: screenwidth*0.048,
                            color: Colors.white,
                          ),),
                        hintText: 'Password',
                        enabled: true,
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                            fontFamily: helveticaneueregular,color: Colors.white70,
                            //        fontSize: 14
                            fontSize:    screenwidth*0.0373
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
                    margin: EdgeInsets.only(top:screenheight*screenwidth*0.000031),
                    height: 1,
                    width: screenwidth,
                    color: Colors.white70,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [

                      InkWell(
                          onTap: (){
                        //    Navigator.of(context).push(forgotpwroute());
                          },
                          child:
                          Container(
                            //    margin: EdgeInsets.only(top: 8),
                            margin: EdgeInsets.only(top: screenheight*screenwidth*0.000031),
                            child:Text('Forgot Password?',style: TextStyle(
                                fontFamily: helveticaneueregular,
                                //    fontSize: 12,
                                fontSize: screenheight*screenwidth*0.0000479,
                                color: Colors.white70
                            ),),))
                    ],)
                ],
              )),
        ),
      ),
      InkWell(
          onTap: () async{
//            var loginProvider = Provider.of<LoginProvider>(context,listen: false);
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Goals()));

          },
          child:
          Container(
//            height: 38,
            height: screenheight*0.0569,

            width: screenwidth*0.8,
            //         width: 312,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30),
              ),
              color: Color(0xff9797de),
            ),
            child: Center(
              child: Text(
                'Sign In',style: TextStyle(
                  fontFamily: helveticaneueregular,
                  color: Colors.white,
                  //        fontSize: 16
                  fontSize: screenwidth*0.0426
              ),
              ),
            ),
          ))]);
  }

  Route forgotpwroute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => Enteremail(),
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


