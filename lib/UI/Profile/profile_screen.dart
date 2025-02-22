import 'package:flutter/material.dart';
import 'package:jak_sie_masz/UI/Profile/viewmodels/profile_viewmodel.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, required this.viewModel});
  final ProfileViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    String formData = "";
    return Scaffold(
      appBar: AppBar(
        title: Text("Profil uzytkownika"),
      ),
      body: Center(
        child: Column(
          children: [
            Consumer<ProfileViewModel>(builder: (context, profile, child) {
              return Text("Nick: ${profile.username}");
            }),
            FormField<String>(
              builder: (state) {
                return SizedBox(
                  width: 400,
                  child: TextFormField(
                    decoration: InputDecoration(hintText: "nick"),
                    onChanged: (value) {
                      formData = value;
                    },
                  ),
                );
              },
            ),
            TextButton(
              child: Text("Kliknij mnie!"),
              onPressed: () => viewModel.changeName(formData),
            ),
          ],
        ),
      ),
    );
  }
}
