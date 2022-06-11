import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:look/base/models/user_model.dart';
import 'package:look/base/repositories/user_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class PaymentController extends ControllerMVC {
  final formKey = GlobalKey<FormState>();
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  String userCollection = "Users";
  void creditUserPoints(double points) async {
    await _firebaseFirestore
        .collection(userCollection)
        .doc(currentUser.value.uid)
        .get()
        .then((value) async {
      User user = User.fromMap(value.data());
      user.points = (user.points! + points);
      currentUser.value.points = user.points;
      currentUser.notifyListeners();
      await _firebaseFirestore
          .collection(userCollection)
          .doc(currentUser.value.uid)
          .update({"points": user.points});
    });
  }
}
