import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Constants {
  static const CALENDAR_COLOR = Color(0xFFFF9800);
  //static const APP_BAR_COLOR = Color(0xFFFFA726);
  static const APP_BAR_COLOR = Color(0xFFAB47BC); //Colors.purple;//0xFFBA68C8
  //static const BACKGROUND_COLOR = Color(0xFFFFFFE0);
  static const BUTTON_COLOR = Color(0xFFBA68C8);
  static const BUTTON_TEXT_COLOR = Color(0xFFFFFFFF);
  static const BACKGROUND_COLOR = Colors.white; //Colors.cyan;ffe0f7fa

  /// *************  AddSlotScreen ****************/
  static const FONT_WEIGHT = FontWeight.w700;
  static const FONT_SIZE = 18.0;
  static const DRAWER_FONT_SIZE = 21.5;
  static const DRAWER_ICON_SIZE = 21.5;
  static const BUTTON_SIZE = 20.0;
  static const SIZED_BOX_HEIGHT = 20.0;
  static const HORIZONTAL_PADDING = 16.0;

  static DateFormat timeFormat = DateFormat.Hm();
  static DateFormat dateFormat = new DateFormat('yyyy-MM-dd');

  static DateTime convertStringToDate(DateFormat dateFormat, String str) {
    return dateFormat.parse(str);
  }

  static String convertDateToString(DateFormat dateFormat, DateTime dateTime) {
    return dateFormat.format(dateTime);
  }

  static const HOME_SCREEN_HEADER_TEXT = 'THE FITNESS PLACE';
  static const HOME_SCREEN_BODY_TEXT = 'one place to get fit';

  /* Split decimal to colon so that it can be convert */
  static DateTime splitAndConvertStringToTime(double time) {
    int _hourValue = time.floor();
    double decimalValue = time - _hourValue;
    int _minuteValue;
    if (decimalValue != 0.0) {
      _minuteValue = int.parse((decimalValue * 100).toStringAsPrecision(2));
    } else {
      _minuteValue = int.parse((decimalValue * 100).toStringAsPrecision(1));
    }
    return convertStringToDate(timeFormat, '$_hourValue:$_minuteValue');
  }

  static Widget loadingView() => Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.red,
        ),
      );

  static Widget noDataView(String msg) => Center(
        child: Text(
          msg,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
        ),
      );

  //******************APIs*****************/
  static const String GET_ADT_ITEMSLOTS_DATA =
      'http://54.152.141.211:8082/adt/booker/slots/items';
  static const String GET_ADT_ITEMS_DATA =
      'http://54.152.141.211:8082/adt/booker/items/';
  static const String GET_ADT_ITEMS_SLOTS_BOOKING_DATA =
      'http://54.152.141.211:8082/adt/booker/booking/';
  static const String ADD_ADT_ITEM_SLOTS_DATA =
      'http://54.152.141.211:8082/adt/booker/slots/';
  static const String SLOT_BOOKING =
      'http://54.152.141.211:8082/adt/booker/booking/';
  static const String GET_TOKEN = 'http://54.152.141.211:9000/oauth/token';
  static const String GET_TOKEN_INFO = 'http://54.152.141.211:8082/users/me';
  static const String CREATE_USER = 'http://54.152.141.211:8082/users/register';
  static const String RESET_PASSWORD =
      'http://54.152.141.211:8082/users/changePassword';
  static const String CANCEL_BOOKING_SLOT =
      'http://54.152.141.211:8082/adt/booker/booking';
  static const String ADD_ITEM = 'http://54.152.141.211:8082/adt/booker/items/';
  static const String DELETE_ITEM =
      'http://54.152.141.211:8082/adt/booker/items';
  static const String UPDATE_ITEM =
      'http://54.152.141.211:8082/adt/booker/items/';
  //******************APIs*****************/

  static final String mobileValidation = "@\"d{10}\$\"";

  static String validateMobile(String value) {
    if (value.isEmpty) {
      // The form is empty
      return "Enter email address";
    }
    RegExp regExp = new RegExp(mobileValidation);
    if (regExp.hasMatch(value)) {
      // So, the email is valid
      return null;
    }
    return 'mobile is not valid';
  }

  static final String emailValidation = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
      "\\@" +
      "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
      "(" +
      "\\." +
      "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
      ")+";

  static String validateEmail(String value) {
    if (value.isEmpty) {
      // The form is empty
      return "Enter email address";
    }
    // This is just a regular expression for email addresses
    RegExp regExp = new RegExp(emailValidation);
    if (regExp.hasMatch(value)) {
      // So, the email is valid
      return null;
    }
    // The pattern of the email didn't match the regex above.
    return 'Email is not valid';
  }

  static String validatePassword(String value) {
    if (value.isEmpty) {
      return 'Enter password';
    }
    return null;
  }

  static String validateCnfPassword(String value) {
    if (value.isEmpty) {
      return 'Enter confirm password';
    }
    return null;
  }

  static Future<bool> asyncInputDialog(
      BuildContext context, String value) async {
    bool _returnValue;
    return showDialog<bool>(
      context: context,
      builder: (BuildContext con) {
        return AlertDialog(
          title: Text('Adt'),
          content: Text(value),
          actions: [
            FlatButton(
              onPressed: () {
                _returnValue = true;
                Navigator.of(context).pop(_returnValue);
              },
              child: Text('yes'),
            ),
            FlatButton(
              onPressed: () {
                _returnValue = false;
                Navigator.of(context).pop(_returnValue);
              },
              child: Text('no'),
            ),
          ],
        );
      },
    );
  }

  static void showDialogue(BuildContext context, String value) {
    showDialog<bool>(
      context: context,
      builder: (BuildContext con) {
        return AlertDialog(
          title: Text('Booked'),
          content: Text(value),
          actions: [
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('ok'),
            ),
          ],
        );
      },
    );
  }
}
