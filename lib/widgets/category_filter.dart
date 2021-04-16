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
  List<String> options = [];

  @override
  void didChangeDependencies() {
    _assignCategoryNames();
    super.didChangeDependencies();
  }

  void _assignCategoryNames() {
    CategoryProvider cProvider =
        Provider.of<CategoryProvider>(context, listen: false);

    setState(() {
      options = cProvider.categoryNames;
    });
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
                activeColor: Colors.blue,
                title: Text(options[index]),
                value: options[index],
                groupValue: aProvider.filter["category"],
                onChanged: (String val) async {
                  setState(() {
                    _selectedValue = val;
                  });

                  aProvider.setFilter(
                    "category",
                    options[index],
                  );

                  Navigator.pop(context);
                });
          }),
    );
  }
}
