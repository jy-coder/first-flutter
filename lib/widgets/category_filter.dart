import 'package:flutter/material.dart';
import 'package:newheadline/provider/article.dart';
import 'package:newheadline/provider/category.dart';
import 'package:provider/provider.dart';

class CategoryFilter extends StatefulWidget {
  static final routeName = '/Category-filter';
  @override
  _CategoryFilterState createState() => _CategoryFilterState();
}

class _CategoryFilterState extends State<CategoryFilter> {
  String _selectedValue = "";
  Map<int, String> options = {};
  List<String> categoryNames;

  @override
  void didChangeDependencies() {
    _assignCategoryNames();
    super.didChangeDependencies();
  }

  void _assignCategoryNames() {
    CategoryProvider cProvider =
        Provider.of<CategoryProvider>(context, listen: false);

    categoryNames = cProvider.categoryNames;
    for (int i = 0; i < categoryNames.length; i++) {
      options[i + 1] = categoryNames[i];
    }
  }

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

                  aProvider.setFilter(
                    "category",
                    options[index + 1],
                  );

                  Navigator.pop(context);
                });
          }),
    );
  }
}
