import 'package:flutter/material.dart';

class Settings {
  String? language;
  bool? newMatch;
  bool? messages;
  int? startAge;
  int? endAge;
  int? distance;
  ValueNotifier<Locale> mobileLanguage = ValueNotifier(Locale('en'));
  Settings({
    this.language,
    this.newMatch,
    this.messages,
    this.startAge,
    this.endAge,
    this.distance,
    required this.mobileLanguage,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'language': language,
      'newMatch': newMatch,
      'messages': messages,
      'startAge': startAge,
      'endAge': endAge,
      'distance': distance,
    };
  }

  factory Settings.fromMap(Map<String, dynamic> map) {
    return Settings(
      distance: map['distance'] != null ? map['distance'] as int : null,
      language: map['language'] != null ? map['language'] : null,
      newMatch: map['newMatch'] != null ? map['newMatch'] as bool : null,
      messages: map['messages'] != null ? map['messages'] as bool : null,
      startAge: map['startAge'] != null ? map['startAge'] as int : null,
      endAge: map['endAge'] != null ? map['endAge'] as int : null,
      mobileLanguage: ValueNotifier(Locale('en')),
    );
  }
}
