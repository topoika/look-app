import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:look/base/controllers/livestream_controller.dart';
import 'package:look/base/pages/utils/snackbar.dart';
import 'package:look/base/repositories/calls_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../models/videocall.dart';

ValueNotifier<VideoCall> activeVideoCall = ValueNotifier(VideoCall());

class SplashController extends ControllerMVC {
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.instance.requestPermission(
        sound: true,
        badge: true,
        alert: true,
        announcement: false,
        carPlay: false,
        criticalAlert: false,
        provisional: false);
    configureFirebase(firebaseMessaging);
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   RemoteNotification? notification = message.notification;
    //   AndroidNotification? android = message.notification?.android;
    //   if (notification != null &&
    //       android != null &&
    //       message.data['type'] == "text") {
    //     flutterLocalNotificationsPlugin.show(
    //       notification.hashCode,
    //       notification.title,
    //       notification.body,
    //       NotificationDetails(
    //         android: AndroidNotificationDetails(
    //           "one",
    //           "one",
    //           icon: 'launch_background',
    //         ),
    //       ),
    //     );
    //   } else if (notification != null &&
    //       android != null &&
    //       message.data['type'] == "call") {
    //     log(message.notification!.body.toString());
    //     getVideocall(message.notification!.body!).then((value) {
    //       setState(() {
    //         activeVideoCall.value = value!;
    //       });
    //       showSnackBar(state!.context, value!.id.toString(), true);
    //     });
    //   }
    // });
  }

  void configureFirebase(FirebaseMessaging _firebaseMessaging) {
    try {
      notificationOnResume;
      notificationOnLaunch;
      notificationOnMessage;
    } catch (e) {}
  }

  Future notificationOnResume(Map<String, dynamic> message) async {
    log(message.toString());

    try {
      if (message['data']['id'] == "orders") {
        // settingRepo.navigatorKey.currentState
        //     .pushReplacementNamed('/Pages', arguments: 3);
      }
    } catch (e) {
      // print(CustomTrace(StackTrace.current, message: e));
    }
  }

  Future notificationOnLaunch(Map<String, dynamic> message) async {
    log("Message is :" + message.toString());
    String messageId = "await settingRepo.getMessageId()";
    try {
      if (messageId != message['google.message_id']) {
        if (message['data']['id'] == "orders") {
          // await settingRepo.saveMessageId(message['google.message_id']);
          // settingRepo.navigatorKey.currentState
          //     .pushReplacementNamed('/Pages', arguments: 3);
        }
      }
    } catch (e) {
      // print(CustomTrace(StackTrace.current, message: e));
    }
  }

  Future notificationOnMessage(Map<String, dynamic> message) async {
    log("message" + message.toString());
    Fluttertoast.showToast(
      msg: message['notification']['title'],
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 5,
    );
  }
}
