import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:look/constant/theme.dart';
import 'package:look/firebase/database/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as cf;

class Chat extends StatefulWidget {
  final String chatRoomId;
  final String uid;
  final String senderName;
  final String myName;
  const Chat(
      {Key? key,
      required this.chatRoomId,
      required this.uid,
      required this.senderName,
      required this.myName})
      : super(key: key);
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  List<String> length = [];
  @override
  void initState() {
    super.initState();
  }

  final _controller = ScrollController();
  TextEditingController messageEditingController = TextEditingController();

  Widget chatMessages() {
    double h = MediaQuery.of(context).size.height;
    return SizedBox(
      height: h * 0.75,
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("chatRoom")
            .doc(widget.chatRoomId)
            .collection("chats")
            .orderBy('time', descending: false)
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<cf.QuerySnapshot> snapshot) {
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            if (_controller.hasClients) {
              _controller.jumpTo(_controller.position.maxScrollExtent);
            } else {
              setState(() => null);
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
                  sendByMe: widget.senderName == document['sendBy'].toString(),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }

  addMessage() {
    if (messageEditingController.text.isNotEmpty) {
      Map<String, dynamic> chatMessageMap = {
        "sendBy": widget.myName,
        "message": messageEditingController.text,
        'time': FieldValue.serverTimestamp(),
      };

      DatabaseService().addMessage(widget.chatRoomId, chatMessageMap);
      setState(() {
        messageEditingController.clear();
      });
    }
    FocusScope.of(context).requestFocus(FocusNode());
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    TextStyle textstyle = TextStyle(
        fontSize: w * 0.041, fontWeight: FontWeight.bold, fontFamily: 'PopR');

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
          widget.senderName,
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
                    controller: messageEditingController,
                    style: textstyle,
                    decoration: InputDecoration(
                        hintText: "Message ...",
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
                      addMessage();
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
