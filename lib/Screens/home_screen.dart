import 'package:flutter/material.dart';
import '../constants/Constants.dart';
import '../widget/HomeScreenWidget.dart';

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
          child: HomeScreenWidget(),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}
