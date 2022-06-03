import 'package:look/base/models/user_model.dart';

class Comment {
  String? id;
  String? comment;
  String? time;
  User? commenter;
  Comment({
    this.id,
    this.comment,
    this.time,
    this.commenter,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'comment': comment,
      'time': time,
      'commenter': commenter?.toMap(),
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      id: map['id'] != null ? map['id'] as String : null,
      comment: map['comment'] != null ? map['comment'] as String : null,
      time: map['time'] != null ? map['time'] as String : null,
      commenter: map['commenter'] != null
          ? User.fromMap(map['commenter'] as Map<String, dynamic>)
          : null,
    );
  }
}
