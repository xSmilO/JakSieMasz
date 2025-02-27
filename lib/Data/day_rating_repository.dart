import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:path_provider/path_provider.dart';

class DayRatingRepository {
  Future<String> get localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get ratedDaysFile async {
    final path = await localPath;
    var file = File('$path/rated_days.json');

    if(!await file.exists()) {
      file = await file.create();
    }

    return file;
  }

  dynamic get ratedDaysParsed async {
    final file = await ratedDaysFile;
    final contents = await file.readAsString();

    try {
      return json.decode(contents);
    } catch(exception) {
      return json.decode("{}");
    }
  }

  void updateRatedDays(Map ratedDays) async {
    final file = await ratedDaysFile;
    file.writeAsString(json.encode(ratedDays));
  }
}