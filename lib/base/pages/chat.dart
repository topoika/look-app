import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:look/base/Helper/dimension.dart';
import 'package:look/base/controllers/chat_controller.dart';
import 'package:look/base/models/chat_room_model.dart';
import 'package:look/base/models/message_model.dart';
import 'package:look/base/pages/call.dart';
import 'package:look/base/pages/utils/chat_bubble.dart';
import 'package:look/base/repositories/user_repository.dart';
import 'package:look/constant/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as cf;
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../Helper/helper.dart';
import '../Helper/strings.dart';
import '../models/videocall.dart';

class Chat extends StatefulWidget {
  final ChatRoom chatRoom;
  const Chat({Key? key, required this.chatRoom}) : super(key: key);
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends StateMVC<Chat> {
  late ChatController _con;
  _ChatState() : super(ChatController()) {
    _con = controller as ChatController;
  }

  TextEditingController messageText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var _otherUser = widget.chatRoom.involved!
        .firstWhere((value) => value.uid != currentUser.value.uid);
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: false,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              color: theme().mPurple,
              onPressed: () {
                Navigator.of(context).pop();
              }),
          leadingWidth: 20,
          title: Row(
            children: <Widget>[
              CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage(_otherUser.image ?? noImage),
                backgroundColor: Colors.transparent,
              ),
              SizedBox(
                width: getHorizontal(context) * 0.03,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _otherUser.name ?? "",
                    style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: getHorizontal(context) * 0.01,
                  ),
                  Text(
                    _otherUser.location ?? "",
                    style: const TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                        fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            GestureDetector(
              onTap: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CallPage(
                            videoCall: VideoCall(),
                          ))),
              child: Icon(Icons.video_call,
                  color: theme().mPurple, size: getHorizontal(context) * 0.09),
            ),
            SizedBox(
              width: getHorizontal(context) * 0.03,
            ),
          ]),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getHorizontal(context) * 0.04,
          vertical: getVertical(context) * 0.015,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: StreamBuilder(
                stream: _con.firebaseFirestore
                    .collection("chatRoom")
                    .doc(widget.chatRoom.id)
                    .collection(_con.chatsCollection)
                    .orderBy('time', descending: true)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<cf.QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: Text(
                        S.of(context).no_data_found,
                        style: TextStyle(color: Colors.red),
                      ),
                    );
                  }

                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      reverse: true,
                      itemBuilder: (context, index) {
                        var message = Message.fromMap(snapshot.data!.docs[index]
                            .data() as Map<String, dynamic>);

                        return ChatBubbleWidget(
                            message: message,
                            sendByMe:
                                message.sendBy!.uid != currentUser.value.uid);
                      });
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageText,
                      textCapitalization: TextCapitalization.sentences,
                      style: TextStyle(
                        fontSize: getHorizontal(context) * 0.038,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: BorderSide(
                            color: Colors.black87,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: BorderSide(
                            color: Colors.black87,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: BorderSide(
                            color: Colors.black87,
                          ),
                        ),
                        prefixIcon: Icon(
                          Icons.attach_file,
                          color: Colors.black87,
                        ),
                        suffixIcon: InkWell(
                          onTap: () {
                            if (messageText.text.trim().isNotEmpty) {
                              Message _message = Message();
                              _message.message = messageText.text;
                              _message.time = DateTime.now().toString();
                              _message.sendBy = currentUser.value;
                              _message.recieved = widget.chatRoom.involved!
                                  .firstWhere((element) =>
                                      element.uid != currentUser.value.uid);
                              _message.deleteBy = [];
                              _con.addMessage(
                                  context, _message, widget.chatRoom.id ?? "");
                              messageText.clear();
                            }
                          },
                          child: Icon(
                            Icons.send,
                            color: Colors.black,
                          ),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: BorderSide(
                            color: Colors.black87,
                          ),
                        ),
                        hintText: "${S.of(context).type_message} ...",
                        hintStyle: TextStyle(
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w600,
                          fontSize: getHorizontal(context) * 0.037,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
