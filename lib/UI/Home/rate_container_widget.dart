import 'package:flutter/material.dart';
import 'package:jak_sie_masz/Styles/styles.dart';
import 'package:jak_sie_masz/UI/Home/rate_slider_widget.dart';

class RateContainerWidget extends StatelessWidget {
  const RateContainerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 48),
      height: 152,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 16,
          children: [
            Row(
              spacing: 8,
              children: [
                Text(
                  "Jak",
                  style: TextStyle(
                    color: Styles.primaryColor500,
                    fontSize: 16,
                    decoration: TextDecoration.none,
                  ),
                ),
                Text(
                  "się masz?",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    decoration: TextDecoration.none,
                  ),
                ),
              ],
            ),
            RateSliderWidget(),
          ],
        ),
      ),
    );
  }
}
