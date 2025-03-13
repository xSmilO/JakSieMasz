import 'package:flutter/material.dart';
import 'package:jak_sie_masz/Data/models/exercise_data_model.dart';
import 'package:jak_sie_masz/Styles/styles.dart';

class ExerciseCardWidget extends StatelessWidget {
  const ExerciseCardWidget({super.key, required this.exercise});
  final ExerciseDataModel exercise;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 172,
      decoration: BoxDecoration(
        color: Styles.primaryColor500,
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            exercise.pathToImage,
            fit: BoxFit.cover,
            color: Styles.primaryColor500.withAlpha(178),
            colorBlendMode: BlendMode.srcOver,
          ),
          Center(
            child: Text(
              exercise.title,
              style: TextStyle(
                color: Colors.white,
                fontFamily: Styles.fontFamily,
                fontSize: Styles.fontSizeH2,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
