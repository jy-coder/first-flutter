import 'package:flutter/material.dart';
import 'package:newheadline/provider/article.dart';
import 'package:newheadline/widgets/article_card.dart';
import 'package:provider/provider.dart';

class ArticlesScreen extends StatelessWidget {
  static final routeName = "/articles";

  @override
  Widget build(BuildContext context) {
    return Consumer<ArticleProvider>(builder: (context, article, child) {
      return ListView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: article.filteredItems.length,
        itemBuilder: (ctx, i) => ArticleCard(
          article.filteredItems[i].id,
          article.filteredItems[i].title,
          article.filteredItems[i].imageUrl,
          article.filteredItems[i].summary,
          article.filteredItems[i].link,
          article.filteredItems[i].description,
          article.filteredItems[i].pubDate,
          article.filteredItems[i].source,
          article.filteredItems[i].category,
        ),
      );
    });
  }
}
