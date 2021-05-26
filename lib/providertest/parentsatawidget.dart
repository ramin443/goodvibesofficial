import 'package:flutter/material.dart';
import 'package:goodvibesoffl/screens/sharables/MusicPlayer.dart';
import 'package:goodvibesoffl/screens/sharables/music_player.dart';
import 'package:provider/provider.dart';
class Parent extends StatefulWidget {
  @override
  _ParentState createState() => _ParentState();
}

class _ParentState extends State<Parent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (_)=>MusicPlays(),
child: MusicPlayer(),
      ),
    );
  }
}
