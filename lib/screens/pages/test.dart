import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  final int id;
  Test({this.id});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(id.toString()),
    );
  }
}
