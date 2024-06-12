import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

part 'you_tube_player_screen_state.dart';

class YouTubePlayerScreenCubit extends Cubit<YouTubePlayerScreenState> {
  YouTubePlayerScreenCubit() : super(YouTubePlayerScreenInitial());
  static YouTubePlayerScreenCubit get(context) => BlocProvider.of(context);

  List<ClosedCaption> subtitles = [];
  late Timer _timer;
  final ScrollController _scrollController = ScrollController();
//loadSubtitles
  Future<void> loadSubtitles(String videoId) async {
    emit(YouTubePlayerLoadingSubtitles());
    try {
      var yt = YoutubeExplode();
      var tracks = await yt.videos.closedCaptions.getManifest(videoId);
      var track = tracks.tracks.first;
      var closedCaptions = await yt.videos.closedCaptions.get(track);
      subtitles = closedCaptions.captions;
      emit(YouTubePlayerLoadedSubtitles());
      yt.close();
    } catch (e) {
      emit(YouTubePlayerErrorSubtitles("Failed to load subtitles: $e"));
    }
  }

//updatePlayerState

  void updatePlayerState(YoutubePlayerController controller) {
    final isPlaying = controller.value.playerState == PlayerState.playing;
    if (isPlaying) {
      _startSubtitleTimer(controller);
      emit(YouTubePlayerPlaying());
    } else {
      _stopSubtitleTimer();
      emit(YouTubePlayerPaused());
    }
  }

  void _startSubtitleTimer(YoutubePlayerController controller) {
    _timer = Timer.periodic(const Duration(milliseconds: 200), (timer) {
      _updateSubtitles(controller);
    });
  }

  void _stopSubtitleTimer() {
    _timer.cancel();
  }

  void _updateSubtitles(YoutubePlayerController controller) {
    final currentPosition = controller.value.position;
    final index = subtitles.indexWhere(
      (subtitle) =>
          subtitle.duration <= currentPosition &&
          currentPosition <= subtitle.end,
    );
    if (index != -1) {
      _scrollController
          .jumpTo(index * 55.0); // Adjust the scroll speed as needed
    }
  }

  ScrollController get scrollController => _scrollController;
}
