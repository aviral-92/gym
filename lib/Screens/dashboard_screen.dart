import 'package:Gym/constants/Constants.dart';

import '../widget/MainDrawer.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool args = ModalRoute.of(context).settings.arguments;
    //print(args);
    return Scaffold(
      backgroundColor: Constants.BACKGROUND_COLOR,
      appBar: AppBar(
        title: Text('Dashboard'),
        backgroundColor: Constants.APP_BAR_COLOR,
      ),
      drawer: MainDrawer(args),
      body: Container(
        height: 120,
        width: double.infinity,
        padding: EdgeInsets.all(20),
        alignment: Alignment.centerLeft,
        //child: Card(
        child: Text(
          'No bookings found. if you have already booked, please check in upcoming events.',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
        //elevation: 6,
        //),
      ),
    );
  }
}
