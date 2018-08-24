import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class FormPage extends StatefulWidget {
  @override
  FormPageState createState() => new FormPageState();
}

class FormPageState extends State<FormPage> {
  Future<SharedPreferences> preferences = SharedPreferences.getInstance();

  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();

  String _email = "Raja Mohamed";
  String _password;

  void _submit() {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();

      // Email & password matched our validation rules
      // and are saved to _email and _password fields.
      _performLogin();
    }
  }

  void _performLogin() async {
    // This is just a demo, so no actual login here.
    final SharedPreferences prefs = await preferences;
    prefs.setString("email", _email);
    prefs.setString("password", _password);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: scaffoldKey,
      appBar: new AppBar(
        title: new Text('Validating forms'),
      ),
      body: new Padding(
        padding: const EdgeInsets.all(16.0),
        child: new Form(
          key: formKey,
          child: new Column(
            children: [
              new TextFormField(
                initialValue: _email,
                decoration: new InputDecoration(labelText: 'Your email'),
                validator: (val) {
                  return !val.contains('@') ? 'Not a valid email.' : null;
                },
                onSaved: (val) async {
                  return _email = val;
                },
              ),
              new TextFormField(
                initialValue: _password,
                decoration: new InputDecoration(labelText: 'Your password'),
                validator: (val) =>
                    val.length < 6 ? 'Password too short.' : null,
                onSaved: (val) => _password = val,
                obscureText: true,
              ),
              new RaisedButton(
                onPressed: _submit,
                child: new Text('SAVE'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void loadPreferencesValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _email = prefs.get("email");
    _password = prefs.get("password");
    print(_email);
    print(_password);
  }
}
