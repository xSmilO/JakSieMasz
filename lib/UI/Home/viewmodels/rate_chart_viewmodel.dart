import 'package:flutter/material.dart';
import 'package:jak_sie_masz/Data/database_helper_service.dart';
import 'package:jak_sie_masz/Data/day_rating_model.dart';

class RateChartViewmodel extends ChangeNotifier {
  List<DayRatingModel> ratings = [];
  final DatabaseHelperService _databaseHelperService;

  RateChartViewmodel(this._databaseHelperService) {
    _loadDayRatings();
  }

  final List<int> _timespans = [7, 14, 30];
  int _activeTimespanId = 0;

  void setTimespan(int id) {
    _activeTimespanId = id;
    notifyListeners();
  }

  Future<void> fetchRates() async {
    // for testing purposes

    // await _databaseHelperService.insertRatingsForTest();

    ratings = await _databaseHelperService
        .getRatingsByNewest(_timespans[_activeTimespanId]);
    // ratings = await _databaseHelperService.getRatingsByNewest(3);
    notifyListeners();
  }

  Future<void> _loadDayRatings() async {
    ratings = await _databaseHelperService
        .getRatingsByNewest(_timespans[_activeTimespanId]);

    notifyListeners();
  }

  int get activeTimespanId => _activeTimespanId;
  List<int> get timespans => _timespans;
}
