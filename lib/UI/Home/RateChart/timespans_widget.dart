import 'package:flutter/material.dart';
import 'package:jak_sie_masz/UI/Home/RateChart/timespan_button_widget.dart';

class TimespansWidget extends StatelessWidget {
  const TimespansWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        spacing: 16,
        children: [
          TimespanButtonWidget(
            label: '7 dni',
          ),
          TimespanButtonWidget(
            label: '2 tyg',
          ),
          TimespanButtonWidget(
            label: '30 dni',
          ),
        ],
      ),
    );
  }
}
