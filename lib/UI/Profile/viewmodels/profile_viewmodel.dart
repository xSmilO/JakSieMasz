import 'package:flutter/material.dart';
import 'package:jak_sie_masz/Data/user_repository.dart';

class ProfileViewModel extends ChangeNotifier {
  String _username = "";
  UserRepository userRepository;
  ProfileViewModel(UserRepository repo) : userRepository = repo {
    _username = repo.username;
    repo.onUsernameChange = (String newUsername) {
      _username = newUsername;
      notifyListeners();
    };
  }

  String get username {
    return _username;
  }

  void changeName(String newName) {
    if (newName == "") return;
    userRepository.setUsername(newName);
    _username = userRepository.username;
    notifyListeners();
  }
}
