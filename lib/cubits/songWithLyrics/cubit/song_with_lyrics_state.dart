import 'package:learning_spanish/views/discover/data/models/subtitle_model.dart';

abstract class SongWithLyricsState {}

class SongWithLyricsInitial extends SongWithLyricsState {}

class SongWithLyricsSubtitlesLoaded extends SongWithLyricsState {
  final List<Subtitle> subtitles;

  SongWithLyricsSubtitlesLoaded(this.subtitles);
}

class SongWithLyricsPositionChanged extends SongWithLyricsState {
  final Duration position;

  SongWithLyricsPositionChanged(this.position);
}

class SongWithLyricsCurrentSubtitleIndexChanged extends SongWithLyricsState {
  final int index;

  SongWithLyricsCurrentSubtitleIndexChanged(this.index);
}

class SongWithLyricsError extends SongWithLyricsState {
  final Object error;

  SongWithLyricsError(this.error);
}

class SongWithLyricsMoveState extends SongWithLyricsState {
  final bool? isPlaying;
  final Duration? position;
  final Duration? duration;

  SongWithLyricsMoveState({this.isPlaying, this.position, this.duration});
}
