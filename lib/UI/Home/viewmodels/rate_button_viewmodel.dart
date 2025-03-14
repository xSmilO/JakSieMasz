import 'package:flutter/material.dart';
import 'package:jak_sie_masz/Data/models/day_rating_model.dart';
import 'package:jak_sie_masz/Data/repositories/day_rating_repository.dart';
import 'package:jak_sie_masz/Data/repositories/rate_slider_repository.dart';
import 'package:jak_sie_masz/UI/AIChat/services/chat_service.dart';
import 'package:jak_sie_masz/UI/Shared/utility.dart';

class RateButtonViewmodel {
  final RateSliderRepository rateSliderRepository;
  final DayRatingRepository dayRatingRepository;
  final ChatService chatService;
  const RateButtonViewmodel({
    required this.dayRatingRepository,
    required this.rateSliderRepository,
    required this.chatService
  });

  Future<void> analyzeRateChart(BuildContext context) async {
    List<DayRatingModel> dayRatings = await dayRatingRepository.databaseHelperService.getRatings();
    int dayRatingsMean = 0;

    for(DayRatingModel dayRating in dayRatings) {
      dayRatingsMean += dayRating.rating;
    }

    dayRatingsMean = (dayRatingsMean / dayRatings.length).round();

    if(dayRatingsMean < 5) {
      Utility.showSimpleOutput(context, "Hej, może powinieneś rozważyć profesjonalną pomoc? 😢");
      chatService.sendMessage("Dostaliśmy informację o tym, że średni poziom samopoczucia twojego rozmówcy spadł poniżej dopuszczalnej wartości. Powinieneś zapytać się, co u twojego rozmówcy, najlepiej zrób to żartobliwie, żeby pobudzić go trochę na duchu.");
    }
  }

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

      Utility.showSimpleOutput(context, message);
      await analyzeRateChart(context);
    }
  }
}
