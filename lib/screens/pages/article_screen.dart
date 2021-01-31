import 'package:flutter/material.dart';

class ArticleScreen extends StatelessWidget {
  static final routeName = '/article';

  @override
  Widget build(BuildContext context) {
    final int args = ModalRoute.of(context).settings.arguments;
    print(args);
    return Container();
  }
}
