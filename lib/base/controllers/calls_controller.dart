import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:look/base/controllers/main_controller.dart';
import 'package:look/base/models/videocall.dart';
import 'package:look/base/pages/utils/snackbar.dart';
import 'package:look/base/repositories/calls_repository.dart';

import '../../generated/l10n.dart';
import '../models/notifications.dart';
import '../models/user_model.dart';
import '../pages/call.dart';
import '../repositories/user_repository.dart';

class CallsController extends MainController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String callsCollection = "callHistory";
  late Timer timer;
  int seconds = 0;
  int minutes = 0;
  int hours = 0;
  final GlobalKey<ScaffoldState> globalKey = GlobalKey();

  void startTimer(VideoCall call) {
    const oneSec = const Duration(seconds: 1);
    timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        setState(() {
          seconds++;
        });
        updateCallTime(call);
        if (seconds == 60) {
          setState(() {
            minutes++;
            seconds = 0;
          });
        }
        if (minutes == 60) {
          hours++;
          minutes = 0;
        }
      },
    );
  }

  void removeFromRandomCalls(BuildContext context) async {
    try {
      await firestore
          .collection("randomCalls")
          .doc(currentUser.value.uid)
          .delete();
      Navigator.pushNamedAndRemoveUntil(
          context, "/LiveUsers", ModalRoute.withName('/LiveUsers'));
    } catch (e) {
      showSnackBar(
          context, S.of(context).verify_your_internet_connection, true);
    }
  }

  void updateCallTime(VideoCall call) async {
    await firestore
        .collection("videoCalls")
        .doc(call.id)
        .update({"minutes": minutes, "hours": hours, "seconds": seconds});
  }

  Future<void> createVideoCall(BuildContext context, User user) async {
    await getChannelToken(user.name!).then(
      (value) {
        if (value.length > 0) {
          VideoCall _videoCall = VideoCall();
          _videoCall.token = value;
          _videoCall.id = currentUser.value.uid;
          _videoCall.name = user.name;
          _videoCall.caller = currentUser.value;
          _videoCall.reciever = user;
          _videoCall.minutes = 00;
          _videoCall.hours = 00;
          _videoCall.seconds = 00;
          _videoCall.time = DateTime.now().toString();
          try {
            firestore
                .collection("videoCalls")
                .doc(currentUser.value.uid)
                .set(_videoCall.toMap())
                .then((value) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CallPage(videoCall: _videoCall),
                ),
              );
            });
            Notifications().sendPushMessage(
                user.deviceToken!, _videoCall.id!, "Message", "call");
          } catch (e) {
            showSnackBar(
                context, S.of(context).verify_your_internet_connection, true);
          }
        } else {
          showSnackBar(
              context,
              S.of(context).error_while_generating_token_please_try_again,
              true);
        }
      },
    );
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
        showSnackBar(
            context, S.of(context).verify_your_internet_connection, true);
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

  void completVideoCall(BuildContext context, VideoCall videoCall) async {
    try {
      Navigator.pushReplacementNamed(context, "/CallPage",
          arguments: videoCall);
    } catch (e) {
      showSnackBar(
          context, S.of(context).verify_your_internet_connection, true);
    }
  }

  void declineVideoCall(BuildContext context, VideoCall videoCall) async {
    videoCall.minutes = minutes;
    videoCall.seconds = seconds;
    videoCall.hours = hours;
    try {
      firestore.collection(callsCollection).add(videoCall.toMap()).then(
          (value) =>
              firestore.collection("videoCalls").doc(videoCall.id).delete());
      Fluttertoast.showToast(
        msg: S.of(context).call_ended,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
      );
    } catch (e) {
      showSnackBar(
          context, S.of(context).verify_your_internet_connection, true);
    }
  }
}
