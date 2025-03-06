import 'package:jak_sie_masz/Data/database_helper_service.dart';
import 'package:jak_sie_masz/Data/day_rating_model.dart';

class DayRatingRepository {
  late DatabaseHelperService databaseHelperService;

  DayRatingRepository() {
    databaseHelperService = DatabaseHelperService.instance;
  }

  String currentDateWithoutTime() {
    DateTime currentDate = DateTime.now();
    print(currentDate.toIso8601String());
    return "${currentDate.day}.${currentDate.month}.${currentDate.year}";
  }

  Future<void> rateDay(int rating) async {
    String currentDate = currentDateWithoutTime();
    DateTime currentTimestamp = DateTime.now();

    print("updated " + currentDate + " rating to " + rating.toString());
    DayRatingModel dayRate = DayRatingModel(
        date: currentDate,
        rating: rating,
        fullDate: currentTimestamp.toIso8601String());

    DayRatingModel? todaysRating =
        await databaseHelperService.findRatingByDate(currentDate);

    print(todaysRating?.toMap());
    if (todaysRating == null)
      databaseHelperService.insertRating(dayRate);
    else {
      DayRatingModel newRating = DayRatingModel(
          id: todaysRating.id,
          date: todaysRating.date,
          rating: rating,
          fullDate: currentTimestamp.toIso8601String());
      await databaseHelperService.updateRating(newRating);
    }
  }
}
