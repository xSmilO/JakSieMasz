import 'package:flutter/material.dart';
import 'package:jak_sie_masz/Data/rate_slider_repository.dart';

class RateSliderViewmodel extends ChangeNotifier {
  final RateSliderRepository rateSliderRepository;
  int currentIndex = 0;
  RateSliderViewmodel({required this.rateSliderRepository});

  void setCurrentIndex(int index) {
    if (index != rateSliderRepository.index) {
      rateSliderRepository.setIndex(index);
      currentIndex = index;
      notifyListeners();
    }
  }
}
