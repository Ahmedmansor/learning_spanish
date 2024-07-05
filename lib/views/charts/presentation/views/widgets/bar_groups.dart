import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../../repos/colors.dart';
import '../../../../../repos/shared_pref_helper.dart';

List<BarChartGroupData> barGroups = [];
double maxYValue = 0;
Future<void> loadData() async {
  barGroups = [];

  for (int i = 1; i <= 7; i++) {
    int minutes =
        CachMemory.getIntFromCachMemory(key: 'appUsageMinutes_$i') ?? 0;
    barGroups.add(
      BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
            toY: minutes.toDouble(),
            width: 24,
            color: kMainColor,
            borderRadius: BorderRadius.circular(4),
            backDrawRodData: BackgroundBarChartRodData(
                show: true,
                toY: 8,
                color: kMainColor.withOpacity(0.1),
                gradient: const LinearGradient(
                  colors: [
                    Colors.white38,
                    Colors.black45,
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                )),
          ),
        ],
      ),
    );
    // Update maxYValue if needed

    if (minutes.toDouble() > maxYValue) {
      maxYValue = minutes.toDouble();
    }
  }
  _getallMinutes();
  _getAverageDailyMinutes();
}

int totalMinutes = 0;
_getallMinutes() async {
  int minutes1 = CachMemory.getIntFromCachMemory(key: 'appUsageMinutes_1') ?? 0;
  int minutes2 = CachMemory.getIntFromCachMemory(key: 'appUsageMinutes_2') ?? 0;
  int minutes3 = CachMemory.getIntFromCachMemory(key: 'appUsageMinutes_3') ?? 0;
  int minutes4 = CachMemory.getIntFromCachMemory(key: 'appUsageMinutes_4') ?? 0;
  int minutes5 = CachMemory.getIntFromCachMemory(key: 'appUsageMinutes_5') ?? 0;
  int minutes6 = CachMemory.getIntFromCachMemory(key: 'appUsageMinutes_6') ?? 0;
  int minutes7 = CachMemory.getIntFromCachMemory(key: 'appUsageMinutes_7') ?? 0;
  return totalMinutes = minutes1 +
      minutes2 +
      minutes3 +
      minutes4 +
      minutes5 +
      minutes6 +
      minutes7;
}

int averageDailyMinutes = 0;
_getAverageDailyMinutes() async {
  return averageDailyMinutes = totalMinutes ~/ 7;
}
