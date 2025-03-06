import 'package:flutter/material.dart';

class RateChartViewmodel extends ChangeNotifier {
  int activeTimespanId = 0;

  void setTimespan(int id) {
    activeTimespanId = id;
    notifyListeners();
  }
}
