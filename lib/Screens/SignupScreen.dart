import 'dart:convert';

//import 'package:Gym/constants/Routing.dart';
import 'package:Gym/model/AdtResponse.dart';
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
  String mobile;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: _formKey,
        autovalidate: _autoValidate,
        child: ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          children: <Widget>[
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Create Account',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Create a new account'),
              ],
            ),
            SizedBox(height: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
            new TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  //borderRadius: new BorderRadius.circular(25.0),
                  borderSide: new BorderSide(),
                ),
                icon: const Icon(Icons.person),
                hintText: 'Enter your first and last name',
                labelText: 'Name',
              ),
              onSaved: (String value) {
                name = value;
              },
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 15),
            new TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
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
            SizedBox(height: 15),
            new TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                icon: const Icon(Icons.mobile_screen_share),
                hintText: 'Enter your mobile number',
                labelText: 'Mobile',
              ),
              onSaved: (String value) {
                mobile = value;
              },
              validator: Constants.validateMobile,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 15),
            new TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
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
            SizedBox(height: 15),
            new TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
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
                child: const Text(
                  'Submit',
                  style: TextStyle(
                      fontWeight: Constants.FONT_WEIGHT,
                      fontSize: Constants.BUTTON_SIZE,
                      color: Constants.BUTTON_TEXT_COLOR),
                ),
                color: Constants.APP_BAR_COLOR,
                onPressed: _validateInputs,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _validateInputs() async {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      if (password != confPassword) {
        Constants.showDialogue(
            context, 'password & confirm password does not match');
      } else {
        //form.save();
        List<String> authorties = ["ROLE_USERS"];
        //authorties.add('ROLE_USERS');
        AdtUsers users =
            new AdtUsers(name, email, password, authorties, mobile, 1);
        var futureResponse = registerUser(users);
        AdtResponse adtResponse;
        await futureResponse.then((value) => {
              if (value.statusCode == 400)
                {
                  adtResponse = AdtResponse.fromMap(json.decode(value.body)),
                  Constants.showDialogue(context, adtResponse.message)
                }
              else if (value.statusCode == 200)
                {
                  //Routing.navigateLogin(context)
                  Navigator.of(context).popAndPushNamed('/login-signup-screen')
                  /*Constants.showDialogue(
                      context, 'you are successfully registered.')*/
                }
              else
                {
                  Constants.showDialogue(context,
                      'Something went wrong, please try it after sometime.')
                }
            });
      }
    } else {
      setState(() => _autoValidate = true);
    }
  }
}
