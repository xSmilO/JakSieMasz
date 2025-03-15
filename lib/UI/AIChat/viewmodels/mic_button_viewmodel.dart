import 'package:flutter/material.dart';
import 'package:jak_sie_masz/UI/AIChat/mic_button_widget.dart';
import 'package:jak_sie_masz/UI/Shared/utility.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class MicButtonViewmodel {
  final TextEditingController textEditingController;
  MicButtonState? state = null;
  SpeechToText? speechToText = null;

  MicButtonViewmodel({required this.textEditingController});

  void bindState(MicButtonState state) {
    this.state = state;
    speechToText = SpeechToText();
  }

  Future<void> onPressed(BuildContext context) async {
    speechToText = speechToText == null ? SpeechToText() : speechToText;
    bool available = await speechToText!.initialize();

    if(available) {
      if(!state!.isListening) {
        state!.publicSetState(() {
          state!.isListening = true;

          Utility.showSimpleOutput(context, "Mów teraz...");
          speechToText!.listen(
            onResult: (SpeechRecognitionResult result) {
              textEditingController.text = result.recognizedWords;
            }
          );
        });
      } else {
        state!.publicSetState(() {
          state!.isListening = false;
          speechToText!.stop();
        });
      }
    }
  }
}