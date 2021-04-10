import 'package:flutter/material.dart';
import 'package:newheadline/provider/article.dart';
import 'package:provider/provider.dart';

class DateFilter extends StatefulWidget {
  static final routeName = '/date-filter';
  @override
  _DateFilterState createState() => _DateFilterState();
}

class _DateFilterState extends State<DateFilter> {
  String _selectedValue = "";

  Map<int, String> options = {
    1: 'One Day',
    2: 'Two Days',
    3: "Three Days",
    4: "Four Days",
    5: "Five Days",
    6: "Six Days",
    7: "Seven Days"
  };

  @override
  Widget build(BuildContext context) {
    ArticleProvider aProvider =
        Provider.of<ArticleProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
          itemCount: options.length,
          itemBuilder: (context, index) {
            return RadioListTile(
                title: Text(options[index + 1]),
                value: index.toString(),
                groupValue: _selectedValue,
                onChanged: (String val) async {
                  setState(() {
                    _selectedValue = val;
                  });

                  aProvider.setFilteredDate(
                    options[index + 1],
                  );

                  Navigator.pop(context);
                });
          }),
    );
  }
}
