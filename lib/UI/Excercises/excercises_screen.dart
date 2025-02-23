import 'package:flutter/material.dart';
import 'package:jak_sie_masz/UI/Excercises/viewmodels/excercises_viewmodel.dart';
import 'package:provider/provider.dart';
import 'excercise_details_screen.dart';
import 'viewmodels/excercises_viewmodel.dart';

class ExcercisesScreen extends StatelessWidget {
  const ExcercisesScreen({super.key});
  final int containersCount = 6;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ćwiczenia"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(7.5),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 1,
          ),
          itemCount: containersCount,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Provider.of<ExcercisesViewModel>(context, listen: false)
                  .setExcerciseNumber(index + 1);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ExcerciseDetailsScreen(),
                  ),
                );
              },
              child: Card(
                color: Colors.greenAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    'Ćwiczenie ${index + 1}',
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}