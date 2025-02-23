import 'package:flutter/material.dart';
import 'package:jak_sie_masz/UI/Home/RateChart/timespan_button_widget.dart';
import 'package:jak_sie_masz/UI/Home/viewmodels/rate_chart_viewmodel.dart';
import 'package:provider/provider.dart';

class TimespansWidget extends StatelessWidget {
  const TimespansWidget({super.key, required this.viewmodel});
  final RateChartViewmodel viewmodel;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Consumer<RateChartViewmodel>(
          builder: (context, value, child) => Row(
            spacing: 8,
            children: [
              TimespanButtonWidget(
                id: 0,
                setId: value.setTimespan,
                selectedId: value.activeTimespanId,
                label: '7 dni',
              ),
              TimespanButtonWidget(
                id: 1,
                selectedId: value.activeTimespanId,
                setId: value.setTimespan,
                label: '2 tyg.',
              ),
              TimespanButtonWidget(
                id: 2,
                selectedId: value.activeTimespanId,
                setId: value.setTimespan,
                label: '30 dni',
              ),
            ],
          ),
        ));
  }
}
