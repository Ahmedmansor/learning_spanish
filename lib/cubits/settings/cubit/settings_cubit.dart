import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:learning_spanish/views/settings/data/models/real_voices_model.dart';

import '../../../repos/shared_pref_helper.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  late FlutterTts _flutterTts;
  List<Map> voices = [];
  SettingsCubit() : super(SettingsInitial()) {
    _flutterTts = FlutterTts();
    _getSelectedVoiceItemFun();
  }

  Map? currentVoice;

  static SettingsCubit get(context) => BlocProvider.of(context);
  List<RealVoicesModel> realVoices = [
    RealVoicesModel(name: 'Stella', sex: 'Male', location: 'United Kingdom'),
    RealVoicesModel(name: 'Serena', sex: 'Female', location: 'United States'),
    RealVoicesModel(name: 'Hans', sex: 'Male', location: 'United Kingdom'),
    RealVoicesModel(name: 'Stella', sex: 'Female', location: 'United Kingdom'),
    RealVoicesModel(name: 'Diego', sex: 'Female', location: 'United States'),
    RealVoicesModel(name: 'Luna', sex: 'Female', location: 'United Kingdom'),
    RealVoicesModel(name: 'Jack', sex: 'Male', location: 'United States'),
    RealVoicesModel(name: 'Maverick', sex: 'Female', location: 'United States'),
    RealVoicesModel(name: 'Leo', sex: 'Female', location: 'United Kingdom'),
    RealVoicesModel(name: 'Aurora', sex: 'Female', location: 'United States'),
    RealVoicesModel(name: 'Jasmine', sex: 'Female', location: 'United States'),
    RealVoicesModel(name: 'Luna', sex: 'Female', location: 'United Kingdom'),
    RealVoicesModel(name: 'Dana', sex: 'Female', location: 'United States'),
    RealVoicesModel(name: 'Mateo', sex: 'Male', location: 'United Kingdom'),
    RealVoicesModel(name: 'Sophia', sex: 'Female', location: 'United Kingdom'),
    RealVoicesModel(name: 'Valeria', sex: 'Female', location: 'United States'),
    RealVoicesModel(name: 'Marco', sex: 'Male', location: 'United Kingdom'),
    RealVoicesModel(name: 'Bruno', sex: 'Male', location: 'United Kingdom'),
    RealVoicesModel(name: 'Adam', sex: 'Male', location: 'United States'),
    RealVoicesModel(name: 'Marry', sex: 'Female', location: 'United States'),
    RealVoicesModel(name: 'Porter', sex: 'Male', location: 'UUnited States'),
    RealVoicesModel(name: 'Martin', sex: 'Male', location: 'United States'),
    RealVoicesModel(name: 'Alexa', sex: 'Female', location: 'United Kingdom'),
    RealVoicesModel(name: 'Jack', sex: 'Male', location: 'United States'),
  ];

  initTts() {
    initializeTts('en');
  }

  Future<void> initializeTts(
    String languageCode,
  ) async {
    await _flutterTts.setSharedInstance(true);
    await _flutterTts.setLanguage(languageCode);
    // await _flutterTts.setSpeechRate(speed);
    await _flutterTts.setPitch(1.0);
    await _flutterTts.setVolume(1.0);
    await _flutterTts.isLanguageAvailable(languageCode);
    await _flutterTts.getVoices.then(
      (data) {
        voices = List.from(data);
        voices = voices
            .where((v) =>
                v['name'].contains('en-gb') || v['name'].contains('en-us'))
            .toList();
        debugPrint("_voices $voices");
        currentVoice = currentVoice ??
            voices[CachMemory.getIntFromCachMemory(key: 'selectedVoiceIndex')!];
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

//to make the chek icon colored after press to any item in voices listview.builder
  int? isSelectedVoiceItem;
  void isSelectedVoiceItemFun(int indix) {
    isSelectedVoiceItem = indix;
    emit(IsSelectedVoiceItemChanged());
  }

  //to make the the checkk icon of the stored selected voice coolors after restart the app
  void _getSelectedVoiceItemFun() {
    isSelectedVoiceItem =
        CachMemory.getIntFromCachMemory(key: 'isSelectedVoiceItem');
    emit(GetSelectedVoiceItemFunSucess());
  }
}
