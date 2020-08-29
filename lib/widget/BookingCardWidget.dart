import 'package:Gym/constants/Routing.dart';
import 'package:Gym/model/ReceivedNotification.dart';
import 'package:Gym/services/NotificationService.dart';
import 'package:flutter/material.dart';
import '../model/AdtItemSlotsBooked.dart';
import '../services/RestApiService.dart';
import '../model/AdtItemSlots.dart';
import '../constants/Constants.dart';

class BookingCardWidget extends StatelessWidget {
  final AdtItemSlots adtItemSlots;
  final bool args;
  BookingCardWidget(this.adtItemSlots, this.args);

  @override
  Widget build(BuildContext context) {
    DateTime startTime =
        Constants.splitAndConvertStringToTime(adtItemSlots.startHour);
    DateTime endTime =
        Constants.splitAndConvertStringToTime(adtItemSlots.endHour);
    TimeOfDay startTimeOfDay =
        new TimeOfDay(hour: startTime.hour, minute: startTime.minute);
    TimeOfDay endTimeOfDay =
        new TimeOfDay(hour: endTime.hour, minute: endTime.minute);
    return Card(
      color: Constants.BACKGROUND_COLOR,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '${startTimeOfDay.format(context)} - ${endTimeOfDay.format(context)}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10),
              Row(
                children: <Widget>[
                  const Icon(
                    Icons.device_hub,
                    color: Constants.APP_BAR_COLOR,
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
                          Constants.splitAndConvertStringToTime(
                              adtItemSlots.startHour),
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
        Constants.asyncInputDialog(context, 'Are you sure?').then(
          (value) {
            // print('=============$value=============');
            if (value) {
              AdtItemSlotsBooked adtItemSlotsBooked = new AdtItemSlotsBooked(
                  0, 'Booked', adtItemSlots.slotPrice, adtItemSlots);
              var response = slotBooking(adtItemSlotsBooked);
              response.then((value) async {
                //Constants.showDialogue(context, 'Successfully Booked the slot');
                notify(context, adtItemSlotsBooked.id);
                new Routing(ModalRoute.of(context).settings.arguments)
                    .navigateUpcomingEvent(context);
              });
            }
          },
        );
      },
    );
  }

  void notify(BuildContext context, int id) {
    var bookedDate = Constants.convertStringToDate(
        Constants.dateFormat, adtItemSlots.slotDate);
    var bookedStartTime =
        Constants.splitAndConvertStringToTime(adtItemSlots.startHour);
    var bookedTime = new TimeOfDay(
        hour: bookedStartTime.hour, minute: bookedStartTime.minute);
    ReceivedNotification receivedNotification = new ReceivedNotification(
        id: id,
        title: 'Successfully booked',
        body:
            'Booking scheduled at ${bookedTime.format(context)} on ${bookedDate.month}/${bookedDate.day}/${bookedDate.year}',
        payload: 'Success');
    NotificationService notificationService =
        new NotificationService(receivedNotification);
    notificationService.initializing();
    notificationService.showNotifications();
    /* Notification scheduled 15 minutes before the scheduled date & time. */
    notificationService.showNotificationsBefore15MinutesDateTime(new DateTime(
        bookedDate.year,
        bookedDate.month,
        bookedDate.day,
        bookedTime.hour,
        bookedTime.minute));
  }
}
