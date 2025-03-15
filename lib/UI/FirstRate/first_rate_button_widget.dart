import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jak_sie_masz/Styles/styles.dart';
import 'package:jak_sie_masz/UI/FirstRate/viewmodel/first_rate_button_viewmodel.dart';
import 'package:jak_sie_masz/routing/routes.dart';

class FirstRateButtonWidget extends StatelessWidget {
  final FirstRateButtonViewmodel viewmodel;

  const FirstRateButtonWidget({super.key, required this.viewmodel});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        viewmodel.rateDay().then(
          (value) {
            context.go(Routes.home);
          },
        );
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
      ),
    );
  }
}
