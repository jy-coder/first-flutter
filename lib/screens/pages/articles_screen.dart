import 'package:flutter/material.dart';
import 'package:newheadline/models/models.dart';
import 'package:newheadline/provider/article.dart';
import 'package:newheadline/screens/pages/article_screen.dart';
import 'package:provider/provider.dart';

class ArticlesScreen extends StatelessWidget {
  static final routeName = "/articles";

  @override
  Widget build(BuildContext context) {
    return Consumer<ArticleProvider>(builder: (context, article, child) {
      return GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: article.filteredItems.length,
        itemBuilder: (ctx, i) => OneArticleGrid(
          article.filteredItems[i].id,
          article.filteredItems[i].title,
          article.filteredItems[i].imageUrl,
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 2,
          crossAxisSpacing: article.filteredItems.length > 0 ? 10 : 0,
          mainAxisSpacing: article.filteredItems.length > 0 ? 10 : 0,
        ),
      );
    });
  }
}

class OneArticleGrid extends StatelessWidget {
  final int id;
  final String title;
  final String imageUrl;

  OneArticleGrid(this.id, this.title, this.imageUrl);
  @override
  Widget build(BuildContext context) {
    return GridTile(
        child: GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .pushNamed(ArticleScreen.routeName, arguments: id);
            },
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            )),
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          title: Text(title, textAlign: TextAlign.center),
        ));
  }
}
