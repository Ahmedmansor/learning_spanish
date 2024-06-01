import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta/meta.dart';
import 'package:translator/translator.dart';

part 'translation_state.dart';

class TranslationCubit extends Cubit<TranslationState> {
  TranslationCubit() : super(TranslationInitial());

  static TranslationCubit get(context) => BlocProvider.of(context);

  String from = 'en';
  String to = 'es';
  void swapLanguages() {
    from != 'en' ? from = 'en' : from = 'es';
    to != 'es' ? to = 'es' : to = 'en';
    emit(SwapTranslationSucess());
  }

// Created a text editing controller to con clear the text in text field
  TextEditingController textEditingController = TextEditingController();
  String translated = '';

  void translate(String text, String from, String to) async {
    final translation = await text.translate(from: from, to: to);
    emit(TranslationSucess());
    text = textEditingController.text;
    translated = translation.text;
  }

  void clear() {
    textEditingController.clear();
    translated = '';
    emit(ClearSucess());
  }

  Future copyToClipBoard() async {
    await Clipboard.setData(ClipboardData(
      text: translated,
    ));

    emit(copyToClipBoardSucess());
    await Fluttertoast.showToast(
        msg: "copied to clipboard",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        textColor: Colors.black,
        backgroundColor: Colors.white,
        fontSize: 16.0);
    debugPrint('toast');
  }
}
