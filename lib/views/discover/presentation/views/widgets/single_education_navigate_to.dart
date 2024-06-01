import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../../../../core/utils/app_settings.dart';
import '../../../data/models/education_item_model.dart';

class SingleEducationNavigateTo extends StatelessWidget {
  const SingleEducationNavigateTo(
      {super.key, required this.title, required this.words});
  final String title;
  final List<Map<dynamic, dynamic>> words;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: ListView(
          children: [
            SizedBox(
              height: AppSettings.height,
              child: ListView.builder(
                itemCount: words.length,
                itemBuilder: (context, index) {
                  return SingleEducationListViewItem(
                      words: words, index: index);
                },
              ),
            )
          ],
        ));
  }
}

class SingleEducationListViewItem extends StatelessWidget {
  SingleEducationListViewItem({
    super.key,
    required this.words,
    required this.index,
  });

  final List<Map> words;

  final int index;
  FlutterTts flutterTts = FlutterTts();
  speak() async {
    await flutterTts.speak(words[index]['english']);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(words[index]['english']),
        Text(words[index]['espanol']),
        IconButton(
            onPressed: () async {
              await speak();
            },
            icon: const Icon(Icons.headset_mic_outlined)),
      ],
    );
  }
}
