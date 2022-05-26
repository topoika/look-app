import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:look/base/Helper/dimension.dart';
import 'package:look/base/pages/search.dart';
import 'package:look/constant/theme.dart';
import 'package:look/firebase/database/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as cf;

import '../../generated/l10n.dart';
import 'chat.dart';

class ChatRooms extends StatefulWidget {
  final String myName;
  final String myUid;

  const ChatRooms({Key? key, required this.myName, required this.myUid})
      : super(key: key);

  @override
  _ChatRoomsState createState() => _ChatRoomsState();
}

class _ChatRoomsState extends State<ChatRooms> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    getUserInfoGetChats();
  }

  late Stream chatRooms;

  Widget chatRoomsList() {
    return StreamBuilder(
      // initialData: null,
      stream: FirebaseFirestore.instance
          .collection("chatRoom")
          .where('usersData', arrayContains: widget.myName)
          .snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<cf.QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: Text(
              "No data found",
              style: TextStyle(color: Colors.red),
            ),
          );
        }
        return ListView(
          children: snapshot.data!.docs.map((document) {
            return Center(
              child: ChatRoomsTile(
                sender: widget.myName,
                uid: widget.myUid,
                userName: document['chatRoomId']
                    .replaceAll("_", "")
                    .replaceAll(widget.myName, "")
                    .toString(),
                chatRoomId: document["chatRoomId"],
              ),
            );
          }).toList(),
        );
      },
    );
  }

  getUserInfoGetChats() async {
    DatabaseService().getUserChats(widget.myName).then((snapshots) {
      if (snapshots != null) {
        print(snapshots.toString());
      }
      setState(() {
        chatRooms = snapshots;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "S.of(context).chats",
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

class ChatRoomsTile extends StatelessWidget {
  final String userName;
  final String chatRoomId;
  final String uid;
  final String sender;
  const ChatRoomsTile(
      {Key? key,
      required this.userName,
      required this.chatRoomId,
      required this.uid,
      required this.sender})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      width: getHorizontal(context),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              // Get.to(() => const Chat());
            },
            child: Row(
              children: [
                Container(
                  height: getVertical(context) * 0.05,
                  width: getHorizontal(context) * 0.1,
                  decoration: BoxDecoration(
                      color: theme().mPurple,
                      borderRadius: BorderRadius.circular(30)),
                  child: Center(
                    child: Text(userName.substring(0, 2),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w400)),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Text(userName,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                        color: Colors.red,
                        fontSize: 18,
                        fontWeight: FontWeight.w600))
              ],
            ),
          ),
        ],
      ),
    );
  }
}