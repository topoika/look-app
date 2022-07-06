import 'package:look/base/models/user_model.dart';

class VideoCall {
  String? id;
  String? name;
  String? token;
  String? time;
  User? caller;
  User? reciever;
  int? minutes;
  int? hours;
  int? seconds;
  VideoCall({
    this.id,
    this.name,
    this.token,
    this.time,
    this.caller,
    this.reciever,
    this.minutes,
    this.hours,
    this.seconds,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'id': id,
      'token': token,
      'time': time,
      'caller': caller?.toMap(),
      'reciever': reciever?.toMap(),
      'minutes': minutes,
      'hours': hours,
      'seconds': seconds,
    };
  }

  factory VideoCall.fromMap(Map<String, dynamic> map) {
    return VideoCall(
      name: map['name'] != null ? map['name'] as String : null,
      id: map['id'] != null ? map['id'] as String : null,
      token: map['token'] != null ? map['token'] as String : null,
      time: map['time'] != null ? map['time'] as String : null,
      caller: map['caller'] != null
          ? User.fromMap(map['caller'] as Map<String, dynamic>)
          : null,
      reciever: map['reciever'] != null
          ? User.fromMap(map['reciever'] as Map<String, dynamic>)
          : null,
      minutes: map['minutes'] != null ? map['minutes'] as int : null,
      hours: map['hours'] != null ? map['hours'] as int : null,
      seconds: map['seconds'] != null ? map['seconds'] as int : null,
    );
  }
}
