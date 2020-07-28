import 'package:Gym/constants/Constants.dart';
import 'package:Gym/model/AdtItemSlotsBooked.dart';
import 'package:Gym/providers/AdtItemSlotsBookedList.dart';
import 'package:Gym/services/RestApiService.dart';
import 'package:flutter/material.dart';

class UpcomingEventWidget extends StatefulWidget {
  @override
  _UpcomingEventWidgetState createState() => _UpcomingEventWidgetState();
}

class _UpcomingEventWidgetState extends State<UpcomingEventWidget> {
  Future<AdtItemSlotsBookedList> adtItemSlotsBookedListFuture;

  @override
  void initState() {
    setState(() {
      adtItemSlotsBookedListFuture = getAdtItemsSlotsBookingData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AdtItemSlotsBookedList>(
        future: adtItemSlotsBookedListFuture,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Constants.loadingView();
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              {
                if (snapshot.hasData) {
                  if (snapshot.data.adtItemsSlotsBookedList != null) {
                    if (snapshot.data.adtItemsSlotsBookedList.length > 0) {
                      return ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemCount:
                              snapshot.data.adtItemsSlotsBookedList.length,
                          itemBuilder: (context, index) {
                            return generateColumn(
                                snapshot.data.adtItemsSlotsBookedList[index]);
                          });
                    } else {
                      return Constants.noDataView("No data found");
                    }
                  } else {
                    // display error message if your list or data is null.
                    //return noDataView("No data found");
                  }
                } else if (snapshot.hasError) {
                  // display your message if snapshot has error.
                  return Constants.noDataView("No booking schedule found.");
                } else {
                  return Constants.noDataView("Something went wrong");
                }
                return Constants.noDataView("No data found");
              }
            case ConnectionState.none:
              break;
          }
          return Constants.noDataView("No data found");
        });
  }

  Widget generateColumn(AdtItemSlotsBooked adtItemSlotsBooked) {
    DateTime slotDate = Constants.convertStringToDate(
        Constants.dateFormat, adtItemSlotsBooked.adtItemSlots.slotDate);
    String slotDateStr =
        Constants.convertDateToString(Constants.dateFormat, slotDate);
    DateTime startTime = Constants.splitAndConvertStringToTime(
        adtItemSlotsBooked.adtItemSlots.startHour);
    DateTime endTime = Constants.splitAndConvertStringToTime(
        adtItemSlotsBooked.adtItemSlots.endHour);
    if (Constants.convertStringToDate(Constants.dateFormat, slotDateStr)
        .isAfter(DateTime.now())) {
      return getColumnWidget(
          slotDateStr, startTime, endTime, adtItemSlotsBooked.desc);
    } else if (slotDateStr !=
        Constants.convertDateToString(Constants.dateFormat, DateTime.now())) {
      return SizedBox.shrink();
    } else if (slotDateStr ==
        Constants.convertDateToString(Constants.dateFormat, DateTime.now())) {
      DateTime dt = new DateTime(slotDate.year, slotDate.month, slotDate.day,
          startTime.hour, startTime.minute);
      if (dt.isBefore(DateTime.now())) {
        return SizedBox.shrink();
      } else {
        return getColumnWidget(
            slotDateStr, startTime, endTime, adtItemSlotsBooked.desc);
      }
    } else {
      print('....................');
    }
    return getColumnWidget(
        slotDateStr, startTime, endTime, adtItemSlotsBooked.desc);
  }

  Widget getColumnWidget(
      String slotDateStr, DateTime startTime, DateTime endTime, String desc) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              '$slotDateStr',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 16,
              ),
            ),
            Text(
              '${Constants.timeFormat.format(startTime)} - ${Constants.timeFormat.format(endTime)}',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 16,
              ),
            ),
            Text('$desc'),
          ],
        ),
        Divider(),
      ],
    );
  }
}
