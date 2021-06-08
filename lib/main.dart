import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:goodvibesoffl/providertest/newtest.dart';
import 'package:goodvibesoffl/screens/auth/login.dart';
import 'package:goodvibesoffl/screens/home/base.dart';
import 'package:goodvibesoffl/screens/initial/goals.dart';
import 'package:goodvibesoffl/screens/initial/splashscreen.dart';
import 'package:goodvibesoffl/screens/plays/meditate.dart';
import 'package:goodvibesoffl/screens/sharables/MusicPlayer.dart';
import 'package:goodvibesoffl/theme.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

import 'locator.dart';
final BehaviorSubject<String> selectNotificationSubject =
BehaviorSubject<String>();

final BehaviorSubject<ThemeData> appThemeDataStream =
BehaviorSubject<ThemeData>()..add(defaultTheme);

final BehaviorSubject<RewardVideoStatus> rewardedStatusStream =
BehaviorSubject<RewardVideoStatus>();


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
await FlutterDownloader.initialize(debug: true);
  await Firebase.initializeApp();
  await setupLocator(
    selectNotificationSubject,
    appThemeDataStream,
    rewardedStatusStream,
  );

  runZonedGuarded(() {
    runApp(MyApp());
  }, (error, stackTrace) {
    print('runZonedGuarded: Caught error in my root zone.');
    FirebaseCrashlytics.instance.recordError(error, stackTrace);
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Good Vibes Official',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
  //    routes: <String,WidgetBuilder>{
    //    '/':(context)=>Base()
     home:SplashScreen(),

  //    home: Base(),
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
  final audios = <Audio>[
    Audio.network(
      'https://files.freemusicarchive.org/storage-freemusicarchive-org/music/Music_for_Video/springtide/Sounds_strange_weird_but_unmistakably_romantic_Vol1/springtide_-_03_-_We_Are_Heading_to_the_East.mp3',
      metas: Metas(
        id: 'Online',
        title: 'Online',
        artist: 'Florent Champigny',
        album: 'OnlineAlbum',
        // image: MetasImage.network('https://www.google.com')
        image: MetasImage.network(
            'https://image.shutterstock.com/image-vector/pop-music-text-art-colorful-600w-515538502.jpg'),
      ),
    ),
    Audio(
      'https://file-examples-com.github.io/uploads/2017/11/file_example_MP3_700KB.mp3',
      //playSpeed: 2.0,
      metas: Metas(
        id: 'Rock',
        title: 'Rock',
        artist: 'Florent Champigny',
        album: 'RockAlbum',
        image: MetasImage.network(
            'https://static.radio.fr/images/broadcasts/cb/ef/2075/c300.png'),
      ),
    ),
    Audio(
      'https://file-examples-com.github.io/uploads/2017/11/file_example_MP3_700KB.mp3',
      metas: Metas(
        id: 'Country',
        title: 'Country',
        artist: 'Florent Champigny',
        album: 'CountryAlbum',
        image: MetasImage.asset('assets/images/country.jpg'),
      ),
    ),
    Audio(
      'https://file-examples-com.github.io/uploads/2017/11/file_example_MP3_700KB.mp3',
      metas: Metas(
        id: 'Electronics',
        title: 'Electronic',
        artist: 'Florent Champigny',
        album: 'ElectronicAlbum',
        image: MetasImage.network(
            'https://99designs-blog.imgix.net/blog/wp-content/uploads/2017/12/attachment_68585523.jpg'),
      ),
    ),
    Audio(
      'https://file-examples-com.github.io/uploads/2017/11/file_example_MP3_700KB.mp3',
      metas: Metas(
        id: 'Hiphop',
        title: 'HipHop',
        artist: 'Florent Champigny',
        album: 'HipHopAlbum',
        image: MetasImage.network(
            'https://beyoudancestudio.ch/wp-content/uploads/2019/01/apprendre-danser.hiphop-1.jpg'),
      ),
    ),
    Audio(
      'https://file-examples-com.github.io/uploads/2017/11/file_example_MP3_700KB.mp3',
      metas: Metas(
        id: 'Pop',
        title: 'Pop',
        artist: 'Florent Champigny',
        album: 'PopAlbum',
        image: MetasImage.network(
            'https://image.shutterstock.com/image-vector/pop-music-text-art-colorful-600w-515538502.jpg'),
      ),
    ),
    Audio(
      'https://file-examples-com.github.io/uploads/2017/11/file_example_MP3_700KB.mp3',
      metas: Metas(
        id: 'Instrumental',
        title: 'Instrumental',
        artist: 'Florent Champigny',
        album: 'InstrumentalAlbum',
        image: MetasImage.network(
            'https://99designs-blog.imgix.net/blog/wp-content/uploads/2017/12/attachment_68585523.jpg'),
      ),
    ),
  ];
  AssetsAudioPlayer get _assetsAudioPlayer => AssetsAudioPlayer.withId('music');
  final List<StreamSubscription> _subscriptions = [];

  @override
  void initState() {
    super.initState();
    //_subscriptions.add(_assetsAudioPlayer.playlistFinished.listen((data) {
    //  print('finished : $data');
    //}));
    //openPlayer();
    _subscriptions.add(_assetsAudioPlayer.playlistAudioFinished.listen((data) {
      print('playlistAudioFinished : $data');
    }));
    _subscriptions.add(_assetsAudioPlayer.audioSessionId.listen((sessionId) {
      print('audioSessionId : $sessionId');
    }));
    _subscriptions
        .add(AssetsAudioPlayer.addNotificationOpenAction((notification) {
      return false;
    }));
    openPlayer();
  }
bool playedonce=false;
  void openPlayer() async {
    await _assetsAudioPlayer.open(
      Playlist(audios: audios, startIndex: 0),
      showNotification: true,
      autoStart: false,
    );
  }

  @override
  void dispose() {
    _assetsAudioPlayer.dispose();
    print('dispose');
    super.dispose();
  }

  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) => element.path == fromPath);
  }

  int _counter = 0;
  final assetsAudioPlayer = AssetsAudioPlayer();
bool played=false;
bool showplayicon=false;
int playtimes=0;
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
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
elevation: 0,
actions: [
  IconButton(icon: Icon(
    assetsAudioPlayer.isPlaying.value?CupertinoIcons.pause_solid:
    CupertinoIcons.play_arrow_solid,
  color: Colors.black,size: 30,
  ), onPressed: ()async{
    playedonce?pauseorplay():initiateplay();
    setState(() {
  playedonce=true;
showplayicon=!showplayicon;
});
  })
],
title: Text("HERO",style: TextStyle(
  fontSize: 20,
  color: Colors.black
),),
        ),
      );
  }
  initiateplay()async{
    try {
      await assetsAudioPlayer.open(
        Audio.network("https://file-examples-com.github.io/uploads/2017/11/file_example_MP3_700KB.mp3",
          metas: Metas(
            title:  "Country",
            artist: "Florent Champigny",
            album: "CountryAlbum",
            image: MetasImage.asset("assets/images/country.jpg"), //can be MetasImage.network
          ),
        ),
        showNotification: true,
playInBackground: PlayInBackground.enabled,

        notificationSettings: NotificationSettings(

        )
      );
    } catch (t) {
      //mp3 unreachable
    }
  }
  pauseorplay()async{

    showplayicon?await assetsAudioPlayer.play():
      await assetsAudioPlayer.pause();

  }
}
