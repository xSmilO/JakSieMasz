import 'package:jak_sie_masz/Data/repositories/exercise_progress_repository.dart';
import 'package:jak_sie_masz/UI/Exercises/exercise_task_checkbox.dart';

class ExerciseTaskCheckboxViewmodel {
  final ExerciseProgressRepository repository;
  final int exerciseID;
  final int taskID;
  ExerciseTaskCheckboxState? state = null;

  ExerciseTaskCheckboxViewmodel(
      {required this.repository,
      required this.exerciseID,
      required this.taskID});

  bool? get isChecked {
    return state?.isChecked;
  }

  Future<void> updateState(bool? state) async {
    await repository.setCheckboxState(exerciseID, taskID, state);
  }

  void bindState(ExerciseTaskCheckboxState state) {
    this.state = state;
  }

  void uncheck() {
    state?.uncheck();
  }
}
