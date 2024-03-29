import 'package:flutter/material.dart';
import 'package:newheadline/screens/authenticate/auth_screen.dart';
import 'package:newheadline/screens/authenticate/no_auth_screen.dart';
import 'package:newheadline/provider/auth.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';
  @override
  Widget build(BuildContext context) {
    if (Auth().currentUser != null) {
      return AuthScreen();
    } else {
      return NoAuthScreen();
    }
  }
}
