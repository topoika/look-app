import 'package:flutter/material.dart';
import 'package:look/base/Helper/dimension.dart';

Widget buttons(String txt, BuildContext context) {
  return Container(
    margin: EdgeInsets.only(
        top: 10,
        left: getHorizontal(context) * 0.03,
        right: getHorizontal(context) * 0.03),
    width: getHorizontal(context) * 0.9,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Theme.of(context).buttonColor,
    ),
    child: Text(
      txt,
      style: TextStyle(
        fontSize: getHorizontal(context) * 0.045,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  );
}
