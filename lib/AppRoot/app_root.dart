import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_spanish/cubits/translation/cubit/translation_cubit.dart';
import 'package:learning_spanish/layout/cubit/layout_cubit.dart';

import '../layout/layout_screen.dart';
import '../core/utils/app_settings.dart';
import '../core/utils/app_theme.dart';

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    AppSettings.init(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LayoutCubit(),
        ),
        BlocProvider(
          create: (context) => TranslationCubit(),
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