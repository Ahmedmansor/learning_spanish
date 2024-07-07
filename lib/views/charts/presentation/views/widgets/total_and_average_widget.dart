import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../core/widgets/column_title_and_box.dart';
import '../../../../../repos/colors.dart';
import 'bar_groups.dart';

class TotalAndAverageWidget extends StatelessWidget {
  const TotalAndAverageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: fivethhColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ColumnTitleAndBox(
            title: 'Total Minutes',
            value: totalMinutes,
          ),
          ColumnTitleAndBox(
            title: 'Average Daily Minutes',
            value: averageDailyMinutes,
          ),
        ],
      ),
    ).animate().move(
        duration: 500.ms,
        begin: const Offset(-100, 0),
        end: const Offset(0, 0));
  }
}
