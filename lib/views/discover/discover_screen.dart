import 'package:flutter/material.dart';

import '../../core/utils/app_settings.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.indigo,
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Discover',
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              AppSettings.heightSpace(amountHeight: 0.06),
            ],
          ),
        ));
  }
}
