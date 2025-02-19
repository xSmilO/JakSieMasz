import 'package:flutter/material.dart';

class ProfileViewModel extends ChangeNotifier {
  String _username = "";
  ProfileViewModel() : _username = "cygan";

  String get username {
    return _username;
  }

  void changeName(String newName) {
    _username = newName;
    notifyListeners();
  }
}
