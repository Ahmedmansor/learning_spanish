import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_spanish/core/utils/navigation.dart';
import 'package:learning_spanish/core/widgets/custom_button.dart';
import 'package:learning_spanish/views/discover/presentation/views/quiz_view.dart';
import 'package:learning_spanish/views/settings/presentation/views/settings_screen.dart';
// import 'package:rive_animated_icon/rive_animated_icon.dart';
// import 'package:rive_animated_icon/rive_animated_icon.dart';
import '../../../../../core/utils/app_settings.dart';
import '../../../../../core/widgets/back_icon.dart';
import '../../../../../cubits/settings/cubit/settings_cubit.dart';
import '../../../../../cubits/single_education_navigate_to/cubit/single_education_navigate_to_cubit.dart';
import '../../../../../repos/colors.dart';
import 'youtube_player_screen_view.dart';

class SingleEducationNavigateTo extends StatelessWidget {
  const SingleEducationNavigateTo({
    super.key,
    required this.title,
    required this.words,
    required this.allquestionsList,
    required this.allAnswersList,
    this.videoId,
  });
  final String title;
  final List<Map<dynamic, dynamic>> words;
  final List<String> allquestionsList;
  final List<String> allAnswersList;
  final String? videoId;

  @override
  Widget build(BuildContext context) {
    var cubit = SingleEducationNavigateToCubit.get(context);
    return Scaffold(
        bottomNavigationBar: BottomNavBar(
          cubit: cubit,
          allquestionsList: allquestionsList,
          allAnswersList: allAnswersList,
          videoId: videoId,
        ),
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            title,
            style: const TextStyle(fontSize: 22),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: IconButton(
                  onPressed: () {
                    NavigationUtils.goTo(
                      context,
                      const SettingScreen(),
                    );
                  },
                  icon: const Icon(
                    Icons.settings,
                    size: 32,
                  )),
            )
          ],
          leading: const BackIcon(),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            children: [
              SizedBox(
                height: AppSettings.height * .8,
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return AppSettings.heightSpace(amountHeight: .01);
                  },
                  itemCount: words.length,
                  itemBuilder: (context, index) {
                    return SingleEducationListViewItem(
                      words: words,
                      index: index,
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
    required this.cubit,
    required this.allquestionsList,
    required this.allAnswersList,
    this.videoId,
  });

  final SingleEducationNavigateToCubit cubit;
  final List<String> allquestionsList;
  final List<String> allAnswersList;
  final String? videoId;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSettings.width,
      decoration: BoxDecoration(
        color: Colors.grey[700],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(bottom: 16, left: 16, right: 16, top: 16),
        child: BlocBuilder<SingleEducationNavigateToCubit,
            SingleEducationNavigateToState>(
          builder: (context, state) {
            return Row(
              children: [
                Expanded(
                  child: CustomGeneralButton(
                    textColor: Colors.black,
                    color: kMainColor,
                    // radius: 8,
                    borderRadius: videoId != null
                        ? const BorderRadius.only(
                            // topLeft: Radius.circular(8),
                            bottomLeft: Radius.circular(24))
                        : BorderRadius.circular(8),

                    text: 'Start Quiz',
                    onTap: () {
                      if (cubit.selectedQuestions.length < 3) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                            'Please Select 3 Words at Least',
                          ),
                          duration: Duration(seconds: 2),
                        ));
                      } else {
                        SingleEducationNavigateToCubit.get(context)
                            .getAnswersForSelectedQuestions(
                                selectedQuestions: cubit.selectedQuestions,
                                allQuestions: allquestionsList,
                                allAnswers: allAnswersList);

                        cubit.selectedQuestions.isEmpty ||
                                cubit.selectedQuestions.length < 3
                            ? null
                            : NavigationUtils.goTo(
                                context, const CompleteStringQuizApp());

                        SingleEducationNavigateToCubit.get(context)
                            .prepareString();
                        cubit.currentQuestionIndex = 0;
                        // cubit.selectedAnswers = [];
                      }
                    },
                  ),
                ),
                if (videoId != null)
                  Expanded(
                    child: CustomGeneralButton(
                      textColor: Colors.black,
                      color: kMainColor,
                      // radius: 8,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(24),
                        // bottomRight: Radius.circular(8),
                      ),
                      text: 'Watch Video',
                      onTap: () {
                        NavigationUtils.goTo(
                            context,
                            YouTubePlayerScreen(
                              videoId: videoId!,
                            ));

                        cubit.playHintSound();
                      },
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class SingleEducationListViewItem extends StatelessWidget {
  const SingleEducationListViewItem({
    super.key,
    required this.words,
    required this.index,
  });

  final List<Map> words;
  final int index;

  @override
  Widget build(BuildContext context) {
    var singleEducationNavigateToCubit =
        SingleEducationNavigateToCubit.get(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: AppSettings.width * .3,
          child: Text(
            words[index]['english'],
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        SizedBox(
          width: AppSettings.width * .3,
          child: Text(
            words[index]['espanol'],
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.start,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BlocBuilder<SingleEducationNavigateToCubit,
                SingleEducationNavigateToState>(
              builder: (context, state) {
                return CheckBox(
                  value: singleEducationNavigateToCubit.selectedQuestions
                      .contains(words[index]['english']),
                  onChanged: (newValue) {
                    singleEducationNavigateToCubit.updateValue(
                        newValue!, words[index]['english']);
                  },
                );
              },
            ),
            // GestureDetector(
            //   child: const Icon(
            //     Icons.mic,
            //     size: 35,
            //   ),
            //   onLongPress: () async {
            //     BlocProvider.of<SettingsCubit>(context).setSpeed(0.1);
            //     BlocProvider.of<SettingsCubit>(context)
            //         .speak(words[index]['espanol']);
            //   },
            //   onTap: () async {
            //     // await FlutterTts.speak(words[index]['espanol']);
            //     BlocProvider.of<SettingsCubit>(context).setSpeed(0.5);

            //     BlocProvider.of<SettingsCubit>(context)
            //         .speak(words[index]['espanol']);
            //   },
            // ),
            GestureDetector(
              onLongPress: () {
                BlocProvider.of<SettingsCubit>(context).setSpeed(0.1);
                BlocProvider.of<SettingsCubit>(context)
                    .speak(words[index]['espanol']);
              },
              child: IconButton(
                  onPressed: () {
                    BlocProvider.of<SettingsCubit>(context).setSpeed(0.5);
                    BlocProvider.of<SettingsCubit>(context)
                        .speak(words[index]['espanol']);
                  },
                  icon: const Icon(Icons.record_voice_over_outlined)),
              // child: RiveAnimatedIcon(
              //   riveIcon: RiveIcon.audio,
              //   width: 50,
              //   height: 50,
              //   color: kMainColor,
              //   loopAnimation: false,
              //   onTap: () {
              //     BlocProvider.of<SettingsCubit>(context).setSpeed(0.5);
              //     BlocProvider.of<SettingsCubit>(context)
              //         .speak(words[index]['espanol']);
              //   },
              // ),
            ),
          ],
        ),
      ],
    );
  }
}

class CheckBox extends StatelessWidget {
  const CheckBox({super.key, required this.value, required this.onChanged});

  final bool value;
  final void Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Transform.scale(
        scale: 1.5,
        child: Checkbox(
          value: value,
          onChanged: onChanged,
          activeColor: Colors.black,
          side: WidgetStateBorderSide.resolveWith(
            (states) => const BorderSide(color: kMainColor),
          ),
          visualDensity: VisualDensity.comfortable,
          // autofocus: true,
          checkColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
      ),
    );
  }
}


  //  FlutterTtsHelper ttsHelper = FlutterTtsHelper(languageCode: 'es');
  //             await ttsHelper.speak(words[index]['espanol']);

  