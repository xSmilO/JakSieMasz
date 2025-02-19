import 'package:flutter/material.dart';
import 'package:jak_sie_masz/UI/Shared/widgets/navigation_widget.dart';

class AIChatScreen extends StatelessWidget {
  const AIChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AI chat"),
      ),
      body: Center(
        child: Text("Popiszemy sobie"),
      ),
      bottomNavigationBar: NavigationWidget(),
    );
  }
}
