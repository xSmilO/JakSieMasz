import 'package:flutter/material.dart';
import 'package:jak_sie_masz/Data/database_helper_service.dart';
import 'package:jak_sie_masz/Data/day_rating_model.dart';

class RateChartViewmodel extends ChangeNotifier {
  DatabaseHelperService _databaseHelperService = DatabaseHelperService.instance;

  RateChartViewmodel() {
    _databaseHelperService
        .getRatingsByNewest(_timespans[_activeTimespanId])
        .then((data) {
      print("data $data");
    });
  }

  final List<int> _timespans = [7, 14, 30];
  int _activeTimespanId = 0;

  void setTimespan(int id) {
    _activeTimespanId = id;
    notifyListeners();
  }

  Future<List<DayRatingModel>> fetchRates() async {
    return await _databaseHelperService
        .getRatingsByNewest(_timespans[_activeTimespanId]);
  }

  int get activeTimespanId => _activeTimespanId;
}
