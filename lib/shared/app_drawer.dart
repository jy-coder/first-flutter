import 'package:flutter/material.dart';
import 'package:newheadline/screens/pages/category_screen.dart';
import 'package:newheadline/screens/pages/home_screen.dart';
import 'package:newheadline/screens/pages/setting_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: <Widget>[
        AppBar(title: Text("User name!"), automaticallyImplyLeading: false),
        Divider(),
        ListTile(
            leading: Icon(Icons.house),
            title: Text("Home"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
            }),
        Divider(),
        ListTile(
            leading: Icon(Icons.text_fields),
            title: Text("All Articles"),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(CategoryScreen.routeName);
            }),
        Divider(),
        ListTile(
            leading: Icon(Icons.history),
            title: Text("Reading History"),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(CategoryScreen.routeName);
            }),
        Divider(),
        ListTile(
            leading: Icon(Icons.settings),
            title: Text("Settings"),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(SettingScreen.routeName);
            }),
        Divider(),
        ListTile(
            leading: Icon(Icons.branding_watermark_rounded),
            title: Text("Advertisments"),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(CategoryScreen.routeName);
            })
      ],
    ));
  }
}
