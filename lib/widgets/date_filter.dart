import 'package:flutter/material.dart';
import 'package:newheadline/provider/article.dart';
import 'package:provider/provider.dart';

class Filter extends StatefulWidget {
  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  List<String> displayedDate = [
    "from 7 days ago",
    "from 14 days ago",
  ];

  String _selectedValue = "";

  @override
  Widget build(BuildContext context) {
    ArticleProvider aProvider =
        Provider.of<ArticleProvider>(context, listen: false);
    return IconButton(
      icon: Icon(Icons.filter_alt_sharp),
      onPressed: () {
        showModalBottomSheet(
            context: context,
            builder: (builder) {
              return StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                return Container(
                  height: 400,
                  child: Column(
                    children: [
                      Expanded(
                          flex: 2,
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    _selectedValue = "";
                                  });

                                  aProvider.setFilteredDate("");
                                  aProvider.clearHistory();
                                },
                                child: Text("Clear"),
                              ),
                            ],
                          )),
                      Expanded(
                        flex: 8,
                        child: ListView.builder(
                            itemCount: displayedDate.length,
                            itemBuilder: (context, index) {
                              return RadioListTile(
                                  title: Text(displayedDate[index]),
                                  value: displayedDate[index],
                                  groupValue: _selectedValue,
                                  onChanged: (String val) {
                                    setState(() {
                                      _selectedValue = val;
                                    });

                                    aProvider.setFilteredDate(val);
                                    aProvider.clearHistory();
                                  });
                            }),
                      ),
                    ],
                  ),
                );
              });
            });
      },
    );
  }
}
