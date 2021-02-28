import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  filled: true,
  contentPadding: EdgeInsets.all(12.0),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black26, width: 2.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black26, width: 2.0),
  ),
);

const searchInputDecoration = InputDecoration(
  filled: true,
  contentPadding: EdgeInsets.all(12.0),
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.black26, width: 2.0),
  ),
);
