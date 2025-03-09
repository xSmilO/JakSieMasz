import 'package:flutter/material.dart';
import '../viewmodels/aichat_viewmodel.dart';

class ChatMessageListWidget extends StatelessWidget {
  final AIChatViewModel viewModel;
  final ScrollController scrollController;
  final List<Animation<double>> dotsAnimations;

  const ChatMessageListWidget({
    Key? key,
    required this.viewModel,
    required this.scrollController,
    required this.dotsAnimations,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return viewModel.messages.isEmpty && !viewModel.isTyping
        ? const Center(
            child: Text(
              "W czym ci pomóc?",
              style: TextStyle(
                fontSize: 30,
                color: Colors.grey,
              ),
            ),
          )
        : ListView.builder(
            controller: scrollController,
            itemCount: viewModel.messages.length + (viewModel.isTyping ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == viewModel.messages.length && viewModel.isTyping) {
                return _buildTypingIndicator();
              }
              return _buildMessageBubble(viewModel.messages[index]);
            },
          );
  }

  Widget _buildTypingIndicator() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            const Text(
              "Andrzej Bugała pisze",
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            Row(
              children: List.generate(3, (dotIndex) {
                return FadeTransition(
                  opacity: dotsAnimations[dotIndex],
                  child: const Text(
                    ".",
                    style: TextStyle(
                      fontSize: 14,
                      height: 1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageBubble(Message message) {
    return Align(
      alignment: message.isBot ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: message.isBot ? Colors.grey[300] : Colors.greenAccent,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(message.text),
      ),
    );
  }
}
