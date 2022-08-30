import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import 'package:look/base/repositories/user_repository.dart';

class Helper {
  late BuildContext context;

  Helper.of(BuildContext _context) {
    context = _context;
  }

  static OverlayEntry overlayLoader(context) {
    OverlayEntry loader = OverlayEntry(builder: (context) {
      final size = MediaQuery.of(context).size;
      return Positioned(
        height: size.height,
        width: size.width,
        top: 0,
        left: 0,
        child: Material(
          color: Theme.of(context).primaryColor.withOpacity(0.85),
          child: const CircularProgressIndicator(),
        ),
      );
    });
    return loader;
  }

  static hideLoader(OverlayEntry loader) {
    Timer(const Duration(milliseconds: 500), () {
      try {
        loader.remove();
      } catch (e) {}
    });
  }

  static showSnackBar(String txt, bool danger) {
    SnackBar snackBar = SnackBar(
      margin: const EdgeInsets.all(20),
      behavior: SnackBarBehavior.floating,
      content: Text(txt),
      backgroundColor: (danger ? Colors.redAccent : Colors.greenAccent),
    );
    return snackBar;
    // ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

Future<bool> isConnection() async {
  bool active = false;
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    active = true;
  } else if (connectivityResult == ConnectivityResult.wifi) {
    active = true;
  } else {
    active = false;
  }
  return active;
}

bool eligibleOfSendingPoints(int points) {
  return currentUser.value.points! > points;
}

String? getDateFormatedFromString(String date, String type) {
  if (type == "time") {
    return DateFormat.jm().format(DateTime.parse(date)).toString();
  } else if (type == "date") {
    return DateFormat.yMMMMd('en_US').format(DateTime.parse(date)).toString();
  }
  return null;
}

void showCustomToast(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0);
}

String? getTimeDifference(String time) {
  final DateTime tm = DateTime.parse(time);
  final DateTime now = DateTime.now();
  int diff = now.difference(tm).inMinutes;
  if (diff == 0) {
    return "Now";
  } else if (diff > 0 && diff < 60) {
    return "$diff min";
  } else if (diff > 60 && diff < 300) {
    return "${(diff / 60).floor()} hours";
  } else if (diff > 300 && diff < 1440) {
    return DateFormat.jm().format(tm).toString();
  } else if (diff > 1440 && diff < 2880) {
    return "Yesterday";
  } else {
    return DateFormat.yMMMMd('en_US').format(tm).toString();
  }
}
