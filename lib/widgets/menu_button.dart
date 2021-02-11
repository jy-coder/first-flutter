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

Future<void> saveBookmark(
    int articleId, String action, BuildContext context) async {
  String url = "";

  if (action == "Bookmark") url = "$BOOKMARK_URL/?article=$articleId";
  // else if (action == "Not interested") ;

  int responseCode = await APIService().post(url);

  if (responseCode == 200) {
    ArticleProvider aProvider =
        Provider.of<ArticleProvider>(context, listen: false);
    aProvider.filterBookmark(articleId);
  }

  Flushbar(
    message: responseCode == 500
        ? "Already bookmarked"
        : responseCode == 200
            ? "Successfully bookmark"
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

  @override
  Widget build(BuildContext context) {
    ArticleProvider aProvider =
        Provider.of<ArticleProvider>(context, listen: false);

    String tabName = aProvider.tabs;
    if (tabName == "Saved") {
      _options = [..._bookMarkOptions];
    } else {
      _options = [..._articleOptions];
    }

    return IconButton(
      icon: Icon(Icons.linear_scale_outlined, size: 15),
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
                              textColor: Colors.grey[700],
                              onPressed: () async {
                                Navigator.of(context).pop();
                                await saveBookmark(
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
