import 'package:flutter/material.dart';
import 'package:look/base/models/chat_room_model.dart';

import 'base/models/videocall.dart';
import 'base/pages/bigevent.dart';
import 'base/pages/call.dart';
import 'base/pages/chat.dart';
import 'base/pages/settings/block_list.dart';
import 'base/pages/settings/call_history.dart';
import 'base/pages/chatrooms.dart';
import 'base/pages/liveusers.dart';
import 'base/pages/mobile_login.dart';
import 'base/pages/mobile_verification.dart';
import 'base/pages/modifyinterests.dart';
import 'base/pages/settings/my_invitees.dart';
import 'base/pages/settings/one_to_one_chat.dart';
import 'base/pages/profile/showprofile.dart';
import 'base/pages/settings/points_redeem.dart';
import 'base/pages/settings/pubic_notice.dart';
import 'base/pages/randomcalling.dart';
import 'base/pages/recharge.dart';
import 'base/pages/search.dart';
import 'base/pages/settings/settings.dart';
import 'base/pages/termscondition.dart';
import 'base/pages/settings/transaction_history.dart';
import 'base/pages/videocall.dart';

class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/LiveUsers':
        return MaterialPageRoute(builder: (_) => LiveUsers());
      case '/ChatRooms':
        return MaterialPageRoute(builder: (_) => ChatRooms());
      case '/Chat':
        return MaterialPageRoute(
            builder: (_) => Chat(chatRoom: args as ChatRoom));
      case '/BigEvent':
        return MaterialPageRoute(builder: (_) => BigEvent());
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
      case '/PointRedeem':
        return MaterialPageRoute(builder: (_) => PointRedeem());
      case '/TermsAndCondition':
        return MaterialPageRoute(
            builder: (_) => TermsAndCondition(val: args as bool));
      case '/MobileVerification':
        return MaterialPageRoute(
            builder: (_) => MobileVerification(verificationId: args as String));
      case '/SettingsPage':
        return MaterialPageRoute(builder: (_) => SettingsPage());
      case '/CallsHistory':
        return MaterialPageRoute(builder: (_) => CallsHistory());
      case '/PublicNotice':
        return MaterialPageRoute(builder: (_) => PublicNotice());
      case '/AdminInquiry':
        return MaterialPageRoute(builder: (_) => AdminInquiry());
      case '/MyInvitee':
        return MaterialPageRoute(builder: (_) => MyInvitee());
      case '/TransactionHistory':
        return MaterialPageRoute(builder: (_) => TransactionHistory());
      case '/BlockList':
        return MaterialPageRoute(builder: (_) => BlockList());
      default:
        return MaterialPageRoute(
            builder: (_) =>
                const Scaffold(body: SafeArea(child: Text('Route Error'))));
    }
  }
}
