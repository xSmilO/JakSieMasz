import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:jak_sie_masz/Data/notification_service.dart';
import 'package:jak_sie_masz/Data/user_repository.dart';

class ProfileViewModel extends ChangeNotifier {
  //todo save hour and minute on notification in device
  String _username = "";
  TimeOfDay? _selectedTime;
  final UserRepository _userRepository;
  ProfileViewModel(UserRepository repo) : _userRepository = repo {
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

  void changeName(String newName) {
    if (newName == "") return;
    _userRepository.setUsername(newName);
    _username = _userRepository.username;
    notifyListeners();
  }

  Future<void> _loadSavedTime() async {}

  Future<void> setNotificaion(TimeOfDay time) async {
    _selectedTime = time;

    NotificationService().cancelAllNotifications();
    NotificationService().scheduleNotification(
      title: "Jak ci leci dzień ?",
      body: "Nie krępuj się i oceń swój dzień",
      hour: time.hour,
      minute: time.minute,
    );
    notifyListeners();
  }

  void showNotification() {
    NotificationService().showNotification(title: "Siema", body: "wypiedalaj");
  }

  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();
}
