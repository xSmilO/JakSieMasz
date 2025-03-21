import 'package:flutter/material.dart';
import 'package:jak_sie_masz/Styles/styles.dart';
import 'package:jak_sie_masz/UI/Home/RateChart/timespans_widget.dart';
import 'package:jak_sie_masz/UI/Home/RateChart/rate_chart_widget.dart';
import 'package:provider/provider.dart';

class RateChartContainerWidget extends StatelessWidget {
  const RateChartContainerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 256,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
          boxShadow: [
            BoxShadow(
              color: Styles.primaryColor300,
              offset: Offset(0, 4),
              blurRadius: 12,
              spreadRadius: -8,
            ),
          ]),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TimespansWidget(
              viewmodel: context.read(),
            ),
            Expanded(
              child: RateChartWidget(
                viewmodel: context.read(),
                dayRatingRepository: context.read(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
