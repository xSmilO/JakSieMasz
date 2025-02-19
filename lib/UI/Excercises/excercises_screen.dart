import 'package:flutter/material.dart';
import 'package:jak_sie_masz/UI/Shared/widgets/navigation_widget.dart';

class ExcercisesScreen extends StatefulWidget {
  const ExcercisesScreen({super.key});

  @override
  State<ExcercisesScreen> createState() => _ExcercisesScreenState();
}

class _ExcercisesScreenState extends State<ExcercisesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ćwiczenia"),
      ),
      body: Center(
        child: Text("Tutaj są ćwiczenia, normalnie jest gitara"),
      ),
      bottomNavigationBar: NavigationWidget(),
    );
  }
}
