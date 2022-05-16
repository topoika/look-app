import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

import '../models/user_model.dart';
import 'package:path/path.dart' as Path;

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
ValueNotifier<User> currentUser = ValueNotifier(User(uid: ""));
const liveCollection = 'liveuser';
const userCollection = 'Users';
const emailCollection = 'emails_to_approve';
const emailCollectionStudents = 'students_emails_to_approve';
const approvedCollection = 'Approved_users';
const approvedCollectionStudents = 'students_Approved_users';

Future<User> registerUser(User user, photo) async {
  Reference storageReference = FirebaseStorage.instance
      .ref()
      .child('${user.email}/${Path.basename(photo.path)}');
  UploadTask uploadTask = storageReference.putFile(photo);
  await uploadTask.then((res) {
    res.ref.getDownloadURL();
  });
  await storageReference.getDownloadURL().then((value) async {
    user.image = value;
    await _firestore
        .collection(userCollection)
        .doc(user.uid)
        .set(user.toMap())
        .then((value) async {
      await _firestore
          .collection(userCollection)
          .doc(user.uid)
          .get()
          .then((value) {
        user = User.fromMap(value.data());
      });
    });
  });
  return user;
}

Future<User> updateUser(User user) async {
  await _firestore
      .collection(userCollection)
      .doc(user.uid)
      .update(user.toMap())
      .then((value) async {
    await _firestore
        .collection(userCollection)
        .doc(user.uid)
        .get()
        .then((value) {
      user = User.fromMap(value.data());
    });
  });
  return user;
}

Future<void> profilePhoto({photo, email}) async {
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
  });
}
