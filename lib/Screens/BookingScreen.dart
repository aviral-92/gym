import 'package:Gym/widget/BookingCardWidget.dart';

import '../providers/AdtItemSlotsList.dart';
import '../services/RestApiService.dart';
import 'package:flutter/material.dart';
import 'package:horizontal_calendar/horizontal_calendar.dart';
import 'package:intl/intl.dart';
import '../widget/MainDrawer.dart';
import '../constants/Constants.dart';
import '../model/AdtItemSlots.dart';

class BookingScreen extends StatefulWidget {
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  static DateFormat dateFormat = new DateFormat('yyyy-MM-dd');
  String _selectedDate = dateFormat.format(DateTime.now());
  Future<AdtItemSlotsList> adtItemSlotListFuture;

  @override
  void initState() {
    setAdtItemSlotListFuture(dateFormat.format(DateTime.now()));
    super.initState();
  }

  void setAdtItemSlotListFuture(String date) {
    setState(() {
      adtItemSlotListFuture = getAdtItemSlotsData(date);
    });
  }

  //AdtItemSlotsList adtItemSlotsList;

  @override
  Widget build(BuildContext context) {
    bool args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: Constants.BACKGROUND_COLOR,
      //Colors.orangeAccent[300],
      appBar: AppBar(
        backgroundColor: Constants.APP_BAR_COLOR,
        title: Text('Booking'),
      ),
      drawer: MainDrawer(args),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Card(
              child: HorizontalCalendar(
                initialDate: DateTime.now(),
                date: DateTime.now(),
                lastDate: DateTime.now().add(Duration(days: 30)),
                textColor: Colors.black,
                backgroundColor: Constants.BACKGROUND_COLOR,
                selectedColor: Constants.CALENDAR_COLOR,
                onDateSelected: (date) => {
                  setState(() {
                    _selectedDate = date;
                    setAdtItemSlotListFuture(date);
                  })
                },
              ),
              elevation: 6,
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 15)),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  '$_selectedDate',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                FutureBuilder<AdtItemSlotsList>(
                    future: adtItemSlotListFuture,
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return loadingView();
                        case ConnectionState.active:
                          break;
                        case ConnectionState.done:
                          {
                            if (snapshot.hasData) {
                              if (snapshot.data.adtItemSlotList != null) {
                                if (snapshot.data.adtItemSlotList.length > 0) {
                                  return ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      physics: ScrollPhysics(),
                                      itemCount:
                                          snapshot.data.adtItemSlotList.length,
                                      itemBuilder: (context, index) {
                                        return generateColumn(snapshot
                                            .data.adtItemSlotList[index]);
                                      });
                                } else {
                                  return noDataView("No data found");
                                }
                              } else {
                                // display error message if your list or data is null.
                                //return noDataView("No data found");
                              }
                            } else if (snapshot.hasError) {
                              // display your message if snapshot has error.
                              //print('no element');
                              return noDataView("No booking schedule found.");
                            } else {
                              return noDataView("Something went wrong");
                            }
                            return noDataView("No data found");
                          }
                        case ConnectionState.none:
                          break;
                      }
                      return noDataView("No data found");
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget generateColumn(AdtItemSlots adtItemSlots) =>
      new BookingCardWidget(adtItemSlots);

  Widget loadingView() => Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.red,
        ),
      );

  Widget noDataView(String msg) => Center(
        child: Text(
          msg,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
        ),
      );
}
