import 'package:flutter/material.dart';

class CustomTextStyle {
  static TextStyle title1(BuildContext context) {
    return Theme.of(context).textTheme.headline1.copyWith(
        fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold);
  }

  static TextStyle small(BuildContext context) {
    return Theme.of(context).textTheme.headline1.copyWith(
        fontSize: 15.0, color: Colors.black, fontWeight: FontWeight.w400);
  }

  static TextStyle normal(BuildContext context) {
    return Theme.of(context).textTheme.headline1.copyWith(
        fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.w400);
  }
}
