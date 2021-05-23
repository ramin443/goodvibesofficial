import 'package:shared_preferences/shared_preferences.dart';

Future<int> _getloginstatus() async{
  final prefs=await SharedPreferences.getInstance();
  final loginstatus=prefs.getInt('loggedin');
  if(loginstatus==null){
    return 0;
  }
  return loginstatus;
}
Future<void> resetloginstatus() async{
  final prefs=await SharedPreferences.getInstance();
  await prefs.setInt('loggedin', 0);
}
Future<void> setloginstatus() async{
  final prefs=await SharedPreferences.getInstance();
  await prefs.setInt('loggedin', 1);
}