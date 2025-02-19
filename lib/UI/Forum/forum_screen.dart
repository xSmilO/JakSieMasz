import 'package:flutter/material.dart';
import 'package:jak_sie_masz/UI/Shared/widgets/navigation_widget.dart';

class ForumScreen extends StatelessWidget {
  const ForumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forum"),
      ),
      body: Center(
        child: Text("Feature is in development. Stay tuned!"),
      ),
      bottomNavigationBar: NavigationWidget(),
    );
  }
}
