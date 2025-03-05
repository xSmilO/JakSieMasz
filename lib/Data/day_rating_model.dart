class DayRatingModel {
  final int? id;
  final String date;
  final String fullDate;
  final int rating;

  const DayRatingModel(
      {this.id,
      required this.date,
      required this.fullDate,
      required this.rating});

  Map<String, Object?> toMap() {
    return {'id': id, 'date': date, 'fulldate': fullDate, 'rating': rating};
  }
}
