import 'package:flutter/material.dart';
import '../models/message.dart';
import '../models/topic.dart';
import '../services/chat_service.dart';
import '../services/chat_database_service.dart';

class AIChatViewModel extends ChangeNotifier {
  final ChatService _chatService;
  final ChatDatabaseService _dbService;

  List<Message> messages = [];
  List<Topic> recentTopics = [];
  bool isTyping = false;
  bool isDrawerOpen = false;
  bool isConnected = false;
  int? currentTopicId;

  AIChatViewModel(this._chatService, this._dbService) {
    _setupChatServiceListeners();
  }

  void _setupChatServiceListeners() {
    _chatService.onMessageReceived = _handleNewMessage;
    _chatService.onTypingStarted = () {
      isTyping = true;
      notifyListeners();
    };
    _chatService.onTypingStopped = () {
      isTyping = false;
      notifyListeners();
    };
    _chatService.onConnected = () {
      isConnected = true;
      notifyListeners();
    };
    _chatService.onDisconnected = () {
      isConnected = false;
      notifyListeners();
    };
  }

  void _handleNewMessage(Message message) async {
    if (currentTopicId != null) {
      await _dbService.saveMessage(currentTopicId!, message.text, true);
    }
    messages.add(message);
    notifyListeners();
  }

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

  Future<String> _getContextFromMessages() async {
    if (currentTopicId == null) return '';

    final lastMessages = messages
        .sublist(
      messages.length > 10 ? messages.length - 10 : 0,
      messages.length,
    )
        .map((msg) {
      return "${msg.isBot ? 'Assistant' : 'User'}: ${msg.text}";
    }).join('\n');

    return lastMessages;
  }

  Future<void> sendMessage(String message) async {
    if (message.isNotEmpty) {
      try {
        if (currentTopicId == null) {
          currentTopicId = await _dbService.createTopic(message);
          recentTopics.insert(
              0, Topic(currentTopicId!, message, DateTime.now()));
          notifyListeners();
        }

        await _dbService.saveMessage(currentTopicId!, message, false);
        messages.add(Message(message, false));
        notifyListeners();

        final context = await _getContextFromMessages();
        _chatService.sendMessage(message, context: context);
      } catch (e) {
        print('Error in sendMessage: $e');
      }
    }
  }

  Future<void> loadChatHistory(int topicId) async {
    try {
      print('Loading chat history for topic: $topicId');
      currentTopicId = topicId;

      messages.clear();

      final topics = await _dbService.getTopics();
      final selectedTopic = topics.firstWhere((t) => t.id == topicId);
      print('Loading messages for topic: ${selectedTopic.text}');

      final chatMessages = await _dbService.getMessagesForTopic(topicId);
      print('Loaded ${chatMessages.length} messages from database');

      messages.addAll(chatMessages);

      isDrawerOpen = false;
      notifyListeners();
    } catch (e) {
      print('Error loading chat history: $e');
    }
  }

  Future<void> initialize() async {
    try {
      _chatService.connectToServer();
      await loadRecentTopics();
    } catch (e) {
      print('Error in initialize: $e');
    }
  }

  Future<void> changeServer() async {
    _chatService.changeServer();
  }

  Future<void> loadRecentTopics() async {
    try {
      recentTopics = await _dbService.getTopics();
      notifyListeners();
    } catch (e) {
      print('Error loading recent topics: $e');
    }
  }

  void toggleDrawer() {
    isDrawerOpen = !isDrawerOpen;
    notifyListeners();
  }

  void startNewChat() {
    currentTopicId = null;
    messages.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    _chatService.dispose();
    super.dispose();
  }
}
