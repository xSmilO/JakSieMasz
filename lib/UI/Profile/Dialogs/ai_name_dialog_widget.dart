import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jak_sie_masz/Styles/styles.dart';

class AiNameDialogWidget extends StatelessWidget {
  const AiNameDialogWidget(
      {super.key, required this.onSubmit, required this.currentAIName});
  final String currentAIName;

  final void Function(String addr) onSubmit;
  @override
  Widget build(BuildContext context) {
    String aiName = "";
    return Dialog(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          spacing: 8,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RichText(
              text: TextSpan(
                text: "Jak chcesz aby nazywał się twój  ",
                style: TextStyle(
                  color: Styles.fontColorDark,
                  fontSize: Styles.fontSizeH3,
                  fontFamily: Styles.fontFamily,
                  fontWeight: FontWeight.w500,
                ),
                children: [
                  TextSpan(
                    text: "twój",
                    style: TextStyle(color: Styles.primaryColor500),
                  ),
                  TextSpan(
                    text: " przyjaciel ?",
                  )
                ],
              ),
            ),
            TextField(
              autofocus: true,
              decoration: InputDecoration(
                hintText: currentAIName,
                hintStyle: TextStyle(
                  color: Styles.profileOptionsHeaderColor,
                ),
                filled: true,
                fillColor: Styles.bgColor,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(16),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(16),
                ),
                contentPadding: EdgeInsets.all(8),
                isDense: true,
              ),
              cursorColor: Styles.primaryColor500,
              style: TextStyle(
                  fontFamily: Styles.fontFamily,
                  color: Styles.fontColorDark,
                  fontSize: 12),
              onChanged: (value) {
                aiName = value;
              },
            ),
            TextButton(
              style: ButtonStyle(
                padding: WidgetStatePropertyAll(
                  EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                ),
                backgroundColor: WidgetStatePropertyAll(Styles.primaryColor100),
                minimumSize: WidgetStatePropertyAll(
                  Size(10, 10),
                ),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(color: Styles.primaryColor500),
                  ),
                ),
              ),
              onPressed: () {
                // change ipaddr
                if (aiName != "") onSubmit(aiName);
                context.pop();
              },
              child: Text(
                "zmień",
                style: TextStyle(
                  fontFamily: Styles.fontFamily,
                  color: Styles.primaryColor500,
                  fontSize: Styles.fontSizeP,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
