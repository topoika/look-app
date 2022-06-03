import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:look/base/models/live_stream_model.dart';
import 'package:look/base/pages/liveclass.dart';
import 'package:look/base/repositories/user_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class LiveStreamController extends ControllerMVC {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  List<LiveStream> channels = <LiveStream>[];
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  void initState() {
    getChannels();
    super.initState();
  }

  Future<void> getChannels() async {
    try {
      _firebaseFirestore.collection("channels").get().then(
        (value) {
          for (var result in value.docs) {
            if (result.data()['channelname'] != null &&
                result.data()['image'] != null &&
                result.data()['country'] != null &&
                result.data()['viewers'] != null) {}
          }
        },
      );
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> getChannel(String txt) async {
    try {
      FirebaseFirestore.instance
          .collection("channels")
          .where('country', isEqualTo: txt)
          .get()
          .then(
        (value) {
          for (var result in value.docs) {
            if (result.data()['channelname'] != null &&
                result.data()['image'] != null &&
                result.data()['country'] != null &&
                result.data()['viewers'] != null) {
              String str = result.data()['country'];
            }
          }
        },
      );
    } catch (e) {
      print(e.toString());
    }
  }

  createLiveStream(BuildContext context) async {
    LiveStream _liveStream = LiveStream();
    _liveStream.host = currentUser.value;
    _liveStream.hostId = currentUser.value.uid;
    _liveStream.reactions = 0;
    _liveStream.comments = [];
    _liveStream.title = "Test Live Stream";
    _liveStream.country = currentUser.value.country;
    _liveStream.viewers = 1;
    await firebaseFirestore
        .collection("liveStreams")
        .add(_liveStream.toMap())
        .then((value) {
      _liveStream.id = value.id;
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: ((context) => LiveClass(
                  isHost: true, isInvited: false, liveStream: _liveStream))));
      firebaseFirestore
          .collection("liveStreams")
          .doc(value.id)
          .update({"id": value.id});
    });
  }
}
