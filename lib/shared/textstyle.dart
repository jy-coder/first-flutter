import 'package:flutter/material.dart';

class CustomTextStyle {
  static TextStyle title1(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .headline1
        .copyWith(fontSize: 20.0, fontWeight: FontWeight.bold);
  }

  static TextStyle small(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .headline1
        .copyWith(fontSize: 15.0, fontWeight: FontWeight.w400);
  }

  static TextStyle normal(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .headline1
        .copyWith(fontSize: 16.0, fontWeight: FontWeight.w400);
  }

  static TextStyle summary(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .headline1
        .copyWith(fontSize: 15.0, fontWeight: FontWeight.w400);
  }

  static TextStyle smallbold(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .headline1
        .copyWith(fontSize: 18.0, fontWeight: FontWeight.w800);
  }

  static TextStyle whitesmall(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .headline1
        .copyWith(fontSize: 18.0, fontWeight: FontWeight.w500);
  }
}
