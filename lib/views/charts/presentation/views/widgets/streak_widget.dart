import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_spanish/cubits/charts/cubit/charts_cubit.dart';
import 'package:lottie/lottie.dart';
import '../../../../../core/utils/app_settings.dart';
import '../../../../../core/widgets/column_title_and_box.dart';
import '../../../../../repos/colors.dart';

class StreakWidget extends StatefulWidget {
  const StreakWidget({
    super.key,
  });

  @override
  State<StreakWidget> createState() => _StreakWidgetState();
}

class _StreakWidgetState extends State<StreakWidget> {
  @override
  void initState() {
    ChartsCubit.get(context).initializeStreak();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: fivethhColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            child: Lottie.asset(
              'assets/animation/fire.json',
              height: 100,
              width: 100,
              repeat: true,
              fit: BoxFit.fill,
              delegates: LottieDelegates(
                values: [
                  ValueDelegate.color(
                    const ['**'], // This applies the color filter to all layers
                    value: kMainColor, // Replace with your desired color
                  ),
                ],
              ),
            ),
          ),
          BlocBuilder<ChartsCubit, ChartsState>(
            builder: (context, state) {
              return ColumnTitleAndBox(
                title: 'Streak Days',
                value: ChartsCubit.get(context).streakCount,
              );
            },
          ),
          AppSettings.widthSpace(amountWidth: 0.1),
          const Text(
            'Study Everyday To\nBuild Your Streak.',
            style: TextStyle(fontSize: 16),
          ).animate().fadeIn(delay: 500.ms, duration: 2000.ms),
        ],
      ),
    );
  }
}
