import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:translator/translator.dart';

part 'translation_state.dart';

class TranslationCubit extends Cubit<TranslationState> {
  TranslationCubit() : super(TranslationInitial());

  static TranslationCubit get(context) => BlocProvider.of(context);

  String translated = 'Traduccion';
  void translate(String text) async {
    final translation = await text.translate(from: 'en', to: 'es');
    translated = translation.text;
    emit(TranslationSucess());
  }
}
