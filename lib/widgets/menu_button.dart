import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:newheadline/utils/response.dart';
import 'package:newheadline/utils/urls.dart';

class MenuBtn extends StatefulWidget {
  final int articleId;

  MenuBtn(this.articleId);

  @override
  _MenuBtnState createState() => _MenuBtnState();
}

Future<void> saveBookmark(
    int articleId, String action, BuildContext context) async {
  String url = "";

  if (action == "Bookmark")
    url = "$BOOKMARK_URL/?article=$articleId";
  else if (action == "Not interested") ;

  int responseCode = await APIService().post(url);

  Flushbar(
    message: responseCode == 500
        ? "Error updating"
        : responseCode == 200
            ? "Successfully update"
            : null,
    duration: Duration(seconds: 1),
    isDismissible: false,
  )..show(context);
}

class _MenuBtnState extends State<MenuBtn> {
  List _options = ['Bookmark', 'Not interested'];
  List _icons = [Icons.bookmark, Icons.cancel];

  @override
  Widget build(BuildContext context) {
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
                                    widget.articleId, _options[index], context);
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
