import 'package:jak_sie_masz/Data/day_rating_model.dart';
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
          fullDate TEXT NOT NULL,
          rating INTEGER NOT NULL
        )
       ''');
      },
    );
  }

  Future<void> removeDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'jak_sie_masz.db');

    await deleteDatabase(path);
  }

  Future<List<DayRatingModel>> getRatings({int range = 7}) async {
    final db = await database;

    final List<Map<String, Object?>> ratingsMaps =
        await db.query('day_ratings');

    return [
      for (final {
            'id': id as int,
            'date': date as String,
            'fullDate': fullDate as String,
            'rating': rating as int
          } in ratingsMaps)
        DayRatingModel(id: id, date: date, fullDate: fullDate, rating: rating)
    ];
  }

  Future<int> insertRating(DayRatingModel value) async {
    final db = await database;
    return await db.insert(
      'day_ratings',
      {'date': value.date, 'rating': value.rating, 'fullDate': value.fullDate},
    );
  }

  Future<void> updateRating(DayRatingModel value) async {
    final db = await database;
    await db.update(
      'day_ratings',
      value.toMap(),
      where: 'date = ?',
      whereArgs: [value.date],
    );
  }

  Future<DayRatingModel?> findRatingByDate(String date) async {
    final db = await database;
    final List<Map<String, Object?>> ratesMaps =
        await db.query('day_ratings', where: "date = ?", whereArgs: [date]);
    if (ratesMaps.isEmpty) return null;

    Map<String, Object?> first = ratesMaps.first;

    return DayRatingModel(
        id: first['id'] as int,
        date: first['date'] as String,
        fullDate: first['fullDate'] as String,
        rating: first['rating'] as int);
  }

  Future<void> deleteData() async {
    final db = await database;
    db.delete("day_ratings");
  }
}
