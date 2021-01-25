// import 'dart:js';
import 'package:http/http.dart' as http;
import 'dart:async';

// import 'dart:io';

// import 'package:provider/provider.dart';

class APIService {
  // final user = Provider.of<AppUser>(context);

  Future<dynamic> fetchCategoryArticle() async {
    try {
      final response = await http.get('http://10.0.2.2:8000/category',
          headers: {"Content-Type": "application/json"}
          // headers: {HttpHeaders.authorizationHeader: "Basic your_api_token_here"},
          );

      // var responseJson = json.decode(response.body) as Map<String, dynamic>;
      // final List<CategoryArticle> loadedCategoryArticle = [];
      print(response.body);

      // return CategoryArticle.fromJson(responseJson);
    } catch (error) {
      print(error);
    }
  }

  // sign in with email and password

}
