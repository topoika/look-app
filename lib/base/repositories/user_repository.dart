import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:look/base/Helper/dimension.dart';
import 'package:look/base/Helper/helper.dart';
import 'package:look/base/Helper/strings.dart';
import 'package:look/base/pages/mobile_login.dart';
import 'package:look/base/pages/utils/snackbar.dart';

import '../models/user_model.dart' as userModel;
import 'package:path/path.dart' as Path;

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseAuth auth = FirebaseAuth.instance;
FirebaseStorage storage = FirebaseStorage.instance;

ValueNotifier<userModel.User> currentUser = ValueNotifier(userModel.User());
const userCollection = 'Users';

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

Future<userModel.User?> getUser(String id) async {
  userModel.User? _user;
  return await _firestore
      .collection(userCollection)
      .doc(id)
      .get()
      .then((value) {
    if (value.exists) {
      _user = userModel.User.fromMap(value.data());
      currentUser.value = userModel.User.fromMap(value.data());
      currentUser.notifyListeners();
    } else {
      _user = null;
    }
    return _user;
  });
}

Future<userModel.User> registerUser(userModel.User user) async {
  await _firestore
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

var acs = ActionCodeSettings(
    // URL you want to redirect back to. The domain (www.example.com) for this
    // URL must be whitelisted in the Firebase Console.
    url: 'https://www.example.com/finishSignUp?cartId=1234',
    // This must be true
    handleCodeInApp: true,
    iOSBundleId: 'com.example.ios',
    androidPackageName: 'com.example.android',
    // installIfNotAvailable
    androidInstallApp: true,
    // minimumVersion
    androidMinimumVersion: '12');
Future phoneLogin(String mobile, BuildContext context) async {
  Overlay.of(context)!.insert(loader);
  log(mobile);
  auth.sendSignInLinkToEmail(
      email: "toptam13@gmil.com", actionCodeSettings: acs);
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
      Helper.hideLoader(loader);
    },
    codeSent: (String verificationId, int? forceResendingToken) {
      Helper.hideLoader(loader);
      Navigator.pushReplacementNamed(context, "/MobileVerification",
          arguments: verificationId);
    },
    codeAutoRetrievalTimeout: (String verificationId) {
      Helper.hideLoader(loader);
      verificationId = verificationId;
    },
  );
}

Future verifyPhone(
    String verificationCode, String smscode, BuildContext context) async {
  Overlay.of(context)!.insert(loader);
  var _credential = PhoneAuthProvider.credential(
      verificationId: verificationCode, smsCode: smscode.trim());
  await auth.signInWithCredential(_credential).then((value) async {
    await FirebaseMessaging.instance.getToken().then((value) {
      currentUser.value.deviceToken = value.toString();
      currentUser.notifyListeners();
    });
    if (value.user != null) {
      Helper.hideLoader(loader);
      Navigator.pushReplacementNamed(context, "/TermsAndCondition",
          arguments: false);
    } else {
      Helper.hideLoader(loader);
      Scaffold.of(context)
          .showSnackBar(const SnackBar(content: Text("Verification Failer")));
    }
    var newUser = await getUser(value.user!.uid);
    if (newUser != null) {
      currentUser.value = newUser;
      updateUserStatus(FirebaseAuth.instance.currentUser!.uid, "active");
      currentUser.notifyListeners();
    } else {
      currentUser.value.uid = value.user!.uid;
      registerUser(currentUser.value);
    }
    await FirebaseMessaging.instance.getToken().then((value) {
      currentUser.value.deviceToken = value.toString();
      currentUser.notifyListeners();
    });
  });
}

void logOut(context) {
  Overlay.of(context)!.insert(loader);
  auth.signOut();
  currentUser.value = userModel.User();
  Helper.hideLoader(loader);
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const MobilePhoneLogin()),
      (route) => false);
}

Future<userModel.User> uploadProfilePictures(
    List<File> photos, userModel.User user) async {
  for (var photo in photos) {
    UploadTask uploadTask = storage
        .ref()
        .child('users/')
        .child('profilePictures/')
        .child("${user.uid}/${photo.path.split('/').last}")
        .putFile(photo);
    await uploadTask.then((res) async {
      await res.ref.getDownloadURL().then((value) {
        currentUser.value.images!.add(value);
      });
    });
  }
  return updateUser(currentUser.value);
}

void deleteImage(BuildContext context) async {
  try {
    await _firestore
        .collection(userCollection)
        .doc(currentUser.value.uid)
        .update({"images": currentUser.value.images});
  } catch (e) {
    showSnackBar(context, "Verify your internet connection", true);
  }
}

void updateUserStatus(String id, String status) async {
  try {
    await _firestore
        .collection(userCollection)
        .doc(id)
        .update({"active": status});
  } catch (e) {
    debugPrint("Error is ==" + e.toString());
  }
  //
}
