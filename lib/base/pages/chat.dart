import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:look/base/Helper/dimension.dart';
import 'package:look/base/controllers/chat_controller.dart';
import 'package:look/base/models/chat_room_model.dart';
import 'package:look/base/repositories/user_repository.dart';
import 'package:look/constant/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as cf;
import 'package:mvc_pattern/mvc_pattern.dart';

class Chat extends StatefulWidget {
  final ChatRoom chatRoom;
  const Chat({Key? key, required this.chatRoom}) : super(key: key);
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends StateMVC<Chat> {
  final ChatController _con = ChatController();
  _ChatState() : super(ChatController());
  final _controller = ScrollController();
  TextEditingController messageText = TextEditingController();

  Widget chatMessages() {
    return SizedBox(
      height: getVertical(context) * 0.75,
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("chatRoom")
            .doc(widget.chatRoom.id)
            .collection("chats")
            .orderBy('time', descending: false)
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<cf.QuerySnapshot> snapshot) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (_controller.hasClients) {
              _controller.jumpTo(_controller.position.maxScrollExtent);
            } else {
              // setState(() => null);
            }
          });
          if (!snapshot.hasData) {
            return const Center(
              child: Text(
                "No data found",
                style: TextStyle(color: Colors.red),
              ),
            );
          }
          return ListView(
            controller: _controller,
            children: snapshot.data!.docs.map((document) {
              return Center(
                child: MessageTile(
                  message: document['message'].toString(),
                  sendByMe: currentUser.value.uid ==
                      document['sendBy']['uid'].toString(),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textstyle = TextStyle(
      fontSize: getHorizontal(context) * 0.041,
      fontWeight: FontWeight.bold,
    );
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
        title: Text(
          "Test ChatRoom",
          style: TextStyle(color: theme().mPurple),
        ),
      ),
      body: Stack(
        children: [
          chatMessages(),
          Container(
            alignment: Alignment.bottomCenter,
            width: MediaQuery.of(context).size.width,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              color: const Color(0x54FFFFFF),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    controller: messageText,
                    style: textstyle,
                    decoration: InputDecoration(
                        hintText: "Type Message ...",
                        hintStyle: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 16,
                        ),
                        border: InputBorder.none),
                  )),
                  const SizedBox(
                    width: 16,
                  ),
                  GestureDetector(
                    onTap: () {
                      _con.addMessage(
                          messageText.text,
                          widget.chatRoom.involved!.firstWhere((element) =>
                              element.uid != currentUser.value.uid));
                    },
                    child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(
                                colors: [Color(0x36FFFFFF), Color(0x0FFFFFFF)],
                                begin: FractionalOffset.topLeft,
                                end: FractionalOffset.bottomRight),
                            borderRadius: BorderRadius.circular(40)),
                        padding: const EdgeInsets.all(12),
                        child: IconButton(
                          icon: const Icon(
                            Icons.send,
                            color: Colors.black,
                          ),
                          onPressed: () {},
                        )),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool sendByMe;

  const MessageTile({Key? key, required this.message, required this.sendByMe})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 8, bottom: 8, left: sendByMe ? 24 : 0, right: sendByMe ? 0 : 24),
      alignment: sendByMe ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: sendByMe
            ? const EdgeInsets.only(right: 30)
            : const EdgeInsets.only(left: 30),
        padding:
            const EdgeInsets.only(top: 17, bottom: 17, left: 20, right: 20),
        decoration: BoxDecoration(
            borderRadius: !sendByMe
                ? const BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomLeft: Radius.circular(23))
                : const BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomRight: Radius.circular(23)),
            gradient: LinearGradient(
              colors: !sendByMe
                  ? [
                      const Color(0xFFf62459).withAlpha(120),
                      const Color(0xFFf62459).withAlpha(120)
                    ]
                  : [
                      const Color(0xFFf62459).withOpacity(0.6),
                      const Color(0xFFf62459).withOpacity(0.6)
                      // const Color(0x1AFFFFFF), const Color(0x1AFFFFFF)
                    ],
            )),
        child: Text(
          message,
          textAlign: TextAlign.start,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'OverpassRegular',
              fontWeight: FontWeight.w300),
        ),
      ),
    );
  }
}
