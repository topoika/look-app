import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:look/base/controllers/user_controller.dart';
import 'package:look/base/models/chat_room_model.dart';
import 'package:look/base/models/message_model.dart';
import 'package:look/base/pages/utils/snackbar.dart';
import 'package:look/base/repositories/user_repository.dart';
import 'package:look/generated/intl/messages_en.dart';
import './../models/user_model.dart' as userModel;

class SearchController extends UserController {
  List<userModel.User> searchResult = <userModel.User>[];
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  @override
  void initState() {
    initialSearch();
    super.initState();
  }

  void initiateSearch(String searchText) async {
    firebaseFirestore
        .collection(userCollection)
        .where('userName', isEqualTo: searchText)
        .where("uid", isNotEqualTo: currentUser.value.uid)
        .snapshots()
        .listen((result) {
      for (var user in result.docs) {
        userModel.User _user = userModel.User.fromMap(user.data());
        if (!searchResult.contains(_user)) {
          setState(() => searchResult.add(_user));
        }
      }
    });
  }

  void initialSearch() async {
    setState(() => searchResult.clear());
    firebaseFirestore
        .collection(userCollection)
        .limit(15)
        .where("uid", isNotEqualTo: currentUser.value.uid)
        .snapshots()
        .listen((result) {
      for (var user in result.docs) {
        userModel.User _user = userModel.User.fromMap(user.data());
        setState(() => searchResult.add(_user));
      }
    });
  }

  Future<String?> chatRoomExist(userModel.User otherUser) async {
    try {
      return await firebaseFirestore
          .collection("chatRoom")
          .where("involves", arrayContains: otherUser.uid)
          .where("involves", arrayContains: currentUser.value.uid)
          .get()
          .then((value) {
        return value.docs.length > 0 ? value.docs[0].id : null;
      });
    } catch (e) {
      return null;
    }
  }

  sendMessage(BuildContext context, userModel.User otherUser) async {
    ChatRoom _chatroom = ChatRoom();
    _chatroom.deletedBy = [];
    _chatroom.involes = [currentUser.value.uid ?? "", otherUser.uid ?? ""];
    _chatroom.involved = [currentUser.value, otherUser];
    _chatroom.lastMessage = Message(
        deleteBy: [],
        message: "This is a new conversation",
        time: DateTime.now().toString());
    _chatroom.lastUpdated = DateTime.now().toString();
    await chatRoomExist(otherUser).then((value) {
      if (value != null) {
        _chatroom.id = value;
        addChatRoom(_chatroom).then((value) =>
            Navigator.pushReplacementNamed(context, "/Chat", arguments: value));
      } else {
        _chatroom.id = currentUser.value.uid! + "===+===" + otherUser.uid!;
        addChatRoom(_chatroom).then((value) =>
            Navigator.pushReplacementNamed(context, "/Chat", arguments: value));
      }
    });
  }

  Future<ChatRoom> addChatRoom(ChatRoom chatRoom) async {
    return firebaseFirestore
        .collection("chatRoom")
        .doc(chatRoom.id)
        .set(chatRoom.toMap())
        .then((value) => chatRoom);
  }
}
