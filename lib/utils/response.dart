import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:newheadline/screens/authenticate/authenticate.dart';
import 'package:newheadline/utils/auth.dart';

class APIService {
  Future<String> getToken() async {
    String token = "";
    await Auth().currentUser.getIdToken().then((String t) {
      token = t;
    });
    return token;
  }

  Future<dynamic> post(String url, [Map<dynamic, dynamic> body]) async {
    String token = await getToken();

    Response response = await http.post(url,
        headers: {"Content-Type": "application/json", "x-id-token": token},
        body: json.encode(body));

    return {};
  }

  Future<dynamic> get(String url) async {
    String token = await getToken();

    await Auth().currentUser.getIdToken().then((String t) {
      token = t;
    });

    Response response = await http.get(url,
        headers: {"Content-Type": "application/json", "X-Id-Token": token});

    // print(response);
    return json.decode(response.body);
  }
}
