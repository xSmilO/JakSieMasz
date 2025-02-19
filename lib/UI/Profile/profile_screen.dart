import 'package:flutter/material.dart';
import 'package:jak_sie_masz/UI/Profile/profile_viewmodel.dart';
import 'package:jak_sie_masz/UI/Shared/widgets/navigation_widget.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.viewModel});
  final ProfileViewModel viewModel;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String formData = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profil uzytkownika"),
      ),
      body: Center(
        // child: Text("profil."),
        child: Column(
          children: [
            Consumer<ProfileViewModel>(builder: (context, profile, child) {
              return Text("Nick: ${profile.username}");
            }),
            FormField<String>(
              builder: (state) {
                return SizedBox(
                  width: 300,
                  child: TextFormField(
                    decoration: InputDecoration(hintText: "nick"),
                    onChanged: (value) {
                      formData = value;
                      print(formData);
                    },
                  ),
                );
              },
            ),
            TextButton(
              child: Text("Zmien nick"),
              onPressed: () => widget.viewModel.changeName(formData),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationWidget(),
    );
  }
}
