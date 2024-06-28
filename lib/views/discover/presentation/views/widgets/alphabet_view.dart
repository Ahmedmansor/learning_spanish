import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_spanish/cubits/discover/cubit/discover_cubit.dart';

import '../../../../../cubits/discover/alphapet_animation/cubit/alphapet_animation_cubit.dart';
import '../../../../../cubits/discover/alphapet_animation/cubit/alphapet_animation_state.dart';
import '../../../../../cubits/settings/cubit/settings_cubit.dart';
import '../../../../../repos/colors.dart';

// Assuming kMainColor and SettingsCubit are defined elsewhere

class AlphabetView extends StatelessWidget {
  const AlphabetView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<SettingsCubit>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 10,
            childAspectRatio: 0.8,
          ),
          itemCount: DiscoverCubit.get(context).spanishAlphabet.length,
          itemBuilder: (context, index) {
            return AlphabetItem(
              letter: DiscoverCubit.get(context).spanishAlphabet[index],
              onTap: () {
                cubit.speak(DiscoverCubit.get(context).spanishAlphabet[index]);

                context.read<AlpphapetAnimationCubit>().animateDown();
              },
            );
          },
        ),
      )
          .animate()
          .blur(begin: const Offset(5.0, 10.0), end: Offset.zero, delay: 400.ms)
          .fadeIn(delay: 100.ms)
          .rotate(begin: 0.2, end: 0.0, delay: 100.ms),
    );
  }
}

class AlphabetItem extends StatelessWidget {
  final String letter;
  final VoidCallback onTap;

  const AlphabetItem({
    Key? key,
    required this.letter,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AlpphapetAnimationCubit(),
      child: BlocBuilder<AlpphapetAnimationCubit, AlpphapetAnimationState>(
        builder: (context, state) {
          return InkWell(
            onTap: () {
              // Trigger the animation down and up with a delay
              context.read<AlpphapetAnimationCubit>().animateDown();
              Future.delayed(const Duration(milliseconds: 100), () {
                context.read<AlpphapetAnimationCubit>().animateUp();
              });

              onTap();
            },
            onTapDown: (_) =>
                context.read<AlpphapetAnimationCubit>().animateDown(),
            onTapUp: (_) => context.read<AlpphapetAnimationCubit>().animateUp(),
            onTapCancel: () =>
                context.read<AlpphapetAnimationCubit>().animateUp(),
            child: Transform.scale(
              scale: state.scale,
              child: Transform.rotate(
                angle: state.rotation,
                child: Opacity(
                  opacity: state.opacity,
                  child: Container(
                    decoration: BoxDecoration(
                      color: kMainColor.withOpacity(0.6),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        letter,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 70,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
