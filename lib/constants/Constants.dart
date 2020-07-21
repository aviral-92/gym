import 'dart:ui';

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

  static DateTime convertStringToDate(DateFormat dateFormat, String str) {
    return dateFormat.parse(str);
  }

  static String convertDateToString(DateFormat dateFormat, DateTime dateTime) {
    return dateFormat.format(dateTime);
  }
}
