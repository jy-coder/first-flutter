import 'package:flutter/material.dart';
import 'package:newheadline/provider/theme.dart';
import 'package:newheadline/screens/authenticate/forget_screen.dart';
import 'package:newheadline/screens/authenticate/home_screen.dart';
import 'package:newheadline/shared/error_dialog.dart';
import 'package:newheadline/provider/auth.dart';
import 'package:newheadline/shared/constants.dart';
import 'package:newheadline/shared/load_dialog.dart';
import 'package:provider/provider.dart';

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

  String email = '';
  String password = '';
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  Future<void> _handleSubmit(BuildContext context) async {
    dynamic result = await _auth.signInWithEmailAndPassword(email, password);
    if (result != null) {
      await _auth.currentUser.getIdToken().then((String token) async {
        LoadDialog.showLoadingDialog(context, _keyLoader);
        await Future.delayed(const Duration(seconds: 7), () {
          Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
          Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
        });
      });
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
    ThemeProvider tProvider =
        Provider.of<ThemeProvider>(context, listen: false);

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
                      'Login',
                    ),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        _handleSubmit(context);
                      }
                    }),
                FlatButton(
                  textColor:
                      tProvider.theme == "dark" ? Colors.white : Colors.black,
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ForgetScreen())),
                  child: Text("Forget Password?"),
                  shape:
                      CircleBorder(side: BorderSide(color: Colors.transparent)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
