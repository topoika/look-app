class User {
  String? uid;
  String? name;
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
  double? points;
  String? personality;
  String? drinking;
  String? smoking;
  String? eating;
  List<String>? interests;
  User({
    this.uid,
    this.name,
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
    this.points,
    this.personality,
    this.drinking,
    this.smoking,
    this.eating,
    this.interests,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'country': country,
      'job': job,
      'location': location,
      'dob': dob,
      'describe': describe,
      'education': education,
      'phone': phone,
      'gender': gender,
      'marital': marital,
      'image': image,
      'points': points,
      'personality': personality,
      'drinking': drinking,
      'smoking': smoking,
      'eating': eating,
      'interests': interests,
    };
  }

  factory User.fromMap(Map<String, dynamic>? map) {
    return User(
      uid: map!['uid'],
      name: map['name'],
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
      points: map['points']?.toDouble(),
      personality: map['personality'],
      drinking: map['drinking'],
      smoking: map['smoking'],
      eating: map['eating'],
      interests:
          map['interests'] != null ? List<String>.from(map['interests']) : null,
    );
  }
}
