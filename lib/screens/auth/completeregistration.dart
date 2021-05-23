import 'package:email_validator/email_validator.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:goodvibesoffl/constants/fontconstants.dart';
import 'package:goodvibesoffl/utils/validator.dart';
class CompleteRegistration extends StatefulWidget {
  @override
  _CompleteRegistrationState createState() => _CompleteRegistrationState();
}
// for FACEBOOK USERS only
class _CompleteRegistrationState extends State<CompleteRegistration> {
  final TextEditingController _emailController = TextEditingController();
  String errortext='';
  returnerrortext(){

    EmailValidator.validate(_emailController.text)?
    errortext='':
    errortext='Email format not valid';
  }
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

    return Stack(
      children: [
        Image.asset('assets/images/X - 1@2x.png',
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,),
        Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: Icon(CupertinoIcons.back,
                color: Colors.black87,
                //size: 30,
                size: screenwidth * 0.08,
              ), onPressed: () {
              Navigator.pop(context);
            },
            ),
          ),
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: false,
body: Container(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Row(
          children: [
            Container(
              margin: EdgeInsets.only(
                //      top: 32,
                //    bottom: 32,
           //       top: 20, bottom: 27, left: 20
             top: screenwidth*0.0533,left: screenwidth*0.0533,bottom: screenwidth*0.072
                //       left: 36

              ),
              child: Text('Complete Registration', style: TextStyle(
                  fontFamily: helveticaneuemedium,
                  color: Colors.black87,
                  //       fontSize: 28
                  fontSize: screenwidth * 0.0746
              ),
              ),
            )
          ]),
Container(
  width: screenwidth,
  margin: EdgeInsets.only(
 //     left: 20,right: 20
      left: screenwidth*0.0533,right: screenwidth*0.0533
  ),
  child: Row(mainAxisAlignment: MainAxisAlignment.start,
    children: [
Text("Enter Your Email Address",
style: TextStyle(
  fontFamily: helveticaneueregular,
  color: Colors.black.withOpacity(0.7),
//  fontSize: 14
fontSize: screenwidth*0.0373
),)
    ],
  ),
),
      Container(
        margin: EdgeInsets.symmetric(
          //   horizontal: 20
            horizontal: screenwidth*0.0533
        ),
        child:
        TextFormField(
          cursorColor: Colors.black87,
          onChanged: (v){
            setState(() {
              returnerrortext();

            });
          },
          controller: _emailController,
          keyboardType: TextInputType.emailAddress ??
              TextInputType.text,
          autocorrect: false,
          autofocus: false,
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
            Padding(
                padding: EdgeInsets.only(
                  //    bottom: 10
                    bottom: screenarea * 0.000039
                ),
                child:
                Icon(EmailValidator.validate(_emailController.text)?
                FeatherIcons.check:Icons.mail_outline,
                  color: EmailValidator.validate(_emailController.text)?
                  Colors.black:Colors.black87,
                  //  size: 18,
                  size: screenwidth * 0.048,
                )),
            hintText: "robertfox@mail.com",
            hintStyle: TextStyle(
                fontFamily: helveticaneueregular,
                color: EmailValidator.validate(_emailController.text)?
                Colors.black:Colors.black54,
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
     //     left: 20, right: 20,
       left: screenwidth*0.0533,right: screenwidth*0.0533
        ),
        //     bottom: 12,
        //   left: 35,
        // right: 35),

        //     margin: EdgeInsets.symmetric(horizontal: 35),
        height: 1,
        width: screenwidth,
        color: Colors.black54,
      ),
      GestureDetector(
          onTap: () async{
          },
          child:
          AnimatedContainer(
            duration: Duration(milliseconds: 350),
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
              color:
              EmailValidator.validate(_emailController.text)?
              Color(0xff9797de): Color(0xff9797de).withOpacity(0.7),
            ),
            child: Center(
              child: Text(
                'Register', style: TextStyle(
                  fontFamily: helveticaneueregular,
                  color: Colors.white,
                  //        fontSize: 16
                  fontSize: screenwidth * 0.0426
              ),
              ),
            ),
          )),
      Container(
        margin: EdgeInsets.only(
     //       top: 75
       top: screenwidth*0.2
        ),
        child: Image.asset("assets/images/comp registration@3x.png",
   //       width: 140,
     width: screenwidth*0.363,
        ),)
  ],),
),
        )
      ],

    );
  }
}
