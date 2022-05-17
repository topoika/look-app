import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class UserController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  GlobalKey<FormState> phoneFormKey = GlobalKey();

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
    log("This is the message to the world");
    setState(() {});
    // ScaffoldMessenger.of(scaffoldKey.currentState!.context)
    //     .showSnackBar(snackBar);
  }
}
