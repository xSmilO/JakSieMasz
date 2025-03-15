import 'package:flutter/cupertino.dart';

class AccessButtonViewmodel extends ChangeNotifier {
  bool _visible = false;

  bool get visible => _visible;

  void show() {
    _visible = !visible;
    notifyListeners();
  }
}
