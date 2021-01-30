import 'package:flutter/material.dart';
import 'package:newheadline/screens/pages/home_screen.dart';

class Tabs extends StatefulWidget {
  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        child: Scaffold(
      appBar: AppBar(
          title: Text('Categories'),
          bottom: TabBar(tabs: <Widget>[
            Tab(icon: null, text: "All"),
            Tab(icon: null, text: "More cateogries"),
          ])),
      body: TabBarView(
          children: <Widget>[HomeScreen(), HomeScreen(), HomeScreen()]),
    ));
  }
}
