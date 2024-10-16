import 'dart:math';

import 'package:flutter/material.dart';
import 'package:learning_spanish/core/utils/app_settings.dart';
import 'package:learning_spanish/core/utils/navigation.dart';
import 'package:learning_spanish/repos/colors.dart';
import 'package:learning_spanish/views/discover/presentation/views/widgets/education_listview_item.dart';
import 'package:learning_spanish/views/discover/presentation/views/single_education_navigate_to.dart';

import '../../../../../core/widgets/back_icon.dart';
import '../../../data/models/education_item_model.dart';

class SeeAllEducationScreen extends StatelessWidget {
  final List<EducationItemModel> educationItems;
  const SeeAllEducationScreen({
    super.key,
    required this.educationItems,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('See All'),
        centerTitle: true,
        leading: const BackIcon(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView.builder(
          itemCount: educationItems.length,
          itemBuilder: (context, index) {
            return EducationListViewItem(
              image: educationItems[index].image,
              title: educationItems[index].title,
              level: educationItems[index].level,
              onTap: () {
                NavigationUtils.goTo(
                    context,
                    SingleEducationNavigateTo(
                      title: educationItems[index].title,
                      words: educationItems[index].words,
                      allAnswersList: educationItems[index].answers,
                      allquestionsList: educationItems[index].questions,
                      videoId: educationItems[index].videoId,
                      subtitleFile: educationItems[index].subtitleFile,
                      songName: educationItems[index].songName,
                    ));
              },
            );
          },
        ),
      ),
    );
  }
}
