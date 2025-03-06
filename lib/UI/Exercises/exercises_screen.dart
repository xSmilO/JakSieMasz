import 'package:flutter/material.dart';
import 'package:jak_sie_masz/Styles/styles.dart';
import 'package:jak_sie_masz/UI/Exercises/viewmodels/exercises_viewmodel.dart';
import 'package:provider/provider.dart';
import 'exercise_details_screen.dart';

class ExercisesScreen extends StatelessWidget {
  const ExercisesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ćwiczenia poprawiające samopoczucie oraz nastrój"),
      ),
      body: Consumer<ExercisesViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading == true) {
            return const Center(
              child: CircularProgressIndicator()
            );
          }
          if (viewModel.isEmpty == true) {
            return const Center(
              child: Text("Brak ćwiczeń do wyświetlenia")
            );
          }

          return Padding(
            padding: const EdgeInsets.all(7.5),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 1,
              ),
              itemCount: viewModel.exercisesList.length,
              itemBuilder: (context, index) {
                var exercise = viewModel.exercisesList[index];

                return GestureDetector(
                  onTap: () {
                    viewModel.selectExercise(exercise.title);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ExercisesDetailsScreen()
                      ),
                    );
                  },
                  child: Card(
                    color: Styles.primaryColor500,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        exercise.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
