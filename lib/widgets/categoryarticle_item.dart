import 'package:flutter/material.dart';
import 'package:newheadline/screens/pages/article_screen.dart';
import 'package:newheadline/screens/pages/category_article_screen.dart';

class CategoryArticleItem extends StatelessWidget {
  final int articleId;
  final String title;
  final String link;
  final String summary;
  final String source;
  final String imageUrl;

  CategoryArticleItem(this.articleId, this.title, this.link, this.summary,
      this.source, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return GridTile(
        child: GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .pushNamed(ArticleScreen.routeName, arguments: articleId);
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
