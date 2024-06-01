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
          // appBar: AppBar(

          //   actions: [
          //     Switch(
          //       value: LayoutCubit.get(context).isDark,
          //       onChanged: (value) {
          //         LayoutCubit.get(context).changeTheme();
          //       },
          //     ),
          //   ],
          // ),
          body:
              LayoutCubit.get(context).screens[LayoutCubit.get(context).index],
          bottomNavigationBar: MoltenBottomNavigationBar(
            barColor: const Color(0xffF7F7F9),
            domeCircleColor: Colors.black,
            borderSize: 50,
            domeHeight: 25,
            selectedIndex: LayoutCubit.get(context).index,
            onTabChange: (clickedIndex) {
              LayoutCubit.get(context).changeScreen(clickedIndex);
            },
            tabs: [
              MoltenTab(
                icon: const Icon(
                  Icons.explore,
                  size: 35,
                ),
                title: const Text(
                  'Discover',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              MoltenTab(
                icon: const Icon(
                  Icons.translate_outlined,
                  size: 35,
                ),
                title: const Text(
                  'translation',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
