import 'package:flutter/cupertino.dart';
import 'package:look/base/models/settings_model.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

ValueNotifier<Settings> setting = ValueNotifier(Settings(
    brightness: ValueNotifier(Brightness.light),
    mobileLanguage: ValueNotifier(Locale("en"))));

class SettingController extends ControllerMVC {
  void initiateSettings() {
    Settings _settings = Settings(
        brightness: ValueNotifier(Brightness.light),
        mobileLanguage: ValueNotifier(Locale("en")));
    _settings.brightness.value = Brightness.light;
    _settings.mobileLanguage.value = Locale("en");
    setting.value = _settings;
    setting.notifyListeners();
  }
}
