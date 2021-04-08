import 'package:flutter/material.dart';
import 'package:newheadline/provider/article.dart';
import 'package:newheadline/shared/constants.dart';
import 'package:provider/provider.dart';

class Filter extends StatefulWidget {
  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  String _selectedValue = "";

  @override
  Widget build(BuildContext context) {
    ArticleProvider aProvider =
        Provider.of<ArticleProvider>(context, listen: false);
    return IconButton(
      icon: Icon(Icons.more_vert),
      onPressed: () {
        showModalBottomSheet(
            context: context,
            builder: (builder) {
              return StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                return Container(
                  // height: 400,
                  child: Column(
                    children: [],
                  ),
                );
              });
            });
      },
    );
  }
}
