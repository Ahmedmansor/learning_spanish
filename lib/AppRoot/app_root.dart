import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_spanish/core/utils/app_settings.dart';
import 'package:learning_spanish/cubits/charts/cubit/charts_cubit.dart';
import 'package:learning_spanish/cubits/discover/cubit/discover_cubit.dart';
import 'package:learning_spanish/cubits/translation/cubit/translation_cubit.dart';
import 'package:learning_spanish/layout/cubit/layout_cubit.dart';
import 'package:learning_spanish/repos/flutter_tts.dart';

import '../cubits/discover/alphapet_animation/cubit/alphapet_animation_cubit.dart';
import '../cubits/settings/cubit/settings_cubit.dart';
import '../cubits/single_education_navigate_to/cubit/single_education_navigate_to_cubit.dart';
import '../cubits/you_tube_player_screen/cubit/you_tube_player_screen_cubit.dart';
import '../layout/layout_screen.dart';
import '../core/utils/app_theme.dart';

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    AppSettings.init(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => DiscoverCubit(),
        ),
        BlocProvider(
          create: (context) => LayoutCubit(),
        ),
        BlocProvider(
          create: (context) => TranslationCubit(),
        ),
        BlocProvider(
          create: (context) => SettingsCubit()..initTts(),
        ),
        BlocProvider(
          create: (context) => SingleEducationNavigateToCubit(),
        ),
        BlocProvider(create: (context) => YouTubePlayerScreenCubit()),
        BlocProvider(
          create: (context) => AlpphapetAnimationCubit(),
        ),
        BlocProvider(
          create: (context) => ChartsCubit(),
        ),
      ],
      child: BlocBuilder<LayoutCubit, LayoutState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Learning Spanish',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: LayoutCubit.get(context).isDark
                ? ThemeMode.dark
                : ThemeMode.light,
            home: const LayoutScreen(),
          );
        },
      ),
    );
  }
}
