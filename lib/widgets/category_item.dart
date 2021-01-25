import 'package:flutter/material.dart';
import 'package:newheadline/screens/pages/category_article_screen.dart';

class CategoryItem extends StatelessWidget {
  final int categoryId;
  final String categoryName;
  final String imageUrl;

  CategoryItem(this.categoryId, this.categoryName, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return GridTile(
        child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(CategoryArticleScreen.routeName,
                  arguments: categoryId);
            },
            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (ctx) => CategoryArticleScreen(),
            //   ),
            // );
            // },
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            )),
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          title: Text(categoryName, textAlign: TextAlign.center),
        ));
  }
}
