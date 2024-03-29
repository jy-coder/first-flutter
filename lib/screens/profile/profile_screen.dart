import 'package:flutter/material.dart';
import 'package:newheadline/provider/auth.dart';
import 'package:newheadline/screens/authenticate/home_screen.dart';
import 'package:newheadline/screens/authenticate/reset_screen.dart';
import 'package:newheadline/screens/profile/subscription_setting_screen.dart';
import 'package:newheadline/screens/reading_list/bookmark_screen.dart';
import 'package:newheadline/screens/reading_list/history_screen.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<String> profileList = [
    "Category Subscription",
    "Bookmark",
    "History",
    "Reset Password",
    "Logout"
  ];
  List<String> navigator = [
    SubscriptionScreen.routeName,
    BookmarkScreen.routeName,
    HistoryScreen.routeName,
    ResetPasswordScreen.routeName,
    HomeScreen.routeName,
  ];

  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of<Auth>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Profile"),
      ),
      body: ListView.builder(
        itemCount: profileList.length,
        itemBuilder: (context, index) {
          return Column(
            children: <Widget>[
              GestureDetector(
                onTap: () async {
                  if (profileList[index] == "Logout") {
                    await auth.signOut();
                    Navigator.of(context).pushReplacementNamed(
                      navigator[index],
                    );
                  } else {
                    Navigator.of(context).pushNamed(
                      navigator[index],
                    );
                  }
                },
                child: ListTile(
                  title: Text(
                    profileList[index],
                  ),
                ),
              ),
              Divider(),
            ],
          );
        },
      ),
    );
  }
}
