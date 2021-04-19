import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:goodvibesofficial/constants/fontconstants.dart';
import 'package:goodvibesofficial/locator.dart';
import 'package:goodvibesofficial/screens/initial/goals.dart';
import 'package:goodvibesofficial/services/user_service.dart';
import 'package:goodvibesofficial/userpreferences/changepassword.dart';
import 'package:goodvibesofficial/userpreferences/daily%20goals.dart';
import 'package:goodvibesofficial/utils/validator.dart';
class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String email, pass, displayname, confirmPass;
  final TextEditingController _namecontroller = TextEditingController();
  bool sound=true;
bool motivationalmsg=true;
bool reminder=true;
bool emailpressed=false;
  final TextEditingController _emailController = TextEditingController();


  @override
  void initState() {
    super.initState();
//_namecontroller.text=locator<UserService>().user.value.name;
//_emailController.text=locator<UserService>().user.value.email;

  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    double screenwidth=MediaQuery.of(context).size.width;
    double screeheight=MediaQuery.of(context).size.height;
    double screenarea=screeheight*screenwidth;
    return
      Scaffold(
        backgroundColor:  Color(0xfff5f5f5),
          body:
      CustomScrollView(
      physics: BouncingScrollPhysics(),

      slivers: [
        SliverAppBar(
          elevation: 0,
          backgroundColor: Color(0xfff5f5f5),
          title: Text("Settings",style: TextStyle(
            fontFamily: helveticaneuemedium,
      //      fontSize: 17,
        fontSize: screenwidth*0.0453,
            color: Colors.black87
          ),),
          centerTitle: true,
          actions: [
            Container(child: IconButton(icon:Icon(Icons.settings,
         //   size: 28,
           size: screenwidth*0.0746,
            color: Color(0xff12c2e9),)),
            ),
          ],
          leading: IconButton(
            icon: Icon(CupertinoIcons.back,
            color: Colors.black87,
      //        size: 24,
        size: screenwidth*0.064,    ),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
        ),
        SliverList(delegate: SliverChildListDelegate([
SingleChildScrollView(
  physics: BouncingScrollPhysics(),
  child: Container(
    margin: EdgeInsets.only(
        left: screenarea*0.000109
        ,            right: screenarea*0.000109,
 //   bottom: 24
   bottom: screenarea*0.0000959
    ),
    color: Color(0xfff5f5f5),
    child: Column(mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
     Container(
      //    height: 108,
        //  width:108,
       height: screeheight*0.1619,
          width: screeheight*0.1619,
          margin: EdgeInsets.only(
       //       top:8,
         top: screenarea*0.0000319
              //     right: 20
            ),
          child:
          Hero(
              tag: 'avatar',
              child:Image.asset('assets/images/profile@3x.png',
            //   width: 45,
            width:screenwidth*0.40,
            fit: BoxFit.contain,
          )),
      ),
        Container(margin: EdgeInsets.only(
     //       top: 18
       top: screenarea*0.0000719
        ),
          child: Text("Change Avatar",style: TextStyle(
          fontFamily: helveticaneuemedium,
          color: Colors.black87,
     //     fontSize: 15.5
       fontSize: screenwidth*0.0413
          ),),),
        Container( margin: EdgeInsets.only(
          //    horizontal: 35
top: screenarea*0.000103
//top: 26
        ),child:
        Column(children:[
          Row(children: [
Container(child: Text("Name",style: TextStyle(
  letterSpacing: 0.5,
  fontFamily: helveticaneueregular,color: Colors.black87,
//  fontSize: 14
fontSize: screenwidth*0.0373
),),)
          ],),
          Container(

            child:


            TextFormField(
              controller: _namecontroller,
              keyboardType: TextInputType.text,
              autocorrect: false,
              autofocus: false,
              onSaved: (val) => displayname = val,
              style: TextStyle(
                  fontFamily: helveticaneueregular,color: Colors.black38,
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
                      color: Colors.black38,
                      //  size: 18,
                      size:screenwidth*0.048 ,
                    )),
                hintText: "Robert Fox",
                hintStyle: TextStyle(
                    fontFamily: helveticaneueregular,color: Colors.black38,
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
//                bottom:20,
bottom: screenarea*0.0000799
              //    left: 35,
              //     right: 35

            ),

            //     margin: EdgeInsets.symmetric(horizontal: 35),
            height: 1,
            width: screenwidth,
            color: Colors.black26,
          ),
          Row(children: [
            Container(child: Text("Email",style: TextStyle(
              letterSpacing: 0.5,
                fontFamily: helveticaneueregular,color: Colors.black87,
       //         fontSize: 14
                fontSize: screenwidth*0.0373
            ),),)
          ],),
          Container(

            child:
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress ?? TextInputType.text,
              autocorrect: false,
              autofocus: false,
              onSaved: (val) => displayname = val,
              style: TextStyle(
                  fontFamily: helveticaneueregular,color: Colors.black,
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
                      color: Colors.black38,
                      //  size: 18,
                      size: screenwidth*0.048,
                    )),
                hintText: "robertfox@mail.com",
                hintStyle: TextStyle(
                    fontFamily: helveticaneueregular,color: Colors.black38,
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
            ),
            //     bottom: 12,
            //   left: 35,
            // right: 35),

            //     margin: EdgeInsets.symmetric(horizontal: 35),
            height: 1,
            width: screenwidth,
            color: Colors.black26,
          ),

        ]
        )
        ),
        GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ChangePassword()));

            },
            child:
            Container(
              margin: EdgeInsets.only(
                //  top: 45
           //       top: 26
                  top: screenarea*0.000103
              ),
              height: screeheight*0.0569,
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
                  'Change password',style: TextStyle(
                    fontFamily: helveticaneueregular,
                    color: Colors.white,
                    //        fontSize: 16
                    fontSize: screenwidth*0.0426
                ),
                ),
              ),
            )),
        Row(mainAxisAlignment:  MainAxisAlignment.start,
        children: [
          Container(
            margin:EdgeInsets.only(
        //        top: 26
                top: screenarea*0.000103
            ),
            child: Text("General",style: TextStyle(
            fontFamily: helveticaneuemedium,
            color: Colors.black87,
      //      fontSize: 16
        fontSize: screenwidth*0.0426
            ),),
          )
        ],),
        Container(
margin: EdgeInsets.only(
  //  top: 8
    top: screenarea*0.0000319

),
          child: Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
Container(child: Text("Sound",style: TextStyle(
  fontFamily: helveticaneueregular,
  color: Colors.black87,
 //   fontSize: 12.5
fontSize: screenwidth*0.03333
),),),GestureDetector(
                    onTap: (){
                      setState(() {
sound=!sound;
                      });
                    },
                    child:
                AnimatedContainer(duration: Duration(milliseconds: 140),
//width: 41,height: 20,
                  width: screenwidth*0.1093,height: screeheight*0.0299,
                  padding: EdgeInsets.only(
              //       left: 2,right: 2
                left: screenarea*0.00000799,right:  screenarea*0.00000799
                  ),
                  alignment:sound?Alignment.centerRight: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(24)
                    ),
                    color: sound?Color(0xff12c2e9):Color(0xffe8e8e8)
                  ),
                  child: Container(
               //     height: 16,width: 16,
                 height: screeheight*0.0239,width: screeheight*0.0239,
                    decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle
                  ),),
                ))
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

              ],
            ),
          ],),
        ),
        Container(
          margin: EdgeInsets.only(
     //         top: 8
              top: screenarea*0.0000319
          ),
          child: Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(child: Text("Motivational Message",style: TextStyle(
                    fontFamily: helveticaneueregular,
                    color: Colors.black87,
                    //fontSize: 12.5
                    fontSize: screenwidth*0.03333
                ),),),
                GestureDetector(
                    onTap: (){
                      setState(() {
                        motivationalmsg=!motivationalmsg;
                      });
                    },
                    child:
                AnimatedContainer(duration: Duration(milliseconds: 140),
                  //width: 41,height: 20,
                  width: screenwidth*0.1093,height: screeheight*0.0299,
                  padding: EdgeInsets.only(
            //          left: 2,right: 2
                      left: screenarea*0.00000799,right:  screenarea*0.00000799
                  ),
                  alignment:motivationalmsg?Alignment.centerRight: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(24)
                      ),
                      color: motivationalmsg?Color(0xff12c2e9):Color(0xffe8e8e8)
                  ),
                  child: Container(
                    //height: 16,width: 16,
                    height: screeheight*0.0239,width: screeheight*0.0239,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle
                    ),),
                ))
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

              ],
            ),
            GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>DailyGoals()));

                },
                child:
                Container(
                  margin: EdgeInsets.only(
//                      top: 26
                      top: screenarea*0.000103
                  ),
                  height: screeheight*0.0569,
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
                      'Edit Daily Goals',style: TextStyle(
                        fontFamily: helveticaneueregular,
                        color: Colors.white,
                        //        fontSize: 16
                        fontSize: screenwidth*0.0426
                    ),
                    ),
                  ),
                )),
            Row(mainAxisAlignment:  MainAxisAlignment.start,
              children: [
                Container(
                  margin:EdgeInsets.only(
          //            top: 26
                      top: screenarea*0.000103
                  ),
                  child: Text("Notification",style: TextStyle(
                      fontFamily: helveticaneuemedium,
                      color: Colors.black87,
             //         fontSize: 16
                      fontSize: screenwidth*0.0426
                  ),),
                )
              ],),
            Container(
              margin: EdgeInsets.only(
              //    top: 8
                  top: screenarea*0.0000319
              ),
              child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(

                  child: Text("Reminder",style: TextStyle(
                    fontFamily: helveticaneueregular,
                    color: Colors.black87,
                      //fontSize: 12.5
                      fontSize: screenwidth*0.03333

                ),),),
                GestureDetector(
                    onTap: (){
                      setState(() {
                        reminder=!reminder;
                      });
                    },
                    child:
                    AnimatedContainer(duration: Duration(milliseconds: 140),
                //      width: 41,height: 20,
                      width: screenwidth*0.1093,height: screeheight*0.0299,
                      padding: EdgeInsets.only(
               //           left: 2,right: 2
                          left: screenarea*0.00000799,right:  screenarea*0.00000799
                      ),
                      alignment:reminder?Alignment.centerRight: Alignment.centerLeft,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(24)
                          ),
                          color: reminder?Color(0xff12c2e9):Color(0xffe8e8e8)
                      ),
                      child: Container(
                        //height: 16,width: 16,
                        height: screeheight*0.0239,width: screeheight*0.0239,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle
                        ),),
                    ))
              ],
            ),),
            Container(
              margin: EdgeInsets.only(
                  //top: 8
                  top: screenarea*0.0000319
              ),
              child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(

                    child: Text("Weekly Progress",style: TextStyle(
                        fontFamily: helveticaneueregular,
                        color: Colors.black87,
                        //fontSize: 12.5
                        fontSize: screenwidth*0.03333

                    ),),),
                  Container(
                      margin: EdgeInsets.only(
                  //        right: 10
                    right:screenarea* 0.0000399
                      ),
                      child:
                  GestureDetector(
                      onTap: (){
                        setState(() {
                          emailpressed=!emailpressed;
                        });
                      },
                      child:

                          emailpressed?  Icon(Icons.email,
                            color:emailpressed?Color(0xff12c2e9): Colors.black54,
                            size: 20,):
                    Icon(Icons.email_outlined,
                    color: Colors.black54,
                    size: 20,)))
                ],
              ),),
            Container(
              margin: EdgeInsets.only(top: 11),
              child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
child:Center(child: Text("?",style: TextStyle(
  fontFamily: helveticaneueregular,
  color: Color(0xff12c2e9),
//  fontSize: 17
  fontSize: screenwidth*0.0453,
),)),
                  height: 22,width: 22,
                  decoration: BoxDecoration(
                    border:Border.all(width: 2,color: Color(0xff12c2e9),
                    ),
                    shape: BoxShape.circle
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                  //    left: 16
                  left: screenarea*0.0000639
                  ),
                  child: Text("Help and Support",style: TextStyle(
                    fontFamily: helveticaneuemedium,
                    color: Color(0xff12c2e9),
                    fontSize: 15
                  )
                  ),
                )
              ],
            ),),
            Container(
              margin: EdgeInsets.only(top: 11),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    FeatherIcons.logOut,
                    color: Color(0xff12c2e9),
                    size: 24,
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      //    left: 16
                        left: screenarea*0.0000639
                    ),
                    child: Text("Log Out",style: TextStyle(
                        fontFamily: helveticaneuemedium,
                        color: Color(0xff12c2e9),
                        fontSize: 15
                    )
                    ),
                  )
                ],
              ),),
            GestureDetector(
                onTap: (){

                },
                child:
                Container(
                  margin: EdgeInsets.only(
                    //  top: 45
           //           top: 26
                      top: screenarea*0.000103
                  ),
                  height: screeheight*0.0569,
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
                      'Privacy Policy',style: TextStyle(
                        fontFamily: helveticaneueregular,
                        color: Colors.white,
                        //        fontSize: 16
                        fontSize: screenwidth*0.0426
                    ),
                    ),
                  ),
                )),
            GestureDetector(
                onTap: (){

                },
                child:
                Container(
                  margin: EdgeInsets.only(
                    //  top: 45
             //         top: 16
                      top: screenarea*0.0000639
                  ),
                  height: screeheight*0.0569,
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
                      'Acknowledgement',style: TextStyle(
                        fontFamily: helveticaneueregular,
                        color: Colors.white,
                        //        fontSize: 16
                        fontSize: screenwidth*0.0426
                    ),
                    ),
                  ),
                )),
            GestureDetector(
                onTap: (){

                },
                child:
                Container(
                  margin: EdgeInsets.only(
                    //  top: 45
            //          top: 16
                      top: screenarea*0.0000639
                  ),
                  height: screeheight*0.0569,
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
                      'Terms',style: TextStyle(
                        fontFamily: helveticaneueregular,
                        color: Colors.white,
                        //        fontSize: 16
                        fontSize: screenwidth*0.0426
                    ),
                    ),
                  ),
                )),
          ],),
        ),
    ],),
  ),
)
        ]
        ))
      ],
      ));
  }
}
