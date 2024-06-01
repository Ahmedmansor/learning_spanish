import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:learning_spanish/core/widgets/custom_button.dart';

import '../../core/utils/app_settings.dart';
import '../../repos/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Discover',
        ),
      ),
      body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            AppSettings.heightSpace(amountHeight: .01),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Education',
                  style: TextStyle(
                      // color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: AppSettings.width * .2,
                  child: CustomGeneralButton(
                    text: 'See All',
                    textColor: secondColor,
                    onTap: () {},
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
            AppSettings.heightSpace(amountHeight: .01),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[700],
                    borderRadius: BorderRadius.circular(16),
                    image: const DecorationImage(
                        image: AssetImage('assets/images/image1.jpg'),
                        fit: BoxFit.cover),
                  ),
                  width: AppSettings.width,
                  height: AppSettings.height * .25,
                ),
                AppSettings.heightSpace(amountHeight: .005),
                const Text(
                  ' School',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ]),
    );
  }
}
