import 'package:flutter/material.dart';
import 'package:newheadline/models/user.dart';
import 'package:newheadline/screens/authenticate/authenticate.dart';
import 'package:newheadline/screens/pages/category_screen.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final user = Provider.of<AppUser>(context);
    return CategoryScreen();
    // return either the Home or Authenticate widget
    // if (user == null) {
    //   return Authenticate();
    // } else {
    //   return Home();
    // }
  }
}
