import 'package:flutter/material.dart';

import '../../../../../core/utils/app_settings.dart';

class SettingsItem extends StatelessWidget {
  const SettingsItem({
    super.key,
    required this.text,
    required this.onTap,
    required this.widget,
    required this.icon,
  });
  final String text;
  // final IconData icon;
  final Function()? onTap;
  final Widget widget;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        // highlightColor: Colors.blue,
        // splashColor: kMainColor,
        onTap: onTap,
        child: SizedBox(
          height: AppSettings.height * .06,
          child: Row(
            children: [
              AppSettings.widthSpace(amountWidth: 0.03),
              Icon(
                icon,
                size: 28,
              ),
              AppSettings.widthSpace(amountWidth: 0.07),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      text,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Transform.scale(scale: 0.75, child: widget),
                  ],
                ),
              ),
              AppSettings.widthSpace(amountWidth: 0.03),
            ],
          ),
        ),
      ),
    );
  }
}
