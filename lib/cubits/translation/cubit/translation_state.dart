part of 'translation_cubit.dart';

@immutable
sealed class TranslationState {}

final class TranslationInitial extends TranslationState {}

final class TranslationSucess extends TranslationState {}

final class SwapTranslationSucess extends TranslationState {}

final class ClearSucess extends TranslationState {}

final class copyToClipBoardSucess extends TranslationState {}
