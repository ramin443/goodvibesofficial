import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:dio_firebase_performance/dio_firebase_performance.dart';
import 'package:email_validator/email_validator.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:goodvibesoffl/constants/apiconstants.dart';
import 'package:goodvibesoffl/screens/initial/goals.dart';
import 'package:goodvibesoffl/services/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:goodvibesoffl/constants/fontconstants.dart';
import 'package:goodvibesoffl/utils/validator.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../locator.dart';
class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool loginsuccesful=false;
  String email, pass, displayname, confirmPass;
  final _formKey = GlobalKey<FormState>();
  bool showpassword = true;
  bool _isSigningin=false;
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _lastnamecontroller = TextEditingController();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _retypepasswordController = TextEditingController();

  String errortext='';
  Future<int> _getloginstatus() async {
    final prefs = await SharedPreferences.getInstance();
    final loginstatus = prefs.getInt('loginstatus');
    if (loginstatus == null) {
      return 0;
    }
    return loginstatus;
  }
  Future<void> _resetloginstatus() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('loginstatus', 0);
  }
  Future<void> _setloginstatus() async {
    final prefs = await SharedPreferences.getInstance();

    int lastStartupNumber = await _getloginstatus();
    int currentStartupNumber = ++lastStartupNumber;

    await prefs.setInt('loginstatus', 1);

  }
  @override
  Widget build(BuildContext context) {
  Widget empty(){return SizedBox(height: 0,);}
    double screenheight = MediaQuery
        .of(context)
        .size
        .height;
    double screenwidth = MediaQuery
        .of(context)
        .size
        .width;
    Widget logindialog(){
      return
        Material(
            type: MaterialType.transparency,
            child:
            Center(child:
            Container(
              width: screenwidth*0.6,
              height: screenwidth*0.4,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(blurRadius: 20,color: Colors.black26,offset: Offset(0,5))],
                borderRadius: BorderRadius.all(Radius.circular(18)),
              ),
              child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedSwitcher(
                    duration: Duration(milliseconds: 250),
                    transitionBuilder: (Widget child, Animation<double> animation)=>
                        ScaleTransition(child:child,scale:animation),
                    child:
                    loginsuccesful?AnimatedContainer(
                      duration:    Duration(milliseconds: 250),
                      //     height: 40,width: 40,
                      height: screenwidth*0.106,width: screenwidth*0.106,
                      decoration: BoxDecoration(
                          color: Colors.greenAccent,
                          shape: BoxShape.circle
                      ),
                      child: Center(child: Icon(FeatherIcons.check,
                        color: Colors.white,
                        //       size: 28,
                        size: screenwidth*0.0746,   ),),
                    ):
                    CircularProgressIndicator(
                      strokeWidth: 2,backgroundColor: Colors.white,
                    ),),
                  AnimatedSwitcher(duration: Duration(milliseconds: 250),
                      transitionBuilder: (Widget child, Animation<double> animation)=>
                          ScaleTransition(child:child,scale:animation),child:
                      loginsuccesful?    Container(
                        margin: EdgeInsets.only(
                          //     top: 14
                            top: screenwidth*0.0373
                        ),
                        child: Text("Sign up succesful",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: helveticaneuemedium,
                            color: Color(0xff9797de),
                            //    fontSize: 18
                            fontSize: screenwidth*0.048,

                          ),),):
                      Container(
                        margin: EdgeInsets.only(
                          //       top: 14
                            top: screenwidth*0.0373
                        ),
                        child: Text("Signing you in, Please wait",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: helveticaneuemedium,
                            color: Color(0xff9797de),
                            //    fontSize: 26
                            //  fontSize: 18,
                            fontSize: screenwidth*0.048,

                          ),),))
                ],),
            )));
    }
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    double screenarea = screenheight * screenwidth;
    final sizeManager = ResponsiveFlutter.of(context);

    returnerrortext(){
      _namecontroller.text.length>4?
      EmailValidator.validate(_emailController.text)?
      _passwordController.text.length>8?
      _retypepasswordController.text==_passwordController.text?
      errortext='':
      errortext='Passwords do not match':
      errortext='Password less than 8 characters':
      errortext='Email format not valid':
      errortext='Name less than 4 characters';
    }
    return Stack(children: [
      Image.asset('assets/images/X - 1@2x.png',
        fit: BoxFit.cover,
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
              color: Colors.black12.withOpacity(0.74) ,
              //size: 30,
              size: screenwidth * 0.08,
            ), onPressed: () {
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
          Center(child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
        Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        //      top: 32,
                        //    bottom: 32,
                          top:screenwidth * 0.0906,
                          bottom: screenwidth * 0.0906,
                          left: screenwidth*0.0586
                        //       left: 36

                      ),
                      child: Text('Create new account?', style: TextStyle(
                          fontFamily: helveticaneuemedium,
                          color: Colors.black12.withOpacity(0.74),
                          //       fontSize: 28
                          fontSize: screenwidth * 0.0746
                      ),
                      ),
                    )
                  ]),
              LimitedBox(
//  maxHeight: 200,
//    margin: EdgeInsets.only(bottom: 100),
                  child: Column(children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                        //    horizontal: 35
                   //       horizontal: screenarea * 0.000139
                     horizontal: screenwidth*0.0693
                      ),
                      child:


                      TextFormField(
                        cursorColor: Colors.black.withOpacity(0.7),
                        controller: _namecontroller,
                        keyboardType: TextInputType.text,
                        autocorrect: false,
                        autofocus: false,
                        onSaved: (val) => displayname = val,
                        style: TextStyle(
                            fontFamily: helveticaneueregular,
                            color: _namecontroller.text.length>4?Colors.black: Colors.black87,
                            //   fontSize: 14
                            fontSize: screenwidth * 0.0373
                        ),
                        readOnly: false,
                        onChanged: (v){
                          setState(() {
                            returnerrortext();
                          });
                        },
                        decoration: InputDecoration(

                          suffixIcon:

                              Icon(_namecontroller.text.length>4?FeatherIcons.check:FeatherIcons.user,
                                color:Colors.black54,
                                //  size: 18,
                                size: screenwidth * 0.048,
                              ),
                          hintText: "First name",
                          hintStyle: TextStyle(
                              fontFamily: helveticaneueregular,
                              color:Colors.black.withOpacity(0.7),
                              //     fontSize: 14
                              fontSize: screenwidth * 0.0373
                          ),
                          errorStyle: Theme
                              .of(context)
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
                          bottom: 20,
                    //      left: screenarea * 0.000139, right: screenarea * 0.000139
                      left: screenwidth*0.0693,right: screenwidth*0.0693
                        //    left: 35,
                        //     right: 35

                      ),

                      //     margin: EdgeInsets.symmetric(horizontal: 35),
                      height: 1,
                      width: screenwidth,
                      color:Colors.black.withOpacity(0.5),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                        //    horizontal: 35
                          horizontal: screenwidth*0.0693
                      ),
                      child:


                      TextFormField(
                        cursorColor: Colors.black.withOpacity(0.7),
                        controller: _lastnamecontroller,
                        keyboardType: TextInputType.text,
                        autocorrect: false,
                        autofocus: false,
                        onSaved: (val) => displayname = val,
                        style: TextStyle(
                            fontFamily: helveticaneueregular,
                            color: _namecontroller.text.length>4?Colors.black: Colors.black87,
                            //   fontSize: 14
                            fontSize: screenwidth * 0.0373
                        ),
                        readOnly: false,
                        onChanged: (v){
                          setState(() {
returnerrortext();
                          });
                        },
                        decoration: InputDecoration(

                          suffixIcon:

                              Icon(_lastnamecontroller.text.length>1?FeatherIcons.check:FeatherIcons.user,
                                color: Colors.black54,
                                //  size: 18,
                                size: screenwidth * 0.048,
                              ),
                          hintText: "Last Name",
                          hintStyle: TextStyle(
                              fontFamily: helveticaneueregular,
                              color: Colors.black.withOpacity(0.7),
                              //     fontSize: 14
                              fontSize: screenwidth * 0.0373
                          ),
                          errorStyle: Theme
                              .of(context)
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
                          bottom:20,
                   //       left: screenarea * 0.000139, right: screenarea * 0.000139
                          left: screenwidth*0.0693,right: screenwidth*0.0693
                        //    left: 35,
                        //     right: 35

                      ),

                      //     margin: EdgeInsets.symmetric(horizontal: 35),
                      height: 1,
                      width: screenwidth,
                      color:  Colors.black.withOpacity(0.5),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                        //   horizontal: 35
                          horizontal: screenwidth*0.0693
                      ),
                      child:
                      TextFormField(
                        cursorColor: Colors.black.withOpacity(0.7),

                        onChanged: (v){
                          setState(() {
                            returnerrortext();

                          });
                        },
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress ,
                        autocorrect: false,
                        autofocus: false,
                        onSaved: (val) => displayname = val,
                        style: TextStyle(
                            fontFamily: helveticaneueregular,
                            color: EmailValidator.validate(_emailController.text)?
                            Colors.black:Colors.black87,
                            //   fontSize: 14
                            fontSize: screenwidth * 0.0373
                        ),
                        readOnly: false,
                        decoration: InputDecoration(
                          suffixIcon:

                              Icon(EmailValidator.validate(_emailController.text)?
                              FeatherIcons.check:FeatherIcons.mail,
                                color:Colors.black54,
                                //  size: 18,
                                size: screenwidth * 0.048,
                              ),
                          hintText: "robertfox@mail.com",
                          hintStyle: TextStyle(

                              fontFamily: helveticaneueregular,
                              color:Colors.black.withOpacity(0.7),
                              //   fontSize: 14
                              fontSize: screenwidth * 0.0373
                          ),
                          errorStyle: Theme
                              .of(context)
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
                          bottom:20,
                  //      left: screenarea * 0.000139, right: screenarea * 0.000139,
                          left: screenwidth*0.0693,right: screenwidth*0.0693
                      ),
                      //     bottom: 12,
                      //   left: 35,
                      // right: 35),

                      //     margin: EdgeInsets.symmetric(horizontal: 35),
                      height: 1,
                      width: screenwidth,
                      color: Colors.black.withOpacity(0.5),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: screenwidth*0.0586
                      ),
                      child:
                      TextFormField(
                        cursorColor: Colors.black.withOpacity(0.7),

                        onChanged: (v){
                          returnerrortext();

                          setState(() {

                          });
                        },
                        controller: _passwordController,
                        autocorrect: false,
                        autofocus: false,
                        obscureText: showpassword,
                        style: TextStyle(
                            fontFamily: helveticaneueregular,
                            color: _passwordController.text.length>8?
                            Colors.black:Colors.black87,
                            //    fontSize: 14
                            fontSize: screenwidth * 0.0373
                        ),
                        decoration:
                        InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                showpassword
                                    ? showpassword = false
                                    : showpassword = true;
                              });
                            },
                            child: Icon(
                              showpassword
                                  ? FeatherIcons.eyeOff
                                  :  FeatherIcons.eye,
                              //   size: 18,
                              size: screenwidth * 0.048,
                              color:Colors.black54,

                            ),),
                          hintText: 'Password',
                          enabled: true,
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                              fontFamily: helveticaneueregular,
                              color: Colors.black.withOpacity(0.7),
                              fontSize: screenwidth * 0.0373
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
                          bottom:20,
                        //     left: 35,right: 35
                 //       left: screenarea * 0.000139, right: screenarea * 0.000139,
                          left: screenwidth*0.0693,right: screenwidth*0.0693
                      ),
                      //     margin: EdgeInsets.symmetric(horizontal: 35),
                      height: 1,
                      width: screenwidth,
                      color: Colors.black.withOpacity(0.5),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: screenwidth*0.0693
                      ),
                      child:
                      TextFormField(
                        cursorColor: Colors.black.withOpacity(0.7),

                        onChanged: (v){
                          returnerrortext();

                          setState(() {
                          });
                        },
                        controller: _retypepasswordController,
                        autocorrect: false,
                        autofocus: false,
                        obscureText: showpassword,
                        style: TextStyle(
                            fontFamily: helveticaneueregular,
                            color: _retypepasswordController.text.length>8?
                            Colors.black:Colors.black87,
                            //    fontSize: 14
                            fontSize: screenwidth * 0.0373
                        ),
                        decoration:
                        InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                showpassword
                                    ? showpassword = false
                                    : showpassword = true;
                              });
                            },
                            child: Icon(
                              showpassword
                                  ? FeatherIcons.eyeOff
                                  :  FeatherIcons.eye,
                              //   size: 18,
                              size: screenwidth * 0.048,
                              color:Colors.black54,

                            ),),
                          hintText: 'Re-Type Password',
                          enabled: true,
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                              fontFamily: helveticaneueregular,
                              color: Colors.black.withOpacity(0.7),
                              fontSize: screenwidth * 0.0373
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
                 //       left: screenarea * 0.000139, right: screenarea * 0.000139,
                          left: screenwidth*0.0586,right: screenwidth*0.0586
                      ),
                      //     margin: EdgeInsets.symmetric(horizontal: 35),
                      height: 1,
                      width: screenwidth,
                      color:  Colors.black.withOpacity(0.5),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                            onTap: (){
                              //    Navigator.of(context).push(forgotpwroute());
                            },
                            child:
                            Container(
                              //    margin: EdgeInsets.only(top: 8),
                              margin: EdgeInsets.only(
top: 7,

                                  left: screenwidth*0.0586
                               ),
                              child:Text(errortext,style: TextStyle(
                                  fontFamily: helveticaneueregular,
                                  //    fontSize: 12,
                                  fontSize: screenheight*screenwidth*0.0000479,
                                  color: Colors.redAccent
                              ),),)),

                      ],)
                  ]
                  )),
                  GestureDetector(
                  onTap: () async{
    EmailValidator.validate(_emailController.text) && _passwordController.text.length>8
    && _namecontroller.text.length>4 && _retypepasswordController.text==_passwordController.text
    ?
    await signup(
    context: context,
    email: _emailController.text,
    password: _passwordController.text,
    fullName:
    _namecontroller.text):

    emptycode();
    },
    child:
    Container(
    margin: EdgeInsets.only(
    //  top: 45
    top:screenarea* 0.000179,
    left: screenwidth*0.0693,
    right: screenwidth*0.0693
    ),
    height:screenwidth * 0.1013,
    width: screenwidth,
    //  height: 44,
    //      width: 312,
    decoration: BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(30),
    ),
    color:

    Color(0xff9797de),
    ),
    child: Center(
    child: Text(
    'Sign Up', style: TextStyle(
    fontFamily: helveticaneueregular,
    color: Colors.white,
    //        fontSize: 16
    fontSize: screenwidth * 0.0426
    ),
    ),
    ),
    )),
              Container(margin: EdgeInsets.symmetric(
                //       vertical: 12
                  vertical: screenarea * 0.0000479
              ),
                child: RichText(
                  text: TextSpan(
                      style: TextStyle(
                          fontFamily: helveticaneueregular,
                          color: Colors.black87,
                          //   fontSize: 16
                          fontSize: screenwidth * 0.0426
                      ),
                      children: [
                        TextSpan(text: "Have an account? "),
                        TextSpan(text: 'Sign In', style: TextStyle(
                          fontFamily: helveticaneuemedium,
                          fontSize: screenwidth * 0.0426,
                          //    fontSize: 16,
                          color: Color(0xff9797de),),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pop(context);
                              })
                      ]
                  ),
                ),
              )
            ],)),
        ),),
      _isSigningin?logindialog():
    empty()
    ],);
  }
handlesignup(){
    setState(() {
      _isSigningin=true;
    });


}
navigatetobase(){
  Navigator.push(context,
      MaterialPageRoute(builder: (context)=>Goals()));
}

  navigatetogoals(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>Goals()));
  }
  Future<bool> resendEmailConfirmation() async {
    final Map response =
    await locator<ApiService>().resendEmailConfirmation(email: _emailController.text);

    if (response == null || response.containsKey("error")) {
      return false;
    }
    return true;
  }
  Future<Map<String, dynamic>> postRequest(
      {var queryParameters, var data, Options options, @required var url}) async {
  //  SessionService _sessionService = locator<SessionService>();
    Map<String, dynamic> httpResponse = {};

    Dio _dio = Dio(BaseOptions(receiveDataWhenStatusError: true));
    final firebasePerformanceInterceptor = DioFirebasePerformanceInterceptor();
    _dio.interceptors.add(firebasePerformanceInterceptor);

 //   recordCrashlyticsLog("post request at $url");
    // print(url);
    try {
      var response = await _dio.post(
        url,
        data: data,
        options: options,
        queryParameters: queryParameters,
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
     //   handleSession(response, _sessionService);
print(response.statusCode);
print(response.statusMessage);
print(response.data);
        if (response != null) {
          if (response.data["success"] == true) {
            httpResponse['data'] = response.data['data'];
            if (response.data.containsKey("message"))
              httpResponse["message"] = response.data["message"];
          } else {
            //// //print(response.data["error"]);
            httpResponse["error"] = response.data["error"];
          }

          return httpResponse;
        } // end of checking response

      }
    } on DioError catch (e, stackTrace) {
      var errorRes = e.response.data;
      print(errorRes);
      if (e.toString().toLowerCase().contains("socketexception")) {
        httpResponse["error"] = "No internet connection";
        return httpResponse;
      }
      if (errorRes is Map) {
        if (errorRes.containsKey("error")) {
          httpResponse["error"] = errorRes["error"];
          return httpResponse;
        }
      }
print("error happened last post request");
 //     handleError(e: e.toString(), httpResponse: httpResponse, stack: stackTrace);

      return httpResponse;
    }
  }

  signup({email, password, fullName, BuildContext context}) async {
    setState(() {
      _isSigningin=true;
    });
    Map response = await locator<ApiService>().signUpUserEmailAndPass(
        fullName: fullName, email: email, password: password);
    if (response.containsKey("data")) {
setState(() {
  loginsuccesful=true;
});
print(response.values);
   Future.delayed(Duration(seconds: 6),navigatetogoals);

    } else {
      print(response["error"]);

    }
  }
emptycode(){}
}