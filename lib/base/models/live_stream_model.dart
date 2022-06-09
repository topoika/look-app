import './user_model.dart' as user;
import 'comment_model.dart';

class LiveStream {
  String? id;
  String? title;
  int? reactions;
  int? viewers;
  String? token;
  user.User? host;
  String? country;
  String? hostId;
  List<Comment>? comments;
  LiveStream({
    this.id,
    this.title,
    this.reactions,
    this.viewers,
    this.token,
    this.host,
    this.country,
    this.hostId,
    this.comments,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'reactions': reactions,
      'viewers': viewers,
      'token': token,
      'country': country,
      'hostId': hostId,
      'host': host?.toMap(),
      'comments': comments!.map((x) => x.toMap()).toList(),
    };
  }

  factory LiveStream.fromMap(Map<String, dynamic> map) {
    return LiveStream(
      id: map['id'] != null ? map['id'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      country: map['country'] != null ? map['country'] as String : null,
      hostId: map['hostId'] != null ? map['hostId'] as String : null,
      token: map['token'] != null ? map['token'] as String : null,
      reactions: map['reactions'] != null ? map['reactions'] as int : null,
      viewers: map['viewers'] != null ? map['viewers'] as int : null,
      host: map['host'] != null
          ? user.User.fromMap(map['host'] as Map<String, dynamic>)
          : null,
      comments: map['comments'] != null
          ? List<Comment>.from(
              (map['comments']).map<Comment?>(
                (x) => Comment.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }
}
