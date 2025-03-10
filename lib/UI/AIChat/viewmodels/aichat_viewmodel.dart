import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class Message {
  final String text;
  final bool isBot;
  Message(this.text, this.isBot);
}

class Topic {
  final String text;
  final DateTime timestamp;

  Topic(this.text, this.timestamp);
}

class AIChatViewModel extends ChangeNotifier {
  final List<Message> messages = [];
  final List<Topic> recentTopics = [
    Topic("Jak radzić sobie ze stresem?",
        DateTime.now().subtract(const Duration(hours: 2))),
    Topic("Techniki relaksacji",
        DateTime.now().subtract(const Duration(hours: 5))),
    Topic("Zdrowe nawyki życiowe",
        DateTime.now().subtract(const Duration(days: 2))),
    Topic("Medytacja dla początkujących",
        DateTime.now().subtract(const Duration(days: 3))),
    Topic(
        "Zarządzanie czasem", DateTime.now().subtract(const Duration(days: 5))),
    Topic(
        "Sztuka komunikacji", DateTime.now().subtract(const Duration(days: 8))),
    Topic("Rozwój osobisty", DateTime.now().subtract(const Duration(days: 15))),
    Topic(
        "Work-life balance", DateTime.now().subtract(const Duration(days: 25))),
  ];

  bool isTyping = false;
  bool isDrawerOpen = false;
  static IO.Socket? _socket;

  List<Topic> get todayTopics => recentTopics
      .where((topic) => topic.timestamp
          .isAfter(DateTime.now().subtract(const Duration(days: 1))))
      .toList();

  List<Topic> get lastWeekTopics => recentTopics
      .where((topic) =>
          topic.timestamp
              .isAfter(DateTime.now().subtract(const Duration(days: 7))) &&
          topic.timestamp
              .isBefore(DateTime.now().subtract(const Duration(days: 1))))
      .toList();

  List<Topic> get lastMonthTopics => recentTopics
      .where((topic) =>
          topic.timestamp
              .isAfter(DateTime.now().subtract(const Duration(days: 30))) &&
          topic.timestamp
              .isBefore(DateTime.now().subtract(const Duration(days: 7))))
      .toList();

  void connectToServer() {
    if (_socket != null) {
      if (!_socket!.connected) {
        _socket!.connect();
      }
      setupSocketListeners();
      return;
    }

    _socket = IO.io('http://10.0.2.2:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });

    setupSocketListeners();
  }

  void setupSocketListeners() {
    _socket!.onConnect((_) {
      print('Connected to server');
    });

    _socket!.on('botStartedTyping', (_) {
      isTyping = true;
      notifyListeners();
    });

    _socket!.on('botStoppedTyping', (_) {
      isTyping = false;
      notifyListeners();
    });

    _socket!.onConnectError((data) {
      print('Connection Error: $data');
    });

    _socket!.on('error', (data) {
      print('Socket Error: $data');
    });

    _socket!.on('receiveMessage', (data) {
      print('Received message from server: $data');
      messages.add(Message(data['text'], data['isBot']));
      notifyListeners();
    });
  }

  void sendMessage(String message) {
    if (message.isNotEmpty) {
      messages.add(Message(message, false));
      _socket?.emit('sendMessage', message);
      notifyListeners();
    }
  }

  void toggleDrawer() {
    isDrawerOpen = !isDrawerOpen;
    notifyListeners();
  }

  @override
  void dispose() {
    _socket?.disconnect();
    _socket?.dispose();
    super.dispose();
  }
}
