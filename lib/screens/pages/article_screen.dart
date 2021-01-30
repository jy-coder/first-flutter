import 'package:flutter/material.dart';
import 'package:newheadline/models/models.dart';
import 'package:newheadline/provider/article.dart';
import 'package:provider/provider.dart';

class ArticleScreen extends StatelessWidget {
  static final routeName = "/category_article";

  @override
  Widget build(BuildContext context) {
    return Consumer<ArticleProvider>(builder: (context, article, child) {
      return GridView.count(crossAxisCount: 1, children: [
        for (Article a in article.filteredItems) Center(child: Text(a.category))
      ]);
    });
  }
}

//   @override
//   Widget build(BuildContext context) {
//     return GridTile(
//         child: GestureDetector(
//             onTap: () {
//               Navigator.of(context)
//                   .pushNamed(ArticleScreen.routeName, arguments: id);
//             },
//             child: Image.network(
//               imageUrl,
//               fit: BoxFit.cover,
//             )),
//         footer: GridTileBar(
//           backgroundColor: Colors.black54,
//           title: Text(title, textAlign: TextAlign.center),
//         ));
//   }
// }
