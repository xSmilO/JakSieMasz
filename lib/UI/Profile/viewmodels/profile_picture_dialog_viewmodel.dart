import 'package:flutter/material.dart';

class ProfilePictureDialogViewmodel extends ChangeNotifier {
  int _selectedIdx = 0;

  int get selectedIdx => _selectedIdx;

  void setSelectedIdx(int idx) {
    if (idx == _selectedIdx) return;
    _selectedIdx = idx;
    notifyListeners();
  }
}
