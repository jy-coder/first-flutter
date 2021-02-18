import 'package:flutter/material.dart';
import 'package:newheadline/provider/article.dart';
import 'package:newheadline/screens/authenticate/authenticate.dart';
import 'package:newheadline/screens/pages/category_screen.dart';
import 'package:newheadline/screens/pages/home_screen.dart';
import 'package:newheadline/screens/pages/reading_list.dart';
import 'package:newheadline/screens/pages/subscription_setting_screen.dart';
import 'package:newheadline/utils/auth.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(child:
        Consumer2<Auth, ArticleProvider>(builder: (context, auth, ap, _) {
      // print(auth.uid);
      return Column(
          children: auth.currentUser != null
              ? authDrawer(context, auth, ap)
              : noAuthDrawer(context, ap));
    }));
  }

  List<Widget> noAuthDrawer(context, ap) {
    return ([
      AppBar(title: Text("Welcome")),
      ListTile(
          leading: Icon(Icons.text_fields),
          title: Text("All Articles"),
          onTap: () {
            ap.setTab("all_articles");
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

  List<Widget> authDrawer(context, auth, ap) {
    return ([
      AppBar(title: Text("User name!"), automaticallyImplyLeading: false),
      Divider(),
      ListTile(
          leading: Icon(Icons.house),
          title: Text("Home"),
          onTap: () {
            ap.setTab("daily_read");
            Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
          }),
      Divider(),
      ListTile(
          leading: Icon(Icons.text_fields),
          title: Text("All Articles"),
          onTap: () {
            ap.setTab("all_articles");
            Navigator.of(context)
                .pushReplacementNamed(CategoryScreen.routeName);
          }),
      Divider(),
      ListTile(
          leading: Icon(Icons.history),
          title: Text("Reading List"),
          onTap: () {
            ap.setTab("reading_list");
            ap.setSubTab("Saved");
            Navigator.of(context)
                .pushReplacementNamed(ReadListScreen.routeName);
          }),
      Divider(),
      ListTile(
          leading: Icon(Icons.settings),
          title: Text("Settings"),
          onTap: () {
            Navigator.of(context).pushReplacementNamed(
                SubscriptionScreen.routeName,
                arguments: "settings");
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
