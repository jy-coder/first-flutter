import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newheadline/screens/pages/home_screen.dart';
import 'package:newheadline/utils/auth.dart';
import 'package:newheadline/shared/constants.dart';
import 'package:newheadline/shared/loading.dart';
import 'package:http/http.dart' as http;
import 'package:newheadline/utils/response.dart';
import 'package:newheadline/utils/url.dart';

import '../../main.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  Auth _auth = Auth();

  // text field state
  String email = '';
  String password = '';
  String fullName = '';
  String error = '';
  dynamic result = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              title: Text('Sign in'),
              actions: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.person),
                  label: Text('Sign In'),
                  onPressed: () => widget.toggleView(),
                ),
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Email'),
                      validator: (val) => val.isEmpty ? 'Enter an email' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
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
                          'Register',
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() => loading = true);
                            result = await _auth.registerWithEmailAndPassword(
                                email, password);
                            setState(() => loading = false);

                            if (result != null) {
                              _auth.getToken().then((String token) {
                                print("saving to database");
                                post(REGISTER_USER, token);
                                Navigator.of(context)
                                    .pushReplacementNamed(HomeScreen.routeName);
                              });
                            } else if (result == null) {
                              setState(
                                  () => error = 'Please supply a valid email');
                            }

                            // dynamic result = await post(REGISTER_USER, "". {
                            //   "email": email
                            // });

                          }
                        }),
                    SizedBox(height: 12.0),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
