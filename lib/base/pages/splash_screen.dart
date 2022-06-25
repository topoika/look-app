import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:look/base/controllers/splash_controller.dart';
import 'package:look/base/models/notifications.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../Helper/dimension.dart';
import '../Helper/strings.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends StateMVC<SplashScreen> {
  late SplashController _con;
  _SplashScreenState() : super(SplashController()) {
    _con = controller as SplashController;
  }
  @override
  void initState() {
    navigate();
    Notifications().sendPushMessage(
        "cz_yiIc4ThqB8UWiCg2hVk:APA91bHqZTRyqA3qOsxQ12wwHphl2VYbbBWtTlO8BUH1lfxJySGAuBzKp5GUXnhnXre6MfePBqZZN8IxSV4E9HzcGildbqdO5DQpt5SYt6WFFL9hZwPjwuT72I0FqdwO4O4t17j8dr_o",
        "Topoika is a developer",
        "Message");
    super.initState();
  }

  void navigate() async {
    await Future.delayed(const Duration(seconds: 2));
    Navigator.pushReplacementNamed(
        context,
        FirebaseAuth.instance.currentUser == null
            ? '/MobilePhoneLogin'
            : '/LiveUsers');
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
