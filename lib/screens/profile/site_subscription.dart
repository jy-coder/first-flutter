import 'package:flutter/material.dart';

class SiteSubscription extends StatefulWidget {
  static const routeName = "/site-settings";
  @override
  _SiteSubscriptionState createState() => _SiteSubscriptionState();
}

class _SiteSubscriptionState extends State<SiteSubscription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
       body:Text("News Site Subscription"),
    );
  }
}