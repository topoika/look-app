import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
import '../../Helper/dimension.dart';

Widget title(BuildContext context, String text) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: getVertical(context) * 0.03),
    child: Text(
      text,
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: getHorizontal(context) * 0.05,
          color: Colors.black45),
    ),
  );
}

Widget skiptText(BuildContext context) {
  return Text(
    S.of(context).skip,
    style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: getHorizontal(context) * 0.05,
        color: Colors.black45),
  );
}

Widget channelName(text) {
  return Text(
    text,
    style: const TextStyle(
      fontWeight: FontWeight.w900,
      color: Colors.white,
      fontSize: 14,
    ),
  );
}
