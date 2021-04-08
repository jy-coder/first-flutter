import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:newheadline/provider/article.dart';
import 'package:newheadline/utils/response.dart';
import 'package:newheadline/utils/urls.dart';
import 'package:provider/provider.dart';
import 'package:newheadline/provider/theme.dart';

class BookmarkBtn extends StatefulWidget {
  final int articleId;
  BookmarkBtn(this.articleId);

  @override
  _BookmarkBtnState createState() => _BookmarkBtnState();
}

Future<void> bookmarkAction(
    int articleId, String action, BuildContext context) async {
  String url = "";
  int responseCode = 0;
  String successMsg = "";
  String errorMsg = "";
  ArticleProvider aProvider =
      Provider.of<ArticleProvider>(context, listen: false);
  if (action.toLowerCase().contains("Bookmark".toLowerCase())) {
    url = "$BOOKMARK_URL/?article=$articleId";

    if (action == "Bookmark") {
      responseCode = await APIService().post(url);
      errorMsg = "Something went wrong";
      successMsg = "Sucessfully Bookmarked this article";
      aProvider.addBookmarkIds(articleId);
    } else if (action == "Unbookmark") {
      responseCode = await APIService().delete(url);
      errorMsg = "Something went wrong";
      successMsg = "Sucessfully unbookmarked this article";
      aProvider.removeBookmarkIds(articleId);
    }
  }

  // Flushbar(
  //   message: responseCode == 500
  //       ? errorMsg
  //       : responseCode == 200
  //           ? successMsg
  //           : null,
  //   duration: Duration(seconds: 1),
  //   isDismissible: false,
  // )..show(context);
}

class _BookmarkBtnState extends State<BookmarkBtn> {
  bool _isPostBookmarked = false;

  @override
  Widget build(BuildContext context) {
    Color darkIconColor = Colors.white;
    Color lightIconColor = Colors.black;
    ArticleProvider aProvider =
        Provider.of<ArticleProvider>(context, listen: false);
    ThemeProvider tProvider =
        Provider.of<ThemeProvider>(context, listen: false);

    for (int bookmarkId in aProvider.bookmarkIds) {
      if (bookmarkId == widget.articleId) {
        darkIconColor = lightIconColor = Colors.yellow[700];
        _isPostBookmarked = true;
      }
    }

    return IconButton(
        icon: Icon(Icons.bookmark,
            color: tProvider.theme == "dark" ? darkIconColor : lightIconColor,
            size: 15),
        onPressed: () async {
          if (_isPostBookmarked == false) {
            await bookmarkAction(widget.articleId, "Bookmark", context);
            setState(() => darkIconColor = lightIconColor = Colors.yellow[700]);
          } else {
            await bookmarkAction(widget.articleId, "Unbookmark", context);
            setState(() => tProvider.theme == "dark"
                ? darkIconColor = Colors.white
                : lightIconColor = Colors.black);
          }
          _isPostBookmarked = !_isPostBookmarked;
        });
  }
}
