import 'package:flutter/material.dart';
import 'package:jak_sie_masz/Styles/styles.dart';
import 'package:jak_sie_masz/UI/Home/viewmodels/rate_button_viewmodel.dart';

class RateButtonWidget extends StatelessWidget {
  final RateButtonViewmodel viewmodel;

  const RateButtonWidget({super.key, required this.viewmodel});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          viewmodel.rateDay(context);
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
                  Radius.circular(12),
                ),
              ),
            ),
            minimumSize: WidgetStatePropertyAll(
              Size(20, 20),
            )),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 32,
            vertical: 4,
          ),
          child: Text(
            "oceń",
            style: TextStyle(
              fontFamily: Styles.fontFamily,
              color: Styles.primaryColor500,
              fontSize: 16,
              fontWeight: FontWeight.w300,
            ),
          ),
        ));
  }
}
