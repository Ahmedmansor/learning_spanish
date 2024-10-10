import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:flutter/services.dart' show rootBundle;

class SongWithLyrics extends StatefulWidget {
  @override
  _SongWithLyricsState createState() => _SongWithLyricsState();
}

class _SongWithLyricsState extends State<SongWithLyrics> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final ItemScrollController _scrollController = ItemScrollController();
  List<Subtitle> _subtitles = [];
  int _currentSubtitleIndex = 0;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _loadSubtitles();
    _audioPlayer.onPositionChanged.listen(_onAudioPositionChanged);
    _audioPlayer.onDurationChanged.listen((Duration d) {
      setState(() {
        _duration = d;
      });
    });
    _audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      setState(() {
        _isPlaying = state == PlayerState.playing;
      });
    });
    _audioPlayer.setSource(AssetSource('songs/Heartstrings and Goodbyes.mp3'));
  }

  Future<void> _loadSubtitles() async {
    try {
      final data = await rootBundle
          .loadString('assets/lyrics/Heartstrings and Goodbyes.srt');
      final lines = data.split('\n');
      _subtitles = _parseSrt(lines);
      print('Subtitles loaded: $_subtitles');
    } catch (e) {
      print('Error loading subtitles: $e');
    }
  }

//   List<Subtitle> _parseSrt(List<String> lines) {
//     final subtitles = <Subtitle>[];
//     for (var i = 0; i < lines.length; i++) {
//       if (lines[i].contains('-->')) {
//         final times = lines[i].split(' --> ');
//         final start = _parseDuration(times[0]);
//         final end = _parseDuration(times[1]);
//         final text = lines[i + 1];
//         subtitles.add(Subtitle(start: start, end: end, text: text));
//       }
//     }
//     return subtitles;
//   }
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
    setState(() {
      _position = position;
    });
    for (var i = 0; i < _subtitles.length; i++) {
      if (position >= _subtitles[i].start && position <= _subtitles[i].end) {
        if (_currentSubtitleIndex != i) {
          setState(() {
            _currentSubtitleIndex = i;
          });
          _scrollController.scrollTo(
            index: i,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
        break;
      }
    }
  }

  void _togglePlayPause() {
    if (_isPlaying) {
      _audioPlayer.pause();
    } else {
      _audioPlayer.play(AssetSource('songs/Heartstrings and Goodbyes.mp3'));
    }
  }

  void _seekTo(Duration position) {
    _audioPlayer.seek(position);
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Song with Lyrics")),
      body: Column(
        children: [
          // Play/Pause Button
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                onPressed: _togglePlayPause,
              ),
            ],
          ),

          // Seek Bar
          Slider(
            value: _position.inMilliseconds.toDouble(),
            min: 0.0,
            max: _duration.inMilliseconds.toDouble(),
            onChanged: (double value) {
              setState(() {
                _position = Duration(milliseconds: value.toInt());
              });
              _seekTo(_position);
            },
          ),

          // Lyrics Display
          Expanded(
            child: ScrollablePositionedList.builder(
              itemCount: _subtitles.length,
              itemScrollController: _scrollController,
              itemBuilder: (context, index) {
                final subtitle = _subtitles[index];
                return GestureDetector(
                  onTap: () {
                    _seekTo(subtitle.start);
                    _audioPlayer.play(
                        AssetSource('songs/Heartstrings and Goodbyes.mp3'));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      subtitle.text,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: _currentSubtitleIndex == index
                            ? FontWeight.bold
                            : FontWeight.w100,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Subtitle {
  final Duration start;
  final Duration end;
  final String text;

  Subtitle({required this.start, required this.end, required this.text});
}
