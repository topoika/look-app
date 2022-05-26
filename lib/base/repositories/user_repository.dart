import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:look/base/Helper/dimension.dart';
import 'package:look/base/Helper/helper.dart';
import 'package:look/base/pages/mobile_login.dart';

import '../models/user_model.dart' as userModel;
import 'package:path/path.dart' as Path;

import '../pages/mobile_verification.dart';
import '../pages/termscondition.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseAuth auth = FirebaseAuth.instance;

ValueNotifier<userModel.User> currentUser = ValueNotifier(userModel.User());
const liveCollection = 'liveuser';
const userCollection = 'Users';
const emailCollection = 'emails_to_approve';
const emailCollectionStudents = 'students_emails_to_approve';
const approvedCollection = 'Approved_users';
const approvedCollectionStudents = 'students_Approved_users';
OverlayEntry loader = OverlayEntry(
  builder: (BuildContext context) {
    return SafeArea(
      child: Container(
        height: double.infinity,
        width: getHorizontal(context),
        color: Colors.white.withOpacity(.4),
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  },
);

Future<userModel.User> getUser(String id) async {
  return await _firestore
      .collection(userCollection)
      .doc(id)
      .get()
      .then((value) {
    currentUser.value = userModel.User.fromMap(value.data());
    log(value.data().toString());
    currentUser.notifyListeners();
    log(currentUser.value.toMap().toString());
    return currentUser.value;
  });
}

Future<userModel.User> registerUser(userModel.User user) async {
  var contained =
      await _firestore.collection(userCollection).doc(user.uid).get();
  currentUser.value = contained.exists
      ? await _firestore
          .collection(userCollection)
          .doc(user.uid)
          .get()
          .then((value) => userModel.User.fromMap(value.data()))
      : await _firestore
          .collection(userCollection)
          .doc(user.uid)
          .set(user.toMap())
          .then((value) async => await _firestore
              .collection(userCollection)
              .doc(user.uid)
              .get()
              .then((value) => userModel.User.fromMap(value.data())));
  currentUser.notifyListeners();
  return currentUser.value;
}

Future<userModel.User> updateUser(userModel.User user) async {
  log(user.uid ?? "sdsds");
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
      currentUser.value = userModel.User.fromMap(value.data());
      currentUser.notifyListeners();
      return currentUser.value;
    });
  });
  return currentUser.value;
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

Future verifyPhone(
    String verificationCode, String smscode, BuildContext context) async {
  var _credential = PhoneAuthProvider.credential(
      verificationId: verificationCode, smsCode: smscode.trim());
  await auth.signInWithCredential(_credential).then((value) {
    if (value.user != null) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const TermsAndCondition(val: true)));
    } else {
      Scaffold.of(context)
          .showSnackBar(const SnackBar(content: Text("Verification Failer")));
    }
    currentUser.value.uid = value.user!.uid;
    registerUser(currentUser.value);
  });
}

void logOut(context) {
  Overlay.of(context)!.insert(loader);
  auth.signOut();
  Helper.hideLoader(loader);
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const MobilePhoneLogin()),
      (route) => false);
}

Future<userModel.User> uploadProfilePicture(photo, userModel.User user) async {
  Reference storageReference = FirebaseStorage.instance
      .ref()
      .child('${user.uid}/${Path.basename(photo.path)}');
  UploadTask uploadTask = storageReference.putFile(photo);
  await uploadTask.then((res) {
    res.ref.getDownloadURL();
  });
  return await storageReference.getDownloadURL().then((value) {
    currentUser.value.image = value;
    return updateUser(currentUser.value);
  });
}
