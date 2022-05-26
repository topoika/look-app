import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../pages/chat.dart';
import '../repositories/chat_repository.dart';
import './../models/user_model.dart' as userModel;

class SearchController extends ControllerMVC {
  List<userModel.User> searchResult = <userModel.User>[];
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  void initiateSearch(String searchText) async {
    firebaseFirestore
        .collection('Users')
        .where('name', isEqualTo: searchText)
        .snapshots()
        .listen((result) {
      for (var result in result.docs) {
        setState(() => searchResult.add(userModel.User.fromMap(result.data())));
      }
    });
  }

  /// 1.create a chatroom, send user to the chatroom, other userdetails
  sendMessage(String userName) {
    List<String> users = ["kjakjskdj", userName];

    Map<String, dynamic> chatRoom = {
      "usersData": users,
      "chatRoomId": "TestChatRoomId",
    };

    addChatRoom(chatRoom, "TestChatRoomId");
    // Get.to(() => const Chat());
  }
}
