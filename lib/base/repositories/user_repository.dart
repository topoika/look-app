import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../models/user_model.dart' as userModel;
import 'package:path/path.dart' as Path;

import '../pages/mobile_verification.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseAuth auth = FirebaseAuth.instance;

ValueNotifier<userModel.User> currentUser =
    ValueNotifier(userModel.User(uid: ""));
const liveCollection = 'liveuser';
const userCollection = 'Users';
const emailCollection = 'emails_to_approve';
const emailCollectionStudents = 'students_emails_to_approve';
const approvedCollection = 'Approved_users';
const approvedCollectionStudents = 'students_Approved_users';

Future<userModel.User> registerUser(userModel.User user, photo) async {
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
        user = userModel.User.fromMap(value.data());
      });
    });
  });
  return user;
}

Future<userModel.User> updateUser(userModel.User user) async {
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
      user = userModel.User.fromMap(value.data());
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

Future phoneLogin(String mobile, BuildContext context) async {
  auth.verifyPhoneNumber(
    phoneNumber: mobile,
    timeout: const Duration(seconds: 60),
    verificationCompleted: (AuthCredential authCredential) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Your code have been sent'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 3),
      ));
    },
    verificationFailed: (FirebaseAuthException authException) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Verification Fialed'),
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 3),
      ));
    },
    codeSent: (String verificationId, int? forceResendingToken) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MobileVerification(
            verificationId: verificationId,
          ),
        ),
      );
    },
    codeAutoRetrievalTimeout: (String verificationId) {
      verificationId = verificationId;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Verification TimeOut'),
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 3),
      ));
    },
  );
}

Future verifyPhone(String verificationCode, String smscode) async {
  var _credential = PhoneAuthProvider.credential(
      verificationId: verificationCode, smsCode: smscode.trim());
  return await auth.signInWithCredential(_credential).then((value) {
    if (value.user != null) {
      return true;
    }
    currentUser.value.uid = value.user!.uid;
  });
}
