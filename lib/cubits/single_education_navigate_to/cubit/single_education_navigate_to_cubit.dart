import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'single_education_navigate_to_state.dart';

class SingleEducationNavigateToCubit
    extends Cubit<SingleEducationNavigateToState> {
  SingleEducationNavigateToCubit() : super(SingleEducationNavigateToInitial());

  static SingleEducationNavigateToCubit get(context) =>
      BlocProvider.of(context);

  bool value = true;
  List<String> selectedValues = [];

  void updateValue(bool newValue, String word) {
    value = newValue;

    if (newValue == true) {
      selectedValues.add(word);
    } else {
      selectedValues.remove(word);
    }
    emit(UpdateValueSucess());
    debugPrint(selectedValues.length.toString());
    debugPrint(selectedValues.toString());
  }
}
    // if (newValue == true) {
    //           selectedValues.add(words[index]['espanol']);
    //         } else {
    //           selectedValues.remove(words[index]['espanol']);
    //         }
    //         debugPrint(selectedValues.length.toString());