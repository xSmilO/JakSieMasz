import 'package:flutter/material.dart';
import 'package:jak_sie_masz/Data/services/notification_service.dart';
import 'package:jak_sie_masz/Data/services/shared_preferences_service.dart';
import 'package:jak_sie_masz/Data/repositories/user_repository.dart';

class ProfileViewModel extends ChangeNotifier {
  //todo add toast notifcation when user selects notification time
  String _username = "";
  TimeOfDay? _selectedTime;
  final UserRepository _userRepository;
  final SharedPreferencesService spService;
  ProfileViewModel(UserRepository repo, this.spService)
      : _userRepository = repo {
    _username = repo.username;
    repo.onUsernameChange = (String newUsername) {
      _username = newUsername;
      notifyListeners();
    };

    _loadSavedTime();
  }

  String get username {
    return _username;
  }

  TimeOfDay? get selectedTime => _selectedTime;

  Future<void> loadUserData() async {
    _username = _userRepository.username;
  }

  Future<void> _loadSavedTime() async {
    String? savedTime = await spService.fetchString("notification_time");

    if (savedTime == null) return;

    List<String> timeElements = savedTime.split(":");
    _selectedTime = TimeOfDay(
      hour: int.parse(timeElements[0]),
      minute: int.parse(
        timeElements[1],
      ),
    );

    notifyListeners();
  }

  void changeName(String newName) {
    if (newName == "") return;
    _userRepository.setUsername(newName);
    _username = _userRepository.username;
    notifyListeners();
  }

  Future<void> setNotificaion(TimeOfDay time) async {
    _selectedTime = time;

    NotificationService().cancelAllNotifications();
    NotificationService().scheduleNotification(
      title: "Jak ci leci dzień ?",
      body: "Nie krępuj się i oceń swój dzień 🤗",
      hour: time.hour,
      minute: time.minute,
    );

    String timeValueToSave = "${time.hour}:${time.minute}";

    await spService.saveString("notification_time", timeValueToSave);
    notifyListeners();
  }
}
