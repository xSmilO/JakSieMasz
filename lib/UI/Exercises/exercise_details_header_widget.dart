import 'package:flutter/material.dart';
import 'package:jak_sie_masz/Styles/styles.dart';

class ExerciseDetailsHeaderWidget extends StatelessWidget {
  final String title;
  const ExerciseDetailsHeaderWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Styles.primaryColor500,
            fontFamily: Styles.fontFamily,
            fontWeight: FontWeight.bold,
            fontSize: Styles.fontSizeH2,
            decoration: TextDecoration.none,
          ),
        ),
        Container(
          color: Color(0xFFD9D9D9),
          height: 1,
        )
      ],
    );
  }
}
