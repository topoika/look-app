import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:look/base/pages/liveusers.dart';
import 'package:look/base/pages/utils/snackbar.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../repositories/user_repository.dart';

class CallsController extends ControllerMVC {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final GlobalKey<ScaffoldState> globalKey = GlobalKey();
  void removeFromRandomCalls(BuildContext context) {
    try {
      firestore.collection("randomCalls").doc(currentUser.value.uid).delete();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LiveUsers()));
    } catch (e) {
      showSnackBar(context, "Veify your internet connection", true);
    }
  }
}
