import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:jak_sie_masz/Styles/styles.dart';
import 'package:jak_sie_masz/UI/Home/RateChart/line_title.dart';

class RateChartWidget extends StatelessWidget {
  RateChartWidget({super.key});

  final List<Color> gradient = [
    Styles.secondaryColor300,
    Styles.primaryColor500,
  ];

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        minY: 1,
        maxY: 10,
        minX: 0,
        maxX: 6,
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
            horizontal:
                BorderSide(color: Styles.horizontalRateChartColor, width: 1),
          ),
        ),
        lineBarsData: [
          LineChartBarData(
            isCurved: true,
            curveSmoothness: 0.3,
            gradient: LinearGradient(
              colors: gradient,
            ),
            preventCurveOverShooting: true,
            spots: [
              FlSpot(
                0,
                7,
              ),
              FlSpot(
                1,
                6,
              ),
              FlSpot(
                2,
                4,
              ),
              FlSpot(
                3,
                8,
              ),
              FlSpot(
                4,
                6,
              ),
              FlSpot(
                5,
                10,
              ),
              FlSpot(
                6,
                6,
              ),
            ],
            dotData: FlDotData(
              show: false,
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
        titlesData: LineTitle.getTitleData(),
        lineTouchData: LineTouchData(enabled: false),
      ),
    );
  }
}
