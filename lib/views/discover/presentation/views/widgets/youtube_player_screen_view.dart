import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../../cubits/you_tube_player_screen/cubit/you_tube_player_screen_cubit.dart';

class YouTubePlayerScreen extends StatefulWidget {
  // var cubit = YouTubePlayerScreenCubit.get(context);
  final String videoId;

  const YouTubePlayerScreen({
    Key? key,
    required this.videoId,
  }) : super(key: key);

  @override
  _YouTubePlayerScreenState createState() => _YouTubePlayerScreenState();
}

class _YouTubePlayerScreenState extends State<YouTubePlayerScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    var cubit = YouTubePlayerScreenCubit.get(context);
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );

    _controller.addListener(_onPlayerStateChanged);
    cubit.loadSubtitles(widget.videoId);
  }

  void _onPlayerStateChanged() {
    context.read<YouTubePlayerScreenCubit>().updatePlayerState(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('YouTube Player with Subtitles'),
      ),
      body: BlocBuilder<YouTubePlayerScreenCubit, YouTubePlayerScreenState>(
        builder: (context, state) {
          if (state is YouTubePlayerLoadingSubtitles) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is YouTubePlayerErrorSubtitles) {
            return Center(child: Text(state.error));
          } else if (state is YouTubePlayerLoadedSubtitles ||
              state is YouTubePlayerPlaying ||
              state is YouTubePlayerPaused) {
            final cubit = context.read<YouTubePlayerScreenCubit>();
            return Column(
              children: [
                Expanded(
                  flex: 2,
                  child: YoutubePlayer(
                    controller: _controller,
                    showVideoProgressIndicator: true,
                    progressIndicatorColor: Colors.red,
                    width: MediaQuery.of(context).size.width,
                    onReady: () {
                      print('Player is ready.');
                    },
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: ListView.builder(
                    controller: cubit.scrollController,
                    itemCount: cubit.subtitles.length,
                    itemBuilder: (context, index) {
                      final subtitle = cubit.subtitles[index];
                      return ListTile(
                        title: Text(subtitle.text),
                        onTap: () {
                          _controller.seekTo(subtitle.offset);
                          _controller.play();
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: Text('No subtitles available'));
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
