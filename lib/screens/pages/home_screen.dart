import 'package:flutter/material.dart';
import 'package:newheadline/shared/app_drawer.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Daily Read')),
        drawer: AppDrawer(),
        body: Text("Empty for now"));
  }
}
