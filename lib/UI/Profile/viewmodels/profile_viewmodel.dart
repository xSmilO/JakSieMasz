import 'package:flutter/material.dart';
import 'package:jak_sie_masz/Data/services/notification_service.dart';
import 'package:jak_sie_masz/Data/services/shared_preferences_service.dart';
import 'package:jak_sie_masz/Data/repositories/user_repository.dart';

class ProfileViewmodel extends ChangeNotifier {
  String _username = "";
  String _avatarPath = "";
  String _ipAddr = "";
  String _aiName = "";
  TimeOfDay? _selectedTime;
  final UserRepository _userRepository;
  final SharedPreferencesService spService;

  ProfileViewmodel(UserRepository repo, this.spService)
      : _userRepository = repo {
    _username = repo.username;
    _avatarPath = repo.avatarPath;
    repo.onUsernameChange = (String newUsername) {
      _username = newUsername;
      notifyListeners();
    };

    repo.onAvatarChange = (String path) {
      _avatarPath = path;
      notifyListeners();
    };

    _loadSavedTime();
    _loadData();
  }

  String get username => _username;

  String get avatarPath => _avatarPath;

  String get ipAddr => _ipAddr;

  String get aiName => _aiName;

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

  Future<void> _loadData() async {
    _ipAddr = await spService.fetchString("ip_addr") as String;
    _aiName = await spService.fetchString("ai_name") as String;
    notifyListeners();
  }

  void changeName(String newName) {
    if (newName == "") return;
    _userRepository.setUsername(newName);
    _username = _userRepository.username;
    notifyListeners();
  }

  Future<void> changeIpAddr(String addr) async {
    // print("new addr $addr");
    await spService.saveString("ip_addr", addr);
    _ipAddr = addr;
    notifyListeners();
  }

  Future<void> changeAiName(String name) async {
    await spService.saveString("ai_name", name);
    _aiName = name;
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
