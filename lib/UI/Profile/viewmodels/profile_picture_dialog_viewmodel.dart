import 'package:flutter/material.dart';
import 'package:jak_sie_masz/Data/repositories/user_repository.dart';

class ProfilePictureDialogViewmodel extends ChangeNotifier {
  UserRepository userRepository;

  ProfilePictureDialogViewmodel({required this.userRepository});
  int _selectedIdx = 0;

  int get selectedIdx => _selectedIdx;

  void setSelectedIdx(int idx) {
    if (idx == _selectedIdx) return;
    _selectedIdx = idx;
    notifyListeners();
  }

  void setAvatar(String path) {
    userRepository.setAvatarPath(path);
  }
}
