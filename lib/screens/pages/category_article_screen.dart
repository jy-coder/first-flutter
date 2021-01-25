import 'package:flutter/material.dart';
import 'package:newheadline/models/models.dart';
import 'package:newheadline/provider/provider.dart';
import 'package:newheadline/widgets/categoryarticle_item.dart';
import 'package:provider/provider.dart';

class CategoryArticleScreen extends StatelessWidget {
  static const routeName = "/category-article";

  @override
  Widget build(BuildContext context) {
    final categoryId = ModalRoute.of(context).settings.arguments as int;
    final loadedCategory = Provider.of<CategoryProvider>(context, listen: false)
        .findById(categoryId);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedCategory.categoryName),
      ),
      body: CategoryArticleGrid(),
    );
  }
}

class CategoryArticleGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categoryArticlesData = Provider.of<CategoryArticleProvider>(context);
    final categoryArticles = categoryArticlesData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: categoryArticles.length,
      itemBuilder: (ctx, i) => CategoryArticleItem(
        categoryArticles[i].articleId,
        categoryArticles[i].title,
        categoryArticles[i].link,
        categoryArticles[i].summary,
        categoryArticles[i].source,
        categoryArticles[i].imageUrl,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
    );
  }
}
