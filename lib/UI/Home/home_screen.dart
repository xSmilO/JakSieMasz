import 'package:flutter/material.dart';
import 'package:jak_sie_masz/UI/Profile/profile_viewmodel.dart';
import 'package:jak_sie_masz/UI/Shared/widgets/navigation_widget.dart';
import 'package:provider/provider.dart';

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
        child: Consumer<ProfileViewModel>(builder: (context, profile, child) {
          return Text("Witaj ${profile.username}");
        }),
      ),
      bottomNavigationBar: NavigationWidget(),
    );
  }
}
