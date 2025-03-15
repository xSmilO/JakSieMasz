import 'package:flutter_tts/flutter_tts.dart';
import 'package:jak_sie_masz/UI/AIChat/widgets/ai_message_widget.dart';

class AIMessageViewmodel {
  AIMessageWidgetState? state;
  final FlutterTts flutterTts;

  AIMessageViewmodel({required this.flutterTts});

  void bindState(AIMessageWidgetState state) {
    this.state = state;
  }

  Future<void> read(String what) async {
    if(!state!.isSpeaking) {
      state!.isSpeaking = true;
      await flutterTts.speak(what);
    } else {
      state!.isSpeaking = false;
      await flutterTts.stop();
    }
  }
}