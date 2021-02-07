import 'package:flutter/material.dart';
import 'package:newheadline/screens/authenticate/authenticate.dart';
import 'package:newheadline/screens/pages/category_screen.dart';
import 'package:newheadline/screens/pages/home_screen.dart';
import 'package:newheadline/screens/pages/setting_screen.dart';
import 'package:newheadline/utils/auth.dart';
import 'package:newheadline/screens/authenticate/login_screen.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(child: Consumer<Auth>(builder: (context, auth, _) {
      // print(auth.uid);
      return Column(
          children: auth.currentUser != null
              ? authDrawer(context, auth)
              : noAuthDrawer(context));
    }));
  }

  List<Widget> noAuthDrawer(context) {
    return ([
      AppBar(title: Text("Welcome")),
      ListTile(
          leading: Icon(Icons.text_fields),
          title: Text("All Articles"),
          onTap: () {
            Navigator.of(context)
                .pushReplacementNamed(CategoryScreen.routeName);
          }),
      Divider(),
      ListTile(
          leading: Icon(Icons.login),
          title: Text("Login"),
          onTap: () {
            Navigator.of(context).pushReplacementNamed(Authenticate.routeName);
          })
    ]);
  }

  List<Widget> authDrawer(context, auth) {
    return ([
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
            Navigator.of(context).pushReplacementNamed(SettingScreen.routeName);
          }),
      Divider(),
      ListTile(
          leading: Icon(Icons.branding_watermark_rounded),
          title: Text("Advertisments"),
          onTap: () {
            Navigator.of(context)
                .pushReplacementNamed(CategoryScreen.routeName);
          }),
      Divider(),
      ListTile(
          leading: Icon(Icons.logout),
          title: Text("Logout"),
          onTap: () async {
            await auth.signOut();
            Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
          })
    ]);
  }
}
