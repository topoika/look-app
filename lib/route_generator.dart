import 'package:flutter/material.dart';
import 'package:look/base/models/videocall.dart';

import 'base/pages/call.dart';
import 'base/pages/chatrooms.dart';
import 'base/pages/liveusers.dart';
import 'base/pages/mobile_login.dart';
import 'base/pages/mobile_verification.dart';
import 'base/pages/modifyinterests.dart';
import 'base/pages/profile/showprofile.dart';
import 'base/pages/randomcalling.dart';
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
      case '/ModifyInterests':
        return MaterialPageRoute(builder: (_) => ModifyInterests());
      case '/Recharge':
        return MaterialPageRoute(builder: (_) => Recharge());
      case '/CallPage':
        return MaterialPageRoute(
            builder: (_) => CallPage(videoCall: args as VideoCall));
      case '/RandomCalling':
        return MaterialPageRoute(builder: (_) => RandomCalling());
      case '/TermsAndCondition':
        return MaterialPageRoute(
            builder: (_) => TermsAndCondition(val: args as bool));
      case '/MobileVerification':
        return MaterialPageRoute(
            builder: (_) => MobileVerification(verificationId: args as String));
      default:
        return MaterialPageRoute(
            builder: (_) =>
                const Scaffold(body: SafeArea(child: Text('Route Error'))));
    }
  }
}
