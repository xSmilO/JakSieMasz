import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:jak_sie_masz/UI/Exercises/data/exercises_data_setup.dart';

class ExercisesViewModel extends ChangeNotifier {
  List<ExercisesDataSetup> _exercises = [];
  ExercisesDataSetup _selectedExercise = ExercisesDataSetup(title: "", image: "", description: "", task_text: "", tasks: [], link_text: "", link_1: "", link_2: "");

  bool _isLoading = true;
  bool _isEmpty = false;

  List<ExercisesDataSetup> get exercisesList => _exercises;
  ExercisesDataSetup get selectedExercise => _selectedExercise;
  bool get isLoading => _isLoading;
  bool get isEmpty => _isEmpty;

  ExercisesViewModel() {
    loadExercises();
  }
  Future<void> loadExercises() async {
    String jsonString = await rootBundle.loadString('lib/UI/Exercises/data/exercises_data.json');
    Map<String, dynamic> jsonData;

    if (jsonString.trim().isEmpty) {
      jsonData = {};
    } 
    else {
      jsonData = json.decode(jsonString);
    }
    List<ExercisesDataSetup> exercisesList = [];
    var entriesList = jsonData.entries;

    entriesList.forEach((entry) {
      exercisesList.add(ExercisesDataSetup.fromJson(entry.value));
    });
    _exercises = exercisesList;

    if (_exercises.isEmpty) {
      _isEmpty = true;
    }
    else { 
      _isEmpty = false;
    }
    _isLoading = false;
    notifyListeners();
  }

  void selectExercise(String title) {
    for (var exercise in _exercises) {
      if (exercise.title == title) {
        _selectedExercise = exercise;
        notifyListeners();
        return;
      }
    }
    _selectedExercise = ExercisesDataSetup(title: "Not found", image: "Not found", description: "Not found", task_text: "Not found", tasks: [], link_text: "Not found", link_1: "Not found", link_2: "Not found");
    notifyListeners();
  }
}