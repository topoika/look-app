import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:look/base/Helper/dimension.dart';
import 'package:look/base/Helper/strings.dart';
import 'package:look/base/controllers/chat_controller.dart';
import 'package:look/base/pages/search.dart';
import 'package:look/base/repositories/user_repository.dart';
import 'package:look/constant/theme.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import 'chat.dart';

class ChatRooms extends StatefulWidget {
  const ChatRooms({Key? key}) : super(key: key);

  @override
  _ChatRoomsState createState() => _ChatRoomsState();
}

class _ChatRoomsState extends StateMVC<ChatRooms> {
  late ChatController _con;
  _ChatRoomsState() : super(ChatController()) {
    _con = controller as ChatController;
  }

  @override
  void initState() {
    _con.listenForChatRooms();
    super.initState();
  }

  Widget chatRoomsList() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("chatRoom")
          .where('involes', arrayContains: currentUser.value.uid)
          .snapshots(),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: _con.userChatRooms.length,
          itemBuilder: (context, index) {
            var _chatRoom = _con.userChatRooms[index];
            var _otherUser = _chatRoom.involved!
                .firstWhere((value) => value.uid != currentUser.value.uid);
            return GestureDetector(
              onTap: (() => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Chat(chatRoom: _chatRoom)))),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 5),
                margin: EdgeInsets.symmetric(
                    horizontal: getHorizontal(context) * 0.04, vertical: 5),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1.0, color: Colors.black26),
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage:
                          NetworkImage(_otherUser.image ?? noImage),
                      backgroundColor: Colors.transparent,
                    ),
                    SizedBox(
                      width: getHorizontal(context) * 0.03,
                    ),
                    SizedBox(
                      width: getHorizontal(context) * 0.6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _otherUser.name ?? "",
                            maxLines: 1,
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: getHorizontal(context) * 0.04,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            _chatRoom.lastMessage!.message ?? "",
                            maxLines: 1,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: getHorizontal(context) * 0.025,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).accentColor,
                          ),
                          child: Text(
                            "10",
                            style: TextStyle(
                              fontSize: getHorizontal(context) * 0.03,
                            ),
                          ),
                        ),
                        Text(
                          "2 hours",
                          style: TextStyle(
                            color: Colors.black38,
                            fontSize: getHorizontal(context) * 0.03,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: Text(
          S.of(context).chats,
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: getHorizontal(context) * 0.045),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        child: chatRoomsList(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: theme().mPurple,
        child: const Icon(Icons.search),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const Search()));
        },
      ),
    );
  }
}
