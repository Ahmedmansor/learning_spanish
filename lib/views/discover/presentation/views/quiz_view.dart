import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stepindicator/flutter_stepindicator.dart';
import 'package:learning_spanish/core/utils/app_settings.dart';
import 'package:learning_spanish/core/widgets/custom_button.dart';
import 'package:learning_spanish/cubits/single_education_navigate_to/cubit/single_education_navigate_to_cubit.dart';
import 'package:learning_spanish/repos/colors.dart';

import '../../../../cubits/settings/cubit/settings_cubit.dart';

class CompleteStringQuizApp extends StatelessWidget {
  const CompleteStringQuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    // var cubit = SingleEducationNavigateToCubit.get(context);
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        SingleEducationNavigateToCubit.get(context).selectedAnswers = [];
        SingleEducationNavigateToCubit.get(context).currentQuestionIndex = 0;

        debugPrint('selectedAnswers = []');
      },
      child: const Scaffold(
        body: CompleteStringQuizScreen(),
      ),
    );
  }
}

class CompleteStringQuizScreen extends StatelessWidget {
  const CompleteStringQuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = SingleEducationNavigateToCubit.get(context);
    return Scaffold(
      body: BlocConsumer<SingleEducationNavigateToCubit,
          SingleEducationNavigateToState>(
        listener: (context, state) {
          if (state is FinishQuizStateSucess) {
            cubit.selectedAnswers = [];
            cubit.currentQuestionIndex = 0;

            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  AppSettings.heightSpace(amountHeight: 0.02),
                  FlutterStepIndicator(
                    negativeColor: Colors.grey,
                    positiveColor: kMainColor,
                    progressColor: kMainColor,
                    height: 20,
                    list: cubit.selectedQuestions,
                    onChange: (i) {},
                    page: cubit.currentQuestionIndex,
                  ),
                  AppSettings.heightSpace(amountHeight: 0.1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        cubit.currentQuestionIndex <
                                cubit.selectedQuestions.length
                            ? cubit
                                .selectedQuestions[cubit.currentQuestionIndex]
                            : "out of range",
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                          onPressed: () {
                            BlocProvider.of<SettingsCubit>(context)
                                .setSpeed(0.5);
                            BlocProvider.of<SettingsCubit>(context).speak(cubit
                                .selectedAnswers[cubit.currentQuestionIndex]);
                          },
                          icon: const Icon(Icons.record_voice_over)),
                    ],
                  ),
                  Wrap(
                    children:
                        List.generate(cubit.separatedChars.length, (index) {
                      if (cubit.separatedChars[index] == '') {
                        return SizedBox(
                          width: 20,
                          child: TextField(
                            textAlign: TextAlign.center,
                            controller: cubit.controllers[index],
                            maxLength: 1,
                            focusNode: cubit.focusNodes[index],
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                            decoration: const InputDecoration(
                              counterText: '',
                            ),

                            //use on changed just to handel the cursor yo go to the next empty field
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                int nextIndex = index + 1;
                                while (
                                    nextIndex < cubit.separatedChars.length &&
                                        cubit.separatedChars[nextIndex] != '') {
                                  nextIndex++;
                                }
                                if (nextIndex < cubit.separatedChars.length) {
                                  FocusScope.of(context).requestFocus(
                                      cubit.focusNodes[nextIndex]);
                                } else {
                                  FocusScope.of(context)
                                      .unfocus(); // Unfocus if no more empty fields
                                }
                              }
                            },
                          ),
                        );
                      } else if (cubit.separatedChars[index] == ' ') {
                        return const SizedBox(width: 20);
                      } else {
                        return Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: SizedBox(
                            width: 20,
                            child: Text(
                              cubit.separatedChars[index],
                              style: const TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                          ),
                        );
                      }
                    }),
                  ),
                  AppSettings.heightSpace(amountHeight: 0.1),
                  SizedBox(
                    width: AppSettings.width * 0.16,
                    child: CustomGeneralButton(
                      // radius: 5,
                      borderRadius: BorderRadius.circular(5),
                      text: 'Hint',
                      color: kMainColor.withOpacity(0.3),
                      onTap: () {
                        cubit.playHintSound();
                        cubit.prepareString();
                      },
                      height: 15,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    width: AppSettings.width * 0.5,
                    child: CustomGeneralButton(
                      // radius: 16,
                      borderRadius: BorderRadius.circular(16),

                      text: 'Next',
                      onTap: SingleEducationNavigateToCubit.get(context)
                          .checkAnswer,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
