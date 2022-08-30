import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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

Widget socialLoginButton(
    BuildContext context, Function ontap, String img, String text) {
  return InkWell(
    splashColor: Colors.white,
    onTap: () => ontap(),
    child: Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
          vertical: 10, horizontal: getHorizontal(context) * 0.04),
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            img,
            height: getVertical(context) * 0.03,
            width: getHorizontal(context) * 0.04,
          ),
          SizedBox(width: getHorizontal(context) * 0.014),
          Text(
            text.toUpperCase(),
            textScaleFactor: MediaQuery.of(context).textScaleFactor,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              letterSpacing: 1,
              fontSize: getHorizontal(context) * 0.03,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ),
  );
}
