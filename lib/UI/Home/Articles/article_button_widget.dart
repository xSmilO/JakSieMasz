import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jak_sie_masz/Styles/styles.dart';

class ArticleButtonWidget extends StatelessWidget {
  const ArticleButtonWidget({super.key, required this.callback});

  final Function callback;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          callback();
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
              Size(10, 10),
            )),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 4,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            spacing: 4,
            children: [
              Text(
                "sprawdź",
                style: TextStyle(
                  fontFamily: Styles.fontFamily,
                  color: Styles.primaryColor500,
                  fontSize: 10,
                  fontWeight: FontWeight.w300,
                ),
              ),
              SvgPicture.asset("assets/icons/arrow-solid.svg")
            ],
          ),
        ));
  }
}
