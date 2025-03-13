import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jak_sie_masz/Styles/styles.dart';

class ServerInputDialogWidget extends StatelessWidget {
  const ServerInputDialogWidget(
      {super.key, required this.currentIpAddr, required this.onSubmit});
  final currentIpAddr;

  final void Function(String addr) onSubmit;
  @override
  Widget build(BuildContext context) {
    String ipAddr = "";
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
                text: "Wpisz ",
                style: TextStyle(
                  color: Styles.fontColorDark,
                  fontSize: Styles.fontSizeH3,
                  fontFamily: Styles.fontFamily,
                  fontWeight: FontWeight.w500,
                ),
                children: [
                  TextSpan(
                    text: "adres",
                    style: TextStyle(color: Styles.primaryColor500),
                  ),
                  TextSpan(
                    text: " serwera",
                  )
                ],
              ),
            ),
            TextField(
              autofocus: true,
              decoration: InputDecoration(
                hintText: currentIpAddr,
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
                ipAddr = value;
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
                if (ipAddr != "") onSubmit(ipAddr);
                context.pop();
              },
              child: Text(
                "zapisz",
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
