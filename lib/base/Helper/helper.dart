import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:look/base/pages/utils/snackbar.dart';
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
