import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  //When creating please recheck 'context' if there is an error!

  String _content;
  Function _yesOnPressed;

  ErrorDialog({String content, Function yesOnPressed}) {
    this._content = content;
    this._yesOnPressed = yesOnPressed;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: new Text(this._content),
      actions: <Widget>[
        new FlatButton(
          child: new Text("Ok"),
          onPressed: () {
            this._yesOnPressed();
          },
        ),
      ],
    );
  }
}
