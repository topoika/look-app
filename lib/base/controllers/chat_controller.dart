import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:look/base/models/message_model.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../repositories/chat_repository.dart';
import '../repositories/user_repository.dart';
import './../models/user_model.dart' as userModel;

class ChatController extends ControllerMVC {
  final userModel.User _user = currentUser.value;
  addMessage(String textMessage, userModel.User reciever) {
    Message _message = Message();
    _message.id = FieldPath.documentId as String?;
    _message.message = textMessage;
    _message.time = FieldValue.serverTimestamp() as String?;
    _message.sendBy = _user;
    _message.recieved = reciever;
    addNewMessage(_message, 'TextRoomId');
  }
}
