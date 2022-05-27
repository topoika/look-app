import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _con.userChatRooms.length,
      itemBuilder: (context, index) {
        var _chatRoom = _con.userChatRooms[index];
        var _otherUser = _chatRoom.involved!
            .firstWhere((value) => value.uid != currentUser.value.uid);
        return GestureDetector(
          onTap: (() => Get.to(() => Chat(chatRoom: _chatRoom))),
          child: ListTile(
            leading: CircleAvatar(
              radius: 30.0,
              backgroundImage: NetworkImage(_otherUser.image ?? noImage),
              backgroundColor: Colors.transparent,
            ),
            title: Text(_otherUser.name ?? ""),
            subtitle: Text(_chatRoom.lastMessage!.message ?? ""),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          S.of(context).chats,
          style: TextStyle(
              color: theme().mPurple,
              fontWeight: FontWeight.bold,
              fontSize: 25),
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
            context,
            MaterialPageRoute(
              builder: (context) => const Search(),
            ),
          );
        },
      ),
    );
  }
}
