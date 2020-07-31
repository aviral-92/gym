import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class Constants {
  static const CALENDAR_COLOR = Color(0xFFFF9800);
  static const APP_BAR_COLOR = Color(0xFFFFA726);
  static const BACKGROUND_COLOR = Color(0xFFFFFFE0);

  /// *************  AddSlotScreen ****************/
  static const FONT_WEIGHT = FontWeight.w700;
  static const FONT_SIZE = 18.0;
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

  static const HOME_SCREEN_HEADER_TEXT = 'Welcome to the GYM.';
  static const HOME_SCREEN_BODY_TEXT =
      'Lines lines lines lines lines lines lines lines lines lines lines';

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
      'http://54.152.141.211:8082/adt/booker/slots/items/slotDate/';
  static const String GET_ADT_ITEMS_DATA =
      'http://54.152.141.211:8082/adt/booker/items/';
  static const String GET_ADT_ITEMS_SLOTS_BOOKING_DATA =
      'http://54.152.141.211:8082/adt/booker/booking/';
  static const String ADD_ADT_ITEM_SLOTS_DATA =
      'http://54.152.141.211:8082/adt/booker/slots/';
  static const String SLOT_BOOKING =
      'http://54.152.141.211:8082/adt/booker/booking/';
  //******************APIs*****************/
}
