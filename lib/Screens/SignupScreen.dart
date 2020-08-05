import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/Constants.dart';
import '../model/AdtUsers.dart';
import '../services/RestApiService.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  static String email;
  String name;
  static String password;
  String confPassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.BACKGROUND_COLOR,
      appBar: AppBar(
        title: Text('Signup Form'),
        backgroundColor: Constants.APP_BAR_COLOR,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          autovalidate: _autoValidate,
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
                  hintText: 'Enter your first and last name',
                  labelText: 'Name',
                ),
                onSaved: (String value) {
                  name = value;
                },
                //validator: Constants.validateEmail,
                keyboardType: TextInputType.text,
              ),
              /*new TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.phone),
                  hintText: 'Enter a phone number',
                  labelText: 'Phone',
                ),
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  WhitelistingTextInputFormatter.digitsOnly,
                ],
              ),*/
              new TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.email),
                  hintText: 'Enter a email address',
                  labelText: 'Email',
                ),
                onSaved: (String value) {
                  email = value;
                },
                validator: Constants.validateEmail,
                keyboardType: TextInputType.emailAddress,
              ),
              new TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.pages),
                  hintText: 'Enter your password',
                  labelText: 'password',
                ),
                keyboardType: TextInputType.text,
                onSaved: (String value) {
                  password = value;
                },
                validator: Constants.validatePassword,
                obscureText: true,
              ),
              new TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.pages),
                  hintText: 'Confirm your password',
                  labelText: 'confirm password',
                ),
                keyboardType: TextInputType.text,
                onSaved: (String value) {
                  confPassword = value;
                },
                validator: Constants.validateCnfPassword,
                obscureText: true,
              ),
              new Container(
                padding: const EdgeInsets.only(left: 40.0, top: 20.0),
                child: new RaisedButton(
                  child: const Text('Submit'),
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
      if (password != confPassword) {
        print('$password....$confPassword');
        print('././././././');
      } else {
        //form.save();
        List<String> authorties = [];
        authorties.add('ROLE_USER');
        AdtUsers users = new AdtUsers(email, password, authorties, 1);
        var futureResponse = registerUser(users);
        await futureResponse.then((value) => print(value.body));
      }
      // Text forms was validated.

    } else {
      setState(() => _autoValidate = true);
    }
  }
}
