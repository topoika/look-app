import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:look/base/models/chat_room_model.dart';
import 'package:look/base/models/message_model.dart';

import 'user_repository.dart';

FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

getUserChats(String itIsMyName) async {
  return firebaseFirestore
      .collection("chatRoom")
      .where('usersData', arrayContains: itIsMyName)
      .snapshots();
}

Future<void> addNewMessage(Message _message, String roomId) async {
  await firebaseFirestore
      .collection("chatRoom")
      .doc(roomId)
      .collection("chats")
      .add(_message.toMap());
}

getChats(String chatRoomId) async {
  return firebaseFirestore
      .collection("chatRoom")
      .doc(chatRoomId)
      .collection("chats")
      .orderBy('time', descending: false)
      .snapshots();
}

Future<QuerySnapshot<Map<String, dynamic>>> getChatRooms() {
  return firebaseFirestore
      .collection("chatRoom")
      .where('involes', arrayContains: currentUser.value.uid)
      .get();
}

Future<void> awards({Uid}) async {
  await firebaseFirestore.collection('Awards').doc(Uid).set({
    'awardnumber': 0,
    'time': FieldValue.serverTimestamp(),
  });
  await FirebaseFirestore.instance.collection('Time').doc(Uid).set({
    'time': FieldValue.serverTimestamp(),
  });
}

// ignore: missing_return
Future<ChatRoom> addChatRoom(ChatRoom chatRoom) async {
  // var exists = firebaseFirestore
  //     .collection("chatRoom")
  //     .where('involes', isEqualTo: chatRoom.involes)
  //     .snapshots()
  //     .toList();
  return firebaseFirestore
      .collection("chatRoom")
      .add(chatRoom.toMap())
      .then((value) {
    chatRoom.id = value.id;
    firebaseFirestore
        .collection("chatRoom")
        .doc(value.id)
        .update({"id": value.id});
    return chatRoom;
  });
}
