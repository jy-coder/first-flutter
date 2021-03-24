import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:newheadline/provider/article.dart';
import 'package:newheadline/utils/response.dart';
import 'package:newheadline/utils/urls.dart';
import 'package:provider/provider.dart';

class MenuBtn extends StatefulWidget {
  final int articleId;

  MenuBtn(this.articleId);

  @override
  _MenuBtnState createState() => _MenuBtnState();
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
      errorMsg = "Already bookmarked";
      successMsg = "Successfully bookmark";
      aProvider.addBookmarkIds(articleId);
    } else if (action == "Remove bookmark") {
      errorMsg = "Something went wrong";
      successMsg = "Successfully remove bookmark";
      responseCode = await APIService().delete(url);
      aProvider.removeBookmarkIds(articleId);
      //change this to starred instead
      if (responseCode == 200) {
        aProvider.filterBookmark(articleId);
      }
    }
  }

  Flushbar(
    message: responseCode == 500
        ? errorMsg
        : responseCode == 200
            ? successMsg
            : null,
    duration: Duration(seconds: 1),
    isDismissible: false,
  )..show(context);
}

class _MenuBtnState extends State<MenuBtn> {
  List _articleOptions = ['Bookmark', 'Not interested'];
  List _bookMarkOptions = ['Remove bookmark'];
  List _icons = [Icons.bookmark, Icons.cancel];
  List _options = [];
  Color iconColor = Colors.white;
  @override
  Widget build(BuildContext context) {
    ArticleProvider aProvider =
        Provider.of<ArticleProvider>(context, listen: false);

    if (aProvider.tab == "reading_list" && aProvider.subTab == "Saved") {
      _options = [..._bookMarkOptions];
    } else {
      _options = [..._articleOptions];
    }
    print(aProvider.bookmarkIds);
    for (var bookmarkId in aProvider.bookmarkIds) {
      if (bookmarkId == widget.articleId) {
        iconColor = Colors.yellow;
      }
    }

    return IconButton(
      icon: Icon(Icons.linear_scale_outlined, color: iconColor, size: 15),
      onPressed: () {
        showModalBottomSheet(
            context: context,
            builder: (builder) {
              return Container(
                  height: MediaQuery.of(context).size.height / 4,
                  child: ListView.builder(
                      itemCount: _options.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: FlatButton(
                              onPressed: () async {
                                Navigator.of(context).pop();
                                await bookmarkAction(
                                  widget.articleId,
                                  _options[index],
                                  context,
                                );
                              },
                              child: Row(
                                children: [
                                  Icon(_icons[index], size: 15),
                                  Container(margin: EdgeInsets.only(right: 25)),
                                  Text(
                                    _options[index],
                                  ),
                                ],
                              )),
                        );
                      }));
            });
      },
    );
  }
}
