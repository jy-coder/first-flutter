import 'package:flutter/material.dart';
import 'package:newheadline/models/models.dart';
import 'package:newheadline/provider/provider.dart';
import 'package:newheadline/widgets/category_item.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatelessWidget {
  static const routeName = '/category';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News"),
      ),
      body: CategoryGrid(),
    );
  }
}

class CategoryGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categoriesData = Provider.of<CategoryProvider>(context);
    final categories = categoriesData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: categories.length,
      itemBuilder: (ctx, i) => CategoryItem(categories[i].categoryId,
          categories[i].categoryName, categories[i].imageUrl),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
    );
  }
}
