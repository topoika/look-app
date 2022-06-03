import 'package:flutter/material.dart';

InputDecoration inputDecoration(BuildContext context, String hintext) {
  return InputDecoration(
    hintText: hintext,
    enabledBorder: InputBorder.none,
    focusedBorder: InputBorder.none,
    contentPadding: EdgeInsets.only(left: 6, top: 5),
  );
}
