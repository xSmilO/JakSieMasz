import 'package:flutter/material.dart';
import 'package:jak_sie_masz/UI/AIChat/viewmodels/mic_button_viewmodel.dart';

class MicButtonWidget extends StatefulWidget {
  final TextEditingController textEditingController;

  const MicButtonWidget({super.key, required this.textEditingController});

  @override
  State<StatefulWidget> createState() {
    return MicButtonState(viewmodel: MicButtonViewmodel(textEditingController: textEditingController));
  }
}

class MicButtonState extends State<MicButtonWidget> {
  final MicButtonViewmodel viewmodel;
  bool isListening = false;

  MicButtonState({required this.viewmodel});

  @override
  void initState() {
    super.initState();
    viewmodel.bindState(this);
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(isListening ? Icons.mic_off_rounded : Icons.mic_rounded, color: Colors.grey),
      onPressed: () async {
        await viewmodel.onPressed(context);
      }
    );
  }

  void publicSetState(VoidCallback callback) {
    setState(callback);
  }
}