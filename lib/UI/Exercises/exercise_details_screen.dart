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

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              child: Center(
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
                    const SizedBox(height: 10),
                    Container(
                      width: 200,
                      height: 200,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Image.asset(exercise.image),
                      ),
                    ),
                    Text(
                      textAlign: TextAlign.center,
                      exercise.description,
                      style: const TextStyle(fontSize: 18),
                    ),
                    Text(
                      textAlign: TextAlign.center,
                      exercise.task_text,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                    Column(
                      children: List.generate(
                        exercise.tasks.length,
                        (index) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 25.0, right: 11.5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              
                              children: [
                                Expanded(
                                  child: Text(
                                    exercise.tasks[index],
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ),
                                Checkbox(
                                  value: false,
                                  onChanged: (bool? value) {},
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20), 
                    Text(
                      textAlign: TextAlign.center,
                      exercise.link_text,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      textAlign: TextAlign.center,
                      exercise.link_1,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.blue,
                      ),
                    ),
                    Text(
                      textAlign: TextAlign.center,
                      exercise.link_2,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}