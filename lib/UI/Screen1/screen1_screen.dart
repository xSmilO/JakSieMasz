import 'package:flutter/material.dart';
import 'package:jak_sie_masz/UI/Shared/widgets/navigation_widget.dart';

class Screen1Screen extends StatelessWidget {
  const Screen1Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Screen1"),
      ),
      body: Center(
        child: Text("Welcome in the Screen1 wariacie!"),
      ),
      bottomNavigationBar: NavigationWidget(),
    );
  }
}
