part of 'single_education_navigate_to_cubit.dart';

@immutable
sealed class SingleEducationNavigateToState {}

final class SingleEducationNavigateToInitial
    extends SingleEducationNavigateToState {}

final class UpdateValueSucess extends SingleEducationNavigateToState {}

final class ClearSelectedQuestionsSucess
    extends SingleEducationNavigateToState {}
