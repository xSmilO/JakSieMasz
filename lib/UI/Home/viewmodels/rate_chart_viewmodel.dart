import 'package:flutter/material.dart';
import 'package:jak_sie_masz/Data/database_helper_service.dart';
import 'package:jak_sie_masz/Data/day_rating_model.dart';
import 'package:jak_sie_masz/Data/day_rating_repository.dart';

class RateChartViewmodel extends ChangeNotifier {
  List<DayRatingModel> ratings = [];
  final DatabaseHelperService databaseHelperService;
  final DayRatingRepository dayRatingRepository;

  RateChartViewmodel(
      {required this.databaseHelperService,
      required this.dayRatingRepository}) {
    _loadDayRatings();
  }

  final List<int> _timespans = [7, 14, 30];
  int _activeTimespanId = 0;

  void setTimespan(int id) {
    _activeTimespanId = id;
    fetchRates();
    // notifyListeners();
  }

  Future<void> fetchRates() async {
    ratings = await databaseHelperService
        .getRatingsByNewest(_timespans[_activeTimespanId]);
    notifyListeners();
  }

  Future<void> _loadDayRatings() async {
    ratings = await databaseHelperService
        .getRatingsByNewest(_timespans[_activeTimespanId]);

    notifyListeners();
  }

  Future<void> setTestRateData() async {
    // for testing purposes

    await databaseHelperService.insertRatingsForTest();
  }

  int get activeTimespanId => _activeTimespanId;
  List<int> get timespans => _timespans;
}
