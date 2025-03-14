import 'package:flutter/material.dart';
import 'package:jak_sie_masz/Data/repositories/user_repository.dart';

class FirstRateViewmodel extends ChangeNotifier {
  String username = "";

  FirstRateViewmodel() {
    // userRepository.onUsernameChange = (String name) {
    //   username = name;
    //   print("kurwa");
    //   notifyListeners();
    // };
  }
  void loadUsername() {
    // username = userRepository.username;
    // notifyListeners();
  }
}
