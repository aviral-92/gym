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
        height: 250,
        width: double.infinity,
        padding: EdgeInsets.all(20),
        alignment: Alignment.centerLeft,
        //child: Card(
        child: GestureDetector(
          onTap: () => {Navigator.of(context).pushNamed('/booking-screen')},
          child: Card(
            //color: Constants.BACKGROUND_COLOR,
            elevation: 6,
            child: Column(
              children: [
                Expanded(
                  child: Image.asset(
                    './assets/img/biking.png',
                  ),
                  flex: 2,
                ),
                SizedBox(height: 10),
                Text(
                  'SPINING',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
