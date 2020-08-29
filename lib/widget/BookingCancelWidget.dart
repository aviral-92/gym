import '../constants/Routing.dart';
import 'package:http/http.dart';

import '../model/AdtItemSlotsBooked.dart';
import '../services/RestApiService.dart';
import '../providers/AdtItemSlotsBookedList.dart';
import '../constants/Constants.dart';
import 'package:flutter/material.dart';

class BookingCancelWidget extends StatefulWidget {
  @override
  _BookingCancelWidgetState createState() => _BookingCancelWidgetState();
}

class _BookingCancelWidgetState extends State<BookingCancelWidget> {
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
      print('............${adtItemSlotsBooked.id}...............');
      return getColumnWidget(
          slotDateStr, startTime, endTime, adtItemSlotsBooked);
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
        print('............${adtItemSlotsBooked.id}...............');
        return getColumnWidget(
            slotDateStr, startTime, endTime, adtItemSlotsBooked);
      }
    } else {
      print('....................');
    }
    return getColumnWidget(slotDateStr, startTime, endTime, adtItemSlotsBooked);
  }

  Widget getColumnWidget(String slotDateStr, DateTime startTime,
          DateTime endTime, AdtItemSlotsBooked adtItemSlotsBooked) =>
      Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('${adtItemSlotsBooked.adtItemSlots.adtItems.itemName}'),
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
              InkWell(
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                    fontSize: 16, //0xFFC62828
                  ),
                ),
                onTap: () => cancelEvent(context, adtItemSlotsBooked.id),
              ),
            ],
          ),
          Divider(),
        ],
      );

  void cancelEvent(BuildContext context, int id) async {
    print(id);
    Response currentRresponse;
    var response = Constants.asyncInputDialog(context, 'Are you sure?');
    await response.then((value) async {
      if (value) {
        var futureResponse = cancelBookingSlot(id);
        await futureResponse.then((value) => currentRresponse = value);
        print('=====${currentRresponse.statusCode}========');
        if (currentRresponse.statusCode == 200) {
          //Constants.showDialogue(context, 'Successfully cancel the slot');
          new Routing(ModalRoute.of(context).settings.arguments)
              .navigateCancelEvent(context);
        } else {
          Constants.showDialogue(context, 'Unable to cancel the slot');
        }
      }
    });
  }
}
