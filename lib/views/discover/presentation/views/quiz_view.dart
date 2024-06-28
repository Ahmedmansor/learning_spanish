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
        // SingleEducationNavigateToCubit.get(context).selectedQuestions = [];

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
            // cubit.selectedQuestions = [];

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
                  SizedBox(
                    width: AppSettings.width,
                    child: FlutterStepIndicator(
                      negativeColor: Colors.grey,
                      positiveColor: kMainColor,
                      progressColor: kMainColor,
                      height: cubit.selectedQuestions.length <= 11 ? 15 : 1,
                      list: cubit.selectedQuestions,
                      onChange: (i) {},
                      page: cubit.currentQuestionIndex,
                      division: cubit.selectedQuestions.length,
                    ),
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
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                            decoration: const InputDecoration(
                              counterText: '',
                            ),
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
                              } else {
                                int prevIndex = index - 1;
                                while (prevIndex >= 0 &&
                                    cubit.separatedChars[prevIndex] != '') {
                                  prevIndex--;
                                }
                                if (prevIndex >= 0) {
                                  FocusScope.of(context).requestFocus(
                                      cubit.focusNodes[prevIndex]);
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
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      }
                    }),
                  ),
                  AppSettings.heightSpace(amountHeight: 0.1),
                  SizedBox(
                    width: AppSettings.width * 0.6,
                    child: CustomGeneralButton(
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(16),
                          topLeft: Radius.circular(16)),
                      text: 'Next',
                      onTap: SingleEducationNavigateToCubit.get(context)
                          .checkAnswer,
                    ),
                  ),
                  SizedBox(
                    width: AppSettings.width * 0.6,
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            child: CustomGeneralButton(
                              borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(16)),
                              text: 'Hint',
                              color: kMainColor.withOpacity(0.5),
                              onTap: () {
                                cubit.playHintSound();
                                cubit.prepareString();
                              },
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            width: AppSettings.width,
                            child: CustomGeneralButton(
                              // radius: 16,
                              borderRadius: const BorderRadius.only(
                                  bottomRight: Radius.circular(16)),
                              color: kMainColor.withOpacity(0.2),

                              text: 'Show Answer',
                              fontSize: 16,
                              onTap: SingleEducationNavigateToCubit.get(context)
                                  .showCurrentAnswer,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  BlocBuilder<SingleEducationNavigateToCubit,
                          SingleEducationNavigateToState>(
                      builder: (context, state) {
                    if (state is ShowCurrentAnswerSuccess) {
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: kMainColor.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: kMainColor.withOpacity(0.6),
                              spreadRadius: 7,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Text(
                          state.answer,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                            letterSpacing: 5,
                          ),
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  }),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
