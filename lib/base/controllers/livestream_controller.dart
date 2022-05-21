import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:look/base/models/live_stream_model.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class LiveStreamController extends ControllerMVC {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  List<LiveStream> channels = <LiveStream>[];

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
}
