import 'package:flutter/material.dart';

import 'base/pages/chatrooms.dart';
import 'base/pages/liveusers.dart';
import 'base/pages/mobile_login.dart';
import 'base/pages/mobile_verification.dart';
import 'base/pages/profile/showprofile.dart';
import 'base/pages/recharge.dart';
import 'base/pages/search.dart';
import 'base/pages/termscondition.dart';
import 'base/pages/videocall.dart';

class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/LiveUsers':
        return MaterialPageRoute(builder: (_) => LiveUsers());
      case '/ChatRooms':
        return MaterialPageRoute(builder: (_) => ChatRooms());
      case '/Search':
        return MaterialPageRoute(builder: (_) => Search());
      case '/VideoCalls':
        return MaterialPageRoute(builder: (_) => VideoCalls());
      case '/MobilePhoneLogin':
        return MaterialPageRoute(builder: (_) => MobilePhoneLogin());
      case '/MyProfile':
        return MaterialPageRoute(builder: (_) => MyProfile());
      case '/Recharge':
        return MaterialPageRoute(builder: (_) => Recharge());
      case '/TermsAndCondition':
        return MaterialPageRoute(
            builder: (_) => TermsAndCondition(val: args as bool));
      case '/MobileVerification':
        return MaterialPageRoute(
            builder: (_) => MobileVerification(verificationId: args as String));
      // case '/Splash':
      //   return MaterialPageRoute(builder: (_) => const SplashScreen());
      // case '/Home':
      //   return MaterialPageRoute(
      //       builder: (_) => MapPage(
      //             created: false,
      //             event: Event(),
      //           ));
      // case '/Login':
      //   return MaterialPageRoute(builder: (_) => const Login());
      // case '/Startup':
      //   return MaterialPageRoute(builder: (_) => const StartUp());
      default:
        return MaterialPageRoute(
            builder: (_) =>
                const Scaffold(body: SafeArea(child: Text('Route Error'))));
    }
  }
}
