import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:jak_sie_masz/Data/repositories/day_rating_repository.dart';
import 'package:jak_sie_masz/Styles/styles.dart';
import 'package:jak_sie_masz/UI/Home/RateChart/line_title.dart';
import 'package:jak_sie_masz/UI/Home/viewmodels/rate_chart_viewmodel.dart';
import 'package:provider/provider.dart';

class RateChartWidget extends StatefulWidget {
  const RateChartWidget(
      {super.key, required this.viewmodel, required this.dayRatingRepository});
  final RateChartViewmodel viewmodel;
  final DayRatingRepository dayRatingRepository;

  @override
  State<RateChartWidget> createState() => _RateChartWidgetState();
}

class _RateChartWidgetState extends State<RateChartWidget> {
  final List<Color> gradient = [
    Styles.secondaryColor300,
    Styles.primaryColor500,
  ];

  @override
  void initState() {
    super.initState();
    // fetch day rates and limit them that you have in what category
    widget.viewmodel.fetchRates();
    widget.dayRatingRepository.onRateDay = widget.viewmodel.fetchRates;
    // widget.viewmodel.setTestRateData();
  }

  @override
  Widget build(BuildContext context) {
    List<FlSpot> dataSpots = [];

    return Consumer<RateChartViewmodel>(
      builder: (context, value, child) {
        int maxX = value.timespans[value.activeTimespanId] - 1;
        dataSpots = [];
        
        for(int i = 0; i < value.ratings.length; i++) {
          dataSpots.add(
            FlSpot(
              (maxX - i).toDouble(),
              value.ratings[i].rating.toDouble(),
            ),
          );
        }
        
        if (dataSpots.isEmpty) {
          dataSpots.add(FlSpot(0, 1));
        }

        return LineChart(
          LineChartData(
            minY: 1,
            maxY: 10,
            minX: 0,
            maxX: maxX.toDouble(),
            gridData: FlGridData(
              show: true,
              horizontalInterval: 2,
              drawVerticalLine: false,
              getDrawingVerticalLine: (value) => FlLine(
                color: Styles.horizontalRateChartColor,
                strokeWidth: 1,
              ),
              getDrawingHorizontalLine: (value) {
                return FlLine(
                  color: Styles.horizontalRateChartColor,
                  strokeWidth: 1,
                );
              },
            ),
            borderData: FlBorderData(
              border: Border.symmetric(
                horizontal: BorderSide(
                    color: Styles.horizontalRateChartColor, width: 1),
              ),
            ),
            lineBarsData: [
              LineChartBarData(
                isCurved: false,
                gradient: LinearGradient(
                  colors: gradient,
                ),
                preventCurveOverShooting: true,
                spots: dataSpots,
                dotData: FlDotData(
                  show: true,
                ),
                belowBarData: BarAreaData(
                  show: true,
                  gradient: LinearGradient(
                    colors: gradient
                        .map(
                          (e) => e.withAlpha(100),
                        )
                        .toList(),
                  ),
                ),
              )
            ],
            titlesData: LineTitle.getTitleData(maxX),
            lineTouchData: LineTouchData(enabled: false),
          ),
        );
      },
    );
  }
}
