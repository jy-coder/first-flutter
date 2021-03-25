import 'package:flutter/material.dart';
import 'package:newheadline/screens/authenticate/home_screen.dart';
import 'package:newheadline/shared/error_dialog.dart';
import 'package:newheadline/provider/auth.dart';
import 'package:newheadline/shared/constants.dart';
import 'package:newheadline/shared/load_dialog.dart';
import 'package:newheadline/utils/response.dart';
import 'package:newheadline/utils/urls.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});
  static final routeName = '/register';

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
  String confirmPassword = '';
  String fullName = '';
  String error = '';
  dynamic result = '';
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  Future<void> _handleSubmit(BuildContext context) async {
    result = await _auth.registerWithEmailAndPassword(email, password);

    if (result != null && _auth.currentUser != null) {
      await _auth.currentUser.getIdToken().then((String token) async {
        LoadDialog.showLoadingDialog(context, _keyLoader);
        APIService().post(REGISTER_URL);

        await Future.delayed(const Duration(seconds: 5), () {
          Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
          Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                decoration: textInputDecoration.copyWith(hintText: 'Email'),
                validator: (val) => val.isEmpty ? 'Enter an email' : null,
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Password'),
                obscureText: true,
                validator: (val) => val.length < 6
                    ? 'Password must be at least 6 characters long'
                    : null,
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration:
                    textInputDecoration.copyWith(hintText: 'Confirm Password'),
                obscureText: true,
                validator: (val) =>
                    val != password ? 'Password does not match' : null,
                onChanged: (val) {
                  setState(() => confirmPassword = val);
                },
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                  child: Text(
                    'Register',
                  ),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      _handleSubmit(context);
                    } else {
                      var dialog = ErrorDialog(
                        content: "Invalid email. Please try again",
                      );
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => dialog,
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
