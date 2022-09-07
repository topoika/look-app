import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:look/base/models/videocall.dart';

Future<String> getChannelToken(String channelName) async {
  var client = http.Client();
  log("https://myoung.herokuapp.com/access_token?channel=$channelName");
  var response = await client.get(Uri.parse(
      "https://myoung.herokuapp.com/access_token?channel=$channelName"));
  if (response.statusCode == 200) {
    log(response.body);
    Map<String, dynamic> responseMap = json.decode(response.body);
    return responseMap['token'];
  } else {
    return "";
  }
}

Future<VideoCall?> getVideocall(String id) async {
  try {
    return await FirebaseFirestore.instance
        .collection("videoCalls")
        .doc(id)
        .get()
        .then((value) {
      return VideoCall.fromMap(value.data()!);
    });
  } catch (e) {
    return null;
  }
}
