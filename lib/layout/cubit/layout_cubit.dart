import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_spanish/views/discover/presentation/views/discover_screen_view.dart';
import '../../views/translate/translate_screen.dart';
part 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(LayoutInitial());

  static LayoutCubit get(context) => BlocProvider.of(context);

  int index = 0;
  List<Widget> screens = const [
    DiscoverScreenView(),
    TranslateScreen(),
  ];

  void changeScreen(i) {
    index = i;
    emit(ChangeScreenState());
  }

//theme
  bool isDark = true;

  void changeTheme() {
    isDark = !isDark;
    emit(ChangeThemeState());
  }
}
