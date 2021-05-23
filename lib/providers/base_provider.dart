import 'package:flutter/cupertino.dart';

class BaseProvider extends ChangeNotifier {
  bool _busy = false;

  bool get busy => _busy;

  void setBusy(bool value) {
    _busy = value;
    //  notifyListeners();
  }
}
