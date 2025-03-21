import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../models/topic.dart';

class TopicsListWidget extends StatelessWidget {
  final List<Topic> todayTopics;
  final List<Topic> lastWeekTopics;
  final List<Topic> lastMonthTopics;
  final Function(int) onTopicTap;
  final Function(int) onIconTap;

  const TopicsListWidget({
    Key? key,
    required this.todayTopics,
    required this.lastWeekTopics,
    required this.lastMonthTopics,
    required this.onTopicTap,
    required this.onIconTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        _buildTopicSection("Dzisiaj", todayTopics),
        _buildTopicSection("Ostatnie 7 dni", lastWeekTopics),
        _buildTopicSection("Ostatnie 30 dni", lastMonthTopics),
      ],
    );
  }

  Widget _buildTopicSection(String title, List<Topic> topics) {
    if (topics.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 4.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ),
        ...topics.map((topic) => ListTile(
              dense: true,
              visualDensity: const VisualDensity(vertical: -4),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      topic.text,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      onIconTap(topic.id);
                    },
                    child: SvgPicture.asset(
                      "assets/icons/trash.svg",
                      width: 16,
                      height: 16,
                    ),
                  )
                ],
              ),
              subtitle: Text(
                _formatDate(topic.timestamp),
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              onTap: () => onTopicTap(topic.id),
            )),
      ],
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    if (date.day == now.day &&
        date.month == now.month &&
        date.year == now.year) {
      return "${date.hour}:${date.minute.toString().padLeft(2, '0')}";
    }
    return "${date.day}/${date.month}";
  }
}
