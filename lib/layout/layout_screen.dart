import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:molten_navigationbar_flutter/molten_navigationbar_flutter.dart';
import 'cubit/layout_cubit.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LayoutCubit, LayoutState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              Switch(
                value: LayoutCubit.get(context).isDark,
                onChanged: (value) {
                  LayoutCubit.get(context).changeTheme();
                },
              ),
            ],
          ),
          body:
              LayoutCubit.get(context).screens[LayoutCubit.get(context).index],
          bottomNavigationBar: MoltenBottomNavigationBar(
            barColor: LayoutCubit.get(context).isDark
                ? Colors.transparent
                : Colors.white,
            borderColor:
                LayoutCubit.get(context).isDark ? Colors.white : Colors.black,
            domeCircleColor: LayoutCubit.get(context).isDark
                ? Colors.transparent
                : Colors.black,
            borderSize: 0.1,
            domeCircleSize: 50,
            domeHeight: 15,
            barHeight: 60,
            domeWidth: 100,
            margin: const EdgeInsets.only(bottom: 5, left: 5, right: 5),
            selectedIndex: LayoutCubit.get(context).index,
            onTabChange: (clickedIndex) {
              LayoutCubit.get(context).changeScreen(clickedIndex);
            },
            tabs: [
              MoltenTab(
                // selectedColor: Colors.white,
                // unselectedColor: Colors.grey,
                icon: const Icon(
                  Icons.explore,
                  size: 35,
                ),
                title: const Text(
                  'Discover',
                ),
              ),
              MoltenTab(
                icon: const Icon(
                  Icons.translate_outlined,
                  size: 35,
                ),
                title: const Text(
                  'translation',
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
