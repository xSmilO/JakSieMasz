import 'dart:ui';

import 'package:fluttertoast/fluttertoast.dart';

class Utility {
  static void showSimpleOutput(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      backgroundColor: Color.fromARGB(255, 28, 30, 36),
      textColor: Color.fromARGB(255, 235, 238, 245),
      fontSize: 16.0
    );
  }

  static String currentDateWithoutTime() {
    DateTime currentDate = DateTime.now();
    return "${currentDate.day}.${currentDate.month}.${currentDate.year}";
  }
}