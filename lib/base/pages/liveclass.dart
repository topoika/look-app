import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:look/base/Helper/dimension.dart';
import 'package:look/base/controllers/livestream_controller.dart';
import 'package:look/base/models/comment_model.dart';
import 'package:look/base/models/gift.dart';
import 'package:look/base/models/live_stream_model.dart';
import 'package:look/base/pages/utils/snackbar.dart';
import 'package:look/base/repositories/user_repository.dart';
import 'package:look/env.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';

import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;

import '../../generated/l10n.dart';
import '../Helper/strings.dart';

class LiveClass extends StatefulWidget {
  final bool isHost;
  final bool isInvited;
  final LiveStream liveStream;
  LiveClass(
      {Key? key,
      required this.isHost,
      required this.isInvited,
      required this.liveStream})
      : super(key: key);

  @override
  _LiveClassState createState() =>
      _LiveClassState(isHost, isInvited, liveStream);
}

class _LiveClassState extends StateMVC<LiveClass> {
  late LiveStreamController _con;
  _LiveClassState(this.isHost, this.isInvited, this.liveStream)
      : super(LiveStreamController()) {
    _con = controller as LiveStreamController;
  }
  RtcEngine? _engine;
  final users = <int>[];
  final bool isHost;
  final bool isInvited;
  final LiveStream liveStream;
  int? _remoteUid;
  TextEditingController _commentController = TextEditingController();
  @override
  void initState() {
    initAgora();
    super.initState();
  }

  Future<void> initAgora() async {
    _engine = await RtcEngine.createWithConfig(RtcEngineConfig(AGORA_APP_ID));
    await _engine!.enableVideo();
    await _engine!.setChannelProfile(ChannelProfile.LiveBroadcasting);
    if (isHost) {
      await _engine!.setClientRole(ClientRole.Broadcaster);
    } else {
      await _engine!.setClientRole(ClientRole.Audience);
    }
    _engine!.setEventHandler(
      RtcEngineEventHandler(
          joinChannelSuccess: (String channel, int uid, int elapsed) {
            log("onchanneljoin : $channel , uid: $uid");
            isHost ? _con.updateStreamHostUid(liveStream, uid) : null;
          },
          userJoined: (int uid, int elapsed) {
            setState(() {
              users.add(uid);
              _remoteUid = uid;
            });
            _con.updateStreamViewers(liveStream);
          },
          error: (e) => log(e.toString()),
          userOffline: (int uid, UserOfflineReason reason) {
            setState(() => users.remove(uid));
            showSnackBar(context, reason.name, true);
          },
          leaveChannel: (stats) {
            if (isHost) {
              setState(() => users.clear());
              _engine!.destroy();
              _con.deleteLiveStream(liveStream, context);
              Navigator.pop(context);
              _engine!.destroy();
              _engine!.leaveChannel();
            } else {
              _engine!.destroy();
              Navigator.pop(context);
              _engine!.leaveChannel();
            }
          }),
    );
    await _engine!
        .joinChannel(liveStream.token, liveStream.title ?? "", null, 0)
        .then((value) => log("Joined"))
        .onError((error, stackTrace) {
      Navigator.pop(context);
      showSnackBar(
          context, "Unable to create livestream, Please try again", true);
    });
  }

  @override
  void dispose() {
    if (isHost) {
      users.clear();
      _engine!.destroy();
      _con.deleteLiveStream(liveStream, context);
      _engine!.destroy();
      _engine!.leaveChannel();
    } else {
      _engine!.destroy();
      Navigator.pop(context);
      _engine!.leaveChannel();
    }
    _engine!.destroy();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("liveStreams")
              .doc(liveStream.id)
              .snapshots(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            var live = snapshot.data;
            return snapshot.hasData
                ? Stack(
                    children: [
                      Center(
                        child: isHost
                            ? RtcLocalView.SurfaceView(
                                channelId: liveStream.title)
                            : liveStream.hostUid != null
                                ? RtcRemoteView.SurfaceView(
                                    uid: liveStream.hostUid ?? 0,
                                    channelId: liveStream.title ?? "",
                                  )
                                : Text(
                                    S.of(context).connecting,
                                    textAlign: TextAlign.center,
                                  ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding:
                              EdgeInsets.all(getHorizontal(context) * 0.023),
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: getHorizontal(context) * 0.03,
                                      vertical: 7),
                                  decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(.3),
                                      borderRadius: BorderRadius.circular(25)),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CircleAvatar(
                                        radius: getHorizontal(context) * 0.045,
                                        backgroundImage: NetworkImage(
                                            liveStream.host!.image ?? noImage),
                                        backgroundColor: Colors.transparent,
                                      ),
                                      SizedBox(
                                        width: getHorizontal(context) * 0.015,
                                      ),
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              liveStream.host!.name ?? "",
                                              maxLines: 1,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white,
                                                fontSize:
                                                    getHorizontal(context) *
                                                        0.03,
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              "💰  546" +
                                                  live!['viewers'].toString(),
                                              maxLines: 1,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white,
                                                fontSize:
                                                    getHorizontal(context) *
                                                        0.03,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: getHorizontal(context) * 0.03,
                                      vertical: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(.3),
                                      borderRadius: BorderRadius.circular(25)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.remove_red_eye,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                      SizedBox(
                                          width: getHorizontal(context) * 0.01),
                                      Text(
                                        live['viewers'].toString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                          fontSize:
                                              getHorizontal(context) * 0.03,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: getHorizontal(context) * 0.03),
                                GestureDetector(
                                  onTap: isHost
                                      ? () {
                                          _engine!.destroy();
                                          _con.deleteLiveStream(
                                              liveStream, context);
                                        }
                                      : () {
                                          Navigator.pop(context);
                                          _engine!.leaveChannel();
                                        },
                                  child: Icon(
                                    Icons.cancel_rounded,
                                    color: Colors.black.withOpacity(.3),
                                    size: getHorizontal(context) * 0.1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: getVertical(context) * 0.28,
                          alignment: Alignment.bottomCenter,
                          margin: EdgeInsets.symmetric(vertical: 60),
                          foregroundDecoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.transparent,
                                Colors.transparent,
                                Colors.transparent
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                          ),
                          child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection("liveStreams")
                                  .doc(liveStream.id)
                                  .collection("comments")
                                  .orderBy("time", descending: true)
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<
                                          QuerySnapshot<Map<String, dynamic>>>
                                      snapshot) {
                                return snapshot.hasData
                                    ? ListView.builder(
                                        itemCount: snapshot.data!.docs.length,
                                        reverse: true,
                                        scrollDirection: Axis.vertical,
                                        itemBuilder: ((context, index) {
                                          var comment = Comment.fromMap(snapshot
                                              .data!.docs[index]
                                              .data());
                                          return Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(9),
                                              gradient: LinearGradient(
                                                colors: [
                                                  Colors.white,
                                                  Colors.white24,
                                                  Colors.white12,
                                                  Colors.transparent
                                                ],
                                                begin: Alignment.centerLeft,
                                                end: Alignment.centerRight,
                                              ),
                                            ),
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 8.0, vertical: 3),
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                CircleAvatar(
                                                  radius: 25.0,
                                                  backgroundImage: NetworkImage(
                                                      comment.commenter!
                                                              .image ??
                                                          noImage),
                                                  backgroundColor:
                                                      Colors.transparent,
                                                ),
                                                SizedBox(
                                                  width:
                                                      getHorizontal(context) *
                                                          0.03,
                                                ),
                                                SizedBox(
                                                  width:
                                                      getHorizontal(context) *
                                                          0.6,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                        comment.commenter!
                                                                .name ??
                                                            "",
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w900,
                                                          fontSize:
                                                              getHorizontal(
                                                                      context) *
                                                                  0.035,
                                                        ),
                                                      ),
                                                      const SizedBox(height: 5),
                                                      Text(
                                                        comment.comment ?? "",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize:
                                                              getHorizontal(
                                                                      context) *
                                                                  0.031,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        }),
                                      )
                                    : SizedBox();
                              }),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          children: [
                            Flexible(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 5),
                                margin: EdgeInsets.symmetric(
                                    horizontal: getHorizontal(context) * 0.02),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(35),
                                  color: Colors.black.withOpacity(.3),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        controller: _commentController,
                                        style: TextStyle(
                                          fontSize:
                                              getHorizontal(context) * 0.041,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        decoration: InputDecoration(
                                            hintText:
                                                S.of(context).type_a_comment +
                                                    "...",
                                            hintStyle: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white60,
                                              fontSize: getHorizontal(context) *
                                                  0.034,
                                            ),
                                            border: InputBorder.none),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Comment _comment = Comment();
                                        if (_commentController.text
                                            .trim()
                                            .isNotEmpty) {
                                          _comment.comment =
                                              _commentController.text;
                                          _comment.time =
                                              DateTime.now().toString();
                                          _comment.commenter =
                                              currentUser.value;
                                          _con.addComment(_comment, liveStream);
                                          _commentController.clear();
                                        }
                                      },
                                      child: const Icon(
                                        Icons.send,
                                        color: Colors.white70,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: getHorizontal(context) * 0.03),
                            Icon(
                              Icons.album,
                              color: Colors.white,
                              size: getHorizontal(context) * 0.1,
                            ),
                            SizedBox(width: getHorizontal(context) * 0.03),
                            GestureDetector(
                              onTap: isHost
                                  ? () => _engine!.switchCamera()
                                  : () {
                                      log("Reward this nigah");
                                    },
                              child: Container(
                                padding: EdgeInsets.all(
                                  getHorizontal(context) * 0.02,
                                ),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(
                                      colors: [
                                        Color.fromARGB(255, 18, 0, 26),
                                        Color.fromARGB(255, 41, 2, 58),
                                        Color.fromARGB(255, 57, 7, 68),
                                        Color.fromARGB(255, 125, 3, 153),
                                        Color.fromARGB(255, 134, 3, 163),
                                        Color.fromARGB(255, 150, 2, 184),
                                      ],
                                      begin: Alignment.bottomLeft,
                                      end: Alignment.topRight,
                                    )),
                                child: isHost
                                    ? Icon(
                                        Icons.switch_camera_outlined,
                                        color: Colors.white,
                                        size: getHorizontal(context) * 0.07,
                                      )
                                    : Image.asset(
                                        box,
                                        height: getHorizontal(context) * 0.09,
                                      ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  )
                : SizedBox();
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: EdgeInsets.only(
              bottom: 65,
              left: getHorizontal(context) * 0.04,
              right: getHorizontal(context) * 0.04),
          child: Container(
            width: getHorizontal(context),
            color: Colors.white,
            child: Row(
              children: <Widget>[
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: gifts.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: ((context, index) {
                      var gift = gifts[index];
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Image.asset(
                            gift.image ?? noImage,
                          ),
                        ],
                      );
                    }))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
