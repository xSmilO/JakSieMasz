import 'package:flutter/material.dart';
import 'package:jak_sie_masz/Styles/styles.dart';
import 'package:jak_sie_masz/UI/Home/rate_slider_widget.dart';
import 'package:jak_sie_masz/UI/Home/viewmodels/rate_slider_viewmodel.dart';
import 'package:provider/provider.dart';

class RateContainerWidget extends StatelessWidget {
  const RateContainerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 48),
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
              spacing: 4,
              children: [
                Text(
                  "Jak",
                  style: TextStyle(
                    color: Styles.primaryColor500,
                    fontSize: 16,
                    decoration: TextDecoration.none,
                    fontFamily: Styles.fontFamily,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Text(
                  "się",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    decoration: TextDecoration.none,
                    fontFamily: Styles.fontFamily,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Text(
                  "masz?",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    decoration: TextDecoration.none,
                    fontFamily: Styles.fontFamily,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
            RateSliderWidget(
              viewModel:
                  RateSliderViewmodel(rateSliderRepository: context.read()),
              rateSliderRepository: context.read(),
            ),
          ],
        ),
      ),
    );
  }
}
