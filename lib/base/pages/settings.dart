import 'package:look/base/controllers/settings_controller.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends StateMVC<SettingsPage> {
  late SettingController _con;
  _SettingsPageState() : super(SettingController()) {
    _con = controller as SettingController;
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
