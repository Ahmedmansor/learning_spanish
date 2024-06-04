import 'package:flutter/material.dart';

import 'AppRoot/app_root.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // FlutterTtsHelper.initTts(context);

  runApp(const AppRoot());
}
//----------------------------------------------------------

// import 'package:flutter/material.dart';
// import 'package:flutter_animated_icons/icons8.dart';
// import 'package:lottie/lottie.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   // FlutterTtsHelper.initTts(context);

//   runApp(const MyHomePage());
// }

// class MyHomePage extends StatelessWidget {
//   const MyHomePage({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Animated Icons',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const AnimatedIcon(),
//     );
//   }
// }

// class AnimatedIcon extends StatefulWidget {
//   const AnimatedIcon({
//     super.key,
//   });

//   @override
//   State<AnimatedIcon> createState() => _AnimatedIconState();
// }

// class _AnimatedIconState extends State<AnimatedIcon>
//     with TickerProviderStateMixin {
//   late AnimationController _settingController;
//   @override
//   initState() {
//     super.initState();
//     _settingController = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 1),
//     );
//   }

//   @override
//   void dispose() {
//     _settingController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: IconButton(
//           splashRadius: 50,
//           iconSize: 100,
//           onPressed: () {
//             _settingController.reset();
//             _settingController.forward();
//           },
//           icon: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Lottie.asset(
//               Icons8.adjust,
//               controller: _settingController,
//             ),
//           )),
//     );
//   }
// }
