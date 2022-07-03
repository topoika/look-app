class Transactions {
  String? type;
  String? doneBy;
  String? name;
  String? time;
  String? created;
  int? points;
  Transactions({
    this.type,
    this.doneBy,
    this.name,
    this.time,
    this.created,
    this.points,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type,
      'doneBy': doneBy,
      'name': name,
      'time': time,
      'created': created,
      'points': points,
    };
  }

  factory Transactions.fromMap(Map<String, dynamic> map) {
    return Transactions(
      type: map['type'] != null ? map['type'] as String : null,
      doneBy: map['doneBy'] != null ? map['doneBy'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      time: map['time'] != null ? map['time'] as String : null,
      created: map['created'] != null ? map['created'] as String : null,
      points: map['points'] != null ? map['points'] as int : null,
    );
  }
}
