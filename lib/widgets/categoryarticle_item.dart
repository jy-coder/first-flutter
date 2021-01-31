import 'package:flutter/material.dart';
import 'package:newheadline/screens/pages/articles_screen.dart';

class CategoryArticleItem extends StatelessWidget {
  final int id;
  final String title;
  final String link;
  final String summary;
  final String source;
  final String imageUrl;

  CategoryArticleItem(
      this.id, this.title, this.link, this.summary, this.source, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return GridTile(
        child: GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .pushNamed(ArticlesScreen.routeName, arguments: id);
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
