// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class NotificationController extends ControllerMVC {
  int unReadNotificationsCount = 0;
  GlobalKey<ScaffoldState> scaffoldKey;

  NotificationController(this.unReadNotificationsCount, this.scaffoldKey) {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }
}
