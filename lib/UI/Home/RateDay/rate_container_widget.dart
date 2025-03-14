import 'package:flutter/material.dart';
import 'package:jak_sie_masz/Styles/styles.dart';
import 'package:jak_sie_masz/UI/Home/RateDay/rate_button_widget.dart';
import 'package:jak_sie_masz/UI/Home/RateDay/rate_slider_widget.dart';
import 'package:jak_sie_masz/UI/Home/viewmodels/rate_button_viewmodel.dart';
import 'package:jak_sie_masz/UI/Home/viewmodels/rate_slider_viewmodel.dart';
import 'package:provider/provider.dart';

class RateContainerWidget extends StatelessWidget {
  const RateContainerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: Styles.sectionSpacing),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
        boxShadow: [
          BoxShadow(
            color: Color(0x667CB89B),
            offset: Offset(0, 4),
            blurRadius: 10,
            spreadRadius: -2,
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 12,
          children: [
            Row(
              spacing: 4,
              children: [
                Text(
                  "Jak",
                  style: TextStyle(
                    color: Styles.primaryColor500,
                    fontSize: Styles.fontSizeH2,
                    decoration: TextDecoration.none,
                    fontFamily: Styles.fontFamily,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Text(
                  "się",
                  style: TextStyle(
                    color: Styles.fontColorDark,
                    fontSize: Styles.fontSizeH2,
                    decoration: TextDecoration.none,
                    fontFamily: Styles.fontFamily,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Text(
                  "masz?",
                  style: TextStyle(
                    color: Styles.fontColorDark,
                    fontSize: Styles.fontSizeH2,
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
            RateButtonWidget(
              viewmodel: RateButtonViewmodel(
                rateSliderRepository: context.read(),
                dayRatingRepository: context.read(),
                chatService: context.read(),
                chatDatabaseService: context.read(),
                aiChatViewModel: context.read() 
              ),
            ),
          ],
        ),
      ),
    );
  }
}
