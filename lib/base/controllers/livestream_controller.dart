import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:look/base/models/comment_model.dart';
import 'package:look/base/models/live_stream_model.dart';
import 'package:look/base/pages/liveclass.dart';
import 'package:look/base/pages/liveusers.dart';
import 'package:look/base/repositories/calls_repository.dart';
import 'package:look/base/repositories/user_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../Helper/dimension.dart';

class LiveStreamController extends ControllerMVC {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  List<LiveStream> channels = <LiveStream>[];
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  void initState() {
    getChannels();
    super.initState();
  }

  OverlayEntry loader = OverlayEntry(
    builder: (BuildContext context) {
      return SafeArea(
        child: Container(
          height: double.infinity,
          width: getHorizontal(context),
          color: Colors.white.withOpacity(.4),
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    },
  );

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

  createLiveStream(BuildContext context, LiveStream _liveStream) async {
    Overlay.of(context)!.insert(loader);
    await getChannelToken(_liveStream.title ?? "").then((value) async {
      _liveStream.host = currentUser.value;
      _liveStream.token = value;
      _liveStream.id = currentUser.value.uid;
      _liveStream.hostId = currentUser.value.uid;
      _liveStream.reactions = 0;
      _liveStream.comments = [];
      _liveStream.country = currentUser.value.country;
      _liveStream.viewers = 1;
      await firebaseFirestore
          .collection("liveStreams")
          .doc(currentUser.value.uid)
          .set(_liveStream.toMap())
          .then((value) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) => LiveClass(
                    isHost: true, isInvited: false, liveStream: _liveStream))));
        loader.remove();
      });
    });
  }

  deleteLiveStream(LiveStream _liveStream, BuildContext context) async {
    await firebaseFirestore
        .collection("liveStreams")
        .doc(currentUser.value.uid)
        .delete()
        .then((value) => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LiveUsers())));
    firebaseFirestore
        .collection("liveStreams")
        .doc(currentUser.value.uid)
        .collection("comments")
        .get()
        .then((value) {
      for (DocumentSnapshot dc in value.docs) {
        dc.reference.delete();
      }
    });
  }

  updateStreamViewers(LiveStream liveStream) async {
    await firebaseFirestore
        .collection("liveStreams")
        .doc(liveStream.id)
        .update({"viewers": 3});
  }

  addComment(Comment comment, LiveStream liveStream) async {
    await firebaseFirestore
        .collection("liveStreams")
        .doc(liveStream.id)
        .collection("comments")
        .add(comment.toMap());
  }
}
