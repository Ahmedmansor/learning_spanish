import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:meta/meta.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  late FlutterTts _flutterTts;
  List<Map> voices = [];
  SettingsCubit() : super(SettingsInitial()) {
    _flutterTts = FlutterTts();
  }

  Map? currentVoice;

  static SettingsCubit get(context) => BlocProvider.of(context);

  initTts() {
    initializeTts('es-US');
  }

  Future<void> initializeTts(
    String languageCode,
  ) async {
    await _flutterTts.setSharedInstance(true);
    await _flutterTts.setLanguage(languageCode);
    // await _flutterTts.setSpeechRate(speed);
    await _flutterTts.setPitch(1.0);
    await _flutterTts.setVolume(1.0);
    await _flutterTts.getVoices.then(
      (data) {
        voices = List.from(data);
        voices = voices.where((v) => v['name'].contains('es')).toList();
        // debugPrint("_voices $voices");
        currentVoice = currentVoice ?? voices[0];
        setVoice(currentVoice);
        debugPrint("5060");
        debugPrint('voices ${voices.length}');
      },
    );
  }

  void setVoice(Map? currentVoice) async {
    await _flutterTts.setVoice(
        {"name": currentVoice!['name'], "locale": currentVoice['locale']});
    emit(VoiceChangedSucess());
  }

  void setSpeed(double speed) async {
    await _flutterTts.setSpeechRate(speed);
    emit(SpeedChangedSuccess());
  }

  Future<void> speak(String text) async {
    await _flutterTts.speak(text);
  }

  Future<void> stop() async {
    await _flutterTts.stop();
  }

  Future<void> pause() async {
    await _flutterTts.pause();
  }

  // final AnimateIconController iconController = AnimateIconController();
  // iconAnimation(context) async {
  //   iconController.animateToStart();
  //   await Future.delayed(const Duration(milliseconds: 500), () {
  //     iconController.animateToEnd();
  //     emit(ChangeIconSttate());
  //   });
  // }
}
