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
  List<String> options = [
    '1 Day',
    '2 Days',
    '3 Days',
    '4 Days',
    '5 Days',
    '6 Days',
    '7 Days'
  ];

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
                activeColor: Colors.blue,
                title: Text(options[index]),
                value: options[index],
                groupValue: aProvider.filter['date'],
                onChanged: (String val) async {
                  setState(() {
                    _selectedValue = val;
                  });

                  aProvider.setFilter(
                    "date",
                    options[index],
                  );

                  Navigator.pop(context);
                });
          }),
    );
  }
}
