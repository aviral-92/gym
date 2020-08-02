import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                './assets/img/Dianes.jpeg',
                fit: BoxFit.fill,
                //height: 550,
                width: double.infinity,
              ),
            ),
            SizedBox(
              height: 30,
              child: Text(
                'Powered by ',
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                  //backgroundColor: Colors.black,
                  fontSize: 20,
                  //decoration: TextDecoration.underline,
                ),
              ),
            ),
            InkWell(
              child: Text(
                'AgileDevTech',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  //backgroundColor: Colors.red[300],
                  fontSize: 20,
                  decoration: TextDecoration.underline,
                ),
              ),
              onTap: () => launch('http://agiledevtech.com'),
            ),
          ],
        ),
      ),
    );
  }
}
