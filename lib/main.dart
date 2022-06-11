import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:look/base/controllers/settings_controller.dart';
import 'package:look/base/models/settings_model.dart';
import 'package:look/base/pages/splash_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'base/repositories/user_repository.dart';
import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await [Permission.microphone, Permission.camera, Permission.notification]
      .request();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    SettingController().initiateSettings();
    FirebaseAuth.instance.currentUser != null
        ? getUser(FirebaseAuth.instance.currentUser!.uid)
        : print("No User Founde");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: setting,
        builder: (context, Settings _setting, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            locale: _setting.mobileLanguage.value,
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            theme: ThemeData(
              fontFamily: 'PopM',
              buttonColor: const Color(0xffff7f6b),
              accentColor: const Color(0xfffccac8),
              scaffoldBackgroundColor: Colors.white.withOpacity(.96),
              textTheme: const TextTheme(
                bodyText1: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
                button: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            home: SplashScreen(),
          );
        });
  }
}
