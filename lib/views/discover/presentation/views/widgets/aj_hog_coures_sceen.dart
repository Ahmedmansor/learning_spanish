import 'package:flutter/material.dart';
import 'package:learning_spanish/views/discover/data/models/aj_hog_model.dart';
import '../../../../../core/utils/navigation.dart';
import '../../../../../cubits/single_education_navigate_to/cubit/single_education_navigate_to_cubit.dart';
import '../single_education_navigate_to.dart';
import 'aj_hog_list_view_item.dart';

class AjHogCouresSceen extends StatelessWidget {
  const AjHogCouresSceen({
    super.key,
    required this.singleEducationNavigateToCubit,
    required this.ajHogListModel,
  });

  final SingleEducationNavigateToCubit singleEducationNavigateToCubit;
  final List<AjHogModel> ajHogListModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
        child: SingleChildScrollView(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.8,
            ),
            shrinkWrap: true,
            // physics: const NeverScrollableScrollPhysics(),
            // scrollDirection: Axis.horizontal,
            itemCount: ajHogListModel.length,
            itemBuilder: (context, index) {
              return AjHogListViewItem(
                // povSubtitleFile: ajHogListModel[index].povSubtitleFile,
                onTap: () {
                  NavigationUtils.goTo(
                    context,
                    SingleEducationNavigateTo(
                      title: ajHogListModel[index].title,
                      words: ajHogListModel[index].words,
                      allquestionsList: ajHogListModel[index].questions,
                      allAnswersList: ajHogListModel[index].answers,
                      mainSubtitleFile: ajHogListModel[index].mainSubtitleFile,
                      vocabSubtitleFile:
                          ajHogListModel[index].vocabSubtitleFile,
                      msSubtitleFile: ajHogListModel[index].msSubtitleFile,
                      povSubtitleFile: ajHogListModel[index].povSubtitleFile,
                      mainSubtitleAudioFile:
                          ajHogListModel[index].mainSubtitleAudioFile,
                      vocabSubtitleAudioFile:
                          ajHogListModel[index].vocabSubtitleAudioFile,
                      msSubtitleAudioFile:
                          ajHogListModel[index].msSubtitleAudioFile,
                      povSubtitleAudioFile:
                          ajHogListModel[index].povSubtitleAudioFile,
                    ),
                  );
                  // NavigationUtils.offScreen(context);
                  singleEducationNavigateToCubit.clearSelectedQuestions();
                  singleEducationNavigateToCubit.selectedAnswers.clear();
                  singleEducationNavigateToCubit.currentQuestionIndex = 0;
                },
                title: ajHogListModel[index].title,
              );
            },
          ),
        ),
      ),
    );
  }
}
