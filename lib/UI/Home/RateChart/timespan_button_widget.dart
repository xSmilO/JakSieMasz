import 'package:flutter/material.dart';
import 'package:jak_sie_masz/Styles/styles.dart';

class TimespanButtonWidget extends StatelessWidget {
  const TimespanButtonWidget({super.key, required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          print("change chart data");
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
                  Radius.circular(8),
                ),
              ),
            ),
            minimumSize: WidgetStatePropertyAll(
              Size(1, 1),
            )),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 4,
          ),
          child: Text(
            label,
            style: TextStyle(
              fontFamily: Styles.fontFamily,
              color: Styles.primaryColor500,
              fontSize: 8,
              fontWeight: FontWeight.normal,
            ),
          ),
        ));
  }
}
