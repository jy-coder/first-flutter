import 'package:flutter/material.dart';
import 'package:newheadline/shared/app_drawer.dart';
import 'package:newheadline/shared/checkbox.dart';

class SettingScreen extends StatelessWidget {
  static const routeName = "/settings";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Settings"),
        ),
        body: CheckBox(),
        drawer: AppDrawer());
  }
}
