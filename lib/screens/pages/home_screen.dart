import 'package:flutter/material.dart';
import 'package:newheadline/provider/article.dart';
import 'package:newheadline/screens/pages/auth_screen.dart';
import 'package:newheadline/screens/pages/no_auth_screen.dart';
import 'package:newheadline/utils/auth.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';
  @override
  Widget build(BuildContext context) {
    ArticleProvider aProvider =
        Provider.of<ArticleProvider>(context, listen: false);
    aProvider.setTab("all_articles");
    if (Auth().currentUser != null) {
      return AuthScreen();
    } else {
      return NoAuthScreen();
    }
    // print(Auth().currentUser);

    // return NoAuthScreen();
  }
}
