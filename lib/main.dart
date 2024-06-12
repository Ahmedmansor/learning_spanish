import 'package:flutter/material.dart';

import 'AppRoot/app_root.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // FlutterTtsHelper.initTts(context);

  runApp(const AppRoot());
}

// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
// import 'package:youtube_explode_dart/youtube_explode_dart.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Flutter YouTube Player'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) =>
//                     const YouTubePlayerScreen(videoId: 'gTMyBHJ4x7g'),
//               ),
//             );
//           },
//           child: const Text('Play Video'),
//         ),
//       ),
//     );
//   }
// }

// class YouTubePlayerScreen extends StatefulWidget {
//   final String videoId;

//   const YouTubePlayerScreen({Key? key, required this.videoId})
//       : super(key: key);

//   @override
//   _YouTubePlayerScreenState createState() => _YouTubePlayerScreenState();
// }

// class _YouTubePlayerScreenState extends State<YouTubePlayerScreen> {
//   late YoutubePlayerController _controller;
//   List<ClosedCaption> subtitles = [];
//   late Timer _timer;
//   bool _isPlaying = false;
//   bool _stopTimer = false;

//   @override
//   void initState() {
//     super.initState();
//     _controller = YoutubePlayerController(
//       initialVideoId: widget.videoId,
//       flags: const YoutubePlayerFlags(
//         autoPlay: true,
//         mute: false,
//       ),
//     );
//     _loadSubtitles(widget.videoId);
//     _controller.addListener(_onPlayerStateChanged);
//   }

//   void _loadSubtitles(String videoId) async {
//     var yt = YoutubeExplode();
//     var tracks = await yt.videos.closedCaptions.getManifest(videoId);
//     var track = tracks.tracks.first;
//     var closedCaptions = await yt.videos.closedCaptions.get(track);
//     setState(() {
//       subtitles = closedCaptions.captions;
//     });
//     yt.close();
//   }

//   void _onPlayerStateChanged() {
//     final isPlaying = _controller.value.playerState == PlayerState.playing;
//     if (isPlaying && !_isPlaying) {
//       _startSubtitleTimer();
//     } else if (!isPlaying && _isPlaying) {
//       _stopSubtitleTimer();
//     }
//     setState(() {
//       _isPlaying = isPlaying;
//     });
//   }

//   void _startSubtitleTimer() {
//     _timer =
//         Timer.periodic(const Duration(milliseconds: 200), _updateSubtitles);
//   }

//   void _stopSubtitleTimer() {
//     _timer.cancel();
//   }

//   void _updateSubtitles(Timer timer) {
//     final currentPosition = _controller.value.position;
//     final index = subtitles.indexWhere(
//       (subtitle) =>
//           subtitle.duration <= currentPosition &&
//           currentPosition <= subtitle.end,
//     );
//     if (index != -1) {
//       _scrollController
//           .jumpTo(index * 55.0); // Adjust the scroll speed as neededa
//       if (subtitles.length - index <= 9) {
//         _stopTimer = true;
//         _stopSubtitleTimer();
//       }
//     }
//   }

//   final _scrollController = ScrollController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('YouTube Player with Subtitles'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             flex: 2,
//             child: YoutubePlayer(
//               controller: _controller,
//               showVideoProgressIndicator: true,
//               progressIndicatorColor: Colors.red,
//               width: MediaQuery.of(context).size.width,
//               onReady: () {
//                 print('Player is ready.');
//               },
//             ),
//           ),
//           Expanded(
//             flex: 3,
//             child: ListView.builder(
//               controller: _scrollController,
//               itemCount: subtitles.length,
//               itemBuilder: (context, index) {
//                 final subtitle = subtitles[index];
//                 return ListTile(
//                   title: Text(subtitle.text),
//                   onTap: () {
//                     _controller.seekTo(subtitle.offset);
//                     _controller.play();
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     _timer.cancel();
//     super.dispose();
//   }
// }

// void main() => runApp(MaterialApp(home: HomeScreen()));
