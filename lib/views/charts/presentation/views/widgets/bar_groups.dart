import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../../repos/colors.dart';
import '../../../../../repos/shared_pref_helper.dart';

List<BarChartGroupData> barGroups = [];
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
  }
}
