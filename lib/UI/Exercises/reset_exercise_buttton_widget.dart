import 'package:flutter/material.dart';
import 'package:jak_sie_masz/Styles/styles.dart';
import 'package:jak_sie_masz/UI/Exercises/viewmodels/reset_exercise_button_viewmodel.dart';

class ResetExerciseButtton extends StatelessWidget {
  final ResetExerciseButtonViewmodel viewmodel;
  final int exerciseID;
  final int tasksCount;

  const ResetExerciseButtton({super.key, required this.viewmodel, required this.exerciseID, required this.tasksCount});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        await viewmodel.uncheckCheckboxes(exerciseID, tasksCount);
      },
      style: ButtonStyle(
        alignment: Alignment.center,
        backgroundColor: WidgetStatePropertyAll(Styles.primaryColor100),
        padding: WidgetStatePropertyAll(EdgeInsets.zero),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            side: BorderSide(
              color: Styles.primaryColor500,
              width: 1,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
        ),
        minimumSize: WidgetStatePropertyAll(
          Size(20, 20),
        )
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 32,
          vertical: 4,
        ),
        child: Text(
          "zacznij od nowa",
          style: TextStyle(
            fontFamily: Styles.fontFamily,
            color: Styles.primaryColor500,
            fontSize: 16,
            fontWeight: FontWeight.w300,
          ),
        ),
      ) 
    );
  }
}