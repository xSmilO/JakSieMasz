import 'package:flutter/material.dart';
import 'package:jak_sie_masz/Styles/styles.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Styles.primaryColor500,
      child: Center(
        child: Text("Siema"),
      ),
    );
  }
}
