import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:dio_firebase_performance/dio_firebase_performance.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:goodvibesofficial/constants/apiconstants.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:goodvibesofficial/constants/fontconstants.dart';
import 'package:goodvibesofficial/constants/styleconstants.dart';
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
    double screenheight = MediaQuery
        .of(context)
        .size
        .height;
    double screenwidth = MediaQuery
        .of(context)
        .size
        .width;
    double screenarea = screenheight * screenwidth;
    final sizeManager = ResponsiveFlutter.of(context);
    return Stack(children: [
      Image.asset('assets/images/timothee-duran-ilfsT5p_qvA-unsplash.png',
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,),
      Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(CupertinoIcons.back,
              color: Colors.white,
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(children: [
                Container(margin: EdgeInsets.only(
                  //    left: 36
                    left: screenarea * 0.00014
                ),
                    child:
                    ClipOval(
                      child: Container(
                        //     margin: EdgeInsets.only(left: 36),
                        //     height:80 ,
                        //   width: 80,
                        height: screenheight * 0.119,
                        width: screenheight * 0.119,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.20),
                        ),
                        alignment: Alignment.center,
                        child: Center(child:
                        SvgPicture.asset('assets/images/white_logo.svg',
                            //   width: 32,
                            width: screenwidth * 0.0853
                        ),
                        ),
                      ),
                    ))
              ],), Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        //      top: 32,
                        //    bottom: 32,
                          top: screenarea * 0.000127,
                          bottom: screenarea * 0.000127,
                          left: screenarea * 0.00014
                        //       left: 36

                      ),
                      child: Text('Create new account?', style: TextStyle(
                          fontFamily: helveticaneuemedium,
                          color: Colors.white,
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
                          horizontal: screenarea * 0.000139
                      ),
                      child:


                      TextFormField(
                        controller: _namecontroller,
                        keyboardType: TextInputType.text,
                        autocorrect: false,
                        autofocus: false,
                        onSaved: (val) => displayname = val,
                        style: TextStyle(
                            fontFamily: helveticaneueregular,
                            color: Colors.white,
                            //   fontSize: 14
                            fontSize: screenwidth * 0.0373
                        ),
                        readOnly: false,
                        decoration: InputDecoration(

                          suffixIcon:
                          Padding(
                              padding: EdgeInsets.only(
                                //    bottom: 10
                                  bottom: screenarea * 0.000039
                              ),
                              child:
                              Icon(CupertinoIcons.person,
                                color: Colors.white,
                                //  size: 18,
                                size: screenwidth * 0.048,
                              )),
                          hintText: "Robert Fox",
                          hintStyle: TextStyle(
                              fontFamily: helveticaneueregular,
                              color: Colors.white70,
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
                          bottom: screenarea * 0.000047,
                          left: screenarea * 0.000139,
                          right: screenarea * 0.000139
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
                          horizontal: screenarea * 0.000139
                      ),
                      child:
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress ??
                            TextInputType.text,
                        autocorrect: false,
                        autofocus: false,
                        onSaved: (val) => displayname = val,
                        style: TextStyle(
                            fontFamily: helveticaneueregular,
                            color: Colors.white,
                            //   fontSize: 14
                            fontSize: screenwidth * 0.0373
                        ),
                        readOnly: false,
                        decoration: InputDecoration(

                          suffixIcon:
                          Padding(
                              padding: EdgeInsets.only(
                                //    bottom: 10
                                  bottom: screenarea * 0.000039
                              ),
                              child:
                              Icon(Icons.mail_outline,
                                color: Colors.white,
                                //  size: 18,
                                size: screenwidth * 0.048,
                              )),
                          hintText: "robertfox@mail.com",
                          hintStyle: TextStyle(
                              fontFamily: helveticaneueregular,
                              color: Colors.white70,
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
                        bottom: screenarea * 0.000047,
                        left: screenarea * 0.000139,
                        right: screenarea * 0.000139,),
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
                          horizontal: screenarea * 0.000139
                        //    horizontal: 35
                      ),

                      child:
                      TextFormField(
                        controller: _phonenumbercontroller,
                        keyboardType: TextInputType.phone,
                        autocorrect: false,
                        autofocus: false,
                        onSaved: (val) => displayname = val,
                        style: TextStyle(
                            fontFamily: helveticaneueregular,
                            color: Colors.white,
                            //   fontSize: 14
                            fontSize: screenwidth * 0.0373
                        ),
                        readOnly: false,
                        decoration: InputDecoration(

                          suffixIcon:

                          Icon(CupertinoIcons.device_phone_portrait,
                            color: Colors.white,
                            //   size: 18,
                            size: screenwidth * 0.048,
                          ),
                          hintText: "Phone number",
                          hintStyle: TextStyle(
                              fontFamily: helveticaneueregular,
                              color: Colors.white70,
                              //        fontSize: 14
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
                        bottom: screenarea * 0.000047,
                        left: screenarea * 0.000139,
                        right: screenarea * 0.000139,
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
                          horizontal: screenarea * 0.000139
                      ),
                      child:
                      TextFormField(
                        controller: _passwordController,
                        autocorrect: false,
                        autofocus: false,
                        obscureText: showpassword,
                        style: TextStyle(
                            fontFamily: helveticaneueregular,
                            color: Colors.white,
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
                                  ? Icons.remove_red_eye_outlined
                                  : Icons.remove_red_eye,
                              //   size: 18,
                              size: screenwidth * 0.048,
                              color: Colors.white,
                            ),),
                          hintText: 'Password',
                          enabled: true,
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                              fontFamily: helveticaneueregular,
                              color: Colors.white70,
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
                        left: screenarea * 0.000139,
                        right: screenarea * 0.000139,
                      ),
                      //     margin: EdgeInsets.symmetric(horizontal: 35),
                      height: 1,
                      width: screenwidth,
                      color: Colors.white70,
                    ),
                  ]
                  )),
              GestureDetector(
                  onTap: () async{
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>
                    Goals()
                    ));
      //              signup(
        //                context: context, email: _emailController.text,
          //              password: _passwordController.text,
            //            fullName: displayname ??
              //              _namecontroller.text);
                  },
                  child:
                  Container(
                    margin: EdgeInsets.only(
                      //  top: 45
                        top: screenarea * 0.000179
                    ),
                    height: screenheight * 0.0569,
                    width: screenwidth * 0.80,
                    //  height: 44,
                    //      width: 312,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30),
                      ),
                      color: Color(0xff9797de),
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
                          color: Colors.white,
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
        ),)
    ],);
  }

  signUp(String name, String email, String password) async {
    final url = "$baseUrl/api/v2/signup";
    Map signupdata = {
      "name": name,
      "email": email,
      "password": password
    };
    Map response = await postRequest(url: url, data: signupdata);
    return response;
  }
  Future<Map<String, dynamic>> postRequest(
      {var queryParameters, var data, Options options, @required var url}) async {
  //  SessionService _sessionService = locator<SessionService>();
    Map<String, dynamic> httpResponse = {};

    Dio _dio = Dio(BaseOptions(receiveDataWhenStatusError: true));
    final firebasePerformanceInterceptor = DioFirebasePerformanceInterceptor();
    _dio.interceptors.add(firebasePerformanceInterceptor);

    //    recordCrashlyticsLog("post request at $url");
    // print(url);
    try {
      var response = await _dio.post(
        url,
        data: data,
        options: options,
        queryParameters: queryParameters,
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
    //    handleSession(response, _sessionService);
Navigator.push(context, MaterialPageRoute(builder: (context)=>Goals()));
        if (response != null) {
          if (response.data["success"] == true) {
            httpResponse['data'] = response.data['data'];
            if (response.data.containsKey("message"))
              httpResponse["message"] = response.data["message"];
          } else {
            print(response.data["error"]);
            print('ok');
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

      print("blerror");

      return httpResponse;
    }
  }
  signup({email, password, fullName, BuildContext context}) async {
    //   userEmailTobeConfimed = email;
    //   _dialogService.showLoadingDialog(context);
    Map response = await apisignUpUserEmailAndPass(
        fullName: fullName, email: email, password: password);

    //  // print(response);
    if (response.containsKey("data")) {
      Navigator.of(context, rootNavigator: true).pop(true);
      print("Sign up Sucessful");
      //     _dialogService.showSuccessDialog(
      //       message: "Sign up Sucessful", context: context);
//     await Future.delayed(Duration(seconds: 2), () {});
      Navigator.push(context, MaterialPageRoute(builder: (context)=> Goals())) ;   } else {
      print("some error");
      //    _dialogService.showErrorDialog(
      //      context: context, message: response["error"] ?? " ");
    }
  }
  apisignUpUserEmailAndPass(
      {String email, String password, String fullName}) async {
    final url = '$baseUrl/signup';

    final Map<String, String> body = {
      'email': email,
      'password': password,
      "full_name": fullName ?? ""
    };

    Map response = await postRequest(url: url, data: body);

    return response;
  }
}