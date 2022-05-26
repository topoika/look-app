import 'package:look/base/models/message_model.dart';
import 'package:look/base/models/user_model.dart';

class ChatRoom {
  String? id;
  Message? lastMessage;
  List<User>? involved;
  DateTime? lastUpdated;
  List<String>? deletedBy;
  ChatRoom({
    this.id,
    this.lastMessage,
    this.involved,
    this.lastUpdated,
    this.deletedBy,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'lastMessage': lastMessage?.toMap(),
      'involved': involved!.map((x) => x.toMap()).toList(),
      'lastUpdated': lastUpdated?.millisecondsSinceEpoch,
      'deletedBy': deletedBy,
    };
  }

  factory ChatRoom.fromMap(Map<String, dynamic> map) {
    return ChatRoom(
      id: map['id'] != null ? map['id'] as String : null,
      lastMessage: map['lastMessage'] != null
          ? Message.fromMap(map['lastMessage'] as Map<String, dynamic>)
          : null,
      involved: map['involved'] != null
          ? List<User>.from(
              (map['involved'] as List<int>).map<User?>(
                (x) => User.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      lastUpdated: map['lastUpdated'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['lastUpdated'] as int)
          : null,
      deletedBy: map['deletedBy'] != null
          ? List<String>.from((map['deletedBy'] as List<String>))
          : null,
    );
  }
}
