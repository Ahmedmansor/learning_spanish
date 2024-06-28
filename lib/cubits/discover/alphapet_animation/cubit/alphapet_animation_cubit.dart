import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_spanish/cubits/discover/alphapet_animation/cubit/alphapet_animation_state.dart';

class AlpphapetAnimationCubit extends Cubit<AlpphapetAnimationState> {
  AlpphapetAnimationCubit()
      : super(AlpphapetAnimationState(scale: 1.0, rotation: 0.0, opacity: 1.0));

  void animateDown() =>
      emit(AlpphapetAnimationState(scale: 0.9, rotation: 0.1, opacity: 0.7));
  void animateUp() =>
      emit(AlpphapetAnimationState(scale: 1.0, rotation: 0.0, opacity: 1.0));
}
