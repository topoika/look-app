import 'package:look/base/models/chat_room_model.dart';
import 'package:look/base/models/message_model.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../repositories/chat_repository.dart';
import '../repositories/user_repository.dart';
import './../models/user_model.dart' as userModel;

class ChatController extends ControllerMVC {
  final userModel.User _user = currentUser.value;
  List<ChatRoom> userChatRooms = <ChatRoom>[];
  addMessage(String textMessage, userModel.User reciever, String roomId) {
    Message _message = Message();
    _message.message = textMessage;
    _message.time = DateTime.now().toString();
    _message.sendBy = _user;
    _message.recieved = reciever;
    _message.deleteBy = [];
    addNewMessage(_message, roomId);
  }

  listenForChatRooms() async {
    getChatRooms().then((value) {
      for (var _chatRoom in value.docs) {
        ChatRoom _one = ChatRoom.fromMap(_chatRoom.data());
        setState(() => userChatRooms.add(_one));
      }
    });
  }
}
