import 'package:flutter/material.dart';
import 'package:newheadline/screens/authenticate/auth_screen.dart';
import 'package:newheadline/screens/authenticate/no_auth_screen.dart';
import 'package:newheadline/provider/auth.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    fetchUser();
    super.initState();
  }

  void fetchUser() async {
    return await Auth().currentUser;
  }

  @override
  Widget build(BuildContext context) {
    Auth auProvider = Provider.of<Auth>(context, listen: true);

    if (auProvider.token != null) {
      return AuthScreen();
    } else {
      return NoAuthScreen();
    }
  }
}
