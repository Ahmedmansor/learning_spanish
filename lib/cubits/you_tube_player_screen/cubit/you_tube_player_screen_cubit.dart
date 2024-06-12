import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'you_tube_player_screen_state.dart';

class YouTubePlayerScreenCubit extends Cubit<YouTubePlayerScreenState> {
  YouTubePlayerScreenCubit() : super(YouTubePlayerScreenInitial());
  static YouTubePlayerScreenCubit get(context) => BlocProvider.of(context);
}
