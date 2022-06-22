import 'package:look/base/models/user_model.dart';

class VideoCall {
  String? id;
  String? name;
  String? token;
  User? caller;
  User? reciever;
  int? minutes;
  VideoCall({
    this.id,
    this.name,
    this.token,
    this.caller,
    this.reciever,
    this.minutes,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'id': id,
      'token': token,
      'caller': caller?.toMap(),
      'reciever': reciever?.toMap(),
      'minutes': minutes,
    };
  }

  factory VideoCall.fromMap(Map<String, dynamic> map) {
    return VideoCall(
      name: map['name'] != null ? map['name'] as String : null,
      id: map['id'] != null ? map['id'] as String : null,
      token: map['token'] != null ? map['token'] as String : null,
      caller: map['caller'] != null
          ? User.fromMap(map['caller'] as Map<String, dynamic>)
          : null,
      reciever: map['reciever'] != null
          ? User.fromMap(map['reciever'] as Map<String, dynamic>)
          : null,
      minutes: map['minutes'] != null ? map['minutes'] as int : null,
    );
  }
}
