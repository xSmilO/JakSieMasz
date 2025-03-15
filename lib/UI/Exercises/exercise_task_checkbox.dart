import 'package:flutter/material.dart';
import 'package:jak_sie_masz/Styles/styles.dart';
import 'package:jak_sie_masz/UI/Exercises/viewmodels/exercise_task_checkbox_viewmodel.dart';

class ExerciseTaskCheckbox extends StatefulWidget {
  final ExerciseTaskCheckboxViewmodel viewmodel;

  const ExerciseTaskCheckbox({super.key, required this.viewmodel});

  @override
  State<StatefulWidget> createState() {
    return ExerciseTaskCheckboxState(viewmodel: viewmodel);
  }
}

class ExerciseTaskCheckboxState extends State {
  final ExerciseTaskCheckboxViewmodel viewmodel;
  bool? isChecked = false;

  ExerciseTaskCheckboxState({required this.viewmodel});

  void uncheck() {
    setState(() {
      isChecked = false;
    });
  }

  @override
  void initState() {
    super.initState();

    viewmodel.repository.getCheckboxState(viewmodel.exerciseID, viewmodel.taskID).then((value) {
      setState(() {
        isChecked = value;
      });
    });

    viewmodel.bindState(this);
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: isChecked,
      activeColor: Styles.primaryColor500,
      onChanged: (bool? value) async {
        await viewmodel.updateState(value);
        setState(() {
          isChecked = value;
        });
      },
    );
  }
}
