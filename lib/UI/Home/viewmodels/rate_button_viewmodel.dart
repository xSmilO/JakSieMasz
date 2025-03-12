import 'package:flutter/material.dart';
import 'package:jak_sie_masz/Data/repositories/day_rating_repository.dart';
import 'package:jak_sie_masz/Data/repositories/rate_slider_repository.dart';
import 'package:jak_sie_masz/UI/Shared/utility.dart';

class RateButtonViewmodel {
  final RateSliderRepository rateSliderRepository;
  final DayRatingRepository dayRatingRepository;
  const RateButtonViewmodel({
    required this.dayRatingRepository,
    required this.rateSliderRepository,
  });

  void rateDay(BuildContext context) async {
    int currentRating = rateSliderRepository.index + 1;

    await dayRatingRepository.rateDay(currentRating);

    // callback this shit

    if (context.mounted) {
      int messageIndex = (currentRating / 3).round();
      String message;

      switch (messageIndex) {
        case 0:
        case 1:
          message = "Nie zapomnij o codziennych ćwiczeniach! 😄";
          break;
        case 2:
          message = "Świeże powietrze to nie trucizna! 😉";
          break;
        case 3:
        default:
          message = "Tak trzymaj! 🤩";
      }

      Utility.showSimpleOutput(message);
    }
  }
}
