import 'package:flutter_tts/flutter_tts.dart';

import '../cubits/settings/cubit/settings_cubit.dart';

class FlutterTtsHelper {
  static FlutterTts flutterTts = FlutterTts();
  // static late String languageCode;

  static initTts(context) {
    SettingsCubit.get(context).initializeTts('es-US');
  }

  static Future<void> speak(String text) async {
    await flutterTts.speak(text);
  }

  Future<void> stop() async {
    await flutterTts.stop();
  }

  Future<void> pause() async {
    await flutterTts.pause();
  }
}
