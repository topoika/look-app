import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:look/base/models/message_model.dart';

import 'user_repository.dart';

FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;



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
