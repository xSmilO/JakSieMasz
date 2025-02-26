import 'package:flutter/material.dart';
import 'package:jak_sie_masz/UI/Exercises/viewmodels/exercises_viewmodel.dart';
import 'package:provider/provider.dart';

class ExercisesDetailsScreen extends StatelessWidget {
  const ExercisesDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Szczegóły ćwiczenia"),
      ),
      body: Consumer<ExercisesViewModel>(
        builder: (context, viewModel, child) {
          final exercise = viewModel.selectedExercise;

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  exercise.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  textAlign: TextAlign.center,
                  exercise.description,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                Container(
                  width: 200,
                  height: 200,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Image.asset(exercise.image),
                  ),
                ),
                Text(
                  textAlign: TextAlign.center,
                  exercise.link,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
