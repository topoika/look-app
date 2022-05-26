//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//
// import 'package:agora_rtc_engine/rtc_engine.dart';
// import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
// import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
// import 'package:look/constant/dailog.dart';
// import 'package:look/constant/variables.dart';
//
//
// class LiveClass extends StatefulWidget {
//   final String channelName;
//   final bool isBroadcaster;
//   final String currentUserUid;
//   final String currentUserName;
//
//
//   const LiveClass({ Key? key,required this.currentUserName,required this.currentUserUid, required this.channelName, required this.isBroadcaster}) : super(key: key);
//
//   @override
//   _LiveClassState createState() => _LiveClassState();
// }
//
// class _LiveClassState extends State<LiveClass> {
//   final _users = <int>[];
//   late RtcEngine _engine;
//   bool muted = false;
//   late int streamId;
//
//   @override
//   void dispose() {
//     // clear users
//     _users.clear();
//     // destroy sdk and leave channel
//     _engine.destroy();
//     super.dispose();
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     // initialize agora sdk
//     initializeAgora();
//   }
//
//   Future<void> initializeAgora() async {
//     await _initAgoraRtcEngine();
//
//     if (widget.isBroadcaster) streamId = (await _engine.createDataStream(false, false))!;
//
//     _engine.setEventHandler(RtcEngineEventHandler(
//       joinChannelSuccess: (channel, uid, elapsed) {
//         setState(() {
//           print('onJoinChannel: $channel, uid: $uid');
//         });
//       },
//       leaveChannel: (stats) {
//         setState(() {
//           print('onLeaveChannel');
//           _users.clear();
//         });
//       },
//       userJoined: (uid, elapsed) {
//         setState(() {
//           print('userJoined: $uid');
//
//           _users.add(uid);
//         });
//       },
//       userOffline: (uid, elapsed) {
//         setState(() {
//           print('userOffline: $uid');
//           _users.remove(uid);
//         });
//       },
//       streamMessage: (_, __, message) {
//         final String info = "here is the message $message";
//         print(info);
//       },
//       streamMessageError: (_, __, error, ___, ____) {
//         final String info = "here is the error $error";
//         print(info);
//       },
//     ));
//
//     await _engine.joinChannel(null, widget.channelName, null, 0);
//   }
//
//   Future<void> _initAgoraRtcEngine() async {
//     _engine = await RtcEngine.createWithConfig(RtcEngineConfig('d5d048ebcb88420bb9f7dcb5b79a085d'));
//     await _engine.enableLocalAudio(true);
//     await _engine.enableVideo();
//
//     await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
//     if (widget.isBroadcaster) {
//       await _engine.setClientRole(ClientRole.Broadcaster);
//     } else {
//       await _engine.setClientRole(ClientRole.Audience);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Stack(
//           children: <Widget>[
//             _broadcastView(),
//             _toolbar(),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _toolbar() {
//     return Container(
//       alignment: Alignment.bottomCenter,
//       padding: const EdgeInsets.symmetric(vertical: 48),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           RawMaterialButton(
//             onPressed: _onToggleMute,
//             child: Icon(
//               muted ? Icons.mic_off : Icons.mic,
//               color: muted ? Colors.white : Colors.blueAccent,
//               size: 20.0,
//             ),
//             shape: const CircleBorder(),
//             elevation: 2.0,
//             fillColor: muted ? Colors.blueAccent : Colors.white,
//             padding: const EdgeInsets.all(12.0),
//           ),
//           RawMaterialButton(
//             onPressed: () => _onCallEnd(context),
//             child: const Icon(
//               Icons.call_end,
//               color: Colors.white,
//               size: 35.0,
//             ),
//             shape: const CircleBorder(),
//             elevation: 2.0,
//             fillColor: Colors.redAccent,
//             padding: const EdgeInsets.all(15.0),
//           ),
//           RawMaterialButton(
//             onPressed: _onSwitchCamera,
//             child: const Icon(
//               Icons.switch_camera,
//               color: Colors.blueAccent,
//               size: 20.0,
//             ),
//             shape: const CircleBorder(),
//             elevation: 2.0,
//             fillColor: Colors.white,
//             padding: const EdgeInsets.all(12.0),
//           ),
//         ],
//       ),
//     );
//        // : Container();
//   }
//
//   /// Helper function to get list of native views
//   List<Widget> _getRenderViews() {
//     final List<StatefulWidget> list = [];
//     if (widget.isBroadcaster) {
//       list.add(RtcLocalView.SurfaceView());
//     }
//     _users.forEach((int uid) => list.add(RtcRemoteView.SurfaceView(uid: uid)));
//     return list;
//   }
//
//   /// Video view row wrapper
//   Widget _expandedVideoView(List<Widget> views) {
//     final wrappedViews = views.map<Widget>((view) => Expanded(child: Container(child: view))).toList();
//     return Expanded(
//       child: Row(
//         children: wrappedViews,
//       ),
//     );
//   }
//
//   /// Video layout wrapper
//   Widget _broadcastView() {
//     final views = _getRenderViews();
//     switch (views.length) {
//       case 1:
//         return Container(
//             child: Column(
//               children: <Widget>[
//                 _expandedVideoView([views[0]])
//               ],
//             ));
//       case 2:
//         return Container(
//             child: Column(
//               children: <Widget>[
//                 _expandedVideoView([views[0]]),
//                 _expandedVideoView([views[1]])
//               ],
//             ));
//       case 3:
//         return Container(
//             child: Column(
//               children: <Widget>[_expandedVideoView(views.sublist(0, 2)), _expandedVideoView(views.sublist(2, 3))],
//             ));
//       case 4:
//         return Container(
//             child: Column(
//               children: <Widget>[_expandedVideoView(views.sublist(0, 2)), _expandedVideoView(views.sublist(2, 4))],
//             ));
//       default:
//     }
//     return Container();
//   }
//
//   Future<void> _onCallEnd(BuildContext context) async {
//     try
//     {
//       await FirebaseFirestore.instance.collection("randomcalling").doc(widget.currentUserUid).set({
//         'name':widget.currentUserName,
//         'userid':widget.currentUserUid,
//       });
//       RANDOMCALL=true;
//
//     }catch(e)
//     {
//       const Dialogg().popUp(context, 'Unable to Search for Users', 'Check your internet connection and try again later', 1);
//     }
//     Navigator.pop(context);
//   }
//
//   void _onToggleMute() {
//     setState(() {
//       muted = !muted;
//     });
//     _engine.muteLocalAudioStream(muted);
//   }
//
//   void _onSwitchCamera() {
//     //  if (streamId != null) _engine?.sendStreamMessage(streamId, "mute user blet");
//     _engine.switchCamera();
//   }
// }

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:look/constant/dailog.dart';
import 'package:look/constant/variables.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;



class LiveClass extends StatefulWidget {

  final String currentUserUid;
  final String currentUserName;
  final String channelName;
  const LiveClass({Key? key,required this.channelName,required this.currentUserName,required this.currentUserUid,}) : super(key: key);

  @override
  _LiveClassState createState() => _LiveClassState();
}

class _LiveClassState extends State<LiveClass> {
  int? _remoteUid;
  late RtcEngine _engine;

  @override
  void initState() {
    super.initState();
    initAgora();
  }

  Future<void> initAgora() async {
    // retrieve permissions
    await [Permission.microphone, Permission.camera].request();

    //create the engine
    _engine = await RtcEngine.create("d5d048ebcb88420bb9f7dcb5b79a085d");
    await _engine.enableVideo();
    _engine.setEventHandler(
      RtcEngineEventHandler(
        joinChannelSuccess: (String channel, int uid, int elapsed) {
          print("local user $uid joined");
        },
        userJoined: (int uid, int elapsed) {
          print("remote user $uid joined");
          setState(() {
            _remoteUid = uid;
          });
        },
        userOffline: (int uid, UserOfflineReason reason) {
          print("remote user $uid left channel");
          setState(() {
            _remoteUid = null;
          });
        },
      ),
    );
print(widget.channelName);
    await _engine.joinChannel(null, widget.channelName, null, 0);
  }

  // Create UI with local view and remote view
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Center(
              child: _remoteVideo(),
            ),
            Align(
              alignment: Alignment.topLeft,
              child:Container(
                margin: const EdgeInsets.only(top: 30,left: 20),
                width: 100,
                height: 100,
                child: Center(
                  child: RtcLocalView.SurfaceView(),
                ),
              ),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child:Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: RawMaterialButton(
                    onPressed: () => _onCallEnd(context),
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
            ),
          ],
        ),
      ),
    );
  }

  // Display remote user's video
  Widget _remoteVideo() {
    if (_remoteUid != null) {
      return RtcRemoteView.SurfaceView(uid: _remoteUid! ,channelId: "dsklkdskd",);
    } else {
      return const Text(
        'wait ...',
        textAlign: TextAlign.center,
      );
    }
  }
  Future<void> _onCallEnd(BuildContext context) async {
    try
    {
      await FirebaseFirestore.instance.collection("randomcalling").doc(widget.currentUserUid).set({
        'name':widget.currentUserName,
        'userid':widget.currentUserUid,
      });
      RANDOMCALL=true;

    }catch(e)
    {
      const Dialogg().popUp(context, 'Unable to Search for Users', 'Check your internet connection and try again later', 1);
    }
    Navigator.pop(context);
  }
}