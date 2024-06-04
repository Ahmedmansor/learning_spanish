import 'package:flutter/material.dart';

import '../../repos/colors.dart';
import '../utils/app_settings.dart';

class CustomGeneralButton extends StatelessWidget {
  const CustomGeneralButton(
      {super.key,
      required this.text,
      required this.onTap,
      this.color = kMainColor,
      this.height = 40,
      this.textColor = Colors.white,
      this.radius = 50,
      this.fontSize = 18});
  final String? text;
  final GestureTapCallback? onTap;
  final Color? color;
  final double? height;
  final Color? textColor;
  final double radius;
  final double? fontSize;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onTap,
      height: height,
      minWidth: AppSettings.width,
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      color: color,
      child: Text(
        text!,
        style: TextStyle(color: textColor, fontSize: fontSize),
      ),
    );
  }
}
