import 'package:jak_sie_masz/Data/repositories/exercise_progress_repository.dart';
import 'package:jak_sie_masz/UI/Exercises/exercise_task_checkbox.dart';
import 'package:jak_sie_masz/UI/Shared/utility.dart';

class ResetExerciseButtonViewmodel {
  final ExerciseProgressRepository repository;
  final List<ExerciseTaskCheckbox> checkboxes;

  ResetExerciseButtonViewmodel(
      {required this.repository, required this.checkboxes});

  Future<void> uncheckCheckboxes(int exerciseID, int tasksCount) async {
    for (ExerciseTaskCheckbox checkbox in checkboxes) {
      checkbox.viewmodel.uncheck();
    }

    await repository.eraseProgress(exerciseID, tasksCount);

    Utility.showSimpleOutput("Możesz zaczynać od początku, powodzenia! 😉");
  }
}
