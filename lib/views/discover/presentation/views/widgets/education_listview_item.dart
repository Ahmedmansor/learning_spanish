import 'package:flutter/material.dart';
import 'package:learning_spanish/repos/colors.dart';

import '../../../../../core/utils/app_settings.dart';

class EducationListViewItem extends StatelessWidget {
  const EducationListViewItem({
    super.key,
    required this.title,
    required this.image,
    required this.onTap,
    required this.level,
  });
  final String title;
  final String image;
  final Map? level;
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
            child: Stack(
              children: [
                Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[700],
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                          image: AssetImage(image), fit: BoxFit.cover),
                    ),
                    height: AppSettings.height * .25,
                    width: AppSettings.width * .88),
                Positioned(
                  child: Container(
                    padding: const EdgeInsets.only(left: 6),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Color.fromARGB(255, 126, 98, 40),
                        Colors.black54,
                        Colors.black45,
                        Colors.black38,
                        Colors.black26,
                        Colors.black12,
                      ]),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        bottomLeft: Radius.circular(16),
                      ),
                    ),
                    height: AppSettings.height * .25,
                    width: AppSettings.width * .20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        LevelsOfTheAudio(alpabet: 'A1', level: level),
                        LevelsOfTheAudio(alpabet: 'A2', level: level),
                        LevelsOfTheAudio(alpabet: 'B1', level: level),
                        LevelsOfTheAudio(alpabet: 'B2', level: level),
                        LevelsOfTheAudio(alpabet: 'C1', level: level),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          AppSettings.heightSpace(amountHeight: .005),
          Text(
            ' $title',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class LevelsOfTheAudio extends StatelessWidget {
  const LevelsOfTheAudio({
    super.key,
    required this.level,
    required this.alpabet,
  });

  final Map? level;
  final String alpabet;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '$alpabet= ',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: kMainColor, // Color for 'A1'
            ),
          ),
          TextSpan(
            text: '${level?[alpabet] ?? ''}',
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                backgroundColor: Colors.black26 // Color for level?['A1']
                ),
          ),
        ],
      ),
    );
  }
}
