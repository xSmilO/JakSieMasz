class RateDayModel {
  final int? id;
  final String date;
  final int rating;

  const RateDayModel({this.id, required this.date, required this.rating});

  Map<String, Object?> toMap() {
    return {'id': id, 'date': date, 'rating': rating};
  }
}
