import 'package:flutter/material.dart';
import 'package:jak_sie_masz/Styles/styles.dart';
import 'package:jak_sie_masz/UI/Home/RateChart/rate_chart_container_widget.dart';

class RateChartSectionWidget extends StatelessWidget {
  const RateChartSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: Styles.sectionSpacing),
      child: Column(
        spacing: 24,
        children: [
          Row(
            spacing: 6,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Twoja",
                style: TextStyle(
                  color: Styles.primaryColor500,
                  fontFamily: Styles.fontFamily,
                  fontWeight: FontWeight.normal,
                  decoration: TextDecoration.none,
                  fontSize: Styles.fontSizeH3,
                ),
              ),
              Text(
                "historia",
                style: TextStyle(
                  color: Styles.fontColorDark,
                  fontFamily: Styles.fontFamily,
                  fontWeight: FontWeight.normal,
                  decoration: TextDecoration.none,
                  fontSize: Styles.fontSizeH3,
                ),
              ),
              Text(
                "samopoczucia",
                style: TextStyle(
                  color: Styles.fontColorDark,
                  fontFamily: Styles.fontFamily,
                  fontWeight: FontWeight.normal,
                  decoration: TextDecoration.none,
                  fontSize: Styles.fontSizeH3,
                ),
              ),
              Expanded(
                child: Container(
                  height: 1,
                  margin: EdgeInsets.only(top: 2),
                  color: Styles.primaryColor500,
                ),
              ),
            ],
          ),
          RateChartContainerWidget(),
        ],
      ),
    );
  }
}
