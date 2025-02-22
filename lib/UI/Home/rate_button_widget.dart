import 'package:flutter/material.dart';
import 'package:jak_sie_masz/Styles/styles.dart';

class RateButtonWidget extends StatelessWidget {
  const RateButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          print("rate day");
        },
        style: ButtonStyle(
            alignment: Alignment.center,
            backgroundColor: WidgetStatePropertyAll(Styles.primaryColor100),
            padding: WidgetStatePropertyAll(EdgeInsets.zero),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                side: BorderSide(
                  color: Styles.primaryColor500,
                  width: 1,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(16),
                ),
              ),
            ),
            minimumSize: WidgetStatePropertyAll(
              Size(20, 20),
            )),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 32,
            vertical: 6,
          ),
          child: Text(
            "oceń",
            style: TextStyle(
              fontFamily: Styles.fontFamily,
              color: Styles.primaryColor500,
              fontSize: 16,
            ),
          ),
        ));
  }
}
