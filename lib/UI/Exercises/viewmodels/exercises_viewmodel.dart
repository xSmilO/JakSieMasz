import 'package:flutter/material.dart';
import 'package:jak_sie_masz/Data/models/exercise_data_model.dart';
import 'package:jak_sie_masz/Data/repositories/exercise_data_repository.dart';

class ExercisesViewModel extends ChangeNotifier {
  final ExerciseDataRepository repository;

  List<ExerciseDataModel> _exercises = [];
  ExerciseDataModel _selectedExercise = ExerciseDataModel.empty;
  bool _isLoading = true;

  List<ExerciseDataModel> get exercisesList => _exercises;
  ExerciseDataModel get selectedExercise => _selectedExercise;
  bool get isLoading => _isLoading;
  bool get isEmpty => _exercises.isEmpty;

  ExercisesViewModel({required this.repository}) {
    repository.getExercisesData().then((exercises) {
      _exercises = exercises;
      _isLoading = false;

      notifyListeners();
    });
  }

  void selectExercise(int id) {
    _selectedExercise = exercisesList.firstWhere((e) => e.id == id);
    notifyListeners();
  }
}
