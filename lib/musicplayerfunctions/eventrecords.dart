import 'package:shared_preferences/shared_preferences.dart';

Future<bool> _playingstate() async {
  final prefs = await SharedPreferences.getInstance();
  final playing = prefs.getBool('playing');
  if (playing == null) {
    return false;
  }
  return playing;
}
Future<void> _setcurrentplayingstate() async {
  final prefs = await SharedPreferences.getInstance();
  bool playingstate=await _playingstate();
  if( playingstate){
    await prefs.setBool('playing', false);
  }else{
    await prefs.setBool('playing', true);
  }
}
Future<bool> _playedmorethanonce() async {
  final prefs = await SharedPreferences.getInstance();
  final playedmorethanonce = prefs.getBool('playedmorethanonce');
  if (playedmorethanonce == null) {
    return false;
  }
  return playedmorethanonce;
}

Future<bool> _setplayedmorethanonce() async {
  final prefs = await SharedPreferences.getInstance();
  bool playedmorethanonce=await _playedmorethanonce();
  if( playedmorethanonce){
    await prefs.setBool('playedmorethanonce', true);
  }else{
    await prefs.setBool('playedmorethanonce', true);
  }
}
Future<bool> _resetplayedmorethanonce() async {
  final prefs = await SharedPreferences.getInstance();
//  bool playedmorethanonce=await _playedmorethanonce();
    await prefs.setBool('playedmorethanonce', false);

  }
