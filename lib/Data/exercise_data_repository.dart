import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:jak_sie_masz/Data/exercise_data_model.dart';

class ExerciseDataRepository {
  Future<String> get _stringData async {
    return rootBundle.loadString("lib/UI/Exercises/data/exercises_data.json");
  }

  Future<List<dynamic>> get _jsonData async {
    return json.decode(await _stringData);
  }

  Future<List<ExerciseDataModel>> getExercisesData() async {
    List<dynamic> jsonData = await _jsonData;
    List<ExerciseDataModel> exercisesData = [];

    for(Map<String, dynamic> exercise in jsonData) {
      exercisesData.add(
        ExerciseDataModel(
          id: exercise["id"],
          title: exercise["title"],
          pathToImage: exercise["path_to_image"],
          description: exercise["description"],
          tasks: [
            for(String task in exercise["tasks"]) task
          ],
          links: [
            for(String link in exercise["links"]) link
          ]
        )
      );
    }

    return exercisesData;  
  }
}