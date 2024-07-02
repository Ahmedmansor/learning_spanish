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
    RealVoicesModel(name: 'Stella', sex: 'Female', location: 'United States'),
    RealVoicesModel(name: 'Serena', sex: 'Female', location: 'United States'),
    RealVoicesModel(name: 'Stella', sex: 'Female', location: 'United States'),
    RealVoicesModel(name: 'Apollo', sex: 'Male', location: 'United States'),
    RealVoicesModel(name: 'Diego', sex: 'Male', location: 'Spain'),
    RealVoicesModel(name: 'Luna', sex: 'Female', location: 'Spain'),
    RealVoicesModel(name: 'Valentina', sex: 'Female', location: 'Spain'),
    RealVoicesModel(name: 'Maverick', sex: 'Male', location: 'United States'),
    RealVoicesModel(name: 'Aurora', sex: 'Female', location: 'United States'),
    RealVoicesModel(name: 'Axel', sex: 'Male', location: 'United States'),
    RealVoicesModel(name: 'Jasmine', sex: 'Female', location: 'United States'),
    RealVoicesModel(name: 'Luna', sex: 'Female', location: 'Spain'),
    RealVoicesModel(name: 'Mateo', sex: 'Male', location: 'Spain'),
    RealVoicesModel(name: 'Sophia', sex: 'Female', location: 'Spain'),
    RealVoicesModel(name: 'Alejandro', sex: 'Male', location: 'United States'),
    RealVoicesModel(name: 'Valeria', sex: 'Female', location: 'Spain'),
    RealVoicesModel(name: 'Isabella', sex: 'Female', location: 'Spain'),
    RealVoicesModel(name: 'Bruno', sex: 'Male', location: 'Spain'),
  ];

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
