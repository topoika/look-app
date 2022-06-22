class User {
  String? uid;
  String? name;
  String? userName;
  String? email;
  String? country;
  String? job;
  String? location;
  String? dob;
  String? describe;
  String? education;
  String? phone;
  String? gender;
  String? marital;
  String? image;
  String? image2;
  String? image3;
  double? points;
  String? personality;
  String? drinking;
  String? smoking;
  String? eating;
  int? videoRate;
  int? smsRate;
  int? age;
  String? active;
  List<String>? interests;
  User({
    this.uid,
    this.name,
    this.userName,
    this.email,
    this.country,
    this.job,
    this.location,
    this.dob,
    this.describe,
    this.education,
    this.phone,
    this.gender,
    this.marital,
    this.image,
    this.image2,
    this.image3,
    this.points,
    this.personality,
    this.drinking,
    this.smoking,
    this.eating,
    this.videoRate,
    this.smsRate,
    this.age,
    this.interests,
    this.active,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name ?? "",
      'email': email ?? "",
      'userName': userName,
      'country': country ?? "",
      'job': job ?? "",
      'location': location ?? "",
      'dob': dob ?? "",
      'describe': describe ?? "",
      'education': education ?? "",
      'phone': phone,
      'gender': gender ?? "",
      'marital': marital ?? "",
      'image': image ?? "",
      'image2': image2 ?? "",
      'image3': image3 ?? "",
      'points': points ?? 0,
      'personality': personality ?? "",
      'drinking': drinking ?? "",
      'smoking': smoking ?? "",
      'eating': eating ?? "",
      'videoRate': videoRate ?? 0,
      'smsRate': smsRate ?? 0,
      'age': age ?? 0,
      'interests': interests ?? [],
      'active': active ?? "online",
    };
  }

  factory User.fromMap(Map<String, dynamic>? map) {
    return User(
      uid: map!['uid'],
      name: map['name'],
      userName: map['userName'],
      email: map['email'],
      country: map['country'],
      job: map['job'],
      location: map['location'],
      dob: map['dob'],
      describe: map['describe'],
      education: map['education'],
      phone: map['phone'],
      gender: map['gender'],
      marital: map['marital'],
      image: map['image'],
      image2: map['image2'],
      image3: map['image3'],
      points: map['points']?.toDouble(),
      personality: map['personality'],
      drinking: map['drinking'],
      smoking: map['smoking'],
      eating: map['eating'],
      videoRate: map['videoRate'],
      smsRate: map['smsRate'],
      age: map['age'],
      interests:
          map['interests'] != null ? List<String>.from(map['interests']) : null,
      active: map['active'],
    );
  }
}
