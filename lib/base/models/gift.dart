import '../Helper/strings.dart';

class Gift {
  String? id;
  String? name;
  String? image;
  int? points;
  Gift({
    this.id,
    this.name,
    this.image,
    this.points,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'image': image,
      'points': points,
    };
  }

  factory Gift.fromMap(Map<String, dynamic> map) {
    return Gift(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      points: map['points'] != null ? map['points'] as int : null,
    );
  }
}

List<Gift> gifts = <Gift>[
  Gift(
    id: "1",
    name: "confetti",
    image: confetti,
    points: 15,
  ),
  Gift(
    id: "2",
    name: "emoji",
    image: emoji,
    points: 5,
  ),
  Gift(
    id: "3",
    name: "fire",
    image: fire, 
    points: 18,
  ),
  Gift(
    id: "4",
    name: "heart",
    image: heart,
    points: 30,
  ),
  Gift(
    id: "5",
    name: "in_love",
    image: in_love,
    points: 40,
  ),
  Gift(
    id: "6",
    name: "party",
    image: party,
    points: 20,
  ),
  Gift(
    id: "7",
    name: "rainbow",
    image: rainbow,
    points: 13,
  ),
];
