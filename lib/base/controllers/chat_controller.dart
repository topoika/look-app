import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:look/base/controllers/main_controller.dart';
import 'package:look/base/models/chat_room_model.dart';
import 'package:look/base/models/message_model.dart';
import 'package:look/base/pages/utils/snackbar.dart';

import '../models/notifications.dart';
import '../repositories/user_repository.dart';

class ChatController extends MainController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final adminCollection = "adminChats";
  final chatsCollection = "chats";
  final chatRoomCollection = "chatRoom";
  addMessage(BuildContext context, Message message, ChatRoom room) async {
    try {
      await firebaseFirestore
          .collection(chatRoomCollection)
          .doc(room.id!)
          .collection(chatsCollection)
          .add(message.toMap());
      updateLastMessage(message, room.id!);
      Notifications().sendPushMessage(
          room.involved!
              .firstWhere((element) => element.uid != currentUser.value.uid)
              .deviceToken!,
          message.message!,
          currentUser.value.name!,
          "text");
    } catch (e) {
      showSnackBar(context, "Verify your internet connection", true);
    }
  }

  addAdminMessage(BuildContext context, String textMessage) async {
    Message _message = Message();
    _message.message = textMessage;
    _message.time = DateTime.now().toString();
    _message.sendBy = currentUser.value;
    _message.recieved = null;
    _message.deleteBy = [];
    try {
      await firebaseFirestore
          .collection(adminCollection)
          .doc(currentUser.value.uid)
          .collection(chatsCollection)
          .add(_message.toMap());
    } catch (e) {
      showSnackBar(context, "Verify your internet connection", true);
    }
  }

  Future<void> addNewMessage(Message _message, String roomId) async {}

  Future<void> updateLastMessage(Message _message, String roomId) async {
    await firebaseFirestore.collection("chatRoom").doc(roomId).update({
      "lastMessage": _message.toMap(),
      "lastUpdated": DateTime.now().toString()
    });
  }
}
