import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:newheadline/provider/auth.dart';

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
        headers: {
          "Content-Type": "application/json",
          'Accept': 'application/json',
          "X-Id-Token": token
        },
        body: json.encode(body));

    return response.statusCode;
  }

  Future<List<Map<String, dynamic>>> get(String url) async {
    List<Map<String, dynamic>> result = [];
    Response response;
    String token = await getToken();
    try {
      response = await http.get(url,
          headers: {"Content-Type": "application/json", "X-Id-Token": token});
      result = List<Map<String, dynamic>>.from(json.decode(response.body));
    } on Exception catch (exception) {
      print(exception);
    }

    return result;
  }

  Future<Map<String, dynamic>> getOne(String url) async {
    Map<String, dynamic> result;
    String token = await getToken();

    Response response = await http.get(url,
        headers: {"Content-Type": "application/json", "X-Id-Token": token});
    try {
      result = Map<String, dynamic>.from(json.decode(response.body));
    } on Exception catch (exception) {
      print(exception);
    }

    return result;
  }

  Future<int> delete(String url) async {
    Response response;
    String token = await getToken();
    try {
      response = await http.delete(url,
          headers: {"Content-Type": "application/json", "X-Id-Token": token});
    } on Exception catch (exception) {
      print(exception);
      return 400;
    }

    return response.statusCode;
  }
}
