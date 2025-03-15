import 'package:flutter/material.dart';
import 'package:jak_sie_masz/Styles/styles.dart';
import 'package:toastification/toastification.dart';

class Utility {
  static void showSimpleOutput(BuildContext context, String message) {
    toastification.show(
      context: context,
      title: Text(
        message,
        style: TextStyle(
          color: Styles.fontColorDark,
          fontFamily: Styles.fontFamily,
          fontSize: Styles.fontSizeP,
          fontWeight: FontWeight.normal,
        ),
      ),
      autoCloseDuration: Duration(seconds: 3),
    );
  }

  static String currentDateWithoutTime() {
    DateTime currentDate = DateTime.now();
    return "${currentDate.day}.${currentDate.month}.${currentDate.year}";
  }
}
