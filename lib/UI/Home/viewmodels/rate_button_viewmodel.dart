import 'package:flutter/material.dart';

import 'package:jak_sie_masz/Data/day_rating_repository.dart';
import 'package:jak_sie_masz/Data/rate_slider_repository.dart';

import 'package:fluttertoast/fluttertoast.dart';

class RateButtonViewmodel {
  final RateSliderRepository rateSliderRepository;
  final DayRatingRepository dayRatingRepository;

  const RateButtonViewmodel({required this.rateSliderRepository, required this.dayRatingRepository});

  String get currentDateWithoutTime {
    final currentDate = DateTime.now();
    return "${currentDate.day}.${currentDate.month}.${currentDate.year}";
  }

  void rateDay(BuildContext context) async {
    final currentDate = currentDateWithoutTime;
    final currentRating = rateSliderRepository.index;
    final ratedDays = await dayRatingRepository.ratedDaysParsed;

    ratedDays[currentDate] = currentRating;
    dayRatingRepository.updateRatedDays(ratedDays);
    print("updated " + currentDate + " rating to " + currentRating.toString());

    if(context.mounted) {
      int messageIndex = (currentRating / 3).toInt();
      String message;

      switch(messageIndex) {
        case 0: message = "Nie załamuj się!"; break;
        case 1: message = "To chyba całkiem git, co?"; break;
        case 2:
        default: message = "Sigma! 😎";
      }

      Fluttertoast.showToast(msg: message, toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, backgroundColor: Color.fromARGB(255, 28, 30, 36), textColor: Color.fromARGB(255, 235, 238, 245), fontSize: 16.0);
    }
  }
}