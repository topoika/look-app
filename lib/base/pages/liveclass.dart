import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:look/base/Helper/dimension.dart';
import 'package:look/base/models/live_stream_model.dart';
import 'package:look/base/repositories/user_repository.dart';
import 'package:look/constant/dailog.dart';
import 'package:look/env.dart';
import 'package:permission_handler/permission_handler.dart';
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

class _LiveClassState extends State<LiveClass> {
  final bool isHost;
  final bool isInvited;
  final LiveStream liveStream;

  int? _remoteUid;
  late RtcEngine _engine;
  TextEditingController _comment = TextEditingController();

  _LiveClassState(this.isHost, this.isInvited, this.liveStream);

  @override
  void initState() {
    super.initState();
    initAgora();
  }

  Future<void> initAgora() async {
    await [Permission.microphone, Permission.camera].request();
    _engine = await RtcEngine.create(AGORA_APP_ID);
    await _engine.enableVideo();
    _engine.setEventHandler(
      RtcEngineEventHandler(
        joinChannelSuccess: (String channel, int uid, int elapsed) {},
        userJoined: (int uid, int elapsed) {
          setState(() {
            _remoteUid = uid;
          });
        },
        userOffline: (int uid, UserOfflineReason reason) {
          setState(() {
            _remoteUid = null;
          });
        },
      ),
    );
    await _engine.joinChannel(
        AGORA_TEST_CHANEL_TOKEN, AGORA_TEST_CHANEL_NAME, null, 0);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Center(
              child: isHost ? RtcLocalView.SurfaceView() : _remoteVideo(),
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
                          NetworkImage(currentUser.value.image ?? noImage),
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
                            currentUser.value.name ?? "",
                            maxLines: 1,
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: getHorizontal(context) * 0.035,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            currentUser.value.location ?? "",
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
                    GestureDetector(
                      onTap: () => _onCallEnd(context),
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
                    ),
                  ],
                ),
              ),
            ),
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
                      controller: _comment,
                      style: TextStyle(
                        fontSize: getHorizontal(context) * 0.041,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                          hintText: "Type somthing ...",
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
                        _comment.clear();
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
      ),
    );
  }

  // Display remote user's video
  Widget _remoteVideo() {
    if (_remoteUid != null) {
      return RtcRemoteView.SurfaceView(
        uid: _remoteUid!,
        channelId: "dsklkdskd",
      );
    } else {
      return const Text(
        'wait ...',
        textAlign: TextAlign.center,
      );
    }
  }

  Future<void> _onCallEnd(BuildContext context) async {
    try {
      await FirebaseFirestore.instance
          .collection("randomcalling")
          .doc(currentUser.value.uid)
          .set({
        'name': currentUser.value.userName,
        'userid': currentUser.value.uid,
      });
    } catch (e) {
      const Dialogg().popUp(context, 'Unable to Search for Users',
          'Check your internet connection and try again later', 1);
    }
    Navigator.pop(context);
  }
}
