import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:remove_diacritic/remove_diacritic.dart';
import 'package:vibration/vibration.dart';

part 'single_education_navigate_to_state.dart';

class SingleEducationNavigateToCubit
    extends Cubit<SingleEducationNavigateToState> {
  SingleEducationNavigateToCubit() : super(SingleEducationNavigateToInitial());

  static SingleEducationNavigateToCubit get(context) =>
      BlocProvider.of(context);

// add user Questions in selectedQuestions list using check box
  bool value = true;
  List<String> selectedQuestions = [];

  void updateValue(bool newValue, String word) {
    value = newValue;

    if (newValue == true) {
      selectedQuestions.add(word);
    } else {
      selectedQuestions.remove(word);
    }
    emit(UpdateValueSucess());
    debugPrint(selectedQuestions.length.toString());
    debugPrint(selectedQuestions.toString());
  }

  // Clear selected questions
  void clearSelectedQuestions() {
    selectedQuestions.clear();
    currentQuestionIndex = 0;

    emit(ClearSelectedQuestionsSucess());
  }

// get answers for selected questions
  List<String> selectedAnswers = [];
  getAnswersForSelectedQuestions({
    required List<String> selectedQuestions,
    required List<String> allQuestions,
    required List<String> allAnswers,
  }) {
    for (String question in selectedQuestions) {
      int index = allQuestions.indexOf(question);

      if (index != -1) {
        selectedAnswers.add(allAnswers[index]);
      } else {
        selectedAnswers.add("Answer not found");
      }
    }

    // return selectedAnswers;
    for (int i = 0; i < selectedQuestions.length; i++) {
      debugPrint("Q: ${selectedQuestions[i]}");
      debugPrint("A: ${selectedAnswers[i]}\n");
      emit(GetAnswersForSelectedQuestionsSucess());
    }
  }

  // quiz functions
  // String originalString = 'Hello World';
  List<String> separatedChars = [];
  List<TextEditingController> controllers = [];
  List<int> emptyIndexes = [];
  int currentQuestionIndex = 0;
  List<FocusNode> focusNodes = [];
  // List<String> selectedAnswers = []; // Add your list of answers here

  void prepareString() {
    String originalString = selectedAnswers[currentQuestionIndex];
    separatedChars = originalString.split('');

    controllers = List.generate(
        separatedChars.length, (index) => TextEditingController());

    // focusNodes to go to the next field
    focusNodes = List.generate(separatedChars.length, (index) => FocusNode());

    // Determine the number of empty indexes based on the length of the string, By using this logic
    // the code ensures that the number of empty indexes is always appropriate for the length of the
    //string, preventing cases where all characters are left blank and maintaining a playable game logic.
    int numEmptyIndexes = min(3, separatedChars.length - 1);

    // Generate 3 random indexes to leave empty
    Random random = Random();
    emptyIndexes = [];
    while (emptyIndexes.length < numEmptyIndexes) {
      int index = random.nextInt(separatedChars.length);
      if (!emptyIndexes.contains(index) && separatedChars[index] != ' ') {
        emptyIndexes.add(index);
      }
    }

    for (int index in emptyIndexes) {
      separatedChars[index] = '';
    }
    emit(PrepareStringStateSucess());
  }

  // check answer
  void checkAnswer() {
    bool isCorrect = true;
    String originalString = selectedAnswers[currentQuestionIndex];

    for (int index in emptyIndexes) {
      String userInput = controllers[index].text;
      String normalizedUserInput = removeDiacritics(userInput).toLowerCase();
      String normalizedOriginal =
          removeDiacritics(originalString[index].toString().toLowerCase());

      if (normalizedUserInput != normalizedOriginal) {
        isCorrect = false;
        break;
      }
    }

    if (isCorrect) {
      if (currentQuestionIndex < selectedAnswers.length - 1) {
        playCorrectSound();
        emit(PrepareStringStateSucess());
        currentQuestionIndex++;
        prepareString();
      } else {
        finishQuiz();
        debugPrint('you ara fnished');
      }
    } else {
      debugPrint('try again');
      _vibrate();
      playWrongSound();
    }
  }

  // Show current answer as text
  void showCurrentAnswer() {
    if (currentQuestionIndex < selectedAnswers.length) {
      String currentAnswer = selectedAnswers[currentQuestionIndex];
      emit(ShowCurrentAnswerSuccess(currentAnswer));
      debugPrint(currentAnswer);
    }
  }
  //------------------------

//play sound when answer is correct
  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> playCorrectSound() async {
    try {
      // Play the sound file from assets
      await _audioPlayer.play(AssetSource('sounds/correctAnswer.mp3'));
    } catch (e) {
      debugPrint('Error playing sound: $e');
    }
  }
//play sound when answer is wrong

  Future<void> playWrongSound() async {
    try {
      // Play the sound file from assets
      await _audioPlayer.play(AssetSource('sounds/wrongAnswer.mp3'));
    } catch (e) {
      debugPrint('Error playing sound: $e');
    }
  }

  //play sound when click hint
  Future<void> playHintSound() async {
    try {
      // Play the sound file from assets
      await _audioPlayer.play(AssetSource('sounds/hintSound.mp3'));
    } catch (e) {
      debugPrint('Error playing sound: $e');
    }
  }

  //vibrate
  void _vibrate() async {
    // Check if the device can vibrate
    if (await Vibration.hasVibrator() ?? false) {
      // Vibrate for 500 milliseconds
      Vibration.vibrate(duration: 500);
    }
  }

  //finish quiz
  void finishQuiz() {
    emit(FinishQuizStateSucess());
  }
}
