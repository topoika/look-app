class User {
  String? uid;
  String? invitee;
  String? name;
  String? userName;
  String? email;
  String? deviceToken;
  String? country;
  String? job;
  String? location;
  String? dob;
  String? joined;
  String? describe;
  String? education;
  String? phone;
  String? gender;
  String? marital;
  int? points;
  String? personality;
  String? drinking;
  String? smoking;
  String? eating;
  int? videoRate;
  int? smsRate;
  int? age;
  String? active;
  List<String>? interests;
  List<String>? images;
  bool? globalMode;
  bool? videoCallsAvailable;
  User({
    this.uid,
    this.invitee,
    this.name,
    this.userName,
    this.email,
    this.deviceToken,
    this.country,
    this.job,
    this.location,
    this.dob,
    this.joined,
    this.describe,
    this.education,
    this.phone,
    this.gender,
    this.marital,
    this.points,
    this.personality,
    this.drinking,
    this.smoking,
    this.eating,
    this.videoRate,
    this.smsRate,
    this.age,
    this.interests,
    this.images,
    this.active,
    this.globalMode,
    this.videoCallsAvailable,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'invitee': invitee,
      'name': name ?? "",
      'email': email ?? "",
      'deviceToken': deviceToken ?? "",
      'userName': userName,
      'country': country ?? "",
      'job': job ?? "",
      'location': location ?? "",
      'dob': dob ?? "",
      'joined': joined ?? "",
      'describe': describe ?? "",
      'education': education ?? "",
      'phone': phone,
      'gender': gender ?? "",
      'marital': marital ?? "",
      'points': points ?? 0,
      'personality': personality ?? "",
      'drinking': drinking ?? "",
      'smoking': smoking ?? "",
      'eating': eating ?? "",
      'videoRate': videoRate ?? 0,
      'smsRate': smsRate ?? 0,
      'age': age ?? 0,
      'interests': interests ?? [],
      'images': images,
      'active': active ?? "online",
      'globalMode': globalMode ?? true,
      'videoCallsAvailable': videoCallsAvailable ?? false,
    };
  }

  factory User.fromMap(Map<String, dynamic>? map) {
    return User(
      uid: map!['uid'],
      invitee: map['invitee'],
      name: map['name'],
      userName: map['userName'],
      email: map['email'],
      deviceToken: map['deviceToken'],
      country: map['country'],
      job: map['job'],
      location: map['location'],
      dob: map['dob'],
      joined: map['joined'],
      describe: map['describe'],
      education: map['education'],
      phone: map['phone'],
      gender: map['gender'],
      marital: map['marital'],
      points: map['points']!.toInt(),
      personality: map['personality'],
      drinking: map['drinking'],
      smoking: map['smoking'],
      eating: map['eating'],
      videoRate: map['videoRate'],
      smsRate: map['smsRate'],
      age: map['age'],
      interests:
          map['interests'] != null ? List<String>.from(map['interests']) : null,
      images: map['images'] != null ? List<String>.from(map['images']) : [],
      active: map['active'],
      globalMode: map['globalMode'],
      videoCallsAvailable: map['videoCallsAvailable'] ?? false,
    );
  }
}
