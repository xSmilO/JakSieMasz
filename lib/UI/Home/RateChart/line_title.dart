import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:jak_sie_masz/Styles/styles.dart';

class LineTitle {
  // static List<String> labels = ["pon", "wt", "śrd", "czw", "pt", "sb", "ndz"];
  static getTitleData(int maxX) => FlTitlesData(
        show: true,
        topTitles: AxisTitles(
          sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 10,
              getTitlesWidget: (value, meta) => Container()),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 20,
              getTitlesWidget: (value, TitleMeta meta) {
                print("Value: $value");
                return SideTitleWidget(
                  meta: meta,
                  fitInside: SideTitleFitInsideData.fromTitleMeta(
                    meta,
                    enabled: true,
                    distanceFromEdge: 2,
                  ),
                  child: Text(
                    value == maxX.toDouble()
                        ? "dzisiaj"
                        : value == 0
                            ? "Ostatnie dni"
                            : "",
                    style: TextStyle(
                      fontSize: 10,
                      fontFamily: Styles.fontFamily,
                      color: Styles.primaryColor500,
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),
                  ),
                );
              }),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                return SideTitleWidget(
                  space: 8,
                  meta: meta,
                  child: Text(
                    value.round().toString(),
                    style: TextStyle(
                      fontSize: 10,
                      fontFamily: Styles.fontFamily,
                      color: Styles.secondaryColor300,
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),
                  ),
                );
              }),
        ),
      );
}
