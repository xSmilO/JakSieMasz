import 'package:flutter/material.dart';

class ExcercisesViewModel extends ChangeNotifier {
  int _excerciseNumber = 0;

  int get excerciseNumber => _excerciseNumber;

  void setExcerciseNumber(int number) {
    _excerciseNumber = number;
    notifyListeners(); 
  }
}