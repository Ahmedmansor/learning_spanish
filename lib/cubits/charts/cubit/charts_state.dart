part of 'charts_cubit.dart';

@immutable
sealed class ChartsState {}

final class ChartsInitial extends ChartsState {}

//-------------------------
final class BarChartsLoaded extends ChartsState {}

final class RefreshChartSucess extends ChartsState {}
