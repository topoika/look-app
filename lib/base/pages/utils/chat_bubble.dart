import 'package:flutter/material.dart';

import '../../Helper/dimension.dart';
import '../../models/message_model.dart';

class ChatBubbleWidget extends StatelessWidget {
  final Message message;
  final bool sendByMe;
  const ChatBubbleWidget(
      {Key? key, required this.message, required this.sendByMe})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: sendByMe ? Alignment.centerLeft : Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: getHorizontal(context) * 0.7,
          minWidth: getHorizontal(context) * 0.1,
        ),
        child: Container(
          padding: EdgeInsets.all(getHorizontal(context) * 0.03),
          margin: EdgeInsets.only(top: 15),
          decoration: BoxDecoration(
            border: Border.all(
                width: 1, color: sendByMe ? Colors.black54 : Colors.redAccent),
            color: sendByMe ? Colors.white : Colors.red.withOpacity(.4),
            borderRadius: !sendByMe
                ? const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15))
                : const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                    bottomRight: Radius.circular(15)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "Hey?  May I help you?",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                  fontSize: getHorizontal(context) * 0.036,
                ),
              ),
              Text(
                "12:32 PM",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                  fontSize: getHorizontal(context) * 0.028,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
