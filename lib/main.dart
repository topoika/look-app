import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:look/frontend/homepage.dart';
import 'package:look/liveusers/liveusers.dart';

import 'constant/variables.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  String uid = '';
  String username = '';
  @override
  void initState() {
    super.initState();
    detectUser();
  }

  void detectUser() {
    FirebaseAuth _auth1 = FirebaseAuth.instance;

    if (_auth1.currentUser != null) {
      uid = FirebaseAuth.instance.currentUser!.uid;
      profile();
    }
  }

  Future<void> profile() async {
    try {
      var result =
          await FirebaseFirestore.instance.collection('Users').doc(uid).get();
      username = result.data()!['name'];
      if (username.isNotEmpty) {
        await FirebaseFirestore.instance
            .collection('CurrentlyActiveUsers')
            .doc(uid)
            .set({
          'name': result.data()!['name'],
          'image': result.data()!['image'],
          'userid': uid,
          'country': result.data()!['country']
        });
      }
    } catch (e) {
      print("something went wrong");
    }
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    profile();
    switch (state) {
      case AppLifecycleState.inactive:
        if (RANDOMCALL == true) {
          FirebaseFirestore.instance
              .collection("randomcalling")
              .doc(uid)
              .delete();
        }
        if (JOINCURRENTCHANNEL != '') {
          var result = await FirebaseFirestore.instance
              .collection('channels')
              .doc(JOINCURRENTCHANNEL)
              .get();
          int viewers = result.data()!['viewers'];
          await FirebaseFirestore.instance
              .collection('channels')
              .doc(JOINCURRENTCHANNEL)
              .update({
            'viewers': viewers - 1,
          });
        }
        if (HOSTCURRENTCHANNEL != '') {
          if (username.isNotEmpty) {
            try {
              await FirebaseFirestore.instance
                  .collection("channels")
                  .doc(username)
                  .update({
                'end': 1,
              });
              await FirebaseFirestore.instance
                  .collection("channels")
                  .doc(username)
                  .delete();
            } catch (e) {
              print(e.toString());
            }
          }
        }
        await FirebaseFirestore.instance
            .collection('CurrentlyActiveUsers')
            .doc(uid)
            .delete();
        print('inactive');
        break;
      case AppLifecycleState.paused:
        if (RANDOMCALL == true) {
          FirebaseFirestore.instance
              .collection("randomcalling")
              .doc(uid)
              .delete();
        }
        if (JOINCURRENTCHANNEL != '') {
          if (username != '') {
            var result = await FirebaseFirestore.instance
                .collection('channels')
                .doc(JOINCURRENTCHANNEL)
                .get();
            int viewers = result.data()!['viewers'];
            await FirebaseFirestore.instance
                .collection('channels')
                .doc(JOINCURRENTCHANNEL)
                .update({
              'viewers': viewers - 1,
            });
          }
        }
        if (HOSTCURRENTCHANNEL != '') {
          if (username != '') {
            try {
              await FirebaseFirestore.instance
                  .collection("channels")
                  .doc(username)
                  .update({
                'end': 1,
              });
              await FirebaseFirestore.instance
                  .collection("channels")
                  .doc(username)
                  .delete();
            } catch (e) {
              print(e.toString());
            }
          }
        }
        await FirebaseFirestore.instance
            .collection('CurrentlyActiveUsers')
            .doc(uid)
            .delete();
        print('paused');
        break;
      case AppLifecycleState.resumed:
        profile();
        print('resumed');
        break;
      case AppLifecycleState.detached:
        if (RANDOMCALL == true) {
          FirebaseFirestore.instance
              .collection("randomcalling")
              .doc(uid)
              .delete();
        }
        if (JOINCURRENTCHANNEL != '') {
          var result = await FirebaseFirestore.instance
              .collection('channels')
              .doc(JOINCURRENTCHANNEL)
              .get();
          int viewers = result.data()!['viewers'];
          await FirebaseFirestore.instance
              .collection('channels')
              .doc(JOINCURRENTCHANNEL)
              .update({
            'viewers': viewers - 1,
          });
        }
        if (HOSTCURRENTCHANNEL != '') {
          await FirebaseFirestore.instance
              .collection("channels")
              .doc(username)
              .update({
            'end': 1,
          });
          await FirebaseFirestore.instance
              .collection("channels")
              .doc(username)
              .delete();
        }

        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: (uid != '') ? const LiveUsers() : const HomePage(),
    );
  }
}
