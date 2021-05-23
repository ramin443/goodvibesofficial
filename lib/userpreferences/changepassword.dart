import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:goodvibesoffl/constants/fontconstants.dart';
class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool showpassword = true;
  String oldpass,pass,confirmPass;
  final TextEditingController _oldpasswordcontroller = TextEditingController();
bool onsavepressed=false;
  final TextEditingController _newpasswordcontroller = TextEditingController();
  final TextEditingController _confirmnewpasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    double screenheight=MediaQuery.of(context).size.height;
    double screenwidth=MediaQuery.of(context).size.width;
    double screenarea=screenheight*screenwidth;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton:
      onsavepressed?
      Container(
        padding: EdgeInsets.symmetric(horizontal: 12),
        height: 28,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(24)),
          color: Colors.black.withOpacity(0.7),
        ),
        child:
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(child: Text("Saved",style: TextStyle(
            fontFamily: helveticaneueregular,
            color: Colors.white,
            fontSize: 12.5
          ),),),
Icon(CupertinoIcons.check_mark_circled_solid,
color: Colors.white,
size: 16,)
        ],),
      ):SizedBox(height: 0,),
      bottomNavigationBar:
      GestureDetector(
          onTap: (){
            setState(() {
              onsavepressed=!onsavepressed;
            });
          },
          child:
      Container(
        margin: EdgeInsets.only(left: screenwidth*0.125,right: screenwidth*0.125,bottom: 40),
        width: screenwidth*0.805,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30),
          ),
          color: Color(0xff9797de),
        ),
        child: Center(
          child: Text(
            'Save',style: TextStyle(
              fontFamily: helveticaneueregular,
              color: Colors.white,
              //        fontSize: 16
              fontSize: screenwidth*0.0426
          ),
          ),
        ),
      )),
      backgroundColor: Color(0xfff5f5f5),
      appBar: AppBar(
        backgroundColor: Color(0xfff5f5f5),
        elevation: 0,
leading: IconButton(icon: Icon(CupertinoIcons.back,
color: Colors.black87,size: 24,),
onPressed: (){
  Navigator.pop(context);
},),
        title: Text("Change Password",style: TextStyle(
          fontFamily: helveticaneuemedium,
          color: Colors.black87,fontSize: 17.5
        ),),
        centerTitle: true,
      ),
      body:
      SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child:
      Container(
        margin: EdgeInsets.only(left: 34,right: 34),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                margin: EdgeInsets.only(top: 24),
                child:Column(children:[
            Row(children: [
              Container(child: Text("Old Password",style: TextStyle(
                  letterSpacing: 0.5,
                  fontFamily: helveticaneueregular,color: Colors.black87,
                  fontSize: 12
              ),),)
            ],),
                  Container(

                    child:
                    TextFormField(
                      controller: _oldpasswordcontroller,
                      autocorrect: false,
                      autofocus: false,
                      obscureText: showpassword,
                      style: TextStyle(
                          fontFamily: helveticaneueregular,color: Colors.black,
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
                            color: Colors.black,
                          ),),
                        hintText: '',
                        enabled: true,
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                            fontFamily: helveticaneueregular,color: Colors.black.withOpacity(0.7),
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
                      bottom:22,
                      ),
                    //     bottom: 12,
                    //   left: 35,
                    // right: 35),

                    //     margin: EdgeInsets.symmetric(horizontal: 35),
                    height: 1,
                    width: screenwidth,
                    color: Colors.black.withOpacity(0.7),
                  ),
                  Row(children: [
                    Container(

                      child: Text("New Password",style: TextStyle(
                        letterSpacing: 0.5,
                        fontFamily: helveticaneueregular,color: Colors.black87,
                        fontSize: 12
                    ),),)
                  ],),
                  Container(

                    child:
                    TextFormField(
                      controller: _newpasswordcontroller,
                      autocorrect: false,
                      autofocus: false,
                      obscureText: showpassword,
                      style: TextStyle(
                          fontFamily: helveticaneueregular,color: Colors.black,
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
                            color: Colors.black,
                          ),),
                        hintText: '',
                        enabled: true,
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                            fontFamily: helveticaneueregular,color: Colors.black.withOpacity(0.7),
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
                      bottom:22,
                    ),
                    //     bottom: 12,
                    //   left: 35,
                    // right: 35),

                    //     margin: EdgeInsets.symmetric(horizontal: 35),
                    height: 1,
                    width: screenwidth,
                    color: Colors.black.withOpacity(0.7),
                  ),
                  Row(children: [
                    Container(child: Text("Re-type New Password",style: TextStyle(
                        letterSpacing: 0.5,
                        fontFamily: helveticaneueregular,color: Colors.black87,
                        fontSize: 12
                    ),),)
                  ],),
                  Container(

                    child:
                    TextFormField(
                      controller: _confirmnewpasswordController,
                      autocorrect: false,
                      autofocus: false,
                      obscureText: showpassword,
                      style: TextStyle(
                          fontFamily: helveticaneueregular,color: Colors.black,
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
                            color: Colors.black,
                          ),),
                        hintText: '',
                        enabled: true,
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                            fontFamily: helveticaneueregular,color: Colors.black.withOpacity(0.7),
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
                      bottom: screenarea*0.000047,
                    ),
                    //     bottom: 12,
                    //   left: 35,
                    // right: 35),

                    //     margin: EdgeInsets.symmetric(horizontal: 35),
                    height: 1,
                    width: screenwidth,
                    color: Colors.black.withOpacity(0.7),
                  ),
                ])),
        ],),)
      ),
    );
  }
}
