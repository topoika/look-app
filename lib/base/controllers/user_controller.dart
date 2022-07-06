import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:look/base/models/user_model.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class UserController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  GlobalKey<FormState> phoneFormKey = GlobalKey();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  String userCollection = "Users";

  @override
  void initState() {
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

  void updateUserVideoRate(User user) async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(user.uid)
        .update({"videoRate": user.videoRate, "smsRate": user.smsRate});
  }
}
