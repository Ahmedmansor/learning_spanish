// flutter_animated_icons 1.0.1 
  // # lottie: ^1.4.3

//---------------------------------------------
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
//     return IconButton(
//         splashRadius: 10,
//         iconSize: 10,
//         onPressed: () {
      

//           _settingController.reset();
//           _settingController.forward();
//         },
//         icon: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Lottie.asset(
//             Icons8.add_cloud,
//             controller: _settingController,
//           ),
//         ));
//   }
// }
//---------------------------------------------
  // animated_icon: ^0.0.9
  // AnimateIcon(
  //               key: UniqueKey(),
  //               onTap: () {
  //                 BlocProvider.of<SettingsCubit>(context).setSpeed(0.5);

  //                 BlocProvider.of<SettingsCubit>(context)
  //                     .speak(words[index]['espanol']);
  //               },
  //               iconType: IconType.animatedOnTap,
  //               height: 70,
  //               width: 70,
  //               animateIcon: AnimateIcons.wink,
  //               color: kMainColor,
  //             ),
//---------------------------------------------
// rive_animated_icon: ^1.1.2
