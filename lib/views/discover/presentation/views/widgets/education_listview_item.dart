import 'package:flutter/material.dart';

import '../../../../../core/utils/app_settings.dart';

class EducationListViewItem extends StatelessWidget {
  const EducationListViewItem({
    super.key,
    required this.title,
    required this.image,
    required this.onTap,
  });
  final String title;
  final String image;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[700],
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                      image: AssetImage(image), fit: BoxFit.cover),
                ),
                height: AppSettings.height * .25,
                width: AppSettings.width * .88),
          ),
          AppSettings.heightSpace(amountHeight: .005),
          Text(
            ' $title',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
