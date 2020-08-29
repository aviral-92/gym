import '../Screens/LoginScreen.dart';
import '../Screens/SignupScreen.dart';
import '../constants/Constants.dart';
import 'package:flutter/material.dart';

class LoginSignUpScreen extends StatelessWidget {
  //TabController _tabController;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Constants.APP_BAR_COLOR,
          title: Text("Login/Signup"),
        ),
        bottomNavigationBar: menu(),
        body: TabBarView(
          children: [
            LoginScreen(),
            SignupScreen(),
          ],
        ),
      ),
    );
  }

  Widget menu() {
    return Container(
      color: Constants.APP_BAR_COLOR,
      child: TabBar(
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white70,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: EdgeInsets.all(5.0),
        indicatorColor: Colors.white,
        tabs: [
          Tab(
            text: "Login",
            icon: Icon(Icons.keyboard_tab),
          ),
          Tab(
            text: "Signup",
            icon: Icon(Icons.fitness_center),
          ),
        ],
      ),
    );
  }
}
