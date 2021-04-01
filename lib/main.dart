import 'package:flutter/material.dart';
import 'package:goodvibesofficial/example%20page.dart';
import 'package:goodvibesofficial/screens/auth/forgotpassword/enteremail.dart';
import 'package:goodvibesofficial/screens/auth/login.dart';
import 'package:goodvibesofficial/screens/auth/signup.dart';
import 'package:goodvibesofficial/screens/home/base.dart';
import 'package:goodvibesofficial/screens/initial/goals.dart';
import 'package:goodvibesofficial/screens/initial/intropage.dart';
import 'package:goodvibesofficial/screens/initial/splashscreen.dart';
import 'package:goodvibesofficial/screens/plays/breathe.dart';
import 'package:goodvibesofficial/screens/plays/meditate.dart';
import 'package:goodvibesofficial/screens/sharables/music_player.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Good Vibes',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Material(
        child: Stack(
            children: <Widget>[
              Scaffold(
                  appBar: AppBar(
                    elevation: 0,
backgroundColor: Colors.white,
                  ),
                  body: Base()
              ),

            ]
        )
    );
  }
}
