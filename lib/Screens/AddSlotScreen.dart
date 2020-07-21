import 'package:Gym/model/AdtItemSlots.dart';
import 'package:Gym/model/AdtItems.dart';
import 'package:Gym/services/RestApiService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../widget/MainDrawer.dart';

import '../constants/Constants.dart';
//import 'package:flutter/material.dart';

class AddSlotScreen extends StatefulWidget {
  @override
  _AddSlotScreenState createState() => _AddSlotScreenState();
}

class _AddSlotScreenState extends State<AddSlotScreen> {
  static DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  static DateFormat timeFormat = DateFormat.Hm();
  //static DateFormat dateTimeFormat = new DateFormat('yyyy-MM-dd H:m');
  //static var fromDate = DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now());
  String _date = dateFormat.format(DateTime.now());
  String _startDateTime = timeFormat.format(DateTime.now());
  String _endDateTime = timeFormat.format(DateTime.now());
  //DateTime _selectedStartDate = DateTime.now();
  double _price;
  String _desc;
  int _itemCount;

  @override
  Widget build(BuildContext context) {
    bool args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      backgroundColor: Constants.BACKGROUND_COLOR,
      appBar: AppBar(
        backgroundColor: Constants.APP_BAR_COLOR,
        title: Text('Add Slot'),
      ),
      drawer: MainDrawer(args),
      body: SafeArea(
        child: Form(
          child: ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: Constants.HORIZONTAL_PADDING,
            ),
            children: <Widget>[
              new TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Title',
                  labelText: 'Title',
                  prefixIcon: const Icon(Icons.description),
                ),
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  //print(value);
                  _desc = value;
                },
              ),
              Divider(),
              new TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Price',
                  labelText: 'Price',
                  prefixIcon: const Icon(Icons.attach_money),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  //print(value);
                  try {
                    _price = double.parse(value);
                  } catch (e) {
                    print(e);
                  }
                },
              ),
              Divider(),
              new TextFormField(
                decoration: const InputDecoration(
                  hintText: 'number of machines',
                  labelText: 'number of machines',
                  prefixIcon: const Icon(Icons.casino),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  //print(value);
                  _itemCount = int.parse(value);
                },
              ),
              Divider(),
              SizedBox(height: Constants.SIZED_BOX_HEIGHT),
              buildExpansionTileForDate(),
              Divider(),
              SizedBox(height: Constants.SIZED_BOX_HEIGHT),
              buildExpansionTile(_startDateTime, true, Icon(Icons.watch)),
              Divider(),
              SizedBox(height: Constants.SIZED_BOX_HEIGHT),
              buildExpansionTile(_endDateTime, false, Icon(Icons.watch_later)),
              Divider(),
              SizedBox(height: Constants.SIZED_BOX_HEIGHT),
              RaisedButton(
                child: Text(
                  'Submit',
                  style: TextStyle(
                    fontWeight: Constants.FONT_WEIGHT,
                    fontSize: Constants.BUTTON_SIZE,
                  ),
                ),
                elevation: 6,
                color: Constants.APP_BAR_COLOR,
                onPressed: () {
                  slotObj();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  ExpansionTile buildExpansionTileForDate() {
    return ExpansionTile(
      title: Text(
        '$_date',
        style: TextStyle(
          fontWeight: Constants.FONT_WEIGHT,
          fontSize: Constants.FONT_SIZE,
        ),
      ),
      leading: Icon(Icons.calendar_today),
      trailing: Text(
        'Date',
        style: TextStyle(
          fontWeight: Constants.FONT_WEIGHT,
          fontSize: Constants.FONT_SIZE,
        ),
      ),
      children: <Widget>[
        SizedBox(
          height: 200,
          child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: DateTime.now(),
              onDateTimeChanged: (date) {
                if (DateTime.now().compareTo(date) == -1) {
                  print(date);
                  setState(() {
                    _date = dateFormat.format(date);
                  });
                }
              }),
        ),
      ],
    );
  }

  ExpansionTile buildExpansionTile(String dateTime, bool start, Icon icon) {
    return ExpansionTile(
      title: Text(
        '$dateTime',
        style: TextStyle(
          fontWeight: Constants.FONT_WEIGHT,
          fontSize: Constants.FONT_SIZE,
        ),
      ),
      leading: icon,
      trailing: start == true
          ? Text(
              'Start Time',
              style: TextStyle(
                fontWeight: Constants.FONT_WEIGHT,
                fontSize: Constants.FONT_SIZE,
              ),
            )
          : Text(
              'End Time',
              style: TextStyle(
                fontWeight: Constants.FONT_WEIGHT,
                fontSize: Constants.FONT_SIZE,
              ),
            ),
      children: <Widget>[
        SizedBox(
          height: 200,
          child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.time,
              initialDateTime: DateTime.now(),
              onDateTimeChanged: (dateTimeValue) {
                //print('.......${timeFormat.format(dateTimeValue)}........');
                //start means start datetime, idea behind is to make generic.
                if (start == true) {
                  try {
                    if (_date == dateFormat.format(DateTime.now()) &&
                        DateTime.now().compareTo(dateTimeValue) == -1) {
                      //print(dateTimeValue);
                      //_selectedStartDate = dateTimeValue;
                      setState(() {
                        _startDateTime = timeFormat.format(dateTimeValue);
                      });
                    } else {
                      //print(dateTimeValue);
                      //_selectedStartDate = dateTimeValue;
                      setState(() {
                        _startDateTime = timeFormat.format(dateTimeValue);
                      });
                    }
                    //print('${timeFormat.parse(_startDateTime)}........');
                  } catch (e) {
                    print(e);
                  }
                } else {
                  //print(timeFormat.parse(_startDateTime));
                  //print(timeFormat.parse(timeFormat.format(dateTimeValue)));
                  if (timeFormat
                      .parse(timeFormat.format(dateTimeValue))
                      .isAfter(timeFormat.parse(_startDateTime))) {
                    //print('..............Hello boss.........');
                    setState(() {
                      _endDateTime = timeFormat.format(dateTimeValue);
                    });
                  } else {
                    //print('......Nothing to print............');
                  }
                }
              }),
        ),
      ],
    );
  }

  void slotObj() {
    var splitStartHour = _startDateTime.split(':');
    var splitEndHour = _endDateTime.split(':');
    double startDateTime =
        double.parse('${splitStartHour[0]}.${splitStartHour[1]}');
    double endDateTime = double.parse('${splitEndHour[0]}.${splitEndHour[1]}');

    print(startDateTime);

    AdtItems adtItems = new AdtItems(1, '', '', 0);
    try {
      print('............$_itemCount..........');
      AdtItemSlots adtItemSlots = new AdtItemSlots(0, adtItems, _desc,
          startDateTime, endDateTime, _date, false, _price, _itemCount);
      print(adtItemSlots.toJson());
      List<AdtItemSlots> adtItemSlotsList = new List<AdtItemSlots>();
      adtItemSlotsList.add(adtItemSlots);
      addAdtItemSlotsData(adtItemSlotsList)
          .then((value) => {print(value.adtItemSlotList.length)});
    } catch (e) {
      print(e);
    }
  }
}
