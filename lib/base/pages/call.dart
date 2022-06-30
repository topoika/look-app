import 'dart:async';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:flutter/material.dart';
import 'package:look/base/Helper/dimension.dart';
import 'package:look/base/Helper/strings.dart';
import 'package:look/base/controllers/calls_controller.dart';
import 'package:look/base/models/videocall.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../env.dart';
import '../../generated/l10n.dart';

class CallPage extends StatefulWidget {
  final VideoCall videoCall;
  CallPage({Key? key, required this.videoCall}) : super(key: key);
  @override
  _CallPageState createState() => _CallPageState();
}

class _CallPageState extends StateMVC<CallPage> {
  late CallsController _con;
  _CallPageState() : super(CallsController()) {
    _con = controller as CallsController;
  }
  bool muted = false;
  bool videoMuted = false;
  RtcEngine? _engine;
  int? _remoteId;

  @override
  void initState() {
    initForAgora();
    super.initState();
  }

  Future<void> initForAgora() async {
    _engine = await RtcEngine.createWithConfig(RtcEngineConfig(AGORA_APP_ID));
    await _engine!.enableVideo();
    _engine!.setEventHandler(RtcEngineEventHandler(
        joinChannelSuccess: ((channel, uid, elapsed) {}),
        userJoined: (uid, elapsed) {
          setState(() => _remoteId = uid);
        },
        userOffline: (uid, reason) {
          Navigator.pop(context);
          _engine!.destroy();
          _engine!.leaveChannel();
        }));
    await _engine!
        .joinChannel(
            widget.videoCall.token, widget.videoCall.name ?? "", null, 0)
        .then((value) => print("Joined successfully"))
        .onError((error, stackTrace) => print(error.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Stack(
          children: <Widget>[
            _remoteId != null
                ? RtcRemoteView.SurfaceView(uid: _remoteId ?? 0, channelId: "")
                : RtcLocalView.SurfaceView(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: getHorizontal(context),
                height: getVertical(context) * 0.2,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Colors.transparent,
                  Colors.black12,
                  Colors.black26,
                  Colors.black38,
                  Colors.black45,
                  Colors.black54,
                  Colors.black87,
                  Colors.black,
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.symmetric(
                  vertical: 20, horizontal: getHorizontal(context) * 0.09),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => _engine!.switchCamera(),
                        child: Icon(
                          Icons.mode_standby_rounded,
                          color: Colors.white,
                          size: getHorizontal(context) * 0.09,
                        ),
                      ),
                      SizedBox(width: getHorizontal(context) * 0.11),
                      GestureDetector(
                        onTap: () => _engine!.switchCamera(),
                        child: Icon(
                          Icons.change_circle_outlined,
                          color: Colors.white,
                          size: getHorizontal(context) * 0.12,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            muted = !muted;
                          });
                          _engine!.muteLocalAudioStream(muted);
                        },
                        child: Icon(
                          muted ? Icons.mic_off_outlined : Icons.mic,
                          color: Colors.white,
                          size: getHorizontal(context) * 0.12,
                        ),
                      ),
                      SizedBox(width: getHorizontal(context) * 0.11),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            videoMuted = !videoMuted;
                          });
                          _engine!.muteLocalVideoStream(videoMuted);
                        },
                        child: Icon(
                          videoMuted
                              ? Icons.videocam_off_outlined
                              : Icons.videocam_rounded,
                          color: Colors.white,
                          size: getHorizontal(context) * 0.09,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: _remoteId != null
                  ? SizedBox()
                  : Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: getVertical(context) * 0.15),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: Theme.of(context).accentColor,
                            foregroundImage: NetworkImage(
                                widget.videoCall.reciever!.image ?? noImage),
                          ),
                          SizedBox(height: 10),
                          Text(
                            widget.videoCall.reciever!.name ?? "",
                            style: TextStyle(color: Colors.black87),
                          ),
                          Text(
                            "${S.of(context).calling_text}...",
                            style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: _remoteId != null
                  ? Container(
                      margin: EdgeInsets.only(top: 40, left: 20),
                      height: getVertical(context) * 0.20,
                      width: getHorizontal(context) * 0.28,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.black26,
                      ),
                      child: RtcLocalView.SurfaceView(),
                    )
                  : SizedBox(),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        margin: EdgeInsets.symmetric(vertical: 40),
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white60, width: 1.2),
            shape: BoxShape.circle),
        child: RawMaterialButton(
          onPressed: () {
            Navigator.pop(context);
            _con.declineVideoCall(context, widget.videoCall);
            _engine!.leaveChannel();
            _engine!.destroy();
          },
          child: const Icon(
            Icons.call_end,
            color: Colors.white,
            size: 35.0,
          ),
          shape: const CircleBorder(),
          elevation: 2.0,
          fillColor: Colors.redAccent,
          padding: const EdgeInsets.all(15.0),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _engine!.leaveChannel();
    _engine!.destroy();

    super.dispose();
  }
}
