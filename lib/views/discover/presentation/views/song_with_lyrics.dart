// import 'package:flutter/material.dart';
// import 'package:audioplayers/audioplayers.dart';
// import 'dart:async';
// import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
// import 'package:flutter/services.dart' show rootBundle;

// import '../../data/models/subtitle_model.dart';

// class SongWithLyricsScreen extends StatefulWidget {
//   const SongWithLyricsScreen({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _SongWithLyricsScreenState createState() => _SongWithLyricsScreenState();
// }

// class _SongWithLyricsScreenState extends State<SongWithLyricsScreen> {
//   final AudioPlayer _audioPlayer = AudioPlayer();
//   final ItemScrollController _scrollController = ItemScrollController();
//   List<Subtitle> _englishSubtitles = [];
//   // List<Subtitle> _arabicSubtitles = [];

//   int _currentSubtitleIndex = 0;
//   Duration _duration = Duration.zero;
//   Duration _position = Duration.zero;
//   bool _isPlaying = false;

//   @override
//   void initState() {
//     super.initState();
//     _loadEngSubtitles();
//     // _loadArabicSubtitles();
//     _audioPlayer.onPositionChanged.listen(_onAudioPositionChanged);
//     _audioPlayer.onDurationChanged.listen((Duration d) {
//       setState(() {
//         _duration = d;
//       });
//     });
//     _audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
//       setState(() {
//         _isPlaying = state == PlayerState.playing;
//       });
//     });
//     _audioPlayer.setSource(AssetSource('songs/Heartstrings and Goodbyes.mp3'));
//   }

//   Future<void> _loadEngSubtitles() async {
//     try {
//       final data = await rootBundle
//           .loadString('assets/lyrics/Heartstrings and Goodbyes.srt');
//       final lines = data.split('\n');
//       _englishSubtitles = _parseSrt(lines);
//       debugPrint('Subtitles loaded: $_englishSubtitles');
//     } catch (e) {
//       debugPrint('Error loading subtitles: $e');
//     }
//   }

//   List<Subtitle> _parseSrt(List<String> lines) {
//     final subtitles = <Subtitle>[];
//     int i = 0;
//     while (i < lines.length) {
//       // Skip empty lines
//       while (i < lines.length && lines[i].trim().isEmpty) {
//         i++;
//       }
//       // Parse subtitle index
//       if (i < lines.length && int.tryParse(lines[i]) != null) {
//         i++;
//       }
//       // Parse timecodes
//       if (i < lines.length && lines[i].contains('-->')) {
//         final times = lines[i].split(' --> ');
//         final start = _parseDuration(times[0]);
//         final end = _parseDuration(times[1]);
//         i++;
//         // Parse subtitle text
//         final textLines = <String>[];
//         while (i < lines.length && lines[i].trim().isNotEmpty) {
//           textLines.add(lines[i]);
//           i++;
//         }
//         final text = textLines.join('\n');
//         subtitles.add(Subtitle(start: start, end: end, text: text));
//       }
//     }
//     return subtitles;
//   }

//   Duration _parseDuration(String time) {
//     final parts = time.split(':');
//     final secondsParts = parts[2].split(',');
//     return Duration(
//       hours: int.parse(parts[0]),
//       minutes: int.parse(parts[1]),
//       seconds: int.parse(secondsParts[0]),
//       milliseconds: int.parse(secondsParts[1]),
//     );
//   }

//   void _onAudioPositionChanged(Duration position) {
//     setState(() {
//       _position = position;
//     });
//     for (var i = 0; i < _englishSubtitles.length; i++) {
//       if (position >= _englishSubtitles[i].start &&
//           position <= _englishSubtitles[i].end) {
//         if (_currentSubtitleIndex != i) {
//           setState(() {
//             _currentSubtitleIndex = i;
//           });
//           _scrollController.scrollTo(
//             index: i,
//             duration: const Duration(milliseconds: 300),
//             curve: Curves.easeInOut,
//           );
//         }
//         break;
//       }
//     }
//   }

//   void _togglePlayPause() {
//     if (_isPlaying) {
//       _audioPlayer.pause();
//     } else {
//       _audioPlayer.play(AssetSource('songs/Heartstrings and Goodbyes.mp3'));
//     }
//   }

//   void _seekTo(Duration position) {
//     _audioPlayer.seek(position);
//   }

//   @override
//   void dispose() {
//     _audioPlayer.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Song with Lyrics")),
//       body: Column(
//         children: [
//           // Play/Pause Button
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               IconButton(
//                 icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
//                 onPressed: _togglePlayPause,
//               ),
//             ],
//           ),

//           // Seek Bar
//           Slider(
//             value: _position.inMilliseconds.toDouble(),
//             min: 0.0,
//             max: _duration.inMilliseconds.toDouble(),
//             onChanged: (double value) {
//               setState(() {
//                 _position = Duration(milliseconds: value.toInt());
//               });
//               _seekTo(_position);
//             },
//           ),

//           // Lyrics Display
//           // Lyrics Display
//           Expanded(
//             child: ScrollablePositionedList.builder(
//               itemCount: _englishSubtitles.length,
//               itemScrollController: _scrollController,
//               itemBuilder: (context, index) {
//                 final englishSub = _englishSubtitles[index];
//                 // final arabicSub = _arabicSubtitles[
//                 //     index]; // assuming you have _arabicSubtitles list

//                 return Column(
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         _seekTo(englishSub.start);
//                         _audioPlayer.play(
//                           AssetSource('songs/Heartstrings and Goodbyes.mp3'),
//                         );
//                       },
//                       child: Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: Text(
//                           englishSub.text,
//                           style: TextStyle(
//                             fontSize: 18.0,
//                             fontWeight: _currentSubtitleIndex == index
//                                 ? FontWeight.bold
//                                 : FontWeight.w100,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 );
//               },
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../../../../cubits/songWithLyrics/cubit/song_with_lyrics_cubit.dart';
import '../../../../cubits/songWithLyrics/cubit/song_with_lyrics_state.dart';

class SongWithLyricsScreen extends StatelessWidget {
  const SongWithLyricsScreen(
      {super.key, required this.songName, this.subtitleFile, this.title});
  final String? title;
  final String? songName;
  final String? subtitleFile;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SongWithLyricsCubit(songName: songName!, subtitleFile: subtitleFile!),
      child: Scaffold(
        appBar: AppBar(title: Text(title!)),
        body: BlocBuilder<SongWithLyricsCubit, SongWithLyricsState>(
          builder: (context, state) {
            final cubit = context.read<SongWithLyricsCubit>();
            return Column(
              children: [
                // Play/Pause Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                          cubit.isPlaying ? Icons.pause : Icons.play_arrow),
                      onPressed: cubit.togglePlayPause,
                      // songName!,
                    ),
                  ],
                ),

                // Seek Bar
                Slider(
                  value: cubit.poosition.inMilliseconds.toDouble(),
                  min: 0.0,
                  max: cubit.duuration.inMilliseconds
                      .toDouble(), // Set max to the duration in milliseconds
                  onChanged: (double value) {
                    cubit.poosition = Duration(milliseconds: value.toInt());

                    cubit.seekTo(cubit.poosition);
                  },
                ),

                // Lyrics Display
                Expanded(
                  child: ScrollablePositionedList.builder(
                    itemCount: cubit.englishSubtitles.length,
                    itemScrollController: cubit.scrollController,
                    itemBuilder: (context, index) {
                      final englishSub = cubit.englishSubtitles[index];

                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              cubit.seekTo(englishSub.start);
                              cubit.audioPlayer.play(
                                AssetSource(
                                  // 'assets/songs/Heartstrings and Goodbyes.mp3'
                                  songName!,
                                ),
                              );
                              cubit.scrollController.scrollTo(
                                index: index,
                                duration: const Duration(milliseconds: 500),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                englishSub.text,
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight:
                                      cubit.currentSubtitleIndex == index
                                          ? FontWeight.bold
                                          : FontWeight.w100,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
