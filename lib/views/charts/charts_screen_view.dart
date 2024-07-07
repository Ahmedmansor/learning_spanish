import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_spanish/core/utils/app_settings.dart';
import 'package:learning_spanish/cubits/charts/cubit/charts_cubit.dart';
import 'package:learning_spanish/repos/colors.dart';
import 'package:learning_spanish/views/charts/presentation/views/widgets/bar_groups.dart';
import 'package:learning_spanish/views/charts/presentation/views/widgets/titles_data.dart';
import 'package:lottie/lottie.dart';
import '../../repos/shared_pref_helper.dart';
import 'presentation/views/widgets/bar_touch.dart';
import 'presentation/views/widgets/streak_widget.dart';
import 'presentation/views/widgets/total_and_average_widget.dart';

class ChartsScreenView extends StatefulWidget {
  const ChartsScreenView({super.key});

  @override
  // ignore: library_private_types_in_public_api
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
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const TotalAndAverageWidget(),
                  AppSettings.heightSpace(amountHeight: 0.02),
                  Container(
                    decoration: BoxDecoration(
                      color: fivethhColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: AspectRatio(
                      aspectRatio: 1.6,
                      child: BarChart(
                        swapAnimationDuration:
                            const Duration(milliseconds: 1000),
                        swapAnimationCurve: Curves.linear,
                        BarChartData(
                          alignment: BarChartAlignment.spaceAround,
                          barGroups: barGroups,
                          titlesData: titlesData,
                          barTouchData: barTouch,
                          gridData: const FlGridData(show: false),
                          maxY: maxYValue + 20,
                          borderData: FlBorderData(show: false),
                        ),
                      ),
                    ),
                  ).animate().move(
                      duration: 500.ms,
                      begin: const Offset(100, 0),
                      end: const Offset(0, 0)),
                  AppSettings.heightSpace(amountHeight: 0.02),
                  const StreakWidget().animate().move(
                      duration: 500.ms,
                      begin: const Offset(0, 100),
                      end: const Offset(0, 0)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
