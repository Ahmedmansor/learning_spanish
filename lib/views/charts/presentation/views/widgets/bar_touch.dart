import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:learning_spanish/repos/colors.dart';

BarTouchData get barTouch => BarTouchData(
      enabled: true,
      touchTooltipData: BarTouchTooltipData(
        getTooltipColor: (group) => Colors.black,
        tooltipPadding: EdgeInsets.zero,
        tooltipMargin: 10,
        getTooltipItem: (
          BarChartGroupData group,
          int groupIndex,
          BarChartRodData rod,
          int rodIndex,
        ) {
          return BarTooltipItem(
            rod.toY.round().toString(),
            const TextStyle(
                color: kMainColor, fontWeight: FontWeight.bold, fontSize: 20),
          );
        },
      ),
    );
