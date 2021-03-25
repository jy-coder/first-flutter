import 'package:flutter/material.dart';
import 'package:newheadline/shared/error_dialog.dart';
import 'package:newheadline/provider/auth.dart';
import 'package:newheadline/shared/constants.dart';
import 'package:newheadline/shared/redirect_dialog.dart';

class ResetPasswordScreen extends StatefulWidget {
  static const routeName = "/resetPassword";
  final Function toggleView;
  ResetPasswordScreen({this.toggleView});

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  Auth _auth = Auth();

  // text field state
  String email = '';
  String password = '';
  String confirmPassword = '';
  String fullName = '';
  String error = '';
  dynamic result = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 20.0,
            horizontal: 50.0,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                TextFormField(
                  decoration:
                      textInputDecoration.copyWith(hintText: 'Password'),
                  obscureText: true,
                  validator: (val) => val.length < 6
                      ? 'Password must be at least 6 characters long'
                      : null,
                  onChanged: (val) {
                    setState(() => password = val);
                  },
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                    child: Text(
                      'Change Password',
                    ),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        setState(() => loading = true);
                        dynamic result = await _auth.resetPassword(password);

                        if (result == null) {
                          var dialog = RedirectDialog(
                            content:
                                "Please check your email to reset password",
                          );
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext context) => dialog,
                          );
                        } else {
                          var dialog = ErrorDialog(
                            content: "Wrong password",
                          );
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => dialog,
                          );
                        }
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
