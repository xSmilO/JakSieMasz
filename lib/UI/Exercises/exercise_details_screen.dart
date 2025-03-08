import 'package:flutter/material.dart';
import 'package:jak_sie_masz/Styles/styles.dart';
import 'package:jak_sie_masz/UI/Exercises/viewmodels/exercises_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ExercisesDetailsScreen extends StatelessWidget {
  const ExercisesDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Szczegóły ćwiczenia"),
        backgroundColor: Styles.primaryColor500,
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
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        textAlign: TextAlign.center,
                        exercise.task_text,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Column(
                      children: List.generate(
                        exercise.tasks.length,
                        (index) {
                        bool isChecked = viewModel.tasksCompletion[exercise.title]?[index] ?? false;
                          return Padding(
                            padding: const EdgeInsets.only(left: 25.0, right: 11.5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Checkbox(
                                  value: isChecked,
                                  onChanged: (bool? value) {
                                    viewModel.tasksCompletion[exercise.title]![index] = value!;
                                    viewModel.notifyListeners();
                                  },
                                  activeColor: Colors.green,
                                  checkColor: Colors.white,
                                ),
                                Expanded(
                                  child: Text(
                                    exercise.tasks[index],
                                    style: TextStyle(
                                    fontSize: 12,
                                    color: isChecked ? Colors.black : Colors.grey,
                                    fontWeight: isChecked ? FontWeight.bold : FontWeight.normal,
                                    ),
                                  softWrap: true,
                                  overflow: TextOverflow.visible,
                                   ),
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
                    Padding(
                      padding: const EdgeInsets.only(top: 2.5), // Odstęp 10px od góry
                      child: InkWell(
                        onTap: () async {
                          final Uri url = Uri.parse(exercise.link_1);
                          if (await canLaunchUrl(url)) {
                            await launchUrl(url); // Otwórz link
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                        child: Text(
                          textAlign: TextAlign.center,
                          exercise.link_1,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.blue,
                            decoration: TextDecoration.underline, // Używamy podkreślenia, aby zaznaczyć link
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 2.5), // Odstęp 10px od góry
                      child: InkWell(
                        onTap: () async {
                          final Uri url = Uri.parse(exercise.link_2);
                          if (await canLaunchUrl(url)) {
                            await launchUrl(url); // Otwórz link
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                        child: Text(
                          textAlign: TextAlign.center,
                          exercise.link_2,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.blue,
                            decoration: TextDecoration.underline, // Używamy podkreślenia, aby zaznaczyć link
                          ),
                        ),
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
