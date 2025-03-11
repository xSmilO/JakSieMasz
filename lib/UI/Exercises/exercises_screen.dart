import 'package:flutter/material.dart';
import 'package:jak_sie_masz/Data/exercise_data_model.dart';
import 'package:jak_sie_masz/Data/exercise_progress_repository.dart';
import 'package:jak_sie_masz/Styles/styles.dart';
import 'package:jak_sie_masz/UI/Exercises/exercise_card_widget.dart';
import 'package:jak_sie_masz/UI/Exercises/viewmodels/exercises_viewmodel.dart';
import 'package:provider/provider.dart';
import 'exercise_details_screen.dart';

class ExercisesScreen extends StatelessWidget {
  const ExercisesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ExercisesViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.isLoading == true) {
          return Center(
            child: CircularProgressIndicator(
              color: Styles.primaryColor500,
            ),
          );
        }
        if (viewModel.isEmpty == true) {
          return const Center(
            child: Text("Brak ćwiczeń do wyświetlenia"),
          );
        }

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 54),
            child: Column(
              spacing: 32,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Ćwiczenia",
                  style: TextStyle(
                    fontFamily: Styles.fontFamily,
                    fontWeight: FontWeight.bold,
                    fontSize: Styles.fontSizeH1,
                    decoration: TextDecoration.none,
                    color: Styles.primaryColor500,
                  ),
                ),
                Column(
                    spacing: 16,
                    children: List.generate(
                      viewModel.exercisesList.length,
                      (index) {
                        ExerciseDataModel exercise =
                            viewModel.exercisesList[index];
                        return GestureDetector(
                          onTap: () {
                            viewModel.selectExercise(exercise.title);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ExercisesDetailsScreen(
                                  repository: ExerciseProgressRepository(),
                                ),
                              ),
                            );
                          },
                          child: ExerciseCardWidget(exercise: exercise),
                        );
                      },
                    )),
              ],
            ),
          ),
        );
      },
    );
  }
}
