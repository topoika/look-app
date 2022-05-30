import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as cf;
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as rtc_local_view;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as rtc_remote_view;
import 'package:get/get.dart';
import 'package:look/constant/theme.dart';
import 'package:look/base/pages/liveusers.dart';

class Join extends StatefulWidget {
  final String channelName;
  final String myName;
  final String myImage;
  const Join(
      {Key? key,
      required this.channelName,
      required this.myImage,
      required this.myName})
      : super(key: key);

  @override
  _JoinState createState() => _JoinState();
}

class _JoinState extends State<Join> {
  final _users = <int>[];
  late RtcEngine _engine;
  bool muted = false;
  late int? streamId;
  bool loading = true;
  var result;
  late int viewers;
  bool get = false;
  bool viewerAdded = false;
  late int msgAdded;
  bool msgadded = false;
  final _channelMessageController = TextEditingController();
  int end = 0;
  var currentFocus;

  unfocus() {
    currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  @override
  void dispose() {
    // clear users
    _users.clear();
    _engine.destroy();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    try {
      result = await FirebaseFirestore.instance
          .collection('channels')
          .doc(widget.channelName)
          .get();
      if (result.data()['channelname'] != null) {
        if (!mounted) return;
        setState(() {
          viewers = result.data()['viewers'];
          end = result.data()['end'];
          msgAdded = result.data()['msgadded'];
        });

        if (viewerAdded == false) {
          await FirebaseFirestore.instance
              .collection('channels')
              .doc(widget.channelName)
              .update({
            'viewers': viewers + 1,
          });
        }
        if (!mounted) return;
        setState(() {
          viewerAdded = true;
          get = true;
        });

        initializeAgora();
      }
    } catch (e) {
      print("Errorr");
      print(e.toString());
    }
  }

  Future<void> initializeAgora() async {
    await _initAgoraRtcEngine();

    streamId = await _engine.createDataStream(false, false);

    _engine.setEventHandler(RtcEngineEventHandler(
      joinChannelSuccess: (channel, uid, elapsed) {
        if (!mounted) return;
        setState(() {
          print('onJoinChannel: $channel, uid: $uid');
        });
      },
      leaveChannel: (stats) {
        if (!mounted) return;
        setState(() {
          print('onLeaveChannel');
          _users.clear();
        });
      },
      userJoined: (uid, elapsed) {
        if (mounted) {
          setState(() {
            print('userJoined: $uid');
            _users.add(uid);
          });
        }
      },
      userOffline: (uid, elapsed) {
        if (!mounted) return;
        setState(() {
          print('userOffline: $uid');
          _users.remove(uid);
        });
      },
      streamMessage: (_, __, message) {
        final String info = "here is the message $message";
        print(info);
      },
      streamMessageError: (_, __, error, ___, ____) {
        final String info = "here is the error $error";
        print(info);
      },
    ));

    try {
      await _engine.joinChannel(null, widget.channelName, null, 0);
      if (!mounted) return;
      setState(() {
        loading = false;
      });
    } catch (e) {
      final snackBar = SnackBar(
        margin: const EdgeInsets.all(20),
        behavior: SnackBarBehavior.floating,
        content: const Text('unable to join the live streaming!'),
        backgroundColor: (Colors.redAccent),
        action: SnackBarAction(
          label: 'dismiss',
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<void> _initAgoraRtcEngine() async {
    _engine = await RtcEngine.createWithConfig(
        RtcEngineConfig('a8b946e934e74e33a6f7b627bd1d169b'));
    await _engine.enableVideo();

    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine.setClientRole(ClientRole.Audience);
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: _onWillPop,
      child: SafeArea(
        child: Scaffold(
          body: (get == true)
              ? (end == 1)
                  ? Container()
                  : Center(
                      child: Stack(
                      //(loading==false)?
                      children: <Widget>[
                        _broadcastView(),
                        _toolbar(w, h),
                      ],
                    )
                      //:const CircularProgressIndicator(),
                      )
              : Container(),
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you want to leave streaming'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () {
                  _onCallEnd(context);
                },
                child: const Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  void popUp() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(child: Text('Live Streaming stopped ')),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const <Widget>[
              Expanded(
                child: Text(
                  "Broadcaster Has Stopped Streaming",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              )
            ],
          ),
          actions: <Widget>[
            TextButton(
                child: const Text('Ok'),
                onPressed: () {
                  _onCallEnd(context);
                })
          ],
        );
      },
    );
  }

  Widget _toolbar(double w, double h) {
    return ListView(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                margin: const EdgeInsets.only(top: 10, left: 15),
                width: w * 0.18,
                height: 28,
                decoration: const BoxDecoration(
                    color: Color(0xfff02e63),
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      width: w * 0.06,
                      height: 30,
                      child: (get == true)
                          ? ListView.builder(
                              itemCount: 1,
                              itemBuilder: (BuildContext context, int index) {
                                Timer.periodic(const Duration(seconds: 5),
                                    (timer) {
                                  if (end == 1) {
                                    popUp();
                                  }
                                  getData();
                                });
                                return Text(
                                  ' $viewers',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                );
                              })
                          : Container(),
                    ),
                    const Icon(
                      Icons.remove_red_eye,
                      color: Colors.white,
                    )
                  ],
                )),
            Container(
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              child: const Text(
                'LIVE',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
            _endCall(),
          ],
        ),
        Container(
          margin: EdgeInsets.only(top: h * 0.4),
          width: w * 0.98,
          height: h * 0.4,
          alignment: Alignment.bottomLeft,
          child: (msgAdded == 1)
              ? StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('channels')
                      .doc(widget.channelName)
                      .collection('Messages')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<cf.QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: Text(
                          "No data found",
                          style: TextStyle(color: Colors.red),
                        ),
                      );
                    }
                    return ListView(
                      children: snapshot.data!.docs.map((document) {
                        return Center(
                            child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(document['image']),
                          ),
                          title: Text(document['name'],
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                          subtitle: Text(document['message'],
                              style: const TextStyle(
                                  color: Colors.red, fontFamily: 'PopM')),
                        ));
                      }).toList(),
                    );
                  })
              : Container(),
        ),
        row(w, h),
      ],
    );
  }

  Widget row(double w, double h) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Expanded(
              child: TextField(
                  cursorColor: theme().mPurple,
                  focusNode: currentFocus,
                  textInputAction: TextInputAction.send,
                  onSubmitted: _sendMessage,
                  style: const TextStyle(color: Colors.white),
                  controller: _channelMessageController,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        _sendMessage(_channelMessageController.text);
                      },
                      icon: const Icon(
                        Icons.send_rounded,
                        color: Colors.redAccent,
                      ),
                    ),
                    isDense: true,
                    hintText: 'Comment',
                    hintStyle: const TextStyle(color: Colors.redAccent),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        borderSide: BorderSide(color: theme().mPurple)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        borderSide: const BorderSide(color: Colors.white)),
                  ))),
        ],
      ),
    );
  }

  Widget _endCall() {
    return Container(
      margin: const EdgeInsets.only(top: 10, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          GestureDetector(
              onTap: () async {
                _onCallEnd(context);
                super.dispose();
              },
              child: Container(
                width: 90,
                decoration: const BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                child: const Center(
                    child: Text(
                  ' Leave ',
                  style: TextStyle(
                      color: Colors.white, fontSize: 20, fontFamily: 'PopM'),
                )),
              )),
        ],
      ),
    );
  }

  /// Helper function to get list of native views
  List<Widget> _getRenderViews() {
    final List<StatefulWidget> list = [];
    list.add(rtc_local_view.SurfaceView(
      channelId: "sjdljsdl",
    ));

    for (var uid in _users) {
      list.add(rtc_remote_view.SurfaceView(uid: uid, channelId: "hdhskdjks"));
    }
    return list;
  }

  /// Video view row wrapper
  Widget _expandedVideoView(List<Widget> views) {
    final wrappedViews = views
        .map<Widget>((view) => Expanded(child: Container(child: view)))
        .toList();
    return Expanded(
      child: Row(
        children: wrappedViews,
      ),
    );
  }

  /// Video layout wrapper
  Widget _broadcastView() {
    final views = _getRenderViews();
    switch (views.length) {
      case 1:
        return Column(
          children: <Widget>[
            _expandedVideoView([views[0]])
          ],
        );
      case 2:
        return Column(
          children: <Widget>[
            _expandedVideoView([views[0]]),
            _expandedVideoView([views[1]])
          ],
        );
      case 3:
        return Column(
          children: <Widget>[
            _expandedVideoView(views.sublist(0, 2)),
            _expandedVideoView(views.sublist(2, 3))
          ],
        );
      case 4:
        return Column(
          children: <Widget>[
            _expandedVideoView(views.sublist(0, 2)),
            _expandedVideoView(views.sublist(2, 4))
          ],
        );
      default:
    }
    return Container();
  }

  void _onCallEnd(BuildContext context) async {
    try {
      await FirebaseFirestore.instance
          .collection("channels")
          .doc(widget.channelName)
          .update({
        'viewers': viewers - 1,
      });

      Get.to(() => const LiveUsers());
    } catch (e) {
      print("Khan");
    }
  }

  void _sendMessage(text) async {
    unfocus();
    if (text.isEmpty) {
      return;
    }
    if (msgadded == false) {
      try {
        await FirebaseFirestore.instance
            .collection('channels')
            .doc(result.data()['name'])
            .update({'msgadded': 1});
        if (!mounted) return;

        setState(() {
          msgadded = true;
        });
      } catch (e) {}
    }
    try {
      await FirebaseFirestore.instance
          .collection('channels')
          .doc(widget.channelName)
          .collection("Messages")
          .add({
        'image': widget.myImage,
        'name': widget.channelName,
        'message': _channelMessageController.text,
      });
      _channelMessageController.clear();
    } catch (errorCode) {
      print('Send channel message error: ' + errorCode.toString());
      //log1('Send channel message error: ' + errorCode.toString());
    }
  }
}
