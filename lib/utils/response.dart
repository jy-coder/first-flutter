import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

Future<dynamic> post(String url,
    [String token, Map<dynamic, dynamic> body]) async {
  Response response = await http.post(url,
      headers: <String, String>{
        "Content-Type": "application/json",
        "x-id-token": token
      },
      body: body);

  return {};
}

Future<dynamic> get(String url, [String token]) async {
  Response response = await http.get(url,
      headers: {"Content-Type": "application/json", "X-Id-Token": token});
  // print(response);
  return json.decode(response.body);
}
