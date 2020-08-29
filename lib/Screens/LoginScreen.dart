import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';
import '../constants/Constants.dart';
import '../model/oauth/AdtAccessToken.dart';
import '../model/oauth/OauthToken.dart';
import '../services/RestApiService.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String errorMsg = '';

  Future<void> navigateDashboard(BuildContext context) async {
    if (_passwordController.text.isEmpty || _usernameController.text.isEmpty) {
      setState(() {
        errorMsg = 'Username or password cannot be empty.';
      });
    } else {
      OauthToken oauthToken = new OauthToken(
          _usernameController.text, _passwordController.text, 'password');
      oauthToken.setClientId('clientId');
      oauthToken.setClientSecret('secret');
      var futureResponse = getToken(oauthToken);
      Response currentRresponse, currentTokenInfoResponse;
      await futureResponse.then((value) => currentRresponse = value);
      if (currentRresponse != null && currentRresponse.statusCode == 200) {
        AdtAccessToken adtAccessToken =
            AdtAccessToken.fromMap(json.decode(currentRresponse.body));
        //Token get stored.
        addStorage('${adtAccessToken.tokenType} ${adtAccessToken.accessToken}');
        //print('Token stored...');
        var futureTokenInfoResponse =
            getTokenInfo(adtAccessToken.tokenType, adtAccessToken.accessToken);
        await futureTokenInfoResponse
            .then((value) => currentTokenInfoResponse = value);
        print('${currentTokenInfoResponse.body}');
        if (currentTokenInfoResponse != null &&
            currentTokenInfoResponse.statusCode == 200) {
          var jsons = json.decode(currentTokenInfoResponse.body);
          bool isAdmin = false;
          if (jsons != null &&
              jsons['authorities'] != null &&
              jsons['authorities'][0] != null) {
            if (jsons['authorities'][0]['authority'] == 'ROLE_ADMIN') {
              isAdmin = true;
              print('..................');
              await sharedPrefForAdmin();
            }
          }
          await sharedPref();
          Navigator.of(context)
              .pushNamed('/dashboard-screen', arguments: isAdmin);
          //addStorage('${adtAccessToken.tokenType} ${adtAccessToken.accessToken}');
        } else {
          print('.....fail:${currentTokenInfoResponse.body}........');
        }
      } else if (currentRresponse.statusCode == 400) {
        setState(() {
          errorMsg = 'Invalid Username or password';
        });
        print(errorMsg);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        child: ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          children: <Widget>[
            SizedBox(height: 75),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome Back',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Sign to continue',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 15),
            new TextFormField(
              controller: _usernameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                icon: const Icon(Icons.person),
                hintText: 'Enter your username',
                labelText: 'email/mobile',
              ),
            ),
            SizedBox(height: 25),
            new TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                icon: const Icon(Icons.camera),
                hintText: 'Enter your password',
                labelText: 'password',
                //errorText: 'Incorrect',
              ),
              keyboardType: TextInputType.text,
              obscureText: true,
            ),
            SizedBox(
              height: 15,
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
                onPressed: () => navigateDashboard(context),
              ),
            ),
            Container(
              child: Text(
                '$errorMsg',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 50,
                vertical: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
