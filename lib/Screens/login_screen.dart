import 'package:Gym/constants/Constants.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  void navigateDashboard(BuildContext context) {
    Navigator.of(context).pushNamed('/dashboard-screen', arguments: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.BACKGROUND_COLOR,
      appBar: AppBar(
        title: Text('Login Form'),
        backgroundColor: Constants.APP_BAR_COLOR,
      ),
      body: SafeArea(
        child: Form(
          child: ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  './assets/img/biking.png',
                  fit: BoxFit.scaleDown,
                  height: 250,
                ),
              ),
              new TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.person),
                  hintText: 'Enter your username',
                  labelText: 'email/mobile',
                ),
              ),
              new TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.camera),
                  hintText: 'Enter your password',
                  labelText: 'password',
                ),
                keyboardType: TextInputType.text,
              ),
              new Container(
                padding: const EdgeInsets.only(left: 40.0, top: 20.0),
                child: new RaisedButton(
                  child: const Text('Submit'),
                  onPressed: () => navigateDashboard(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
