import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:look/base/controllers/main_controller.dart';
import 'package:look/base/models/message_model.dart';
import 'package:look/base/pages/utils/snackbar.dart';

import '../repositories/chat_repository.dart';
import '../repositories/user_repository.dart';
import './../models/user_model.dart' as userModel;

class ChatController extends MainController {
  final userModel.User _user = currentUser.value;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final adminCollection = "adminChats";
  final chatsCollection = "chats";
  final chatRoomCollection = "chatRoom";
  addMessage(BuildContext context, Message message, String roomId) async {
    try {
      await firebaseFirestore
          .collection(chatRoomCollection)
          .doc(roomId)
          .collection(chatsCollection)
          .add(message.toMap());
      updateLastMessage(message, roomId);
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
