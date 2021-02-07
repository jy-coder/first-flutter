import 'package:flutter/material.dart';
import 'package:newheadline/screens/pages/category_screen.dart';
import 'package:newheadline/screens/pages/daily_read_screen.dart';
import 'package:newheadline/utils/auth.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';
  @override
  Widget build(BuildContext context) {
    if (Auth().currentUser != null) {
      return DailyReadScreen();
    } else {
      return CategoryScreen();
    }
  }
}
