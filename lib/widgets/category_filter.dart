import 'package:flutter/material.dart';
import 'package:newheadline/provider/article.dart';
import 'package:newheadline/provider/category.dart';
import 'package:provider/provider.dart';
import 'package:newheadline/utils/common.dart';

class CategoryFilter extends StatefulWidget {
  static final routeName = '/Category-filter';
  @override
  _CategoryFilterState createState() => _CategoryFilterState();
}

class _CategoryFilterState extends State<CategoryFilter> {
  List<String> options = [];
  List<String> isChecked = [];

  @override
  void didChangeDependencies() {
    _assignCategoryNames();
    super.didChangeDependencies();
  }

  void _assignCategoryNames() {
    CategoryProvider cProvider =
        Provider.of<CategoryProvider>(context, listen: false);
    ArticleProvider aProvider =
        Provider.of<ArticleProvider>(context, listen: false);
    String categoryFilter = aProvider.filter['category'];
    setState(() {
      options = cProvider.categoryNames;
      if (categoryFilter != "") {
        isChecked = stringToList(categoryFilter);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ArticleProvider aProvider =
        Provider.of<ArticleProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: options.length,
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    activeColor: Colors.blue,
                    title: Text(options[index]),
                    value: isChecked.contains(options[index]),
                    onChanged: (bool value) {
                      if (value) {
                        setState(() {
                          isChecked.add(options[index]);
                        });
                      } else {
                        setState(() {
                          isChecked.remove(options[index]);
                        });
                      }
                    },
                  );
                }),
          ),
          RaisedButton(
            child: Text("Filter"),
            onPressed: () {
              aProvider.setFilter(
                "category",
                listToString(isChecked),
              );
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
