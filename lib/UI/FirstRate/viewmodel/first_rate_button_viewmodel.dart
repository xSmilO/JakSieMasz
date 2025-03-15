import 'package:flutter/cupertino.dart';
import 'package:jak_sie_masz/Data/repositories/day_rating_repository.dart';
import 'package:jak_sie_masz/Data/repositories/rate_slider_repository.dart';

class FirstRateButtonViewmodel extends ChangeNotifier {
  RateSliderRepository rateSliderRepository;
  DayRatingRepository dayRatingRepository;
  FirstRateButtonViewmodel(
      {required this.rateSliderRepository, required this.dayRatingRepository});

  Future<void> rateDay() async {
    print(rateSliderRepository.index);
    await dayRatingRepository.rateDay(rateSliderRepository.index + 1);
  }
}
