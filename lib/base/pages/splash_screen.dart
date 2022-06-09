import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Helper/dimension.dart';
import '../Helper/strings.dart';
import 'liveusers.dart';
import 'mobile_login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    navigate();
    super.initState();
  }

  void navigate() async {
    await Future.delayed(const Duration(seconds: 4));
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: ((context) => FirebaseAuth.instance.currentUser == null
                ? MobilePhoneLogin()
                : LiveUsers())));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              logo,
              height: 50,
            ),
            SizedBox(height: getVertical(context) * 0.03),
          ],
        ),
      ),
    );
  }
}
