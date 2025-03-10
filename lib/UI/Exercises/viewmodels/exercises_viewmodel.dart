import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:jak_sie_masz/UI/Exercises/data/exercises_data_setup.dart';

class ExercisesViewModel extends ChangeNotifier {
  List<ExercisesDataSetup> _exercises = [];
  ExercisesDataSetup _selectedExercise = ExercisesDataSetup(
      id: -1,
      title: "",
      image: "",
      description: "",
      task_text: "",
      tasks: [],
      link_text: "",
      link_1: "",
      link_2: "");
  Map<String, List<bool>> tasksCompletion = {};

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
    String jsonString = await rootBundle
        .loadString('lib/UI/Exercises/data/exercises_data.json');
    Map<String, dynamic> jsonData;

    if (jsonString.trim().isEmpty) {
      jsonData = {};
    } else {
      jsonData = json.decode(jsonString);
    }
    List<ExercisesDataSetup> exercisesList = [];
    var entriesList = jsonData.entries;

    entriesList.forEach((entry) {
      exercisesList.add(ExercisesDataSetup.fromJson(entry.key, entry.value));
    });
    _exercises = exercisesList;

    if (_exercises.isEmpty) {
      _isEmpty = true;
    } else {
      _isEmpty = false;
    }
    _isLoading = false;
    notifyListeners();
  }

  void selectExercise(String title) {
    _selectedExercise = exercisesList.firstWhere((e) => e.title == title);
    tasksCompletion[title] = List.filled(selectedExercise.tasks.length, false);
    notifyListeners();
  }
}
