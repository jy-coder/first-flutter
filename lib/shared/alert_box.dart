import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  String _content;

  ErrorDialog({String content}) {
    this._content = content;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(''),
      content: Text(
        this._content,
      ),
      actions: <Widget>[
        new FlatButton(
          child: new Text("Ok"),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
      ],
    );
  }
}
