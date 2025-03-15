import 'package:flutter/material.dart';
import 'package:jak_sie_masz/Styles/styles.dart';

import 'package:jak_sie_masz/UI/FirstRate/first_rate_button_widget.dart';
import 'package:jak_sie_masz/UI/FirstRate/viewmodel/first_rate_button_viewmodel.dart';
import 'package:jak_sie_masz/UI/FirstRate/viewmodel/first_rate_viewmodel.dart';
import 'package:jak_sie_masz/UI/FirstRate/rate_slider_widget.dart';
import 'package:jak_sie_masz/UI/Home/viewmodels/rate_slider_viewmodel.dart';
import 'package:provider/provider.dart';

class FirstRateScreen extends StatelessWidget {
  const FirstRateScreen({super.key, required this.viewmodel});
  final FirstRateViewmodel viewmodel;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Styles.primaryColor500,
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Consumer<FirstRateViewmodel>(
            builder: (context, value, child) => Text(
              "Witaj ${value.username}! Jeszcze nie oceniłeś dzisiejszego dnia!",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontFamily: Styles.fontFamily,
                fontSize: Styles.fontSizeH1,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none,
                height: 1.5,
              ),
            ),
          ),
          RateSliderWidget(
            viewModel: RateSliderViewmodel(
              rateSliderRepository: context.read(),
            ),
            rateSliderRepository: context.read(),
          ),
          FirstRateButtonWidget(
            viewmodel: FirstRateButtonViewmodel(
              rateSliderRepository: context.read(),
              dayRatingRepository: context.read(),
            ),
          )
        ],
      ),
    );
  }
}
