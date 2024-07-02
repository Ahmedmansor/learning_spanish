import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_spanish/repos/colors.dart';

import '../../../repos/shared_pref_helper.dart';
import '../../../views/charts/presentation/views/widgets/bar_groups.dart';
part 'charts_state.dart';

class ChartsCubit extends Cubit<ChartsState> {
  ChartsCubit() : super(ChartsInitial()) {
    getBarGroups();
  }

  static ChartsCubit get(context) => BlocProvider.of(context);

  void getBarGroups() async {
    loadData();
    emit(BarChartsLoaded());
  }

  Future<void> refreshChart() async {
    getBarGroups();

    emit(RefreshChartSucess());
    debugPrint('refreshed');
    debugPrint(
        CachMemory.getIntFromCachMemory(key: 'appUsageMinutes_1').toString());
    debugPrint(
        CachMemory.getIntFromCachMemory(key: 'appUsageMinutes_2').toString());
    debugPrint(
        CachMemory.getIntFromCachMemory(key: 'appUsageMinutes_3').toString());
    debugPrint(
        CachMemory.getIntFromCachMemory(key: 'appUsageMinutes_4').toString());
    debugPrint(
        CachMemory.getIntFromCachMemory(key: 'appUsageMinutes_5').toString());
  }
}
