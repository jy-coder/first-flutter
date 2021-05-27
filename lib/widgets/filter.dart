import 'package:flutter/material.dart';
import 'package:newheadline/provider/article.dart';
import 'package:newheadline/provider/theme.dart';
import 'package:newheadline/widgets/category_filter.dart';
import 'package:newheadline/widgets/date_filter.dart';
import 'package:newheadline/widgets/site_filter.dart';
import 'package:provider/provider.dart';

class Filter extends StatefulWidget {
  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  List<String> displayText = ["Day", "Source", "Category"];
  List<String> routeName = [
    DateFilter.routeName,
    SiteFilter.routeName,
    CategoryFilter.routeName
  ];

  Widget _getFilter(index) {
    ArticleProvider aProvider =
        Provider.of<ArticleProvider>(context, listen: false);
    if (displayText[index] == "Day") {
      if (aProvider.filter['date'] != "") return Text(aProvider.filter['date']);
    } else if (displayText[index] == "Source") {
      if (aProvider.filter['newssite'] != "")
        return Text(aProvider.filter['newssite']);
    } else if (displayText[index] == "Category") {
      if (aProvider.filter['category'] != "")
        return Text(aProvider.filter['category']);
    }
    return Text("Set Filter");
  }

  @override
  Widget build(BuildContext context) {
    ArticleProvider aProvider =
        Provider.of<ArticleProvider>(context, listen: false);
    ThemeProvider tProvider = Provider.of<ThemeProvider>(context, listen: true);

    return IconButton(
      icon: Icon(Icons.more_vert),
      onPressed: () {
        aProvider.setFilterOpen(true);
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                ArticleProvider aProvider =
                    Provider.of<ArticleProvider>(context, listen: true);
                return Container(
                  height: 300,
                  child: Column(
                    children: [
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          RaisedButton(
                            color: tProvider.theme == "light"
                                ? Colors.white
                                : Colors.grey[900],
                            onPressed: () {
                              aProvider.resetFilter();
                            },
                            child: Text(
                              "Clear Filter",
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
                                      subtitle: _getFilter(index),
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
            }).whenComplete(() {
          aProvider.setFilterOpen(false);
        });
      },
    );
  }
}
