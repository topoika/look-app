import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:look/constant/variables.dart';
import 'package:look/base/pages/termscondition.dart';



class VerifyScreen extends StatefulWidget {
final String email;
final String pass;
  const VerifyScreen({Key? key,required this.email,required this.pass})
      : super(key: key);

  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final auth = FirebaseAuth.instance;
  User? user;
  late Timer timer;

  @override
  void initState() {
    user = auth.currentUser;
    user!.sendEmailVerification();

    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      checkEmailVerified();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'An email has been sent to ${user!.email} please verify',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
           const Text("After Verification, you will be proceed to profile"),

          ],
        ),
      ),
    );
  }

  Future<void> checkEmailVerified() async {
    user = auth.currentUser;
    await user!.reload();
    if (user!.emailVerified) {
      var _auth1 = FirebaseAuth.instance;
      await _auth1.createUserWithEmailAndPassword(email: widget.email, password: widget.pass);
      EMAIL = widget.email;
      timer.cancel();
      Get.to(() => const TermsAndCondition(val: false,));
    //  (widget.student==true)?Get.to(() => const Page1_S()):Get.to(() => const Page1_T());
    }
  }
}