import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:newheadline/screens/authenticate/authenticate.dart';
import 'package:newheadline/utils/auth.dart';

class APIService {
  Future<String> getToken() async {
    String token = "";
    User user = Auth().currentUser;
    if (user != null)
      await user.getIdToken().then((String t) {
        token = t;
      });
    return token;
  }

  Future<dynamic> post(String url, [Map<dynamic, dynamic> body]) async {
    String token = await getToken();

    Response response = await http.post(url,
        headers: {"Content-Type": "application/json", "x-id-token": token},
        body: json.encode(body));

    // print(response.statusCode);
    return response.statusCode;
  }

  Future<dynamic> get(String url) async {
    String token = await getToken();

    Response response = await http.get(url,
        headers: {"Content-Type": "application/json", "X-Id-Token": token});

    // print(response);
    return json.decode(response.body);
  }
}
