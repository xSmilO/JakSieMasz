import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:jak_sie_masz/Data/day_rating_model.dart';
import 'package:jak_sie_masz/Styles/styles.dart';
import 'package:jak_sie_masz/UI/Home/RateChart/line_title.dart';
import 'package:jak_sie_masz/UI/Home/viewmodels/rate_chart_viewmodel.dart';

class RateChartWidget extends StatefulWidget {
  const RateChartWidget({super.key, required this.viewmodel});
  final RateChartViewmodel viewmodel;

  @override
  State<RateChartWidget> createState() => _RateChartWidgetState();
}

class _RateChartWidgetState extends State<RateChartWidget> {
  final List<Color> gradient = [
    Styles.secondaryColor300,
    Styles.primaryColor500,
  ];

  late Future<List<DayRatingModel>> data;

  @override
  void initState() {
    super.initState();
    // fetch day rates and limit them that you have in what category
    data = widget.viewmodel.fetchRates();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<DayRatingModel>>(
        future: data,
        builder: (context, snapshot) {
          List<FlSpot> dataSpots = [];

          if (snapshot.hasData) {
            for (int idx = 0; idx < snapshot.data!.length; ++idx) {
              dataSpots.insert(
                  0,
                  FlSpot(
                      idx.toDouble(), snapshot.data![idx].rating.toDouble()));
            }
          }
          return LineChart(
            LineChartData(
              minY: 1,
              maxY: 10,
              minX: 0,
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
                  isCurved: true,
                  curveSmoothness: 0.3,
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
              titlesData: LineTitle.getTitleData(),
              lineTouchData: LineTouchData(enabled: false),
            ),
          );
        });
  }
}
