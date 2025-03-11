import 'package:jak_sie_masz/Data/database_helper_service.dart';
import '../models/topic.dart';
import '../models/message.dart';

class ChatDatabaseService {
  final DatabaseHelperService _dbHelper;

  ChatDatabaseService(this._dbHelper);

  Future<int> createTopic(String title) async {
    return await _dbHelper.createChatTopic(title);
  }

  Future<void> saveMessage(int topicId, String message, bool isBot) async {
    await _dbHelper.saveChatMessage(topicId, message, isBot);
  }

  Future<List<Topic>> getTopics() async {
    final topics = await _dbHelper.getTopics();
    return topics
        .map((topic) => Topic(topic['id'] as int, topic['title'] as String,
            DateTime.parse(topic['created_at'] as String)))
        .toList();
  }

  Future<List<Message>> getMessagesForTopic(int topicId) async {
    final messages = await _dbHelper.getMessagesForTopic(topicId);
    return messages
        .map((msg) => Message(msg['message'] as String, msg['is_bot'] == 1))
        .toList();
  }

  Future<Topic?> getTopic(int topicId) async {
    final topics = await _dbHelper.getTopics();
    final topicData = topics.firstWhere(
      (topic) => topic['id'] as int == topicId,
      orElse: () => {},
    );

    if (topicData.isEmpty) return null;

    return Topic(topicData['id'] as int, topicData['title'] as String,
        DateTime.parse(topicData['created_at'] as String));
  }
}
