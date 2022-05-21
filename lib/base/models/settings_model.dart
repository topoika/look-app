import 'package:flutter/material.dart';

class Settings {
  String? language;
  String? theme;
  ValueNotifier<Brightness>? brightness = ValueNotifier(Brightness.light);
  ValueNotifier<Locale>? mobileLanguage = ValueNotifier(const Locale('en', ''));
  Settings({this.language, this.theme, this.brightness, this.mobileLanguage});

  Map<String, dynamic> toMap() {
    return {
      'language': language,
      'theme': theme,
      'mobileLanguage': mobileLanguage!.value.languageCode
    };
  }

  factory Settings.fromMap(Map<String, dynamic> map) {
    return Settings(
      language: map['language'],
      theme: map['theme'],
    );
  }
}
