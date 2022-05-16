import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static const liveCollection = 'liveuser';
  static const userCollection = 'Users';
  static const emailCollection = 'emails_to_approve';
  static const emailCollectionStudents = 'students_emails_to_approve';
  static const approvedCollection = 'Approved_users';
  static const approvedCollectionStudents = 'students_Approved_users';

  Future<void> phot({photo, email}) async
  {
    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('$email/${Path.basename(photo.path)}');
    UploadTask uploadTask = storageReference.putFile(photo);
    await uploadTask.then((res) {
      res.ref.getDownloadURL();
    });
    await storageReference.getDownloadURL().then((fileURL) async {
      await FirebaseFirestore.instance
          .collection(userCollection)
          .doc("hell")
          .set({
        'email': email,
        'image': fileURL,
      });
    }
    );
  }

  Future<void> regUser(
      {email, name, country, job, location, dob, describe, education, phone, gender, photo, marital,
        drinking, smoking, eating, personality, interests, uid}) async {

    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('$email/${Path.basename(photo.path)}');
    UploadTask uploadTask = storageReference.putFile(photo);
    await uploadTask.then((res) {
      res.ref.getDownloadURL();
    });
    await storageReference.getDownloadURL().then((fileURL) async {
      await FirebaseFirestore.instance
          .collection(userCollection)
          .doc(uid)
          .set({
        'name': name,
        'email': email,
        'country': country,
        'job': job,
        "location": location,
        "DOB": dob,
        "describe": describe,
        "education": education,
        "phone": phone,
        "gender": gender,
        "marital": marital,
        'drinking': drinking,
        'smoking': smoking,
        "eating": eating,
        "personality": personality,
        "interest": interests,
        'userid': uid,
        'image': fileURL,
        'points':15,
      });
    }
    );
    awards(Uid: uid);
  }
  Future<void> regUser2(
      {email, name, country, job, location, dob, describe, education, phone, gender, marital, drinking, smoking, eating, personality, interests, uid}) async {

      await FirebaseFirestore.instance
          .collection(userCollection)
          .doc(uid)
          .set({
        'name': name,
        'email': email,
        'country': country,
        'job': job,
        "location": location,
        "DOB": dob,
        "describe": describe,
        "education": education,
        "phone": phone,
        "gender": gender,
        "marital": marital,
        'drinking': drinking,
        'smoking': smoking,
        "eating": eating,
        "personality": personality,
        "interest": interests,
        'userid': uid,
        'image': 'https://www.kindpng.com/picc/m/252-2524695_dummy-profile-image-jpg-hd-png-download.png',
      });
      awards(Uid: uid);
  }

  getUserChats(String itIsMyName) async {
    return FirebaseFirestore.instance
        .collection("chatRoom")
        .where('usersData', arrayContains: itIsMyName)
        .snapshots();
  }

//   // ignore: missing_return
  Future<void> addMessage(String chatRoomId, chatMessageData) async {
    await FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .add(chatMessageData);
  }

  getChats(String chatRoomId) async {
    return FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy('time', descending: false)
        .snapshots();
  }


  Future<void> awards({Uid}) async {

    await FirebaseFirestore.instance
        .collection('Awards')
        .doc(Uid)
        .set({
      'awardnumber':0,
      'time':FieldValue.serverTimestamp(),
    });
    await FirebaseFirestore.instance
        .collection('Time')
        .doc(Uid)
        .set({
      'time':FieldValue.serverTimestamp(),
    });
  }
  // ignore: missing_return
  Future<void> addChatRoom(chatRoom, chatRoomId) async {
    FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .set(chatRoom);
  }
}
