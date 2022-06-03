import 'package:flutter/material.dart';

import '../../Helper/dimension.dart';

Widget buttonWidget(BuildContext context, Function ontap, String text) {
  return InkWell(
    splashColor: Colors.white,
    onTap: () => ontap(),
    child: Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 18),
      margin: EdgeInsets.symmetric(
          horizontal: getVertical(context) * 0.02, vertical: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).buttonColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        text.toUpperCase(),
        textScaleFactor: MediaQuery.of(context).textScaleFactor,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          letterSpacing: 1,
          fontSize: getHorizontal(context) * 0.03,
          color: Colors.white,
        ),
      ),
    ),
  );
}
