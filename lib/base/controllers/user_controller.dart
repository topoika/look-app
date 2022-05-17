import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class UserController extends ControllerMVC {
  late GlobalKey<ScaffoldState> scaffoldKey;
  late GlobalKey<FormState> phoneFormKey;

  @override
  void initState() {
    signMobileNumber();
    super.initState();
  }

  void signMobileNumber() {
    final snackBar = SnackBar(
      margin: const EdgeInsets.all(20),
      behavior: SnackBarBehavior.floating,
      content: const Text('invalid phone number!'),
      backgroundColor: (Colors.redAccent),
      action: SnackBarAction(
        label: 'dismiss',
        onPressed: () {},
      ),
    );
    ScaffoldMessenger.of(scaffoldKey.currentState!.context)
        .showSnackBar(snackBar);
  }
}
