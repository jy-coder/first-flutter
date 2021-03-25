import 'package:flutter/material.dart';
import 'package:newheadline/screens/authenticate/home_screen.dart';

class RedirectDialog extends StatelessWidget {
  String _content;

  RedirectDialog({String content}) {
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
          textColor: Colors.blue[300],
          child: new Text("Ok"),
          onPressed: () {
            Navigator.of(context)
                .pushReplacementNamed(HomeScreen.routeName)
                .then((result) {
              Navigator.of(context).pop();
            });
          },
        ),
      ],
    );
  }
}
