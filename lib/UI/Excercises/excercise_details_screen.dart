import 'package:flutter/material.dart';
import 'package:jak_sie_masz/UI/Excercises/viewmodels/excercises_viewmodel.dart';
import 'package:provider/provider.dart';

class ExcerciseDetailsScreen extends StatelessWidget {
  const ExcerciseDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Szczegóły ćwiczenia"),
      ),
      body: Consumer<ExcercisesViewModel>(
        builder: (context, viewModel, child) {
          return Center(
            child: Text(
              'Numer ćwiczenia: ${viewModel.excerciseNumber}',
              style: const TextStyle(fontSize: 20),
            ),
          );
        },
      ),
    );
  }
}