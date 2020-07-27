import 'package:flutter/material.dart';
import '../constants/Constants.dart';
import '../widget/BookingCancelWidget.dart';
import '../widget/MainDrawer.dart';

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
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              BookingCancelWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
