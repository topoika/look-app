import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:look/base/Helper/dimension.dart';
import 'package:look/base/controllers/livestream_controller.dart';
import 'package:look/base/models/comment_model.dart';
import 'package:look/base/models/live_stream_model.dart';
import 'package:look/base/pages/utils/snackbar.dart';
import 'package:look/base/repositories/user_repository.dart';
import 'package:look/env.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';

import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;

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
          },
          userJoined: (int uid, int elapsed) {
            setState(() => users.add(uid));
            _con.updateStreamViewers(liveStream);
          },
          error: (e) => log(e.toString()),
          userOffline: (int uid, UserOfflineReason reason) {
            setState(() => users.remove(uid));
            showSnackBar(context, reason.name, true);
          },
          leaveChannel: (stats) {
            setState(() => users.clear());
          }),
    );
    await _engine!
        .joinChannel(liveStream.token, liveStream.title ?? "", null, 0)
        .then((value) => log("Joined"));
  }

  @override
  void dispose() {
    users.clear();
    _engine!.destroy();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Center(
              child: isHost
                  ? RtcLocalView.SurfaceView(channelId: liveStream.title)
                  : _remoteUid != null
                      ? RtcRemoteView.SurfaceView(
                          uid: _remoteUid!,
                          channelId: liveStream.title ?? "",
                        )
                      : Text(
                          'wait ...',
                          textAlign: TextAlign.center,
                        ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                margin: EdgeInsets.symmetric(
                    horizontal: getHorizontal(context) * 0.023, vertical: 60),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.remove_red_eye,
                      color: Colors.white,
                      size: 18,
                    ),
                    SizedBox(width: 5),
                    Text(
                      users.length.toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.all(getHorizontal(context) * 0.023),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage:
                          NetworkImage(liveStream.host!.image ?? noImage),
                      backgroundColor: Colors.transparent,
                    ),
                    SizedBox(
                      width: getHorizontal(context) * 0.03,
                    ),
                    SizedBox(
                      width: getHorizontal(context) * 0.6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            liveStream.host!.name ?? "",
                            maxLines: 1,
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: getHorizontal(context) * 0.035,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            liveStream.host!.location ?? "",
                            maxLines: 1,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: getHorizontal(context) * 0.021,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    isHost
                        ? GestureDetector(
                            onTap: () {
                              _engine!.destroy();
                              _con.deleteLiveStream(liveStream, context);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: getHorizontal(context) * 0.035),
                              decoration: BoxDecoration(
                                  color: Colors.redAccent,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text(
                                'End Live',
                                style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: getHorizontal(context) * 0.029),
                              ),
                            ),
                          )
                        : SizedBox(),
                  ],
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
                        Colors.white10.withOpacity(.1),
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
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                              snapshot) {
                        return snapshot.hasData
                            ? ListView.builder(
                                itemCount: snapshot.data!.docs.length,
                                reverse: true,
                                scrollDirection: Axis.vertical,
                                itemBuilder: ((context, index) {
                                  var comment = Comment.fromMap(
                                      snapshot.data!.docs[index].data());
                                  return Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(9),
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
                                              comment.commenter!.image ??
                                                  noImage),
                                          backgroundColor: Colors.transparent,
                                        ),
                                        SizedBox(
                                          width: getHorizontal(context) * 0.03,
                                        ),
                                        SizedBox(
                                          width: getHorizontal(context) * 0.6,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                comment.commenter!.name ?? "",
                                                maxLines: 1,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w900,
                                                  fontSize:
                                                      getHorizontal(context) *
                                                          0.035,
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              Text(
                                                comment.comment ?? "",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize:
                                                      getHorizontal(context) *
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
                )),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                margin: EdgeInsets.symmetric(
                    horizontal: getHorizontal(context) * 0.02),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white.withOpacity(.8),
                ),
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                      controller: _commentController,
                      style: TextStyle(
                        fontSize: getHorizontal(context) * 0.041,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                          hintText: "Type a comment ...",
                          hintStyle: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 16,
                          ),
                          border: InputBorder.none),
                    )),
                    const SizedBox(
                      width: 16,
                    ),
                    GestureDetector(
                      onTap: () {
                        Comment _comment = Comment();
                        if (_commentController.text.trim().isNotEmpty) {
                          _comment.comment = _commentController.text;
                          _comment.time = DateTime.now().toString();
                          _comment.commenter = currentUser.value;
                          _con.addComment(_comment, liveStream);
                          _commentController.clear();
                        }
                      },
                      child: const Icon(
                        Icons.send,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: isHost
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: FloatingActionButton(
                  onPressed: () => _engine!.switchCamera(),
                  backgroundColor: Colors.transparent,
                  child: Icon(
                    Icons.switch_camera_outlined,
                    color: Colors.white,
                    size: getHorizontal(context) * 0.09,
                  ),
                ),
              )
            : SizedBox(),
      ),
    );
  }
}
