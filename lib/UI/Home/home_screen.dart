import 'package:flutter/material.dart';
import 'package:jak_sie_masz/UI/Shared/widgets/navigation_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Center(
        child: Text("Hello World"),
      ),
      bottomNavigationBar: NavigationWidget(),
    );
  }
}
