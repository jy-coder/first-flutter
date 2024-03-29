import 'package:flutter/material.dart';
import 'package:newheadline/provider/theme.dart';
import 'package:newheadline/shared/textstyle.dart';
import 'package:provider/provider.dart';

class ErrorDialog extends StatelessWidget {
  String _content;

  ErrorDialog({String content}) {
    this._content = content;
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider tProvider =
        Provider.of<ThemeProvider>(context, listen: false);
    return AlertDialog(
      title: Text(''),
      content: Text(
        this._content,
      ),
      actions: <Widget>[
        new FlatButton(
          textColor: tProvider.theme == "dark" ? Colors.white : Colors.black,
          child: new Text(
            "Ok",
          ),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
      ],
    );
  }
}
