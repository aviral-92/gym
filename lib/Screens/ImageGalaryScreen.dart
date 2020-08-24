import 'package:Gym/constants/Constants.dart';
import 'package:Gym/widget/MainDrawer.dart';
import 'package:flutter/material.dart';

class ImageGalaryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Gallary'),
        backgroundColor: Constants.APP_BAR_COLOR,
      ),
      drawer: MainDrawer(
        admin: args,
      ),
      body: SingleChildScrollView(
          //child: ListView(
          //children: <Widget>[
          //Card(
          //child: ,
          //)
          //],
          //),
          ),
    );
  }
}
