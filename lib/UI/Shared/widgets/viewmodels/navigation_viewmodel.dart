import 'package:flutter/material.dart';
import 'package:jak_sie_masz/Data/navigation_service.dart';

class NavigationViewmodel extends ChangeNotifier {
  NavigationViewmodel(NavigationService navigationService)
      : _navigationService = navigationService;

  int selectedPageIdx = 2;
  NavigationService _navigationService;

  void setPageIdx(int idx) {
    _navigationService.setPage(idx);
    selectedPageIdx = _navigationService.selectedPageIdx;
    print("page idx ${idx}");
    notifyListeners();
  }
}
