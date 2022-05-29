import 'package:look/base/models/user_model.dart';

class Message {
  String? id;
  String? message;
  String? time;
  User? sendBy;
  User? recieved;
  List<dynamic>? deleteBy;
  Message({
    this.id,
    this.message,
    this.time,
    this.sendBy,
    this.recieved,
    this.deleteBy,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'message': message,
      'time': time,
      'sendBy': sendBy?.toMap(),
      'recieved': recieved?.toMap(),
      'deleteBy': deleteBy,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['id'] != null ? map['id'] as String : null,
      message: map['message'] != null ? map['message'] as String : null,
      time: map['time'] != null ? map['time'] as String : null,
      sendBy: map['sendBy'] != null
          ? User.fromMap(map['sendBy'] as Map<String, dynamic>)
          : null,
      recieved: map['recieved'] != null
          ? User.fromMap(map['recieved'] as Map<String, dynamic>)
          : null,
      deleteBy: map['deleteBy'] != null
          ? List<dynamic>.from((map['deleteBy'] as List<dynamic>))
          : null,
    );
  }
}
