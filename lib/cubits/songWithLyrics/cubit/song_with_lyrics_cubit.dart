import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:learning_spanish/cubits/songWithLyrics/cubit/song_with_lyrics_state.dart';
import 'dart:async';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../../../views/discover/data/models/subtitle_model.dart';

class SongWithLyricsCubit extends Cubit<SongWithLyricsState> {
  final String subtitleFile;
  final String songName;

  final AudioPlayer audioPlayer = AudioPlayer();
  final ItemScrollController scrollController = ItemScrollController();
  List<Subtitle> englishSubtitles = [];
  int currentSubtitleIndex = 0;
  Duration duuration = Duration.zero;
  Duration poosition = Duration.zero;
  bool isPlaying = false;

  SongWithLyricsCubit({required this.subtitleFile, required this.songName})
      : super(SongWithLyricsInitial()) {
    _loadEngSubtitles();
    togglePlayPause();
    audioPlayer.onPositionChanged.listen(_onAudioPositionChanged);
    audioPlayer.onDurationChanged.listen((Duration duration) {
      duuration = duration;
      emit(SongWithLyricsMoveState(duration: duration));
    });
    audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      isPlaying = state == PlayerState.playing;
      emit(SongWithLyricsMoveState(isPlaying: isPlaying));
    });
  }

  Future<void> _loadEngSubtitles() async {
    try {
      emit(SongWithLyricsSubtitlesLoading());

      final data = await rootBundle.loadString(subtitleFile);
      // 'assets/lyrics/Heartstrings and Goodbyes.srt'
      final lines = data.split('\n');
      englishSubtitles = _parseSrt(lines);
      emit(SongWithLyricsSubtitlesLoaded(englishSubtitles));
    } catch (e) {
      emit(SongWithLyricsError(e));
    }
  }

  List<Subtitle> _parseSrt(List<String> lines) {
    final subtitles = <Subtitle>[];
    int i = 0;
    while (i < lines.length) {
      // Skip empty lines
      while (i < lines.length && lines[i].trim().isEmpty) {
        i++;
      }
      // Parse subtitle index
      if (i < lines.length && int.tryParse(lines[i]) != null) {
        i++;
      }
      // Parse timecodes
      if (i < lines.length && lines[i].contains('-->')) {
        final times = lines[i].split(' --> ');
        final start = _parseDuration(times[0]);
        final end = _parseDuration(times[1]);
        i++;
        // Parse subtitle text
        final textLines = <String>[];
        while (i < lines.length && lines[i].trim().isNotEmpty) {
          textLines.add(lines[i]);
          i++;
        }
        final text = textLines.join('\n');
        subtitles.add(Subtitle(start: start, end: end, text: text));
      }
    }
    return subtitles;
  }

  Duration _parseDuration(String time) {
    final parts = time.split(':');
    final secondsParts = parts[2].split(',');
    return Duration(
      hours: int.parse(parts[0]),
      minutes: int.parse(parts[1]),
      seconds: int.parse(secondsParts[0]),
      milliseconds: int.parse(secondsParts[1]),
    );
  }

  void _onAudioPositionChanged(Duration position) {
    poosition = position;
    emit(SongWithLyricsPositionChanged(position));
    for (var i = 0; i < englishSubtitles.length; i++) {
      if (position >= englishSubtitles[i].start &&
          position <= englishSubtitles[i].end) {
        if (currentSubtitleIndex != i) {
          currentSubtitleIndex = i;
          emit(SongWithLyricsCurrentSubtitleIndexChanged(i));
          scrollController.scrollTo(
            index: i,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
        break;
      }
    }
  }

  void togglePlayPause() {
    if (isPlaying) {
      audioPlayer.pause();
    } else {
      audioPlayer.play(AssetSource(songName));
      // 'songs/Heartstrings and Goodbyes.mp3'
    }
    emit(SongWithLyricsMoveState(isPlaying: !isPlaying));
  }

  void seekTo(Duration position) {
    audioPlayer.seek(position);
    poosition = position;

    emit(SongWithLyricsMoveState(position: position));
  }

  @override
  Future<void> close() {
    audioPlayer.dispose();
    return super.close();
  }
}
