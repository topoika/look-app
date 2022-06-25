// ignore: import_of_legacy_library_into_null_safe
import 'dart:convert';
import 'dart:developer';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

class Notifications {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  void sendPushMessage(String token, String body, String title) async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAA9XyBCYg:APA91bEHxVMWqOXITvP7jcmC7v1-t7snMAj8upfoL0QdlscfZOHLWWSn02bjkqtZxN5umSJgvYsMGsm_KuVnHmDFmM-GX1C7b38lZI8ttpTISODvYzn8rRs9v--kisUwifNKmXaiSH40',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{'body': body, 'title': title},
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done'
            },
            "to": token,
          },
        ),
      );
      log("Done sending notification");
    } catch (e) {
      log("error push notification");
    }
  }
}
