import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:learning_spanish/core/utils/navigation.dart';
import 'package:learning_spanish/core/widgets/custom_button.dart';
import 'package:learning_spanish/views/discover/presentation/views/widgets/see_all_education_screen.dart';
import 'package:learning_spanish/views/discover/presentation/views/widgets/single_education_navigate_to.dart';

import '../../../../core/utils/app_settings.dart';
import '../../../../cubits/single_education_navigate_to/cubit/single_education_navigate_to_cubit.dart';
import '../../../../repos/colors.dart';
import '../../data/models/education_item_model.dart';
import 'widgets/alphabet_view.dart';
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
          const Text(
            'Learn Alpaphet',
            style: TextStyle(
                // color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold),
          ),
          InkWell(
            onTap: () {
              NavigationUtils.goTo(context, AlphabetView());
            },
            child: Image.asset(
              'assets/images/alphabet.jpg',
              width: AppSettings.width,
              height: AppSettings.height * .2,
              fit: BoxFit.fill,
            ),
          ).animate().fade(duration: 500.ms).scale(delay: 500.ms),
          AppSettings.heightSpace(amountHeight: .05),
          EducationPartInDiscoverScreenView(
            singleEducationNavigateToCubit: singleEducationNavigateToCubit,
            text: 'Education',
            educationItemsmodel: educationItems,
          ),
          AppSettings.heightSpace(amountHeight: .01),
          EducationPartInDiscoverScreenView(
            singleEducationNavigateToCubit: singleEducationNavigateToCubit,
            text: 'Learn with Music',
            educationItemsmodel: songStory,
          ),
        ],
      ),
    );
  }
}

class EducationPartInDiscoverScreenView extends StatelessWidget {
  const EducationPartInDiscoverScreenView({
    super.key,
    required this.singleEducationNavigateToCubit,
    required this.text,
    required this.educationItemsmodel,
  });

  final SingleEducationNavigateToCubit singleEducationNavigateToCubit;
  final String text;
  final List<EducationItemModel> educationItemsmodel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: const TextStyle(
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
                      context,
                      SeeAllEducationScreen(
                        educationItems: educationItemsmodel,
                      ));
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
            itemCount: educationItemsmodel.length,
            itemBuilder: (context, index) {
              return EducationListViewItem(
                title: educationItemsmodel[index].title,
                image: educationItemsmodel[index].image,
                onTap: () {
                  NavigationUtils.goTo(
                      context,
                      SingleEducationNavigateTo(
                        title: educationItemsmodel[index].title,
                        words: educationItemsmodel[index].words,
                        allquestionsList: educationItemsmodel[index].questions,
                        allAnswersList: educationItemsmodel[index].answers,
                        videoId: educationItemsmodel[index].videoId,
                      ));
                  // NavigationUtils.offScreen(context);
                  singleEducationNavigateToCubit.clearSelectedQuestions();
                  singleEducationNavigateToCubit.selectedAnswers.clear();
                  singleEducationNavigateToCubit.currentQuestionIndex = 0;
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
