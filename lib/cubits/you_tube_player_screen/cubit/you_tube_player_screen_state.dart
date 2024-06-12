part of 'you_tube_player_screen_cubit.dart';

@immutable
sealed class YouTubePlayerScreenState {}

final class YouTubePlayerScreenInitial extends YouTubePlayerScreenState {}

//----------------------------------------------------------------------------------------------
final class YouTubePlayerLoadingSubtitles extends YouTubePlayerScreenState {}

class YouTubePlayerLoadedSubtitles extends YouTubePlayerScreenState {
  // final List<ClosedCaption> subtitles;
  YouTubePlayerLoadedSubtitles();
}

final class YouTubePlayerErrorSubtitles extends YouTubePlayerScreenState {
  final String error;
  YouTubePlayerErrorSubtitles(this.error);
}

//---------------------------------------------------------------------------------------------
class YouTubePlayerPlaying extends YouTubePlayerScreenState {}

class YouTubePlayerPaused extends YouTubePlayerScreenState {}

class YouTubePlayerError extends YouTubePlayerScreenState {
  final String message;
  YouTubePlayerError(this.message);
}
