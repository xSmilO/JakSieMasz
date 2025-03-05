import 'package:flutter/material.dart';
import 'package:jak_sie_masz/Styles/styles.dart';

class ForumScreen extends StatelessWidget {
  const ForumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Niestety musimy ciebie zasmucić, ale forum jest w budowli 👷‍♀️",
        style: TextStyle(
          fontFamily: Styles.fontFamily,
          fontWeight: FontWeight.normal,
          fontSize: Styles.fontSizeH2,
          decoration: TextDecoration.none,
          color: Styles.fontColorDark,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
