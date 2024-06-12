import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:learning_spanish/core/utils/navigation.dart';
import 'package:learning_spanish/core/widgets/custom_button.dart';
import 'package:learning_spanish/views/discover/presentation/views/widgets/see_all_education_screen.dart';
import 'package:learning_spanish/views/discover/presentation/views/widgets/single_education_navigate_to.dart';

import '../../../../core/utils/app_settings.dart';
import '../../../../cubits/single_education_navigate_to/cubit/single_education_navigate_to_cubit.dart';
import '../../../../repos/colors.dart';
import '../../data/models/education_item_model.dart';
import 'widgets/education_listview_item.dart';

class DiscoverScreenView extends StatelessWidget {
  const DiscoverScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    var singleEducationNavigateToCubit =
        SingleEducationNavigateToCubit.get(context);
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
                    fontSize: 16,
                    textColor: kMainColor,
                    onTap: () {
                      NavigationUtils.goTo(
                          context, const SeeAllEducationScreen());
                    },
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
            AppSettings.heightSpace(amountHeight: .01),
            SizedBox(
              height: AppSettings.height * .35,
              child: ListView.builder(
                  shrinkWrap: true,
                  // physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: educationItems.length,
                  itemBuilder: (context, index) {
                    return EducationListViewItem(
                      title: educationItems[index].title,
                      image: educationItems[index].image,
                      onTap: () {
                        NavigationUtils.goTo(
                            context,
                            SingleEducationNavigateTo(
                              title: educationItems[index].title,
                              words: educationItems[index].words,
                              allquestionsList: educationItems[index].questions,
                              allAnswersList: educationItems[index].answers,
                              videoId: educationItems[index].videoId,
                            ));
                        // NavigationUtils.offScreen(context);
                        singleEducationNavigateToCubit.clearSelectedQuestions();
                        singleEducationNavigateToCubit.selectedAnswers.clear();
                      },
                    );
                  }),
            ),
          ]),
    );
  }
}
