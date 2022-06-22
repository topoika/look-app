import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:look/base/models/videocall.dart';
import 'package:look/base/pages/utils/snackbar.dart';
import 'package:look/base/repositories/calls_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../repositories/user_repository.dart';

class CallsController extends ControllerMVC {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final GlobalKey<ScaffoldState> globalKey = GlobalKey();
  void removeFromRandomCalls(BuildContext context) async {
    try {
      await firestore
          .collection("randomCalls")
          .doc(currentUser.value.uid)
          .delete();
      Navigator.pushReplacementNamed(context, "/LiveUsers");
    } catch (e) {
      showSnackBar(context, "Veify your internet connection", true);
    }
  }

  Future<VideoCall> createRandomCall(BuildContext context) async {
    VideoCall videoCall = VideoCall();
    await getChannelToken(currentUser.value.name ?? "New Channel")
        .then((value) async {
      videoCall.caller = currentUser.value;
      videoCall.reciever = null;
      videoCall.minutes = 0;
      videoCall.name = currentUser.value.name ?? "New Channel";
      videoCall.id = currentUser.value.uid;
      videoCall.token = value;
      try {
        await firestore
            .collection("randomCalls")
            .doc(currentUser.value.uid)
            .set(videoCall.toMap());
      } catch (e) {
        showSnackBar(context, "Veify your internet connection", true);
      }
      return videoCall;
    });
    return videoCall;
  }

  Future<VideoCall> getRandomCall(BuildContext context) async {
    VideoCall videoCall = VideoCall();
    try {
      await firestore
          .collection("randomCalls")
          .where("id", isNotEqualTo: currentUser.value.uid)
          .where('reciever', isEqualTo: null)
          .limit(1)
          .get()
          .then((value) {
        videoCall = VideoCall.fromMap(value.docs[0].data());
      });
    } catch (e) {
      // showSnackBar(context, "Veify your internet connection", true);
    }
    return videoCall;
  }
}
