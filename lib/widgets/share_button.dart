import 'package:flutter/material.dart';
import 'package:share/share.dart';

class ShareBtn extends StatefulWidget {
  final String link;

  ShareBtn({this.link});

  @override
  _ShareBtnState createState() => _ShareBtnState();
}

class _ShareBtnState extends State<ShareBtn> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.share, size: 15),
        onPressed: () {
          share(context, this.widget.link);
        });
  }
}

void share(BuildContext context, String link) {
  Share.share(link, subject: link);
}
