import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jak_sie_masz/Styles/styles.dart';

class UsernameDialogWidget extends StatelessWidget {
  const UsernameDialogWidget(
      {super.key, required this.currentUserName, required this.onSubmit});
  final String currentUserName;
  final void Function(String username) onSubmit;

  @override
  Widget build(BuildContext context) {
    String usernameInput = "";
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          spacing: 8,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                text: "Jak chcesz się  ",
                style: TextStyle(
                  color: Styles.fontColorDark,
                  fontSize: Styles.fontSizeH3,
                  fontFamily: Styles.fontFamily,
                ),
                children: [
                  TextSpan(
                    text: "nazywać ",
                    style: TextStyle(color: Styles.primaryColor500),
                  ),
                  TextSpan(
                    text: "?",
                  )
                ],
              ),
            ),
            TextField(
              autofocus: true,
              decoration: InputDecoration(
                hintText: currentUserName,
                hintStyle: TextStyle(
                  color: Styles.profileOptionsHeaderColor,
                ),
                contentPadding: EdgeInsets.only(bottom: 8),
                enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Styles.secondaryColor300, width: 1),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Styles.primaryColor500, width: 1),
                ),
                isDense: true,
              ),
              cursorColor: Styles.primaryColor500,
              style: TextStyle(
                  fontFamily: Styles.fontFamily,
                  color: Styles.fontColorDark,
                  fontSize: 12),
              onChanged: (value) => usernameInput = value,
            ),
            Row(
              children: [
                Spacer(),
                TextButton(
                  style: ButtonStyle(
                    padding: WidgetStatePropertyAll(
                      EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    ),
                    backgroundColor:
                        WidgetStatePropertyAll(Styles.primaryColor500),
                    minimumSize: WidgetStatePropertyAll(
                      Size(10, 10),
                    ),
                  ),
                  onPressed: () {
                    onSubmit(usernameInput);
                    context.pop();
                  },
                  child: Text(
                    "zmień",
                    style: TextStyle(
                      fontFamily: Styles.fontFamily,
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
