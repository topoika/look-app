import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:look/base/models/transaction.dart';
import 'package:look/base/models/user_model.dart';
import 'package:look/base/pages/utils/snackbar.dart';
import 'package:look/base/repositories/user_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class PaymentController extends ControllerMVC {
  final formKey = GlobalKey<FormState>();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  String userCollection = "Users";
  String transCollection = "Transactions";
  void creditUserPoints(BuildContext context, int points, String type) async {
    await firebaseFirestore
        .collection(userCollection)
        .doc(currentUser.value.uid)
        .get()
        .then((value) async {
      User user = User.fromMap(value.data());
      user.points = (user.points! + points);
      currentUser.value.points = user.points;
      currentUser.notifyListeners();
      await firebaseFirestore
          .collection(userCollection)
          .doc(currentUser.value.uid)
          .update({"points": user.points});
      addTransaction(context, points, type);
    });
  }

  void addTransaction(BuildContext context, int points, String type) async {
    Transactions _trans = Transactions();
    _trans.created = DateTime.now().toString();
    _trans.time = DateTime.now().toString();
    _trans.points = points;
    _trans.type = type;
    _trans.doneBy = currentUser.value.uid;
    _trans.name = currentUser.value.name!.toLowerCase();
    try {
      firebaseFirestore.collection(transCollection).add(_trans.toMap());
    } catch (e) {
      showSnackBar(context, "Verify your internet connection", true);
    }
  }
}
