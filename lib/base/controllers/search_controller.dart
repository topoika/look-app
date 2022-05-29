import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:look/base/models/chat_room_model.dart';
import 'package:look/base/models/message_model.dart';
import 'package:look/base/repositories/user_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../pages/chat.dart';
import '../repositories/chat_repository.dart';
import './../models/user_model.dart' as userModel;

class SearchController extends ControllerMVC {
  List<userModel.User> searchResult = <userModel.User>[];
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  void initiateSearch(String searchText) async {
    setState(() => searchResult.clear());
    firebaseFirestore
        .collection('Users')
        .where('userName', isEqualTo: searchText)
        .where("uid", isNotEqualTo: currentUser.value.uid)
        .snapshots()
        .listen((result) {
      for (var user in result.docs) {
        userModel.User _user = userModel.User.fromMap(user.data());
        setState(() => searchResult.add(_user));
      }
    });
  }

  /// 1.create a chatroom, send user to the chatroom, other userdetails

  sendMessage(userModel.User otherUser) {
    ChatRoom _chatroom = ChatRoom();
    Message _message = Message();
    _chatroom.deletedBy = [];
    _chatroom.involes = [currentUser.value.uid ?? "", otherUser.uid ?? ""];
    _chatroom.involved = [currentUser.value, otherUser];
    _chatroom.lastMessage = _message;
    _message.message = "This is a new conversation";
    _chatroom.lastUpdated = DateTime.now();
    addChatRoom(_chatroom).then((value) => Get.to(() => Chat(chatRoom: value)));
  }
}
