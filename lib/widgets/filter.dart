import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:newheadline/provider/article.dart';
import 'package:newheadline/widgets/date_filter.dart';
import 'package:provider/provider.dart';

class Filter extends StatefulWidget {
  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  List<String> displayText = ["Date", "New Site"];
  List<String> routeName = [DateFilter.routeName, DateFilter.routeName];

  @override
  Widget build(BuildContext context) {
    // print(aProvider.dateFilter);
    return IconButton(
      icon: Icon(Icons.more_vert),
      onPressed: () {
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                ArticleProvider aProvider =
                    Provider.of<ArticleProvider>(context, listen: true);
                print(aProvider.dateFilter);
                return Container(
                  height: 250,
                  child: Column(
                    children: [
                      Expanded(
                          child: Column(
                        children: [
                          TextButton(
                            onPressed: () {
                              aProvider.setFilteredDate("");
                              aProvider.clearHistory();
                            },
                            child: Text(
                              "Clear",
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                                itemCount: displayText.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                      title: Text(
                                        displayText[index],
                                      ),
                                      subtitle: aProvider.dateFilter != ""
                                          ? Text(aProvider.dateFilter)
                                          : Text("Not Setted"),
                                      trailing: Icon(
                                        Icons.arrow_right,
                                      ),
                                      onTap: () {
                                        Navigator.of(context).pushNamed(
                                          routeName[index],
                                        );
                                      });
                                }),
                          )
                        ],
                      )),
                    ],
                  ),
                );
              });
            });
      },
    );
  }
}
