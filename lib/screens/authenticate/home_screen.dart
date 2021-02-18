import 'package:flutter/material.dart';
import 'package:newheadline/provider/article.dart';
import 'package:newheadline/screens/authenticate/auth_screen.dart';
import 'package:newheadline/screens/authenticate/no_auth_screen.dart';
import 'package:newheadline/provider/auth.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';
  @override
  Widget build(BuildContext context) {
    ArticleProvider aProvider =
        Provider.of<ArticleProvider>(context, listen: true);
    aProvider.setTab("all_articles");
    if (Auth().currentUser != null) {
      return AuthScreen();
    } else {
      return NoAuthScreen();
    }
  }
}
