import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class SplashController extends ControllerMVC {
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  late GlobalKey<ScaffoldState> scaffoldKey;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  SplashScreenController() {
    this.scaffoldKey = GlobalKey<ScaffoldState>();
  }

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

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
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
        log(message.toString());
      }
    });
  }

  void configureFirebase(FirebaseMessaging _firebaseMessaging) {
    try {
      notificationOnResume;
      notificationOnLaunch;
      notificationOnMessage;
    } catch (e) {}
  }

  Future notificationOnResume(Map<String, dynamic> message) async {
    try {
      if (message['data']['id'] == "orders") {
        // settingRepo.navigatorKey.currentState
        //     .pushReplacementNamed('/Pages', arguments: 3);
        log(message['data'].toString());
      }
    } catch (e) {
      // print(CustomTrace(StackTrace.current, message: e));
    }
  }

  Future notificationOnLaunch(Map<String, dynamic> message) async {
    String messageId = "await settingRepo.getMessageId()";
    try {
      log(message.toString());

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
    log(message.toString());
    Fluttertoast.showToast(
      msg: message['notification']['title'],
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 5,
    );
  }
}
