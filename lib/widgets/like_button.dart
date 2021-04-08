import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:newheadline/provider/article.dart';
import 'package:newheadline/utils/response.dart';
import 'package:newheadline/utils/urls.dart';
import 'package:provider/provider.dart';
import 'package:newheadline/provider/theme.dart';

class LikeBtn extends StatefulWidget {
  final int articleId;
  LikeBtn(this.articleId);

  @override
  _LikeBtnState createState() => _LikeBtnState();
}

Future<void> likeAction(
    int articleId, String action, BuildContext context) async {
  String url = "";
  int responseCode = 0;
  String successMsg = "";
  String errorMsg = "";
  ArticleProvider aProvider =
      Provider.of<ArticleProvider>(context, listen: false);
  if (action.toLowerCase().contains("Like".toLowerCase())) {
    url = "$LIKE_URL/?article=$articleId";

    if (action == "Like") {
      responseCode = await APIService().post(url);
      errorMsg = "Something went wrong";
      successMsg = "Sucessfully Liked this article";
      aProvider.addLikeIds(articleId);
    } else if (action == "Unlike") {
      responseCode = await APIService().delete(url);
      errorMsg = "Something went wrong";
      successMsg = "Sucessfully unliked this article";
      aProvider.removeLikeIds(articleId);
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

class _LikeBtnState extends State<LikeBtn> {
  bool _isPostLiked = false;

  @override
  Widget build(BuildContext context) {
    Color darkIconColor = Colors.white;
    Color lightIconColor = Colors.black;
    ArticleProvider aProvider =
        Provider.of<ArticleProvider>(context, listen: false);
    ThemeProvider tProvider =
        Provider.of<ThemeProvider>(context, listen: false);

    for (int likeId in aProvider.likeIds) {
      if (likeId == widget.articleId) {
        darkIconColor = lightIconColor = Colors.red;
        _isPostLiked = true;
      }
    }

    return IconButton(
        icon: Icon(Icons.favorite,
            color: tProvider.theme == "dark" ? darkIconColor : lightIconColor,
            size: 15),
        onPressed: () async {
          if (_isPostLiked == false) {
            await likeAction(widget.articleId, "Like", context);
            setState(() => darkIconColor = lightIconColor = Colors.red);
          } else {
            await likeAction(widget.articleId, "Unlike", context);
            setState(() => tProvider.theme == "dark"
                ? darkIconColor = Colors.white
                : lightIconColor = Colors.black);
          }
          _isPostLiked = !_isPostLiked;
        });
  }
}
