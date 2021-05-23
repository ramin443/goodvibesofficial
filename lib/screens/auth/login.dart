import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:device_info/device_info.dart';
import 'package:dio/dio.dart';
import 'package:dio_firebase_performance/dio_firebase_performance.dart';
import 'package:email_validator/email_validator.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';

import 'package:goodvibesoffl/constants/fontconstants.dart';
import 'package:goodvibesoffl/models/loggedinuser.dart';
import 'package:goodvibesoffl/models/model.dart';
import 'package:goodvibesoffl/models/playlist_model.dart';
import 'package:goodvibesoffl/models/user_model.dart';
import 'package:goodvibesoffl/screens/auth/forgotpassword/enteremail.dart';
import 'package:goodvibesoffl/screens/auth/signup.dart';
import 'package:goodvibesoffl/screens/initial/goals.dart';
import 'package:goodvibesoffl/services/api_service.dart';
import 'package:goodvibesoffl/services/database_service.dart';
import 'package:goodvibesoffl/services/shared_pref_service.dart';
import 'package:goodvibesoffl/services/user_service.dart';
import 'package:goodvibesoffl/utils/common_functiona.dart';
import 'package:goodvibesoffl/utils/validator.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config.dart';
import '../../locator.dart';
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final googleSignIn = GoogleSignIn();

  bool _isSigningIn=false;
  String email, pass, displayname, confirmPass;
  final _formKey = GlobalKey<FormState>();
  bool showpassword = true;
  List<CurrentUser> currentuserlist;
  int count = 0;
  String errortext='';
bool loginsuccesful=false;
  // FormMode formMode = FormMode.LOGIN;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final Trace splashTrace =
  FirebasePerformance.instance.newTrace("splash trace");
  Future<Null> facebooklogin() async {
    List<Genre> _genre = [];
    await FacebookAuth.instance.logOut();

    AccessToken accessToken = await FacebookAuth.instance.login();

    if(accessToken.userId!=null){
      setState(() {
        _isSigningIn = true;
        _setloginstatus();
      });

      print(accessToken.token);
      print(accessToken.userId);
      print(accessToken.applicationId);
Map response=await locator<ApiService>().socialLogin(
    provider: "facebook", accessToken: accessToken.token );
print(response.values);
      await _setloginstatus();
      Map respone= await locator<ApiService>().getSingleTrack('0421TGV27');
      Map genrerespone= await locator<ApiService>().getGenre();
      Map tracksfromgenre= await locator<ApiService>().getGenreTracks(id: 25,page: 1,perpage: 4);
      List<dynamic> trckfrmgnr = tracksfromgenre['data'] as List;
      List<dynamic> rsp = genrerespone['data'] as List;
      var a = rsp.map<Genre>((json) => Genre.fromJson(json));
      _genre.addAll(a);
      for(int i=0;i<=_genre.length-1;i++){
        print(_genre[i].id );
        print(_genre[i].name );
        print(_genre[i].description );
        print(_genre[i].categories.length );
      }
      print(tracksfromgenre.values);

      Future.delayed(Duration(milliseconds: 5000
      ),sendtogoals);
    }
    else {
      setState(() {
        _isSigningIn = false;
        errortext="Login Failed";
      });
    }
  }
  sendtogoals(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>
        Goals()));
  }
  Future googlelogin() async {
    setState(() {
      _isSigningIn = true;
    });
await googleSignIn.signOut();
    final user = await googleSignIn.signIn();
    if (user == null) {
      setState(() {
        _isSigningIn = false;
        errortext="Sign In not completed";
      });
      return;
    } else {
      setState(() {
        _isSigningIn = true;
        errortext="Sign In Successful";

      });
      print(user.email);
      print(user.displayName);
      print(user.photoUrl);
      await user.authentication.then((value) =>
          socialLogin(provider:"google",accessToken:value.idToken ));
      await _setloginstatus();
      Future.delayed(Duration(seconds: 5),
          navigatetogoals()

      ) ;
      setState(() {
        errortext=user.displayName+user.email+user.id;

      });
      //    final credential = GoogleAuthProvider.credential(accessToken: googleAuth.accessToken, idToken: googleAuth.idToken,);

//      await socialLogin(provider: "google",accessToken: googleAuth.idToken);
      setState(() {
        _isSigningIn = true;
        errortext="Sign In Succesful";

      });
    }
  }
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
    await prefs.setInt('loginstatus', 1);
  }


  returnerrortext(){
    EmailValidator.validate(_emailController.text)?_passwordController.text.length>8?
    errortext='':errortext='Password less than 8 char':errortext='Email format not valid';
  }
 // FormMode formMode = FormMode.LOGIN;


  Future<Null> _logOut() async {
//    await facebookSignIn.logOut();
    print('Logged out.');
  }

  socialLogin({String provider, String accessToken}) async {
    var url = "$baseUrl/login";

    var data = {"provider": provider,"access_token": accessToken};

    final response = await postRequest(url: url, data: data);
print(response.values);
    //log.i(response);

    // return {"error": "login error"};
    return response;
  }

  @override
  void initState() {
    super.initState();
    getitinstance();
    initfirebase();
  }
  getitinstance()async{
     GetIt.instance;
  }
  initfirebase()async{
await Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
  //  final loginProvider = Provider.of<LoginProvider>(context);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    double screenheight=MediaQuery.of(context).size.height;
    double screenwidth=MediaQuery.of(context).size.width;

    AppBar appbar=  AppBar(
      automaticallyImplyLeading: false, // Don't show the leading button

      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: false,
      title:

      SvgPicture.asset('assets/images/logo 2.svg',fit: BoxFit.cover,
        //        height: double.infinity,
        width:screenheight*screenwidth*0.000435,
        //     width: screenheight*screenwidth*0.000439,
        color: Color(0xff9797de),
        //         alignment: Alignment.center,
      ),
    );
        double imageheight= screenheight*0.45-1.5*appbar.preferredSize.height;

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
    child: Text("Log in succesful",
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
            child: Text("Signing in, Please wait",
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
    return
          Stack(children:[
            Material(
                color: Colors.transparent,
                type: MaterialType.transparency,
                child:
            Container(
              width: screenwidth,
              height: screenheight*0.45,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/minibg.png"),
                    fit: BoxFit.cover,
                  )
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppBar(
                    automaticallyImplyLeading: false, // Don't show the leading button

                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    centerTitle: false,
                    title:

                    SvgPicture.asset('assets/images/logo 2.svg',fit: BoxFit.cover,
                      //        height: double.infinity,
                      width:screenheight*screenwidth*0.000435,
                      //     width: screenheight*screenwidth*0.000439,
                      color: Color(0xff9797de),
                      //         alignment: Alignment.center,
                    ),
                  ),
                  Container(
                    height: imageheight,
                  child: Image.asset("assets/images/updatedloginregis.png",fit: BoxFit.cover,),
                  )
                ],),
            )),
         Positioned.fill(child:
Material(
        type: MaterialType.transparency,
         child:
Align(
    alignment: Alignment.bottomCenter,
    child:
    Container(
      alignment: Alignment.bottomCenter,
          height: screenheight*0.64,
decoration: BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.only(topLeft: Radius.circular(16),topRight: Radius.circular(16))
),
          width: screenwidth,
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
Container(child:Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children:[
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
             color: Color(0xff9797de),
             fontSize: screenwidth*0.08
     //     fontSize: 30
           ),
           ),),
]),


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
    cursorColor: Colors.black54,
    onSaved: (val) => displayname = val,
    style: TextStyle(
    fontFamily: helveticaneueregular,color:

    Colors.black87,
    //  fontSize: 14
    fontSize: screenwidth*0.0373
    ),
    readOnly: false,
    onChanged: (v){
    setState(() {
    returnerrortext();
    });
    },
    decoration: InputDecoration(

    suffixIcon:

    Icon(EmailValidator.validate(_emailController.text)?FeatherIcons.check:Icons.mail_outline,
    color: Colors.black.withOpacity(0.7),
    size: screenwidth*0.048,
    //size:18
    ),
    hintText: "robertfox@mail.com",
    hintStyle: TextStyle(
    fontFamily: helveticaneueregular,color: Colors.black.withOpacity(0.7),
    //              fontSize: 14
    fontSize: screenwidth*0.0373
    ),
    errorStyle: Theme.of(context)
        .textTheme
        .bodyText2
        .copyWith(color: Colors.redAccent),
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
    color: Colors.black.withOpacity(0.54),
    ),

    Expanded(
    child: TextFormField(
    cursorColor: Colors.black54,
    onChanged: (v){
    setState(() {
    returnerrortext();

    });
    },
    controller: _passwordController,
    autocorrect: false,
    autofocus: false,
    obscureText: showpassword,
    style: TextStyle(
    fontFamily: helveticaneueregular,color:
    Colors.black.withOpacity(0.7),
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
    showpassword? FeatherIcons.eyeOff:FeatherIcons.eye,
    //       size: 18,
    size: screenwidth*0.048,
    color: Colors.black.withOpacity(0.7),
    ),),
    hintText: 'Password',
    enabled: true,
    border: InputBorder.none,
    hintStyle: TextStyle(
    fontFamily: helveticaneueregular,color:Colors.black.withOpacity(0.7),
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
    color: Colors.black.withOpacity(0.54),
    ),
    Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    InkWell(
    onTap: (){
    //    Navigator.of(context).push(forgotpwroute());
    },
    child:
    Container(
    //    margin: EdgeInsets.only(top: 8),
    margin: EdgeInsets.only(top: screenheight*screenwidth*0.000031),
    child:Text(errortext,style: TextStyle(
    fontFamily: helveticaneueregular,
    //    fontSize: 12,
    fontSize: screenheight*screenwidth*0.0000479,
    color: Colors.redAccent
    ),),)),
    InkWell(
    onTap: (){
        Navigator.of(context).push(forgotpwroute());
    },
    child:
    Container(
    //    margin: EdgeInsets.only(top: 8),
    margin: EdgeInsets.only(top: screenheight*screenwidth*0.000031),
    child:Text('Forgot Password?',style: TextStyle(
    fontFamily: helveticaneuemedium,
    //    fontSize: 12,
    fontSize: screenheight*screenwidth*0.0000479,
    color: Color(0xff9797de)
    ),),))
    ],)
    ],
    )),
    ),
    ),
    InkWell(
    onTap: () async{
    //         await Firebase.initializeApp();
    //       await FirebaseFirestore.instance.collection("secondintegration").add({
    //"Testtransmission":"Succesful"});
  //  EmailValidator.validate(_emailController.text) && _passwordController.text.length>8?
    await login(context: context, email: _emailController.text, password: _passwordController.text,
    );
//            Navigator.push(context, MaterialPageRoute(builder: (context)=>Goals()));
    },
    child:
    Container(
//            height: 38,
    height: screenwidth*0.1013,

    width: screenwidth*0.8,
    //         width: 312,
    decoration: BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(30),
    ),
    color:

    Color(0xff9797de)
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
    ))])])),
          Container(child:Column(children:[
          Container(
            margin: EdgeInsets.only(
          //      bottom: 22,left: 22,right: 22
            bottom: screenwidth*0.0586,left: screenwidth*0.0586,right: screenwidth*0.0586
            ),
            child: Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                  onTap: (){
                    googlelogin();
                  },
                  child:
              Container(
                margin: EdgeInsets.only(
           //         right: 10
             right: screenwidth*0.0266
                ),

                //      height: 61,width: 61,
            height: screenwidth*0.1626,width: screenwidth*0.1626,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.16),
                  blurRadius: 10,offset: Offset(0, 3)
                  )]
                ),
                child: Center(child: FaIcon(FontAwesomeIcons.google,
            //    size: 30,
                  size: screenwidth*0.06,
                  color: Colors.black87,),),
              )

              ),
              GestureDetector(
                  onTap: (){
                    facebooklogin();
                  },
                  child:
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    //      height: 61,width: 61,
                    height: screenwidth*0.1626,width: screenwidth*0.1626,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.16),
                            blurRadius: 10,offset: Offset(0, 3)
                        )]
                    ),
                    child: Center(child: Icon(FontAwesomeIcons.facebookF,
                      //    size: 30,
                      size: screenwidth*0.06,
                      color: Colors.black87,),),
                  )

              )
            ],),
          ),

          Container(
          //  margin: EdgeInsets.symmetric(vertical: 16),
            margin: EdgeInsets.only(
        //        bottom: 16
          bottom: screenwidth*0.0426
            ),

            child: RichText(
              text: TextSpan(
                  style: TextStyle(
                      fontFamily: helveticaneueregular,
                      color: Colors.black87,
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
          )]))
      ],),
    )))),
          _isSigningIn?logindialog():empty()
          ]);
  }
  Widget empty(){
    return SizedBox(height: 0,);
  }
  getPasswordTextFieldDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      border: InputBorder.none,
      hintStyle: Theme.of(context).textTheme.subtitle1,
      errorStyle:
      Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.red),
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


  apisocialLogin({String provider, String accessToken}) async {
    var url = "$baseUrl/login";

    var data = {"provider": provider, "access_token": accessToken};

    final response = await postRequest(url: url, data: data);

    //log.i(response);

    // return {"error": "login error"};
    return response;
  }
  navigatetogoals(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>Goals()));
  }
  Future<Map<String, dynamic>> postRequest(
      {var queryParameters, var data, Options options, @required var url}) async {
    //  SessionService _sessionService = locator<SessionService>();
    Map<String, dynamic> httpResponse = {};

    Dio _dio = Dio(BaseOptions(receiveDataWhenStatusError: true));
    final firebasePerformanceInterceptor = DioFirebasePerformanceInterceptor();
    _dio.interceptors.add(firebasePerformanceInterceptor);

    recordCrashlyticsLog("post request at $url");
    // print(url);
    try {
      var response = await _dio.post(
        url,
        data: data,
        options: options,
        queryParameters: queryParameters,
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {

        if (response != null) {
          if (response.data["success"] == true) {
            httpResponse['data'] = response.data['data'];
            if (response.data.containsKey("message"))
              httpResponse["message"] = response.data["message"];
            setState(() {
              loginsuccesful=true;
            });

          } else {
            //// //print(response.data["error"]);
            httpResponse["error"] = response.data["error"];
          }

          return httpResponse;
        } // end of checking response

      }
    } on DioError catch (e, stackTrace) {
      setState(() {
        _isSigningIn=false;
        errortext=e.response.data["error"];
        errortext=e.response.data["error"];
      });
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

      //    handleError(e: e.toString(), httpResponse: httpResponse, stack: stackTrace);

      return httpResponse;
    }

  }




  login({String email, String password, BuildContext context}) async {
    setState(() {
      _isSigningIn=true;
    });
    print('first one');
    Map response = await apilogin(email: email, password: password);
    print(response);
print(response['data']);
    if (response.containsKey("data")) {
      apitracktest();

await _setloginstatus();
      print("response does contain key");
     Future.delayed(Duration(seconds: 5),
         navigatetogoals()

     ) ;

    }


  }
  apitracktest()async{
    List<Categories> _categories = [];
    List<Playable> _track=[];
    List<Track> _tracks=[];

    List<Genre> _genres=[];
    List<PlayList> _playlis=[];
    Map meditationresponse=await locator<ApiService>().getMeditate(page: 1,perpage: 30);

    Map recenttracksresponse=await locator<ApiService>().getRecentTracks(page: 1,perpage: 30);
    Map playlist=await locator<ApiService>().getAlbums(page: 1,perpage: 30);
    print("playlistvalue"+(playlist.values).toString());

    Map genres=await locator<ApiService>().getGenre();
    Map respone= await locator<ApiService>().getSingleTrack('0421TGV27');
    Map categoryrespone= await locator<ApiService>().getGenreCategory(id: 24,page: 1,perpage: 5);
    Map tracksfromcategoryresponse= await locator<ApiService>().getCategoryTracks(id: 85,page: 1,perpage: 5);
    //  Map tracksfromgenre= await locator<ApiService>().getGenreTracks(id: 25,page: 1,perpage: 4);
//    List<dynamic> trckfrmgnr = tracksfromgenre['data'] as List;
    print('playdata');

    List<dynamic> meditationtrackslist=meditationresponse['data'] as List;
    var medittratra = meditationtrackslist.map<Playable>((json) => Playable.fromJson(json));
    _track.addAll(medittratra);

    List<dynamic> recenttrackslist=recenttracksresponse['data'] as List;
    var recenttra = recenttrackslist.map<Track>((json) => Track.fromJson(json));
    _tracks.addAll(recenttra);

    List<dynamic> playlistlist=playlist['data'] as List;
    var p = playlistlist.map<PlayList>((json) => PlayList.fromJson(json));
    _playlis.addAll(p);

    List<dynamic> genrelist=genres['data'] as List;
    var g = genrelist.map<Genre>((json) => Genre.fromJson(json));
    _genres.addAll(g);
    List<dynamic> rsp = categoryrespone['data'] as List;
    var a = rsp.map<Categories>((json) => Categories.fromJson(json));
    _categories.addAll(a);
    List<dynamic> tracklist = tracksfromcategoryresponse['data'] as List;
    var t = tracklist.map<Track>((json) => Track.fromJson(json));
 //   print(genres["data"]);
 //   _tracks.addAll(t);
    for(int i=0;i<=_track.length-1;i++){
      print("playlisttrack id:"+(_track[i].id).toString() );
      print("playlisttrack name"+_track[i].typeObject.title );
      print("playlisttrack description:"+(_track[i].typeObject.description).toString() );
      print("playlisttrack gid:"+(_track[i].track.url).toString() );
    }


 //   print(tracksfromgenre.values);

//    User user=User.fromJson(response["data"]);
    Track track=Track.fromJson(respone["data"]);
    print(respone.values);
 //   print(user.authToken);


  }
  apilogin({String email, String password}) async {
    final url = '$baseUrl/login';

    final Map<String, String> body = {'email': email, 'password': password};
    final response = await postRequest(url: url, data: body);
    return response;
  }
  _setUser({Map user}) async {
    User _user = User.fromJson(user);
    UserService().user.value = _user;

    await DatabaseService().insertIntoUserTable(_user);
   // notifyListeners();
  }
  Future<Map<String, String>> getDeviceInfo() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    Map<String, String> deviceInfo;
    try {
      if (Platform.isAndroid) {
        final androidInfo = await deviceInfoPlugin.androidInfo;

        deviceInfo = {
          "manufacture": androidInfo.manufacturer + " " + androidInfo.model,
          "uid": androidInfo.androidId,
        };
      } else {
        final iosInfo = await deviceInfoPlugin.iosInfo;

        deviceInfo = {
          "manufacture": "apple" + " " + iosInfo.localizedModel,
          "uid": iosInfo.identifierForVendor,
        };
      }
      return deviceInfo;
    } on PlatformException catch (e) {
      // print(e.message);
      return deviceInfo;
    }
  }
  setDeviceToken() async {
    var token = await SharedPrefService().getNotificationToken();
    PackageInfo info = await PackageInfo.fromPlatform();
    final _user = UserService().user.value;

    final deviceInfo = await getDeviceInfo();
    await locator<ApiService>().setDeviceToken(
      token: token,
      platform: Platform.isIOS ? 'ios' : 'android',
      manufacture: deviceInfo == null
          ? Platform.isIOS
          ? "apple"
          : "android"
          : deviceInfo["manufacture"],
      uid: deviceInfo == null
          ? base64Encode(utf8.encode(_user?.uid))
          : base64Encode(utf8.encode("${deviceInfo["uid"]}${_user?.uid}")),
      version: info.version,
    );
  }




  emptycode(){}
}


