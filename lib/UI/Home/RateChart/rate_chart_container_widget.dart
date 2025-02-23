import 'package:flutter/material.dart';
import 'package:jak_sie_masz/UI/Home/RateChart/timespans_widget.dart';
import 'package:jak_sie_masz/UI/Home/RateChart/rate_chart_widget.dart';

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
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TimespansWidget(),
            Expanded(child: RateChartWidget()),
          ],
        ),
      ),
    );
  }
}
