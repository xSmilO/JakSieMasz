import 'package:flutter/material.dart';
import 'package:jak_sie_masz/Data/database_helper_service.dart';
import 'package:jak_sie_masz/Data/rate_day_model.dart';

import 'package:jak_sie_masz/Data/rate_slider_repository.dart';

import 'package:fluttertoast/fluttertoast.dart';

class RateButtonViewmodel {
  final RateSliderRepository rateSliderRepository;
  final DatabaseHelperService databaseHelperService;
  const RateButtonViewmodel({
    required this.databaseHelperService,
    required this.rateSliderRepository,
  });

  String get currentDateWithoutTime {
    final currentDate = DateTime.now();
    return "${currentDate.day}.${currentDate.month}.${currentDate.year}";
  }

  void rateDay(BuildContext context) async {
    final currentDate = currentDateWithoutTime;
    final currentRating = rateSliderRepository.index + 1;

    print("updated " + currentDate + " rating to " + currentRating.toString());

    RateDayModel dayRate =
        RateDayModel(date: currentDate, rating: currentRating);

    RateDayModel? todaysRating =
        await databaseHelperService.findRatingByDate(currentDate);

    print(todaysRating?.toMap());
    if (todaysRating == null)
      databaseHelperService.insertRating(dayRate);
    else {
      RateDayModel newRating = RateDayModel(
          id: todaysRating.id, date: todaysRating.date, rating: currentRating);
      await databaseHelperService.updateRating(newRating);
    }

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

      Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Color.fromARGB(255, 28, 30, 36),
          textColor: Color.fromARGB(255, 235, 238, 245),
          fontSize: 16.0);
    }
  }
}
