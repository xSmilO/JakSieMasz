import 'package:flutter/material.dart';

import 'package:jak_sie_masz/Data/services/shared_preferences_service.dart';

class FirstRateViewmodel extends ChangeNotifier {
  String username = "";

  SharedPreferencesService sp;

  FirstRateViewmodel({required this.sp}) {
    print("rateview constructor");

    this.sp.fetchString("username").then((value) {
      print("kurwa mac do chuja $value");

      username = value!;
      notifyListeners();
    });
  }
  void loadUsername() async {
    if (username != "") return;

    notifyListeners();
  }
}
