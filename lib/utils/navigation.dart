import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class NavigationUtils {
  static goTo(BuildContext context, Widget screen) {
    Navigator.push(
        context,
        PageTransition(
            child: screen, type: PageTransitionType.leftToRightWithFade));
  }

  static goToAndOff(BuildContext context, Widget screen) {
    Navigator.pushReplacement(
        context,
        PageTransition(
            child: screen, type: PageTransitionType.leftToRightWithFade));
  }

  static offScreen(BuildContext context) {
    Navigator.pop(context);
  }
}
