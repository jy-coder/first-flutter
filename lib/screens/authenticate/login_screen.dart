import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newheadline/screens/authenticate/home_screen.dart';
import 'package:newheadline/shared/error_dialog.dart';
import 'package:newheadline/shared/app_drawer.dart';
import 'package:newheadline/provider/auth.dart';
import 'package:newheadline/shared/constants.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "/login";
  final Function toggleView;
  LoginScreen({this.toggleView});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginScreen> {
  final Auth _auth = Auth();
  final _formKey = GlobalKey<FormState>();

  bool loading = false;

  // text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // drawer: AppDrawer(),

      appBar: AppBar(
        elevation: 0.0,
        title: Text('Sign in'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Register'),
            onPressed: () => widget.toggleView(),
          ),
        ],
      ),
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
                  decoration: textInputDecoration.copyWith(
                    hintText: 'Email',
                  ),
                  validator: (val) => val.isEmpty ? 'Enter an email' : null,
                  onChanged: (val) {
                    setState(() => email = val);
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(
                    hintText: 'Password',
                  ),
                  obscureText: true,
                  validator: (val) =>
                      val.length < 0 ? 'Password must not be empty' : null,
                  onChanged: (val) {
                    setState(() => password = val);
                  },
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                    child: Text(
                      'Login',
                    ),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        setState(() => loading = true);
                        dynamic result = await _auth.signInWithEmailAndPassword(
                            email, password);
                        if (result.runtimeType == PlatformException) {
                          var dialog = ErrorDialog(
                            content: "Invalid credentials. Please try again",
                          );
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => dialog,
                          );
                        } else if (result != null) {
                          Navigator.of(context)
                              .pushReplacementNamed(HomeScreen.routeName);
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
