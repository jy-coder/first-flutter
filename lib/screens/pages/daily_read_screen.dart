import 'package:flutter/material.dart';
import 'package:newheadline/shared/app_drawer.dart';

class DailyReadScreen extends StatefulWidget {
  @override
  _DailyReadScreenState createState() => _DailyReadScreenState();
}

class _DailyReadScreenState extends State<DailyReadScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Daily Read')),
        drawer: AppDrawer(),
        body: Text("Empty for now"));
  }
}
