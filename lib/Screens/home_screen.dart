import 'package:Gym/constants/Constants.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void navigateSignup(BuildContext context) {
    Navigator.of(context).pushNamed('/signup-screen');
  }

  void navigateLogin(BuildContext context) {
    Navigator.of(context).pushNamed('/login-screen');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Constants.BACKGROUND_COLOR,
        appBar: AppBar(
          title: Text('Biking'),
          backgroundColor: Constants.APP_BAR_COLOR,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 35,
              horizontal: 35,
            ),
            child: Container(
              child: Column(
                children: <Widget>[
                  Text(
                    'Welcome to the GYM',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(10, 0, 0, 1),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Lines lines lines lines lines lines lines lines lines lines lines',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(10, 0, 0, 1),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 25,
                    ),
                    child: Image.asset(
                      './assets/img/biking.png',
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: RaisedButton(
                          onPressed: () => navigateSignup(context),
                          child: Text(
                            'Signup',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          elevation: 6,
                          color: Color.fromRGBO(229, 229, 229, 1),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                        ),
                        child: RaisedButton(
                          onPressed: () => navigateLogin(context),
                          //textColor: Colors.white,
                          child: Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          elevation: 6,
                          color: Color.fromRGBO(229, 229, 229, 1),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ));
  }
}
