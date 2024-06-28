import 'package:flutter/material.dart';
import 'package:learning_spanish/core/utils/app_settings.dart';
import 'package:learning_spanish/core/utils/navigation.dart';
import 'package:learning_spanish/views/discover/presentation/views/widgets/education_listview_item.dart';
import 'package:learning_spanish/views/discover/presentation/views/widgets/single_education_navigate_to.dart';

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
        title: const Text('Educations'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView.builder(
          itemCount: educationItems.length,
          itemBuilder: (context, index) {
            return EducationListViewItem(
              image: educationItems[index].image,
              title: educationItems[index].title,
              onTap: () {
                NavigationUtils.goTo(
                    context,
                    SingleEducationNavigateTo(
                      title: educationItems[index].title,
                      words: educationItems[index].words,
                      allAnswersList: educationItems[index].answers,
                      allquestionsList: educationItems[index].questions,
                    ));
              },
            );
          },
        ),
      ),
    );
  }
}
