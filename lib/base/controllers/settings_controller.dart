import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart' as fs;
import 'package:flutter/cupertino.dart';
import 'package:look/base/models/settings_model.dart';
import 'package:look/base/pages/utils/snackbar.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';

ValueNotifier<Settings> setting =
    ValueNotifier(Settings(mobileLanguage: ValueNotifier(Locale('en'))));

class SettingController extends ControllerMVC {
  fs.FirebaseFirestore _firestore = fs.FirebaseFirestore.instance;
  void initiateSettings() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.containsKey("settings") &&
        preferences.getString("settings") != null) {
      setting.value =
          Settings.fromMap(json.decode(preferences.getString("settings")!));
      setting.value.mobileLanguage.value = Locale(setting.value.language!);
      setting.value.mobileLanguage.notifyListeners();
    } else {
      setting.value.mobileLanguage = ValueNotifier(Locale("en"));
      setting.value.newMatch = true;
      setting.value.messages = true;
      setting.value.startAge = 18;
      setting.value.endAge = 26;
      setting.value.distance = 80;
    }
    setting.notifyListeners();
  }

  Future<void> updateUser(BuildContext context, User user) async {
    try {
      await _firestore.collection("Users").doc(user.uid).update(user.toMap());
    } catch (e) {
      showSnackBar(context, "Verify your internet connection", true);
    }
  }

  updateSettins() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      setting.value.language = setting.value.mobileLanguage.value.languageCode;
    });
    preferences.setString("settings", json.encode(setting.value.toMap()));
  }
}
