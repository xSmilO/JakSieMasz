import 'package:flutter/material.dart';
import 'package:jak_sie_masz/Data/day_rating_repository.dart';
import 'package:jak_sie_masz/Data/rate_slider_repository.dart';
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
      int messageIndex = (currentRating / 3).toInt();
      String message;

      switch (messageIndex) {
        case 0:
          message = "Nie załamuj się!";
          break;
        case 1:
          message = "To chyba całkiem git, co?";
          break;
        case 2:
        default:
          message = "Sigma! 😎";
      }

      Utility.showSimpleOutput(message);
    }
  }
}
