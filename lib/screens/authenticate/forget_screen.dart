import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newheadline/screens/authenticate/home_screen.dart';
import 'package:newheadline/screens/authenticate/login_screen.dart';
import 'package:newheadline/shared/error_dialog.dart';
import 'package:newheadline/provider/auth.dart';
import 'package:newheadline/shared/constants.dart';
import 'package:newheadline/shared/load_dialog.dart';
import 'package:newheadline/shared/success_dialog.dart';

class ForgetScreen extends StatefulWidget {
  static final routeName = '/forget';

  @override
  _ForgetScreenState createState() => _ForgetScreenState();
}

class _ForgetScreenState extends State<ForgetScreen> {
  final Auth _auth = Auth();
  final _formKey = GlobalKey<FormState>();
  String email = '';

  Future<void> _handleForgetPassword(BuildContext context) async {
    dynamic result = await _auth.resetForgotPassword(email);
    if (result == null) {
      var success = SuccessDialog(
          content: "Please check your email for further instructions!");
      showDialog(
        context: context,
        builder: (BuildContext context) => success,
      );
    } else {
      var dialog = ErrorDialog(
        content: "Invalid credentials. Please try again",
      );
      showDialog(
        context: context,
        builder: (BuildContext context) => dialog,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text('Forget Password'),
        ),
        body: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 20.0,
                  horizontal: 50.0,
                ),
                child: Form(
                    key: _formKey,
                    child: Column(children: <Widget>[
                      SizedBox(height: 20.0),
                      TextFormField(
                        enableInteractiveSelection: false,
                        decoration: textInputDecoration.copyWith(
                          hintText: 'Email',
                        ),
                        validator: (val) =>
                            val.isEmpty ? 'Enter an email' : null,
                        onChanged: (val) {
                          setState(() => email = val);
                        },
                      ),
                      SizedBox(height: 20.0),
                      RaisedButton(
                          child: Text(
                            'Submit',
                          ),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              _handleForgetPassword(context);
                            }
                          }),
                    ])))));
  }
}
