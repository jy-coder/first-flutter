import 'package:flutter/material.dart';
import 'package:newheadline/models/models.dart';
import 'package:newheadline/screens/pages/article_screen.dart';
import 'package:provider/provider.dart';

class CategoryItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final category = Provider.of<Category>(context);

    return GridTile(
        child: GestureDetector(
            onTap: () {
              // Navigator.of(context).pushNamed(CategoryArticleScreen.routeName,
              //     arguments: category.id);
            },
            child: Image.network(
              category.imageUrl,
              fit: BoxFit.cover,
            )),
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          title: Text(category.categoryName, textAlign: TextAlign.center),
        ));
  }
}
