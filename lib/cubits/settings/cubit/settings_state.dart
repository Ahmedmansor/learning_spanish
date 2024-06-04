part of 'settings_cubit.dart';

@immutable
sealed class SettingsState {}

final class SettingsInitial extends SettingsState {}

//----------------------------------------------

class VoiceChangedSucess extends SettingsState {}

class VoiceChangedError extends SettingsState {}

class SpeedChangedSuccess extends SettingsState {}

class ChangeIconSttate extends SettingsState {}
