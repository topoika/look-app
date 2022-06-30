import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../pages/utils/calling_dialog.dart';
import '../repositories/calls_repository.dart';

class MainController extends ControllerMVC {
  GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  @override
  void initState() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null &&
          android != null &&
          message.data['type'] == "text") {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              "one",
              "one",
              icon: 'launch_background',
            ),
          ),
        );
      } else if (notification != null &&
          android != null &&
          message.data['type'] == "call") {
        getVideocall(message.notification!.body!).then((value) {
          showDialog(
              context: state!.context,
              barrierColor: Colors.black45,
              barrierDismissible: false,
              builder: (context) {
                return CallingDialog(videoCall: value!);
              });
        });
      }
    });
    super.initState();
  }
}
