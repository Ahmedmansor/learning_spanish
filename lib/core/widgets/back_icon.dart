import 'package:flutter/material.dart';

import '../../repos/colors.dart';
import '../utils/navigation.dart';

class BackIcon extends StatelessWidget {
  const BackIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        NavigationUtils.offScreen(context);
      },
      icon: const Icon(
        Icons.arrow_back_ios_sharp,
        color: kMainColor,
        size: 24,
      ),
    );
  }
}
