import 'package:Gym/constants/Constants.dart';
import 'package:Gym/widget/BookingCardWidget.dart';
import 'package:flutter/material.dart';
import 'package:horizontal_calendar/horizontal_calendar.dart';
import 'package:intl/intl.dart';
import '../widget/MainDrawer.dart';

class BookingScreen extends StatefulWidget {
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  static DateFormat dateFormat = DateFormat.yMMMEd();
  String _selectedDate = dateFormat.format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    bool args = ModalRoute.of(context).settings.arguments;
    //print(args);
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
                BookingCardWidget(),
                BookingCardWidget(),
                BookingCardWidget(),
                BookingCardWidget(),
                BookingCardWidget(),
                BookingCardWidget(),
                BookingCardWidget(),
                BookingCardWidget(),
                BookingCardWidget(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
