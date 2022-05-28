import 'dart:async';
import 'package:flutter/material.dart';
import 'package:look/agora/users.dart';
import 'package:permission_handler/permission_handler.dart';

import '../base/pages/call.dart';

class CallGoing extends StatefulWidget {
  const CallGoing({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CallGoing();
}

class _CallGoing extends State<CallGoing> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            margin: const EdgeInsets.only(left: 8, right: 8),
            child: ListView(
              children: [
                Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    children: allUser
                        .map((User user) => GestureDetector(
                              onTap: () {
                                onJoin(user.userId);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(top: 8),
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                    color: Colors.amber.shade700,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Center(
                                  child: Text(
                                    user.userName,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ))
                        .toList())
              ],
            )));
  }

  Future<void> onJoin(chennal) async {
    await _handleCameraAndMic(Permission.camera);
    await _handleCameraAndMic(Permission.microphone);
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CallPage(),
      ),
    );
  }

  Future<void> _handleCameraAndMic(Permission permission) async {
    await permission.request();
  }
}
