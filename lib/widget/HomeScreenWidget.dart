import 'package:flutter/material.dart';
import '../constants/Constants.dart';
//import '../constants/Routing.dart';

class HomeScreenWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
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
              './assets/img/IMG_1632.jpeg',
              fit: BoxFit.scaleDown,
              height: height - 310,
            ),
          ),
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(left: 40.0),
                child: new RaisedButton(
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                        fontWeight: Constants.FONT_WEIGHT,
                        fontSize: Constants.BUTTON_SIZE,
                        color: Constants.BUTTON_TEXT_COLOR),
                  ),
                  color: Constants.APP_BAR_COLOR,
                  onPressed: () {},
                  elevation: 6,
                ),
              ),
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
          textColor: Constants.BUTTON_TEXT_COLOR,
          label: Text(
            buttonText,
            style: TextStyle(
              fontSize: 20,
              color: Constants.BUTTON_TEXT_COLOR,
              fontWeight: Constants.FONT_WEIGHT,
            ),
          ),
          elevation: 6,
          color: Constants.BUTTON_COLOR,
          icon: icon,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(color: Colors.red)),
        ),
      );
}
