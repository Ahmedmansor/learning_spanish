import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:translator/translator.dart';

import '../../../../../cubits/songWithLyrics/cubit/song_with_lyrics_cubit.dart';
import '../../../../../cubits/songWithLyrics/cubit/song_with_lyrics_state.dart';
import '../../../../../repos/colors.dart';
import '../aj_hog_stream_view.dart';

class TabBatItem extends StatelessWidget {
  final String subtitleFile;
  final String audioFile;

  const TabBatItem({
    super.key,
    required this.subtitleFile,
    required this.audioFile,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SongWithLyricsCubit(
        subtitleFile: subtitleFile,
        songName: audioFile,
      ),
      child: Scaffold(
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
                    ),
                  ],
                ),
                // Seek Bar
                Slider(
                  value: cubit.poosition.inMilliseconds.toDouble(),
                  min: 0.0,
                  max: cubit.duuration.inMilliseconds.toDouble(),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              cubit.seekTo(englishSub.start);
                              cubit.audioPlayer.play(
                                AssetSource(
                                  audioFile,
                                ),
                              );
                              cubit.scrollController.scrollTo(
                                index: index,
                                duration: const Duration(milliseconds: 500),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: RichText(
                                text: TextSpan(
                                  children:
                                      englishSub.text.split(' ').map((word) {
                                    return TextSpan(
                                      text: '$word ',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight:
                                            cubit.currentSubtitleIndex == index
                                                ? FontWeight.bold
                                                : FontWeight.w100,
                                        color:
                                            cubit.currentSubtitleIndex == index
                                                ? Colors.white
                                                : kMainColor.withOpacity(0.5),
                                      ),
                                      recognizer: LongPressGestureRecognizer()
                                        ..onLongPress = () async {
                                          final language = await detectLanguage(
                                              word); // You need to implement this function

                                          final translation =
                                              await GoogleTranslator()
                                                  .translate(
                                            word,
                                            from:
                                                language == 'en' ? 'en' : 'ar',
                                            to: language == 'en' ? 'ar' : 'en',
                                          );
                                          Fluttertoast.showToast(
                                            msg: translation.text,
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 3,
                                            backgroundColor: Colors.grey,
                                            textColor: Colors.white,
                                            fontSize: 16.0,
                                          );
                                        },
                                    );
                                  }).toList(),
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
