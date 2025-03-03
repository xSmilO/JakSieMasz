import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:jak_sie_masz/Data/notification_repository.dart';
import 'package:jak_sie_masz/Data/user_repository.dart';

class ProfileViewModel extends ChangeNotifier {
  String _username = "";
  TimeOfDay? _selectedTime;
  final UserRepository _userRepository;
  final NotificationRepository _notificationRepository =
      NotificationRepository();

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

  Future<void> _loadSavedTime() async {
    final savedTime = await _notificationRepository.getNotificationTime();

    if (savedTime != null) {
      _selectedTime =
          TimeOfDay(hour: savedTime['hour']!, minute: savedTime['minute']!);

      notifyListeners();
    }
  }

  Future<void> setNotificaion(TimeOfDay time) async {
    _selectedTime = time;
    notifyListeners();

    await _notificationRepository.saveNotifiation(time.hour, time.minute);
    await _notificationRepository.scheduleNotification(time.hour, time.minute);
  }

  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotifications() async {
    print("init");
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings("@mipmap/ic_launcher");

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
      iOS: DarwinInitializationSettings(),
    );
  }

  Future<void> showTestNotification() async {
    print("Show kurwa!");
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'test_channel_id',
      "Test channel",
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails details = NotificationDetails(
      android: androidDetails,
      iOS: DarwinNotificationDetails(),
    );

    await _notificationsPlugin.show(
        0, "Test notification", "This is a test notification", details);
  }
}
