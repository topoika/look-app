import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:look/base/controllers/settings_controller.dart';
import 'package:look/base/models/settings_model.dart';
import 'package:look/base/pages/splash_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'base/repositories/user_repository.dart';

import 'firebase_options.dart';
import 'generated/l10n.dart';
import 'route_generator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
    name: "out-app",
  );
  await FirebaseAppCheck.instance.activate(
    webRecaptchaSiteKey: 'recaptcha-v3-site-key',
  );
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
    WidgetsBinding.instance.addObserver(this);
    if (FirebaseAuth.instance.currentUser != null) {
      getUser(FirebaseAuth.instance.currentUser!.uid);
      updateUserStatus(FirebaseAuth.instance.currentUser!.uid, "active");
    }
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    final isBg = state == AppLifecycleState.paused;
    final isClosed = state == AppLifecycleState.detached;
    final isScreen = state == AppLifecycleState.resumed;
    final inactive = state == AppLifecycleState.inactive;
    if (isScreen && FirebaseAuth.instance.currentUser != null) {
      updateUserStatus(FirebaseAuth.instance.currentUser!.uid, "active");
    }
    if (isClosed && FirebaseAuth.instance.currentUser != null) {
      updateUserStatus(FirebaseAuth.instance.currentUser!.uid, "offline");
    }
    if (isBg && FirebaseAuth.instance.currentUser != null) {
      updateUserStatus(FirebaseAuth.instance.currentUser!.uid, "offline");
    }
    if (inactive && FirebaseAuth.instance.currentUser != null) {
      updateUserStatus(FirebaseAuth.instance.currentUser!.uid, "offline");
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    updateUserStatus(FirebaseAuth.instance.currentUser!.uid, "offline");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: setting,
      builder: (context, Settings _setting, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          locale: _setting.mobileLanguage.value,
          onGenerateRoute: RouteGenerator.generateRoute,
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
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              titleTextStyle: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 24,
                color: Colors.black54,
              ),
            ),
            iconTheme: IconThemeData(
              color: Colors.black54,
            ),
            textTheme: const TextTheme(
              bodyText1: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
              headline6: TextStyle(
                fontWeight: FontWeight.w800,
                color: Colors.black87,
              ),
              button: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          home: SplashScreen(),
        );
      },
    );
  }
}
