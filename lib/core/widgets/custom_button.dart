import 'package:flutter/material.dart';

import '../../repos/colors.dart';
import '../utils/app_settings.dart';

class CustomGeneralButton extends StatelessWidget {
  const CustomGeneralButton(
      {super.key,
      required this.text,
      required this.onTap,
      this.color = kMainColor,
      this.height = 40});
  final String? text;
  final GestureTapCallback? onTap;
  final Color? color;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onTap,
      height: height,
      minWidth: AppSettings.width,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      color: color,
      child: Text(
        text!,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
