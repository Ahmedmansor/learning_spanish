import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:learning_spanish/repos/colors.dart';

FlTitlesData get titlesData => const FlTitlesData(
      show: true,
      bottomTitles: AxisTitles(
        // axisNameWidget: Text('Days'),
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 30,
          getTitlesWidget: getTitles,
        ),
      ),
      leftTitles: AxisTitles(
        axisNameWidget: Text(
          'Minutes',
          style: TextStyle(fontSize: 18, letterSpacing: 5),
        ),
        sideTitles: SideTitles(showTitles: false),
      ),
      topTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      rightTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
    );

Widget getTitles(double value, TitleMeta meta) {
  final style = TextStyle(
    color: kMainColor,
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );
  String text;
  switch (value.toInt()) {
    case 1:
      text = 'Mn';
      break;
    case 2:
      text = 'Te';
      break;
    case 3:
      text = 'Wd';
      break;
    case 4:
      text = 'Tu';
      break;
    case 5:
      text = 'Fr';
      break;
    case 6:
      text = 'St';
      break;
    case 7:
      text = 'Sn';
      break;
    default:
      text = '';
      break;
  }
  return SideTitleWidget(
    axisSide: meta.axisSide,
    space: 4,
    child: Text(text, style: style),
  );
}
