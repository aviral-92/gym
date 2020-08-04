import 'package:Gym/widget/MainDrawer.dart';

import '../constants/Constants.dart';
import 'package:flutter/material.dart';

class PasswordResetScreen extends StatelessWidget {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    bool args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: Constants.BACKGROUND_COLOR,
      appBar: AppBar(
        title: Text('Password Reset'),
        backgroundColor: Constants.APP_BAR_COLOR,
      ),
      drawer: MainDrawer(args),
      body: SafeArea(
        //child: Container(
        child: Form(
          child: ListView(
            children: <Widget>[
              new TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  icon: const Icon(Icons.email),
                  hintText: 'Enter your username',
                  labelText: 'email',
                ),
              ),
              new TextFormField(
                controller: _oldPasswordController,
                decoration: const InputDecoration(
                  icon: const Icon(Icons.pages),
                  hintText: 'Enter your old password',
                  labelText: 'old password',
                ),
                obscureText: true,
              ),
              new TextFormField(
                controller: _newPasswordController,
                decoration: const InputDecoration(
                  icon: const Icon(Icons.confirmation_number),
                  hintText: 'Enter your new password',
                  labelText: 'new password',
                ),
                obscureText: true,
              ),
              new TextFormField(
                controller: _confirmPasswordController,
                decoration: const InputDecoration(
                  icon: const Icon(Icons.confirmation_number),
                  hintText: 'Confirm your password',
                  labelText: 'Confirm Password',
                ),
                obscureText: true,
              ),
              new Container(
                padding: const EdgeInsets.only(
                  left: 40.0,
                  top: 20.0,
                  right: 20.0,
                ),
                child: new RaisedButton(
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      fontWeight: Constants.FONT_WEIGHT,
                      fontSize: Constants.BUTTON_SIZE,
                    ),
                  ),
                  color: Constants.APP_BAR_COLOR,
                  onPressed: () {},
                ),
              ),
            ],
            //),
          ),
        ),
      ),
    );
  }
}
