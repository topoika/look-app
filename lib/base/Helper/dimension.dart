import 'package:flutter/material.dart';

double getHorizontal(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double getVertical(BuildContext context) {
  return MediaQuery.of(context).size.height;
}
