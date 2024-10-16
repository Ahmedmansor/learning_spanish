import 'package:flutter/material.dart';

import '../../../../../core/utils/app_settings.dart';
import '../../../../../layout/cubit/layout_cubit.dart';
import '../../../../../repos/colors.dart';

class AjHogListViewItem extends StatelessWidget {
  const AjHogListViewItem({
    super.key,
    required this.onTap,
    required this.title,

    // required this.povSubtitleFile,
  });

  final String title;
  final void Function()? onTap;
  // final String? povSubtitleFile;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: CircleAvatar(
            backgroundColor:
                LayoutCubit.get(context).isDark ? Colors.white10 : Colors.black,
            radius: 40,
            child: Icon(
              Icons.podcasts_outlined,
              size: 50,
              color:
                  LayoutCubit.get(context).isDark ? kMainColor : Colors.white,
            ),
          ),
        ),
        AppSettings.heightSpace(amountHeight: 0.005),
        Text(
          title,
          style: const TextStyle(fontSize: 16, color: Colors.white),
        ),
      ],
    );
  }
}
