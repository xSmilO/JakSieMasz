import 'package:flutter/material.dart';
import 'package:jak_sie_masz/Styles/styles.dart';
import 'package:jak_sie_masz/UI/Exercises/viewmodels/reset_exercise_button_viewmodel.dart';

class ResetExerciseButtton extends StatelessWidget {
  final ResetExerciseButtonViewmodel viewmodel;
  final int exerciseID;
  final int tasksCount;

  const ResetExerciseButtton(
      {super.key,
      required this.viewmodel,
      required this.exerciseID,
      required this.tasksCount});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () async {
          await viewmodel.uncheckCheckboxes(exerciseID, tasksCount);
        },
        style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Styles.secondaryColor100),
            padding: WidgetStatePropertyAll(EdgeInsets.zero),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                side: BorderSide(
                  color: Styles.secondaryColor500,
                  width: 1,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(32),
                ),
              ),
            ),
            minimumSize: WidgetStatePropertyAll(
              Size(10, 10),
            )),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 12,
          ),
          child: Text(
            "zacznij od nowa",
            style: TextStyle(
              fontFamily: Styles.fontFamily,
              color: Styles.secondaryColor500,
              fontSize: Styles.fontSizeP,
              fontWeight: FontWeight.w500,
            ),
          ),
        ));
  }
}
