import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showSnackBar(BuildContext context, String txt, bool danger) {
  var snackBar = SnackBar(
    margin: const EdgeInsets.all(20),
    behavior: SnackBarBehavior.floating,
    content: Text(txt),
    backgroundColor: (danger ? Colors.redAccent : Colors.greenAccent),
    // action: SnackBarAction(
    //   label: 'dismiss',
    //   onPressed: () {},
    // ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void showToast(String text) {
  Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
  );
}
