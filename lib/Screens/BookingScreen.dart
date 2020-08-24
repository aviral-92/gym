import 'package:Gym/model/AdtTest.dart';
import 'package:flutter/material.dart';
import 'package:horizontal_calendar/horizontal_calendar.dart';
import '../widget/BookingCardWidget.dart';
import '../providers/AdtItemSlotsList.dart';
import '../services/RestApiService.dart';
import '../widget/MainDrawer.dart';
import '../constants/Constants.dart';
import '../model/AdtItemSlots.dart';

class BookingScreen extends StatefulWidget {
  final AdtTest adtTest;

  BookingScreen({Key key, this.adtTest}) : super(key: key);

  @override
  _BookingScreenState createState() => _BookingScreenState(adtTest);
}

class _BookingScreenState extends State<BookingScreen> {
  final AdtTest adtTest;

  _BookingScreenState(this.adtTest);

  String _selectedDate =
      Constants.convertDateToString(Constants.dateFormat, DateTime.now());
  Future<AdtItemSlotsList> adtItemSlotListFuture;

  @override
  void initState() {
    setAdtItemSlotListFuture(
        Constants.convertDateToString(Constants.dateFormat, DateTime.now()));
    super.initState();
  }

  void setAdtItemSlotListFuture(String date) {
    setState(() {
      adtItemSlotListFuture = getAdtItemSlotsData(adtTest.adtItems.id, date);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.BACKGROUND_COLOR,
      //Colors.orangeAccent[300],
      appBar: AppBar(
        backgroundColor: Constants.APP_BAR_COLOR,
        title: Text('Booking'),
      ),
      drawer: MainDrawer(admin: adtTest.isAdmin),
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
                selectedColor: Constants.APP_BAR_COLOR,
                onDateSelected: (date) => {
                  setState(() {
                    this._selectedDate = date;
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
                          return Constants.loadingView();
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
                                        return generateColumn(
                                            snapshot
                                                .data.adtItemSlotList[index],
                                            adtTest.isAdmin);
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
                              //print('no element');
                              return Constants.noDataView(
                                  "No booking schedule found.");
                            } else {
                              return Constants.noDataView(
                                  "Something went wrong");
                            }
                            return Constants.noDataView("No data found");
                          }
                        case ConnectionState.none:
                          break;
                      }
                      return Constants.noDataView("No data found");
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget generateColumn(AdtItemSlots adtItemSlots, bool args) =>
      new BookingCardWidget(adtItemSlots, args);
}
