import 'package:http/http.dart' as http;
import 'package:newheadline/services/auth.dart';
import 'package:http/http.dart' as http;

class Res {
  Auth _auth = Auth();

  void makeRequest(String url) {
    // String token = _auth.getToken().toString();
    // http.get(url,
    //     headers: {"Content-Type": "application/json", "x-id-token": token});

    // final response = await http.get('http://10.0.2.2:8000/category',
    //   headers: {"Content-Type": "application/json"}
  }
}
