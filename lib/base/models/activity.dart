import 'package:look/base/models/comment_model.dart';
import 'package:look/base/models/gift.dart';
import 'package:look/base/models/user_model.dart';

class Activity {
  String? type;
  Comment? comment;
  User? actor;
  String? time;
  Gift? gift;
  String? desc;
  Activity({
    this.type,
    this.comment,
    this.actor,
    this.time,
    this.gift,
    this.desc,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type,
      'comment': comment?.toMap(),
      'time': time,
      'actor': actor?.toMap(),
      'gift': gift?.toMap(),
      'desc': desc,
    };
  }

  factory Activity.fromMap(Map<String, dynamic> map) {
    return Activity(
      type: map['type'] != null ? map['type'] as String : null,
      comment: map['comment'] != null
          ? Comment.fromMap(map['comment'] as Map<String, dynamic>)
          : null,
      time: map['time'] != null ? map['time'] as String : null,
      actor: map['actor'] != null
          ? User.fromMap(map['actor'] as Map<String, dynamic>)
          : null,
      gift: map['gift'] != null
          ? Gift.fromMap(map['gift'] as Map<String, dynamic>)
          : null,
      desc: map['desc'] != null ? map['desc'] as String : null,
    );
  }
}
