import 'package:flutter/material.dart';
import 'package:jak_sie_masz/Styles/styles.dart';
import '../viewmodels/aichat_viewmodel.dart';
import '../models/message.dart';

class ChatMessageListWidget extends StatefulWidget {
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
  State<ChatMessageListWidget> createState() => _ChatMessageListWidgetState();
}

class _ChatMessageListWidgetState extends State<ChatMessageListWidget> {
  void _scrollToBottom() {
    if (widget.scrollController.hasClients) {
      widget.scrollController.animateTo(
        widget.scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void didUpdateWidget(ChatMessageListWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.viewModel.messages.length >
            oldWidget.viewModel.messages.length ||
        widget.viewModel.isTyping != oldWidget.viewModel.isTyping) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToBottom();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.viewModel.messages.isEmpty && !widget.viewModel.isTyping
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
            controller: widget.scrollController,
            itemCount: widget.viewModel.messages.length +
                (widget.viewModel.isTyping ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == widget.viewModel.messages.length &&
                  widget.viewModel.isTyping) {
                return _buildTypingIndicator();
              }
              return _buildMessageBubble(widget.viewModel.messages[index]);
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
            Text(
              //todo make bot name
              "${widget.viewModel.aiName} pisze",
              style: TextStyle(
                fontSize: Styles.fontSizeH4,
                fontFamily: Styles.fontFamily,
                color: Styles.fontColorDark,
                fontWeight: FontWeight.normal,
              ),
            ),
            Row(
              children: List.generate(3, (dotIndex) {
                return FadeTransition(
                  opacity: widget.dotsAnimations[dotIndex],
                  child: Text(
                    ".",
                    style: TextStyle(
                      fontSize: Styles.fontSizeH4,
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
