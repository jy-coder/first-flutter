import 'package:flutter/material.dart';

class CustomTextStyle {
  static TextStyle title1(BuildContext context, double readingSize) {
    return Theme.of(context)
        .textTheme
        .headline1
        .copyWith(fontSize: readingSize + 4, fontWeight: FontWeight.bold);
  }

  static TextStyle small(BuildContext context, double readingSize) {
    return Theme.of(context)
        .textTheme
        .headline1
        .copyWith(fontSize: readingSize - 5, fontWeight: FontWeight.w400);
  }

  static TextStyle normal(BuildContext context, double readingSize) {
    return Theme.of(context)
        .textTheme
        .headline1
        .copyWith(fontSize: readingSize, fontWeight: FontWeight.w400);
  }

  static TextStyle normalBold(BuildContext context, double readingSize) {
    return Theme.of(context)
        .textTheme
        .headline1
        .copyWith(fontSize: readingSize, fontWeight: FontWeight.w800);
  }

  static TextStyle summary(BuildContext context, double readingSize) {
    return Theme.of(context)
        .textTheme
        .headline1
        .copyWith(fontSize: readingSize - 1, fontWeight: FontWeight.w400);
  }

  static TextStyle smallbold(BuildContext context, double readingSize) {
    return Theme.of(context)
        .textTheme
        .headline1
        .copyWith(fontSize: readingSize + 2, fontWeight: FontWeight.w800);
  }

  static TextStyle whitesmall(BuildContext context, double readingSize) {
    return Theme.of(context)
        .textTheme
        .headline1
        .copyWith(fontSize: readingSize + 2, fontWeight: FontWeight.w500);
  }

  static TextStyle italic(BuildContext context, double readingSize) {
    return Theme.of(context).textTheme.headline1.copyWith(
          fontStyle: FontStyle.italic,
          fontSize: readingSize - 5,
          fontWeight: FontWeight.w400,
        );
  }

  static TextStyle cardSummary(BuildContext context, double readingSize) {
    double _size = 0;

    if (readingSize < 16) {
      _size = -1;
    } else if (readingSize > 16 && readingSize < 20) {
      _size = 0.5;
    } else if (readingSize >= 20 && readingSize < 25) {
      _size = 1;
    } else if (readingSize >= 25 && readingSize <= 30) {
      _size = 1.5;
    }
    // if readingSize = 16
    return Theme.of(context)
        .textTheme
        .headline1
        .copyWith(fontSize: readingSize + _size, fontWeight: FontWeight.w400);
  }

  static TextStyle cardTitle(BuildContext context, double readingSize) {
    double _size = 0;

    if (readingSize < 16) {
      _size = -0.5;
    } else if (readingSize > 16 && readingSize < 20) {
      _size = 1;
    } else if (readingSize >= 20 && readingSize < 25) {
      _size = 2;
    } else if (readingSize >= 25 && readingSize <= 30) {
      _size = 3;
    }
    // if readingSize = 16
    return Theme.of(context)
        .textTheme
        .headline1
        .copyWith(fontSize: readingSize + _size, fontWeight: FontWeight.w800);
  }
}
