import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:goodvibesofficial/constants/fontconstants.dart';
class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Container(
      child: Center(
        child: Text("Profile",
          style: TextStyle(
              fontFamily: helveticaneuemedium,
              color: Colors.black
          ),),
      ),);
  }
}
