import 'package:flutter/material.dart';
import 'package:newheadline/screens/authenticate/register_screen.dart';
import 'package:newheadline/screens/authenticate/login_screen.dart';

class Authenticate extends StatefulWidget {
  static final routeName = '/authenticate';
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return LoginScreen(toggleView: toggleView);
    } else {
      return Register(toggleView: toggleView);
    }
  }
}
