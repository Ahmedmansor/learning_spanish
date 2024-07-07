import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../views/charts/data/models/streak_tracker.dart';
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
  }

  //Streak Widget Logic
  int streakCount = 0;
  final StreakTracker streakTracker = StreakTracker();
  Future<void> initializeStreak() async {
    await streakTracker.checkAndUpdateStreak();
    final currentStreak = await streakTracker.getCurrentStreak();
    emit(InitializeStreakState());
    streakCount = currentStreak;
  }
}
