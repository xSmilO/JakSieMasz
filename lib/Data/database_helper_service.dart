import 'package:jak_sie_masz/Data/day_rating_repository.dart';
import 'package:jak_sie_masz/Data/rate_day_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelperService {
  static final DatabaseHelperService instance =
      DatabaseHelperService._internal();
  static Database? _database;

  DatabaseHelperService._internal();
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'jak_sie_masz.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE day_ratings (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          date TEXT NOT NULL,
          rating INTEGER NOT NULL
        )
       ''');
      },
    );
  }

  Future<List<RateDayModel>> getRatings({int range = 7}) async {
    final db = await database;

    final List<Map<String, Object?>> ratingsMaps =
        await db.query('day_ratings');

    return [
      for (final {
            'id': id as int,
            'date': date as String,
            'rating': rating as int
          } in ratingsMaps)
        RateDayModel(id: id, date: date, rating: rating)
    ];
  }

  Future<int> insertRating(RateDayModel value) async {
    final db = await database;
    return await db.insert(
      'day_ratings',
      {'date': value.date, 'rating': value.rating},
    );
  }

  Future<void> updateRating(RateDayModel value) async {
    final db = await database;
    await db.update(
      'day_ratings',
      value.toMap(),
      where: 'date = ?',
      whereArgs: [value.date],
    );
  }

  Future<RateDayModel?> findRatingByDate(String date) async {
    final db = await database;
    final List<Map<String, Object?>> ratesMaps =
        await db.query('day_ratings', where: "date = ?", whereArgs: [date]);
    if (ratesMaps.isEmpty) return null;

    Map<String, Object?> first = ratesMaps.first;

    return RateDayModel(
        id: first['id'] as int,
        date: first['date'] as String,
        rating: first['rating'] as int);
  }

  Future<void> deleteData() async {
    final db = await database;
    db.delete("day_ratings");
  }
}
