class User {
  String uid = "";
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
  String? drinStringsmoking;
  String? eating;
  String? personality;
  String? interests;
  String? image;
  double? points;
  User({
    required uid,
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
    this.drinStringsmoking,
    this.eating,
    this.personality,
    this.interests,
    this.image,
    this.points,
  });

  Map<String, dynamic> toMap() {
    return {
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
      'drinStringsmoking': drinStringsmoking,
      'eating': eating,
      'personality': personality,
      'interests': interests,
      'uid': uid,
      'fileURL': image,
      'points': points,
    };
  }

  factory User.fromMap(Map<String, dynamic>? map) {
    return User(
      name: map!['name'],
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
      drinStringsmoking: map['drinStringsmoking'],
      eating: map['eating'],
      personality: map['personality'],
      interests: map['interests'],
      uid: map['uid'],
      image: map['image'],
      points: map['points']?.toDouble(),
    );
  }
}
