import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:look/base/Helper/strings.dart';
import 'package:look/base/controllers/calls_controller.dart';
import 'package:look/base/models/videocall.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../Helper/dimension.dart';
import '../call.dart';

class CallingDialog extends StatefulWidget {
  final VideoCall videoCall;
  CallingDialog({Key? key, required this.videoCall}) : super(key: key);

  @override
  _CallingDialogState createState() => _CallingDialogState();
}

class _CallingDialogState extends StateMVC<CallingDialog> {
  late CallsController _con;
  _CallingDialogState() : super(CallsController()) {
    _con = controller as CallsController;
  }
  @override
  void initState() {
    FlutterRingtonePlayer.play(
      android: AndroidSounds.ringtone,
      ios: IosSounds.glass,
      looping: true, // Android only - API >= 28
      volume: .7, // Android only - API >= 28
      asAlarm: false, // Android only - all APIs
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetAnimationDuration: Duration(seconds: 2),
      alignment: Alignment.topCenter,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      insetPadding: EdgeInsets.symmetric(
          horizontal: getHorizontal(context) * 0.024,
          vertical: getVertical(context) * 0.01),
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: getVertical(context) * 0.012,
            horizontal: getHorizontal(context) * 0.024),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.video_call,
                          color: Colors.white,
                          size: getHorizontal(context) * 0.05,
                        ),
                        SizedBox(width: getHorizontal(context) * 0.01),
                        Text(
                          widget.videoCall.caller!.name!,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: getHorizontal(context) * 0.03,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Incoming video call",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: getHorizontal(context) * 0.03,
                      ),
                    ),
                  ],
                ),
                CircleAvatar(
                  radius: getHorizontal(context) * 0.05,
                  backgroundColor: Colors.white24,
                  backgroundImage: NetworkImage(
                      widget.videoCall.caller!.images!.length > 0
                          ? widget.videoCall.caller!.images![0]
                          : noImage),
                )
              ],
            ),
            SizedBox(height: getHorizontal(context) * 0.01),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    FlutterRingtonePlayer.stop();
                    Navigator.pop(context);
                    _con.declineVideoCall(context, widget.videoCall);
                  },
                  child: Container(
                    child: Text(
                      "Decline",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: getHorizontal(context) * 0.029,
                      ),
                    ),
                  ),
                ),
                Text(
                  "|",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 20,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    FlutterRingtonePlayer.stop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CallPage(videoCall: widget.videoCall),
                      ),
                    );
                  },
                  child: Container(
                    child: Text(
                      "Answer",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: getHorizontal(context) * 0.029,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
