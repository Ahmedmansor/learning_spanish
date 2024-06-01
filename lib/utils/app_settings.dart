import 'package:flutter/material.dart';

class AppSettings {
  static late double width;
  static late double height;
  static late double defultSize;
  static double? orientation;

  static init(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    defultSize =
        // ignore: unrelated_type_equality_checks
        orientation == Orientation.landscape ? height * .024 : width * .024;

    debugPrint('this is the default size $defultSize');
  }

  static SizedBox heightSpace({required double amountHeight}) {
    return SizedBox(
      height: height * amountHeight,
    );
  }

  static SizedBox widthSpace({required double amountWidth}) {
    return SizedBox(
      height: width * amountWidth,
    );
  }
}
