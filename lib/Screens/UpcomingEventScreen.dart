import 'package:Gym/constants/Constants.dart';

import '../widget/MainDrawer.dart';
import 'package:flutter/material.dart';

class UpcomingEventScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool args = ModalRoute.of(context).settings.arguments;
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
        child: Text(
          'You have no upcoming event! Book an event to see....',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
