import 'dart:convert';
import 'dart:io';

import 'package:jak_sie_masz/UI/Shared/utility.dart';
import 'package:path_provider/path_provider.dart';

class ExerciseProgressRepository {
  const ExerciseProgressRepository();

  Future<String> get _localPath async {
    return (await getApplicationDocumentsDirectory()).path;
  }

  Future<File> get _exercisesProgressFile async {
    File file = File('${await _localPath}/exercises_progress.json');

    if (!await file.exists()) {
      file.create();
    }

    return file;
  }

  Future<List<dynamic>> get _exercisesProgress async {
    File exercisesProgressFile = await _exercisesProgressFile;

    try {
      return json.decode(await exercisesProgressFile.readAsString());
    } catch (error) {
      return [];
    }
  }

  Map<String, dynamic> _resolveEmptyExerciseStructure(int exerciseID, int tasksCount) {
    return {
      "id": exerciseID,
      "tasks": [
        for (int i = 0; i < tasksCount; i++)
          {"id": i, "recorded_checkbox_values": {}}
      ]
    };
  }

  Future<void> _reserveSpace(List<dynamic> exercisesProgress, int exerciseID, int tasksCount) async {
    File exercisesProgressFile = await _exercisesProgressFile;

    exercisesProgress.add(_resolveEmptyExerciseStructure(exerciseID, tasksCount));
    exercisesProgressFile.writeAsString(json.encode(exercisesProgress));
  }

  Future<Map<String, dynamic>> _resolveRecordedCheckboxValues(List<dynamic> exercisesProgress, int exerciseID, int taskID) async {
    for(Map<String, dynamic> exercise in exercisesProgress) {
      if(exercise["id"] == exerciseID) {
        for(Map<String, dynamic> task in exercise["tasks"]) {
          if(task["id"] == taskID) {
            return task["recorded_checkbox_values"];
          }
        }
      }
    }

    return {};
  }

  void reserveSpace(int exerciseID, int tasksCount) async {
    List<dynamic> exercisesProgress = await _exercisesProgress;

    if(exercisesProgress.isEmpty) {
      await _reserveSpace(exercisesProgress, exerciseID, tasksCount);
    } else {
      bool found = false;

      for(Map<String, dynamic> exercise in exercisesProgress) {
        if(exercise["id"] == exerciseID) {
          found = true;
          break;
        }
      }

      if(!found) {
        await _reserveSpace(exercisesProgress, exerciseID, tasksCount);
      }
    }
  }

  Future<bool?> getCheckboxState(int exerciseID, int taskID) async {
    String currentDate = Utility.currentDateWithoutTime();
    Map<String, dynamic> recordedCheckboxValues = await _resolveRecordedCheckboxValues(await _exercisesProgress, exerciseID, taskID);

    if(recordedCheckboxValues.keys.contains(currentDate)) {
      return recordedCheckboxValues[currentDate];
    }

    return false;
  }

  Future<void> setCheckboxState(int exerciseID, int taskID, bool? state) async {
    String currentDate = Utility.currentDateWithoutTime();
    File exercisesProgressFile = await _exercisesProgressFile;
    List<dynamic> exercisesProgress = await _exercisesProgress;
    Map<String, dynamic> recordedCheckboxValues = await _resolveRecordedCheckboxValues(exercisesProgress, exerciseID, taskID);
    recordedCheckboxValues[currentDate] = state == null ? false : state;

    exercisesProgressFile.writeAsString(json.encode(exercisesProgress));
  }

  Future<void> eraseProgress(int exerciseID, int tasksCount) async {
    File exercisesProgressFile = await _exercisesProgressFile;
    List<dynamic> exercisesProgress = await _exercisesProgress;

    for(Map<String, dynamic> exercise in exercisesProgress) {
      if(exercise["id"] == exerciseID) {
        print("resetting for exercise: " + exerciseID.toString());
        exercise = _resolveEmptyExerciseStructure(exerciseID, tasksCount);
      }
    }

    exercisesProgressFile.writeAsString(json.encode(exercisesProgress));
  }
}
