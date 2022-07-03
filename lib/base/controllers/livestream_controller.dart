import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:look/base/Helper/helper.dart';
import 'package:look/base/controllers/main_controller.dart';
import 'package:look/base/models/activity.dart';
import 'package:look/base/models/comment_model.dart';
import 'package:look/base/models/gift.dart';
import 'package:look/base/models/live_stream_model.dart';
import 'package:look/base/models/user_model.dart';
import 'package:look/base/pages/liveclass.dart';
import 'package:look/base/pages/utils/snackbar.dart';
import 'package:look/base/repositories/calls_repository.dart';
import 'package:look/base/repositories/user_repository.dart';

import '../Helper/dimension.dart';

class LiveStreamController extends MainController {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  String liveStreamCollection = "liveStreams";
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
      _liveStream.viewers = 0;
      _liveStream.pointsGifted = 0;
      await firebaseFirestore
          .collection(liveStreamCollection)
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
        .collection(liveStreamCollection)
        .doc(currentUser.value.uid)
        .delete();
    firebaseFirestore
        .collection(liveStreamCollection)
        .doc(currentUser.value.uid)
        .collection("activities")
        .get()
        .then((value) {
      for (DocumentSnapshot dc in value.docs) {
        dc.reference.delete();
      }
    });
  }

  updateStreamViewers(LiveStream liveStream, String action) async {
    await firebaseFirestore
        .collection(liveStreamCollection)
        .doc(liveStream.id)
        .get()
        .then((value) async {
      int viewers = action == "joined"
          ? value.data()!['viewers'] + 1
          : value.data()!['viewers'] - 1;
      firebaseFirestore
          .collection(liveStreamCollection)
          .doc(liveStream.id)
          .update({"viewers": viewers});
    });
  }

  updateRections(LiveStream liveStream) async {
    await firebaseFirestore
        .collection(liveStreamCollection)
        .doc(liveStream.id)
        .get()
        .then((value) async {
      int viewers = value.data()!['reactions'] + 1;
      firebaseFirestore
          .collection(liveStreamCollection)
          .doc(liveStream.id)
          .update({"reactions": viewers});
    });
  }

  updateStreamHostUid(LiveStream liveStream, int uid) async {
    await firebaseFirestore
        .collection(liveStreamCollection)
        .doc(liveStream.id)
        .update({"hostUid": uid});
  }

  addComment(Comment comment, LiveStream liveStream) async {
    await firebaseFirestore
        .collection(liveStreamCollection)
        .doc(liveStream.id)
        .collection("comments")
        .add(comment.toMap());
  }

  giftHostPoints(Gift gift, LiveStream liveStream) async {
    await firebaseFirestore
        .collection(liveStreamCollection)
        .doc(liveStream.id)
        .get()
        .then((value) async {
      int points = value.data()!['pointsGifted'] + gift.points;
      firebaseFirestore
          .collection(liveStreamCollection)
          .doc(liveStream.id)
          .update({"pointsGifted": points});
    });
  }

  void addActivity(BuildContext context, String type, String desc, User actor,
      LiveStream liveStream, Gift? gift, Comment? comment) async {
    Activity activity = Activity();
    activity.actor = actor;
    activity.type = type;
    activity.desc = desc;
    activity.time = DateTime.now().toString();
    activity.gift = gift != null ? gift : null;
    activity.comment = comment != null ? comment : null;
    if (gift != null && eligibleOfSendingPoints(gift.points!)) {
    } else if (gift == null) {
      await firebaseFirestore
          .collection(liveStreamCollection)
          .doc(liveStream.id)
          .collection("activities")
          .add(activity.toMap());
    } else {
      showSnackBar(
          context, "Your points balance it too low, please recharge", true);
    }
  }
}
