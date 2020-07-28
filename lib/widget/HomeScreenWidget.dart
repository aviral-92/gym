import 'package:flutter/material.dart';
import '../constants/Constants.dart';
import '../constants/Routing.dart';

class HomeScreenWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(
            Constants.HOME_SCREEN_HEADER_TEXT,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(10, 0, 0, 1),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              Constants.HOME_SCREEN_BODY_TEXT,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Color.fromRGBO(10, 0, 0, 1),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 25,
            ),
            child: Image.asset(
              './assets/img/biking.png',
              fit: BoxFit.scaleDown,
            ),
          ),
          Row(
            children: <Widget>[
              getPaddingWidgetWithButton(
                  'Login',
                  () => Routing.navigateLogin(context),
                  Icon(Icons.keyboard_tab)),
              getPaddingWidgetWithButton(
                  'Signup',
                  () => Routing.navigateSignup(context),
                  Icon(Icons.fitness_center)),
            ],
          ),
        ],
      ),
    );
  }

  Widget getPaddingWidgetWithButton(
          String buttonText, Function fun, Icon icon) =>
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: RaisedButton.icon(
          onPressed: () => fun(),
          textColor: Colors.black,
          label: Text(
            buttonText,
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.w900,
            ),
          ),
          elevation: 6,
          color: Colors.amberAccent[700],
          icon: icon,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(color: Colors.red)),
        ),
      );
}
