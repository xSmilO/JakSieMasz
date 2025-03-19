import 'dart:math';

import 'package:jak_sie_masz/Data/models/day_rating_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelperService {
  Database? _database;

  DatabaseHelperService();
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
      version: 2,
      onCreate: (db, version) async {
        // create day_ratings
        await db.execute('''
        CREATE TABLE day_ratings (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          date TEXT NOT NULL,
          fullDate TEXT NOT NULL,
          rating INTEGER NOT NULL
        )
       ''');
        // Create chat topics table
        await db.execute('''
        CREATE TABLE chat_topics (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT NOT NULL,
          created_at TEXT NOT NULL
        )
        ''');

        // Create chat messages table
        await db.execute('''
        CREATE TABLE chat_messages (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          topic_id INTEGER NOT NULL,
          message TEXT NOT NULL,
          is_bot INTEGER NOT NULL,
          timestamp TEXT NOT NULL,
          FOREIGN KEY (topic_id) REFERENCES chat_topics (id)
        )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        // Handle upgrade from version 1 to 2
        if (oldVersion == 1) {
          // Create new tables for chat
          await db.execute('''
            CREATE TABLE chat_topics (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              title TEXT NOT NULL,
              created_at TEXT NOT NULL
            )
          ''');

          await db.execute('''
            CREATE TABLE chat_messages (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              topic_id INTEGER NOT NULL,
              message TEXT NOT NULL,
              is_bot INTEGER NOT NULL,
              timestamp TEXT NOT NULL,
              FOREIGN KEY (topic_id) REFERENCES chat_topics (id)
            )
          ''');
        }
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

  Future<List<DayRatingModel>> getRatingsByNewest(int range) async {
    final db = await database;

    final List<Map<String, Object?>> ratingsMaps =
        await db.query('day_ratings', orderBy: 'fullDate DESC', limit: range);

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

  Future<void> deleteData() async {
    final db = await database;
    await db.delete("day_ratings");
    await db.delete("chat_topics");
    await db.delete("chat_messages");
  }

  Future<void> insertRatingsForTest() async {
    int daysToGenerate = 30;
    DateTime now = DateTime.now();
    Random rng = Random();
    for (int i = 0; i < daysToGenerate; ++i) {
      DateTime date = now.subtract(Duration(days: i));
      int rating = rng.nextInt(9) + 1;
      // rating = i + 1;

      String dateStr = "${date.day}.${date.month}.${date.year}";
      DayRatingModel model = DayRatingModel(
          date: dateStr, fullDate: date.toIso8601String(), rating: rating);

      DayRatingModel? todaysRating = await findRatingByDate(dateStr);

      if (todaysRating == null) {
        insertRating(model);
      } else {
        DayRatingModel newRating = DayRatingModel(
            id: todaysRating.id,
            date: todaysRating.date,
            rating: rating,
            fullDate: date.toIso8601String());

        await updateRating(newRating);
      }
    }
  }

  Future<int> createChatTopic(String title) async {
    final db = await database;
    return await db.insert('chat_topics', {
      'title': title,
      'created_at': DateTime.now().toIso8601String(),
    });
  }

  Future<void> saveChatMessage(int topicId, String message, bool isBot) async {
    final db = await database;
    await db.insert('chat_messages', {
      'topic_id': topicId,
      'message': message,
      'is_bot': isBot ? 1 : 0,
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  Future<List<Map<String, dynamic>>> getTopics() async {
    final db = await database;
    return await db.query('chat_topics', orderBy: 'created_at DESC');
  }

  Future<List<Map<String, dynamic>>> getMessagesForTopic(int topicId) async {
    final db = await database;
    return await db.query(
      'chat_messages',
      where: 'topic_id = ?',
      whereArgs: [topicId],
      orderBy: 'timestamp ASC',
    );
  }

  Future<bool> isCurrentDayRated() async {
    final currDate = DateTime.now();
    final dateOnly = "${currDate.day}.${currDate.month}.${currDate.year}";

    DayRatingModel? data = await findRatingByDate(dateOnly);

    return data == null ? false : true;
  }

  Future<void> deleteTopic(int topicId) async {
    final db = await database;
    await db
        .delete("chat_messages", where: "topic_id = ?", whereArgs: [topicId]);
    await db.delete("chat_topics", where: "id = ?", whereArgs: [topicId]);
  }
}
