import 'package:flutter/material.dart';
import 'package:jak_sie_masz/Data/rate_slider_repository.dart';

class RateSliderViewmodel extends ChangeNotifier {
  final RateSliderRepository sliderRepository;
  int currentIndex = 0;
  RateSliderViewmodel({required this.sliderRepository});

  void setCurrentIndex(int index) {
    if (index != sliderRepository.index) {
      print("new index ${index}");
      sliderRepository.setIndex(index);
      currentIndex = index;
      notifyListeners();
    }
  }
}
