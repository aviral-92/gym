import 'package:flutter/material.dart';
import '../constants/Constants.dart';
import '../widget/MainDrawer.dart';

class Contact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: Constants.BACKGROUND_COLOR,
      appBar: AppBar(
        backgroundColor: Constants.APP_BAR_COLOR,
        title: Text('Contact Us'),
      ),
      drawer: MainDrawer(args),
      body: Container(
        child: Row(
          children: <Widget>[],
        ),
      ),
    );
  }
}
