import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:learning_spanish/cubits/charts/cubit/charts_cubit.dart';
import 'package:learning_spanish/views/charts/presentation/views/widgets/bar_groups.dart';
import 'package:learning_spanish/views/charts/presentation/views/widgets/titles_data.dart';

import '../../repos/shared_pref_helper.dart';
import 'presentation/views/widgets/bar_touch.dart';

class ChartsScreenView extends StatefulWidget {
  @override
  _ChartsScreenViewState createState() => _ChartsScreenViewState();
}

class _ChartsScreenViewState extends State<ChartsScreenView>
    with WidgetsBindingObserver {
  Timer? usageTimer;

  @override
  void initState() {
    super.initState();
    ChartsCubit.get(context).getBarGroups();
    WidgetsBinding.instance.addObserver(this);
    _trackAppUsage();
  }

  void _trackAppUsage() async {
    final now = DateTime.now();
    final key = 'appUsageMinutes_${now.weekday}';
    usageTimer = Timer.periodic(const Duration(minutes: 1), (timer) async {
      int minutes = CachMemory.getIntFromCachMemory(key: key) ?? 0;
      CachMemory.insertIntToCachMemory(key: key, value: minutes + 1);
    });
  }

  @override
  void dispose() {
    usageTimer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // App is in the background
      usageTimer?.cancel();
      debugPrint('paused');
    } else if (state == AppLifecycleState.resumed) {
      // App is in the foreground
      _trackAppUsage();
      debugPrint('resumed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ChartsCubit, ChartsState>(
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                  flex: 2,
                  child: IconButton(
                    onPressed: () {
                      ChartsCubit.get(context).refreshChart();
                    },
                    icon: const Icon(
                      FontAwesomeIcons.arrowsRotate,
                      size: 30,
                    ),
                  )),
              Expanded(
                flex: 1,
                child: Container(
                  margin: const EdgeInsets.all(16),
                  child: AspectRatio(
                    aspectRatio: 1.6,
                    child: BarChart(
                      swapAnimationDuration: const Duration(milliseconds: 1000),
                      swapAnimationCurve: Curves.linear,
                      BarChartData(
                        alignment: BarChartAlignment.spaceAround,
                        barGroups: barGroups,
                        titlesData: titlesData,
                        barTouchData: barTouch,
                        gridData: const FlGridData(show: false),
                        maxY: 20,
                        borderData: FlBorderData(show: false),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
