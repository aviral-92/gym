import 'package:Gym/model/AdtItemSlotsBooked.dart';
import 'package:Gym/services/RestApiService.dart';
import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';
import '../model/AdtItemSlots.dart';
import '../constants/Constants.dart';

class BookingCardWidget extends StatelessWidget {
  final AdtItemSlots adtItemSlots;
  //static DateFormat timeFormat = DateFormat.Hm();

  BookingCardWidget(this.adtItemSlots);

  @override
  Widget build(BuildContext context) {
    DateTime startTime = splitAndConvertStringToTime(adtItemSlots.startHour);
    DateTime endTime = splitAndConvertStringToTime(adtItemSlots.endHour);
    //print('startTime=$startTime............. endTime=$endTime');
    return Card(
      color: Constants.BACKGROUND_COLOR,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '${Constants.timeFormat.format(startTime)} - ${Constants.timeFormat.format(endTime)}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10),
              Row(
                children: <Widget>[
                  const Icon(
                    Icons.device_hub,
                    color: Constants.CALENDAR_COLOR,
                    size: 40.0,
                  ),
                  Text(
                    '${adtItemSlots.desc} \n price: \$${adtItemSlots.slotPrice} \n Slots left: ${adtItemSlots.itemCount}',
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 18),
                  ),
                ],
              ),
            ],
          ),
          adtItemSlots.itemCount > 0 &&
                  _isDateOrTimeAfter(
                      Constants.dateFormat.parse(adtItemSlots.slotDate),
                      Constants.dateFormat
                          .parse(Constants.dateFormat.format(DateTime.now())))
              ? getIconButton(context)
              : adtItemSlots.itemCount > 0 &&
                      _isDateOrTimeAfter(
                          splitAndConvertStringToTime(adtItemSlots.startHour),
                          Constants.convertStringToDate(
                              Constants.timeFormat,
                              Constants.convertDateToString(
                                  Constants.timeFormat, DateTime.now())))
                  ? getIconButton(context)
                  : SizedBox.shrink(),
        ],
      ),
      elevation: 1,
    );
  }

  bool _isDateOrTimeAfter(DateTime first, DateTime second) {
    return first.isAfter(second);
  }

  Widget getIconButton(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.add_circle,
        size: 35.0,
        color: Constants.APP_BAR_COLOR,
      ),
      tooltip: 'click to book',
      onPressed: () {
        _asyncInputDialog(context, 'Are you sure?').then(
          (value) {
            print('=============$value=============');
            if (value) {
              AdtItemSlotsBooked adtItemSlotsBooked = new AdtItemSlotsBooked(
                  'Booked', adtItemSlots.slotPrice, adtItemSlots);
              var response = slotBooking(adtItemSlotsBooked);
              response.then((value) =>
                  _showDialogue(context, 'Successfully Booked the slot'));
            }
          },
        );
      },
    );
  }

  Future<bool> _asyncInputDialog(BuildContext context, String value) async {
    bool _returnValue;
    return showDialog<bool>(
      context: context,
      builder: (BuildContext con) {
        return AlertDialog(
          title: Text('Booking'),
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

  void _showDialogue(BuildContext context, String value) {
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
    return Constants.convertStringToDate(
        Constants.timeFormat, '$_hourValue:$_minuteValue');
  }
}
