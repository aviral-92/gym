import 'package:Gym/widget/MainDrawer.dart';

import '../constants/Constants.dart';
import 'package:flutter/material.dart';
import '../services/RestApiService.dart';

class PasswordResetScreen extends StatefulWidget {
  @override
  _PasswordResetScreenState createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  static String username;
  static String oldPassword;
  static String newPassword;
  String confirmPassword;

  @override
  Widget build(BuildContext context) {
    bool args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: Constants.BACKGROUND_COLOR,
      appBar: AppBar(
        title: Text('Password Reset'),
        backgroundColor: Constants.APP_BAR_COLOR,
      ),
      drawer: MainDrawer(
        admin: args,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          autovalidate: _autoValidate,
          child: ListView(
            children: <Widget>[
              new TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.email),
                  hintText: 'Enter your username',
                  labelText: 'email',
                ),
                onSaved: (String value) {
                  username = value;
                },
                validator: Constants.validateEmail,
                keyboardType: TextInputType.emailAddress,
              ),
              new TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.pages),
                  hintText: 'Enter your old password',
                  labelText: 'old password',
                ),
                onSaved: (String value) {
                  oldPassword = value;
                },
                validator: Constants.validatePassword,
                keyboardType: TextInputType.text,
                obscureText: true,
              ),
              new TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.confirmation_number),
                  hintText: 'Enter your new password',
                  labelText: 'new password',
                ),
                obscureText: true,
                onSaved: (String value) {
                  newPassword = value;
                },
                validator: Constants.validatePassword,
                keyboardType: TextInputType.text,
              ),
              new TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.confirmation_number),
                  hintText: 'Confirm your password',
                  labelText: 'Confirm Password',
                ),
                onSaved: (String value) {
                  confirmPassword = value;
                },
                validator: Constants.validateCnfPassword,
                keyboardType: TextInputType.text,
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
                  onPressed: _validateInputs,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _validateInputs() async {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      if (newPassword != confirmPassword) {
        //print('$newPassword....$confirmPassword');
        //print('././././././');
      } else {
        //form.save();
        Map<String, String> toMaps = {
          'userName': username,
          'newPassword': newPassword,
          'oldPassword': oldPassword,
        };
        var futureResponse = passwordReset(toMaps);
        await futureResponse.then((value) => {
              if (value.statusCode == 200)
                {
                  Constants.showDialogue(
                      context, 'Successfully updated your password.')
                }
              else if (value.statusCode == 400)
                {
                  Constants.showDialogue(
                      context, 'username or old password is wrong.')
                }
            });
      }
      // Text forms was validated.

    } else {
      setState(() => _autoValidate = true);
    }
  }
}
