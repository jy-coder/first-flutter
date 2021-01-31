import 'package:flutter/material.dart';

class CustomTextStyle {
  static TextStyle title1(BuildContext context) {
    return Theme.of(context).textTheme.headline1.copyWith(
        fontSize: 25.0, color: Colors.black, fontWeight: FontWeight.bold);
  }

  static TextStyle small(BuildContext context) {
    return Theme.of(context).textTheme.headline1.copyWith(
        fontSize: 18.0, color: Colors.black, fontWeight: FontWeight.w400);
  }
}
