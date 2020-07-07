import 'package:Gym/constants/Constants.dart';
import 'package:Gym/widget/MainDrawer.dart';
import 'package:flutter/material.dart';

class CancelBookingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: Constants.BACKGROUND_COLOR,
      appBar: AppBar(
        title: Text('Cancel Slot'),
        backgroundColor: Constants.APP_BAR_COLOR,
      ),
      drawer: MainDrawer(args),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Slot 1'),
                Text('07/02/2020'),
                InkWell(
                  child: const Text('Cancel'),
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
