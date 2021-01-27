import 'package:flutter/material.dart';
import 'package:newheadline/shared/app_drawer.dart';
import 'package:newheadline/utils/auth.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    Auth aProvider = Provider.of<Auth>(context);
    print(aProvider.currentUser);
    return Scaffold(
        appBar: AppBar(title: Text('Daily Read')),
        drawer: AppDrawer(),
        body: Text("Empty for now"));
  }
}
