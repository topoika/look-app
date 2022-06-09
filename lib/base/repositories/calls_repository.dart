import 'dart:convert';

import 'package:http/http.dart' as http;

Future<String> getChannelToken(String channelName) async {
  var client = http.Client();
  var response = await client.get(Uri.parse(
      "https://myoung.herokuapp.com/access_token?channel=$channelName"));
  if (response.statusCode == 200) {
    Map<String, dynamic> responseMap = json.decode(response.body);
    return responseMap['token'];
  } else {
    return "";
  }
}
