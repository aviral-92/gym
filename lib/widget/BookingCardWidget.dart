import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/AdtItemSlots.dart';
import '../constants/Constants.dart';

class BookingCardWidget extends StatelessWidget {
  final AdtItemSlots adtItemSlots;
  static DateFormat timeFormat =
      new DateFormat(TimeOfDayFormat.HH_colon_mm.toString());

  BookingCardWidget(this.adtItemSlots);

  @override
  Widget build(BuildContext context) {
    DateTime startTime = splitAndConvertStringToTime(adtItemSlots.startHour);
    DateTime endTime = splitAndConvertStringToTime(adtItemSlots.endHour);

    return Card(
      color: Constants.BACKGROUND_COLOR,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '${timeFormat.format(startTime)} - ${timeFormat.format(endTime)}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.device_hub,
                    color: Constants.CALENDAR_COLOR,
                    size: 40.0,
                  ),
                  Text(
                    '${adtItemSlots.desc} \n price: \$${adtItemSlots.slotPrice} \n Slots left: ${adtItemSlots.itemCount}',
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 18),
                  ),
                  //Icon(Icons.add_circle),
                ],
              ),
            ],
          ),
          IconButton(
              icon: Icon(
                Icons.add_circle,
                size: 35.0,
                color: Constants.APP_BAR_COLOR,
              ),
              //tooltip: 'click to book',
              onPressed: () {
                //var response = fetchItemSlot();
                //print(response.then((value) => value.indexOf('0'));
                //response.then((value) => print(jsonEncode(value.elementAt(0))));
              }),
        ],
      ),
      elevation: 1,
    );
  }

/* Split decimal to colon so that it can be convert */
  DateTime splitAndConvertStringToTime(double time) {
    int _hourValue = time.floor();
    double decimalValue = time - _hourValue;
    int _minuteValue;
    if (decimalValue != 0.0) {
      _minuteValue = int.parse((decimalValue * 100).toStringAsPrecision(2));
    } else {
      _minuteValue = int.parse((decimalValue * 100).toStringAsPrecision(1));
    }
    return timeFormat.parse('$_hourValue:$_minuteValue');
  }
}
