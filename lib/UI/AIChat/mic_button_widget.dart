import 'package:flutter/material.dart';
import 'package:jak_sie_masz/UI/Shared/utility.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class MicButtonWidget extends StatefulWidget {
  final TextEditingController textEditingController;

  const MicButtonWidget({super.key, required this.textEditingController});

  @override
  State<StatefulWidget> createState() {
    return _MicButtonState(textEditingController: textEditingController);
  }
}

class _MicButtonState extends State<MicButtonWidget> {
  final TextEditingController textEditingController;
  bool _isListening = false;
  SpeechToText? speechToText = null;

  _MicButtonState({required this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(_isListening ? Icons.mic_off_outlined : Icons.mic_outlined, color: Colors.grey),
      onPressed: () async {
        speechToText = speechToText == null ? SpeechToText() : speechToText;
        bool available = await speechToText!.initialize();

        if(available) {
          if(!_isListening) {
            setState(() {
              _isListening = true;

              Utility.showSimpleOutput(context, "Mów teraz...");
              speechToText!.listen(
                onResult: (SpeechRecognitionResult result) {
                  textEditingController.text = result.recognizedWords;
                }
              );
            });
          } else {
            setState(() {
              _isListening = false;
              speechToText!.stop();
            });
          }
        }
      }
    );
  }
}