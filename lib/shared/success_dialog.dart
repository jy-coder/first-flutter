import 'package:flutter/material.dart';
import 'package:newheadline/provider/theme.dart';
import 'package:newheadline/screens/authenticate/forget_screen.dart';
import 'package:newheadline/screens/authenticate/login_screen.dart';
import 'package:provider/provider.dart';

class SuccessDialog extends StatelessWidget {
  String _content;

  SuccessDialog({String content}) {
    this._content = content;
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider tProvider =
        Provider.of<ThemeProvider>(context, listen: false);
    return AlertDialog(
      content: Text(
        this._content,
      ),
      actions: <Widget>[
        new FlatButton(
          textColor: tProvider.theme == "dark" ? Colors.white : Colors.black,
          child: new Text("Ok"),
          onPressed: () {
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
        ),
      ],
    );
  }
}
