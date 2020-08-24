import '../constants/Constants.dart';
import '../widget/UpcomingEventWidget.dart';
import '../widget/MainDrawer.dart';
import 'package:flutter/material.dart';

class UpcomingEventScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: Constants.BACKGROUND_COLOR,
      appBar: AppBar(
        title: Text('Upcoming Schedule'),
        backgroundColor: Constants.APP_BAR_COLOR,
      ),
      drawer: MainDrawer(
        admin: args,
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              UpcomingEventWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
