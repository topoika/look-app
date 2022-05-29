import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  Future<void> addMessage(String chatRoomId, chatMessageData) async {
    await FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .add(chatMessageData);
  }

  getChats(String chatRoomId) async {
    return FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy('time', descending: false)
        .snapshots();
  }

  Future<void> awards({Uid}) async {
    await FirebaseFirestore.instance.collection('Awards').doc(Uid).set({
      'awardnumber': 0,
      'time': FieldValue.serverTimestamp(),
    });
    await FirebaseFirestore.instance.collection('Time').doc(Uid).set({
      'time': FieldValue.serverTimestamp(),
    });
  }

  // ignore: missing_return
  Future<void> addChatRoom(chatRoom, chatRoomId) async {
    FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .set(chatRoom);
  }
}
