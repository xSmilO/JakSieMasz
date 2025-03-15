import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:jak_sie_masz/Styles/styles.dart';
import 'package:jak_sie_masz/UI/AIChat/models/message.dart';
import 'package:jak_sie_masz/UI/AIChat/viewmodels/ai_message_viewmodel.dart';

class AIMessageWidget extends StatefulWidget {
  final Message message;

  const AIMessageWidget({super.key, required this.message});

  @override
  State<StatefulWidget> createState() {
    return AIMessageWidgetState(viewmodel: AIMessageViewmodel(flutterTts: FlutterTts()), message: message);
  }
}

class AIMessageWidgetState extends State<AIMessageWidget> {
  final AIMessageViewmodel viewmodel;
  final Message message;
  bool isSpeaking = false;

  AIMessageWidgetState({required this.viewmodel, required this.message});

  @override
  void initState() {
    super.initState();
    viewmodel.bindState(this);
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: InkWell(
        splashColor: Styles.primaryColor200,
        borderRadius: BorderRadius.circular(15),
        onLongPress: () async {
          await viewmodel.read(message.text);
        },
        child: Container(
          margin: const EdgeInsets.all(8.0),
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(message.text)
        ),
      )
    );
  }
}