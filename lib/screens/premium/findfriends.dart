import 'dart:math';

import 'package:email_validator/email_validator.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:goodvibesoffl/constants/fontconstants.dart';
import 'package:goodvibesoffl/locator.dart';
import 'package:goodvibesoffl/models/invite_model.dart';
import 'package:goodvibesoffl/services/api_service.dart';
import 'package:goodvibesoffl/utils/validator.dart';
class FindFriends extends StatefulWidget {
  @override
  _FindFriendsState createState() => _FindFriendsState();
}

class _FindFriendsState extends State<FindFriends> {
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _lastnamecontroller = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String errortext='';
  bool findfriends=false;
  bool      invitesuccesful=false;
  List<InviteModel> _invitedpeople=[];
  @override
  void initState() {
    super.initState();
    fetchinvitelist();
  }
  fetchinvitelist()async{
    Map invitelist=await locator<ApiService>().getInviteStatus();
    List<dynamic> invitedlist=invitelist['data'] as List;
    var invli = invitedlist.map<InviteModel>((json) => InviteModel.fromJson(json));
    _invitedpeople.addAll(invli);
  }
  @override
  Widget build(BuildContext context) {
    double screenheight=MediaQuery.of(context).size.height;
    double screenwidth=MediaQuery.of(context).size.width;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: GestureDetector(
        onTap: (){
          EmailValidator.validate(_emailController.text)?sendinvite():
          emptycode();
        },
        child:
        AnimatedSwitcher(
            duration: Duration(milliseconds: 250),
            child:findfriends?SizedBox(height: 0,):
            AnimatedContainer(
              margin: EdgeInsets.only(bottom: 20),
              duration: Duration(milliseconds: 250),
              height: 40,
              width: 302,
              decoration: BoxDecoration(
                color:    invitesuccesful?Colors.greenAccent:EmailValidator.validate(_emailController.text)?Color(0xff9797de):Color(0xff9797de).withOpacity(0.7),
                borderRadius:BorderRadius.all(Radius.circular(20)),
              ),
              child: Center(
                child:
                AnimatedSwitcher(
                    duration: Duration(milliseconds: 250),
                    child:invitesuccesful?Row(
                      key: Key('invite'),
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            margin: EdgeInsets.only(right: 8),
                            child:
                            Text("Invite Sent Succesfully",style: TextStyle(
                                fontFamily: helveticaneuemedium,
                                color: Colors.white,
                                fontSize: 15
                            ),)),
                        Container(
                          child: Icon(FeatherIcons.check,
                            color: Colors.white,
                            size: 26,),
                        )
                      ],
                    ):
                    Text("Send Invite",
                      key: Key('invite'),
                      style: TextStyle(
                          fontFamily: helveticaneuemedium,
                          color: Colors.white,
                          fontSize: 15
                      ),)),
              ),
            )),
      ),
      backgroundColor: Color(0xfff5f5f5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(CupertinoIcons.back,
            color: Colors.black87.withOpacity(0.7),
            //   size: 28
            size: screenwidth*0.0746 ,),onPressed: (){
          Navigator.pop(context);
        },
        ),
        centerTitle: true,
        title:
        AnimatedSwitcher(
            duration: Duration(milliseconds: 350),
            child:findfriends?Text("Friend List",
              key:Key('text')
              ,style: TextStyle(
                  fontFamily: helveticaneuemedium,
                  color: Colors.black87,
                  //     fontSize: 17
                  fontSize: screenwidth*0.0453
              ),):
            Text("Find Friends",
              key:Key('text')
              ,style: TextStyle(
                  fontFamily: helveticaneuemedium,
                  color: Colors.black87,
                  //     fontSize: 17
                  fontSize: screenwidth*0.0453
              ),)),
      ),
      body: SingleChildScrollView(
        child:

        Container(child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: (){
                    setState(() {
                      findfriends=false;
                    });
                  },
                  child:
                  AnimatedContainer(
                    duration: Duration(milliseconds: 250),
                    child:

                    Icon(
                      Ionicons.search,
//    size: 34,
                      size: screenwidth*0.0906,
                      color:findfriends?Colors.black38: Colors.black87,
                    ),),),
                SizedBox(width: 26,),
                GestureDetector(
                  onTap: ()async{

                    setState(() {
                      findfriends=true;
                    });
                  },
                  child:
                  AnimatedContainer(


                    duration: Duration(milliseconds: 250),
                    child:

                    Icon(
                      FontAwesomeIcons.userFriends,
                      //   size: 32,
                      size: screenwidth*0.0853,
                      color: findfriends?Colors.black87:Colors.black38,
                    ),),),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedContainer(
                  margin: EdgeInsets.only(
                    //            top: 7,left: 8
                      top: screenwidth*0.0186,left: screenwidth*0.02133
                  ),
                  duration: Duration(milliseconds: 250),
//height: 4,width: 105,
                  height: screenwidth*0.0106,width: screenwidth*0.28,
                  alignment: findfriends?Alignment.centerRight:Alignment.centerLeft,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 250),
                    height: screenwidth*0.0106,width: screenwidth*0.133,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      color: Color(0xff9797de),
                    ),
                  ),
                )
              ],
            ),
            AnimatedSwitcher(duration: Duration(milliseconds: 250),child:
            findfriends?findfriendstab(context):
            Container(child:Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children:[
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 23),
                    width: screenwidth,
                    child: Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(child: Text("Get Good Vibes Premium Free",style: TextStyle(
                                fontFamily: helveticaneuemedium,
                                color: Colors.black87,
                                fontSize: screenwidth*0.0453
                            ),),),
                            Container(
                              margin: EdgeInsets.only(top: 6),
                              child: Text("Refer at least 3 friends to get 1 month Good\n"
                                  "Vibes premium for free",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: helveticaneueregular,
                                    color: Colors.black87,
                                    fontSize: 11.5
                                ),),),
                          ],
                        ),)
                      ],),
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
                  ),Container(
                      margin:EdgeInsets.only(bottom: 20,top: 5,
                          left: screenwidth*0.0586
                      ),
                      child:
                      Row(mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(child:Text(errortext,style: TextStyle(
                              fontFamily: helveticaneueregular,
                              color: Colors.redAccent,
                              fontSize: 12.5
                          ),)),

                        ],)),
                  Container(
                    child: Image.asset("assets/images/Saly-31-min.png",
                      width: screenwidth*0.672,),
                  )
                ]))
            )],
        ),),
      ),
    );
  }
  Widget findfriendstab(BuildContext context){
    double screenheight=MediaQuery.of(context).size.height;
    double screenwidth=MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: screenwidth*0.0586),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.symmetric(
              //        vertical: 20,
                vertical: screenwidth*0.05333
            ),
            child:
            Row(mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  Container(
                    //     height:35 ,
                    //     height: screeheight*0.05247,
                      height: screenwidth*0.0933,
                      //    width: 302,
                      width: screenwidth*0.805,
                      padding: EdgeInsets.only(
                        //    left: 10,
                        //  left: screenwidth*0.0266,
                          bottom: 0),
                      decoration: BoxDecoration(
                        boxShadow: [BoxShadow(blurRadius: 50,offset: Offset(0,3),
                            color: Colors.grey[300]
                        )],
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),child:Center(child: TextField(
                    onTap: (){
                      setState(() {
                        //      tabtap=true;
                      });
                    },

                    style: TextStyle(
                        fontFamily: helveticaneueregular,
                        color: Colors.grey[800],
                        //  fontSize: 14
                        fontSize: screenwidth*0.0373
                    ),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: IconButton(
                          icon: Icon(Ionicons.search,
                            color: Colors.black.withOpacity(0.6),
                            size: 22,
                          ),
                        ),
                        hintStyle: TextStyle(
                            fontFamily: helveticaneueregular,
                            color: Colors.grey[600],
                            //        fontSize: 14
                            fontSize: screenwidth*0.0373
                        ),
                        hintText: 'Email, name or username'
                    ),
                  ),)
                  )]),),
          LimitedBox(
            maxHeight: screenheight*0.8,
            maxWidth: screenwidth,
            child: ListView.builder(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: _invitedpeople.length,
                itemBuilder: (context,index){
                  return         Container(
                      margin: EdgeInsets.only(
                          bottom: 14
                      ),
                      child:
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:[
                            Container(
                              //  height:56,
                              height:screenwidth*0.149,
                              child: Row(mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    //      height: 56,width: 56,
                                    height:screenwidth*0.149,width: screenwidth*0.149,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: AssetImage(getpicture()),
                                            fit: BoxFit.cover
                                        )
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: screenwidth*0.0586),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                            //       bottom: 4
                                              bottom: screenwidth*0.0106
                                          ),
                                          child: Text(_invitedpeople[index].email,style: TextStyle(
                                              fontFamily: helveticaneuemedium,
                                              color: Colors.black87,
                                              //   fontSize: 15
                                              fontSize: screenwidth*0.04
                                          ),),),
                                        Container(child: Text(_invitedpeople[index].date,style: TextStyle(
                                            fontFamily: helveticaneueregular,
                                            color: Colors.black54,
                                            //       fontSize: 12.5
                                            fontSize: screenwidth*0.0333
                                        ),),),
                                      ],
                                    ),
                                  ),

                                ],
                              ),
                            ),
                            Container(
                              //   height: screenwidth*0.0746,width: screenwidth*0.2133,
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(4)),
                                  border: Border.all(color: Color(0xff12c2e9),width: 1)
                              ),
                              child:Center(child: Text(_invitedpeople[index].accpted?"Accepted":
                              "Not Accepted",style: TextStyle(
                                  fontFamily: helveticaneueregular,
                                  color: Color(0xff12c2e9),
                                  //         fontSize: 12.5
                                  fontSize: screenwidth*0.0333
                              ),)),
                            ),

                          ])

                  );
                }),
          ),
        ],
      ),
    );
  }
  getpicture(){
    String a;
    Random().nextInt(10).isOdd?
    a="assets/images/oliviamurray.png":
    a="assets/images/guyavatar.png";
    return a;
  }
  sendinvite()async{
    Map inviteresponse=  await locator<ApiService>().postInvitation(email: _emailController.text);
// print(inviteresponse.values);

    if(inviteresponse.containsKey("data")){
//  print("Invite sent succesfully");
      setState(() {
        invitesuccesful=true;
        Future.delayed(Duration(milliseconds: 3000),setinvitetofalse);
      });
    }
    if(inviteresponse.containsKey("error")){
      setState(() {
        errortext=inviteresponse.values.toString();
      });
    }
  }
  setinvitetofalse(){
    setState(() {
      _emailController.text="";
      invitesuccesful=false;
      FocusScopeNode currentFocus = FocusScope.of(context);

      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
    });
  }
  returnerrortext(){
    EmailValidator.validate(_emailController.text)?
    errortext="":errortext='Email format not valid';
  }
  emptycode(){

  }
}

