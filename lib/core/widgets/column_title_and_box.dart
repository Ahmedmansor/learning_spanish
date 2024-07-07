import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../repos/colors.dart';

class ColumnTitleAndBox extends StatelessWidget {
  const ColumnTitleAndBox({
    super.key,
    required this.title,
    required this.value,
  });
  final String title;
  final int value;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        Container(
          margin: const EdgeInsets.only(top: 8),
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: kMainColor, width: 2),
            color: kMainColor.withOpacity(0.1),
          ),
          child: Center(
            child: Text(
              value.toString(),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ).animate().flip(delay: 500.ms, duration: 1000.ms),
          ),
        ).animate().fadeIn(delay: 500.ms, duration: 1500.ms),
      ],
    );
  }
}
